import os
import sys
import uuid
import json
import shutil
import sqlite3
import argparse
import subprocess
from datetime import datetime, timedelta

# ==========================================
# CONFIGURATION
# ==========================================

# Path to jellyfin.db on your host machine
DB_PATH = r"jellyfin.db"

# Local host folder where trailers are stored
HOST_TRAILERS_DIR = r"/volume1/video/EXTRAS"

# 1. Translation: Jellyfin Movie Path -> Python Host Path
MOVIE_PATH_MAPPINGS = {
    "/media/movies": r"/volume1/video/MOVIES"
}

# 2. Translation: Python Host Trailer Path -> Jellyfin Container Trailer Path
TRAILER_PATH_MAPPINGS = {
    r"/volume1/video/EXTRAS": "/media/extras"
}

TRAILER_EXTENSIONS = [".mp4", ".mkv", ".webm", ".avi"]

# Path to ffprobe executable (Leave as "ffprobe" if added to PATH, or set absolute path)
FFPROBE_PATH = "ffprobe"

# ==========================================
# HELPER FUNCTIONS
# ==========================================

def generate_guid() -> str:
    """Generates an uppercase GUID string formatted for SQLite/EF Core."""
    return str(uuid.uuid4()).upper()


def translate_movie_path_to_host(docker_path: str) -> str:
    """Translates Docker movie path from Jellyfin into local Host path."""
    norm_path = os.path.normpath(docker_path)
    for docker_prefix, host_prefix in MOVIE_PATH_MAPPINGS.items():
        norm_docker_prefix = os.path.normpath(docker_prefix)
        if norm_path.startswith(norm_docker_prefix):
            rel_path = os.path.relpath(norm_path, norm_docker_prefix)
            return os.path.normpath(os.path.join(host_prefix, rel_path))
    return norm_path


def translate_trailer_path_to_docker(host_path: str) -> str:
    """Translates local Host trailer path into Docker path Jellyfin can read."""
    norm_path = os.path.normpath(host_path)
    for host_prefix, docker_prefix in TRAILER_PATH_MAPPINGS.items():
        norm_host_prefix = os.path.normpath(host_prefix)
        if norm_path.startswith(norm_host_prefix):
            rel_path = os.path.relpath(norm_path, norm_host_prefix)
            docker_rel = rel_path.replace("\\", "/")
            return f"{docker_prefix.rstrip('/')}/{docker_rel.lstrip('/')}"
    return norm_path.replace("\\", "/")


def find_matching_trailer_on_host(movie_filename: str) -> str:
    """Checks host disk to see if a trailer matching the movie exists."""
    base_name = os.path.splitext(movie_filename)[0]

    for ext in TRAILER_EXTENSIONS:
        candidate_1 = os.path.join(HOST_TRAILERS_DIR, f"{base_name}-trailer{ext}")
        candidate_2 = os.path.join(HOST_TRAILERS_DIR, f"{base_name}{ext}")

        if os.path.exists(candidate_1):
            return candidate_1
        elif os.path.exists(candidate_2):
            return candidate_2

    return None


def create_db_backup(db_path: str):
    """Creates a timestamped backup copy of jellyfin.db."""
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_path = f"{db_path}.backup_{timestamp}"
    shutil.copy2(db_path, backup_path)
    print(f"[+] Backup created at: {backup_path}")


def get_baseitems_schema_defaults(cursor):
    """
    Dynamically inspects BaseItems schema and builds default values
    for all NOT NULL columns without explicit default values.
    """
    cursor.execute("PRAGMA table_info(BaseItems);")
    columns_info = cursor.fetchall()

    defaults = {}
    for col_id, col_name, col_type, not_null, default_val, pk in columns_info:
        if not_null and default_val is None and not pk:
            col_type_upper = col_type.upper()
            if "INT" in col_type_upper or "BOOL" in col_type_upper:
                defaults[col_name] = 0
            elif "TEXT" in col_type_upper or "VARCHAR" in col_type_upper:
                defaults[col_name] = ""
            elif "DATETIME" in col_type_upper:
                defaults[col_name] = datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S')
            else:
                defaults[col_name] = 0

    return defaults


def probe_video_with_ffprobe(host_trailer_path: str):
    """Runs ffprobe on the local trailer file to extract metadata."""
    cmd = [
        FFPROBE_PATH,
        "-v", "quiet",
        "-print_format", "json",
        "-show_streams",
        "-show_format",
        host_trailer_path
    ]

    width, height, duration_sec, bitrate = 0, 0, 0.0, 0
    container_ext = os.path.splitext(host_trailer_path)[1].lstrip('.').lower()

    try:
        result = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, check=True)
        probe_data = json.loads(result.stdout)

        format_info = probe_data.get("format", {})
        bitrate = int(format_info.get("bit_rate", 0)) if format_info.get("bit_rate") else 0
        duration_sec = float(format_info.get("duration", 0.0)) if format_info.get("duration") else 0.0

        # Get primary container name (e.g. 'mkv' from 'matroska,webm')
        fmt_name = format_info.get("format_name", "")
        if "matroska" in fmt_name:
            container_ext = "mkv"
        elif "mp4" in fmt_name:
            container_ext = "mp4"

        for stream in probe_data.get("streams", []):
            if stream.get("codec_type") == "video":
                width = int(stream.get("width", 0))
                height = int(stream.get("height", 0))
                break

    except Exception as e:
        print(f"[!] ffprobe warning for {os.path.basename(host_trailer_path)}: {e}")

    runtime_ticks = int(duration_sec * 10_000_000)
    file_size = os.path.getsize(host_trailer_path) if os.path.exists(host_trailer_path) else 0

    return width, height, runtime_ticks, bitrate, file_size, container_ext


def build_trailer_data_json(host_trailer_path: str):
    """Executes ffprobe and constructs the required JSON blob for BaseItems.Data."""
    width, height, runtime_ticks, bitrate, file_size, container_ext = probe_video_with_ffprobe(host_trailer_path)

    # Create strict ISO-8601 format with 'T' separator
    now_iso = datetime.utcnow().strftime('%Y-%m-%dT%H:%M:%S.%f') + "Z"

    data_payload = {
        "TrailerTypes": [],
        "AdditionalParts": [],
        "LocalAlternateVersions": [],
        "LinkedAlternateVersions": [],
        "SubtitleFiles": [],
        "AudioFiles": [],
        "HasSubtitles": False,
        "IsPlaceHolder": False,
        "DefaultVideoStreamIndex": 0,
        "VideoType": "VideoFile",
        "Size": file_size,
        "Container": container_ext,
        "IsHD": height >= 720,
        "IsShortcut": False,
        "Width": width,
        "Height": height,
        "DateLastSaved": now_iso,
        "RemoteTrailers": []
    }

    return data_payload, file_size, container_ext, width, height, runtime_ticks, bitrate


def process_existing_trailers(cursor, movie_id: str, movie_name: str, new_docker_trailer_path: str, dry_run: bool) -> bool:
    """
    Checks for existing trailers linked via OwnerId.
    - Returns True if an existing trailer points to the same file (signal to skip).
    - Removes old trailer records that point to a different file and returns False.
    """
    cursor.execute("""
        SELECT Id, Path FROM BaseItems
        WHERE OwnerId = ? AND (
            Type LIKE '%Trailer%' OR ExtraType = 2 OR UnratedType = 'Trailer'
        )
    """, (movie_id,))
    existing_trailers = cursor.fetchall()

    for trailer_id, existing_path in existing_trailers:
        if existing_path == new_docker_trailer_path:
            print(f"[=] Movie '{movie_name}' already linked to existing trailer file: {existing_path}. Skipping.")
            return True

        print(f"[-] Found old trailer pointing to a different file for '{movie_name}': {existing_path}")
        if dry_run:
            print(f"    [DRY-RUN] Would remove old trailer record ID {trailer_id} from database (file unaffected).")
        else:
            cursor.execute("DELETE FROM BaseItems WHERE Id = ?", (trailer_id,))
            print(f"    [+] Removed old trailer record ID {trailer_id} from database.")

    return False


# ==========================================
# MAIN EXECUTION
# ==========================================

def main():
    parser = argparse.ArgumentParser(description="Map external trailers to Jellyfin 12 BaseItems using OwnerId and ffprobe.")
    parser.add_argument("--apply", action="store_true", help="Apply changes to jellyfin.db (default is dry-run mode)")
    parser.add_argument("--hours", type=float, default=None, help="Filter search to movies added within the last X hours")
    args = parser.parse_args()

    dry_run = not args.apply

    if dry_run:
        print("\n=== DRY-RUN MODE (No changes written). Pass '--apply' to execute. ===\n")
    else:
        print("\n=== APPLY MODE: Writing changes to SQLite DB ===\n")

    if not os.path.exists(DB_PATH):
        print(f"[!] Database file not found at: {DB_PATH}")
        sys.exit(1)

    if not os.path.exists(HOST_TRAILERS_DIR):
        print(f"[!] Host trailers directory not found at: {HOST_TRAILERS_DIR}")
        sys.exit(1)

    if not dry_run:
        create_db_backup(DB_PATH)

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    not_null_defaults = get_baseitems_schema_defaults(cursor)

    query = """
        SELECT Id, Name, Path, ProductionYear, DateCreated
        FROM BaseItems
        WHERE Type LIKE '%Movie%' AND (ExtraType IS NULL OR ExtraType = '') AND Path IS NOT NULL AND Path != ''
    """
    params = []

    if args.hours is not None:
        cutoff_dt = datetime.utcnow() - timedelta(hours=args.hours)
        cutoff_str = cutoff_dt.strftime('%Y-%m-%d %H:%M:%S')
        query += " AND DateCreated >= ?"
        params.append(cutoff_str)
        print(f"[+] Filtering movies added in the last {args.hours} hour(s) (DateCreated >= {cutoff_str})...")

    print("[+] Fetching movies from Jellyfin database...")
    cursor.execute(query, params)
    movies = cursor.fetchall()
    print(f"[+] Found {len(movies)} main movie entries.\n")

    linked_count = 0

    for movie_id, movie_name, docker_movie_path, prod_year, date_created in movies:
        host_movie_path = translate_movie_path_to_host(docker_movie_path)
        movie_filename = os.path.basename(host_movie_path)

        host_trailer_path = find_matching_trailer_on_host(movie_filename)
        if not host_trailer_path:
            continue

        docker_trailer_path = translate_trailer_path_to_docker(host_trailer_path)

        # Process existing trailers linked via OwnerId
        should_skip = process_existing_trailers(cursor, movie_id, movie_name, docker_trailer_path, dry_run)
        if should_skip:
            continue

        now_iso = datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S.%f')
        trailer_id = generate_guid()
        pres_key = trailer_id.replace("-", "").lower()

        # Extract video metadata via ffprobe and construct Data payload
        data_json, file_size, container_ext, width, height, runtime_ticks, bitrate = build_trailer_data_json(host_trailer_path)

        linked_count += 1
        if dry_run:
            print(f"[DRY-RUN] Would create Trailer BaseItem:")
            print(f"          Movie:       {movie_name}")
            print(f"          OwnerId:     {movie_id}")
            print(f"          Docker Path: {docker_trailer_path}")
            print(f"          Resolution:  {width}x{height}")
            print(f"          Bitrate:     {bitrate} bps\n")
        else:
            item_data = not_null_defaults.copy()
            item_data.update({
                "Id": trailer_id,
                "Path": docker_trailer_path,
                "Name": "Trailer",
                "CleanName": "trailer",
                "SortName": "trailer",
                "Type": "MediaBrowser.Controller.Entities.Trailer",
                "ExtraType": 2,
                "UnratedType": "Trailer",
                "OwnerId": movie_id,          # Sets ownership link to parent movie
                "MediaType": "Video",
                "IsFolder": 0,
                "IsMovie": 0,
                "IsLocked": 0,
                "ProductionYear": prod_year,
                "Size": file_size,
                "Width": width,
                "Height": height,
                "RunTimeTicks": runtime_ticks,
                "TotalBitrate": bitrate,
                "PresentationUniqueKey": pres_key,
                "Data": json.dumps(data_json),
                "DateCreated": now_iso,
                "DateModified": now_iso,
                "DateLastSaved": now_iso,
                "DateLastRefreshed": now_iso
            })

            columns = list(item_data.keys())
            placeholders = ", ".join(["?"] * len(columns))
            column_names = ", ".join([f'"{c}"' for c in columns])
            values = list(item_data.values())

            sql = f"INSERT INTO BaseItems ({column_names}) VALUES ({placeholders})"
            cursor.execute(sql, values)
            print(f"[+] Successfully inserted trailer for '{movie_name}': {docker_trailer_path}\n")

    if not dry_run:
        conn.commit()
        print("\n" + "=" * 60)
        print(f"Successfully committed {linked_count} trailer record(s) to BaseItems in SQLite.")
        print("Please restart your Jellyfin server to refresh the in-memory cache.")
        print("=" * 60)
    else:
        print("\n" + "=" * 60)
        print(f"Dry-run complete. Found {linked_count} matching trailer(s) to link.")
        print("Run with '--apply' to write changes to SQLite.")
        print("=" * 60)

    conn.close()


if __name__ == "__main__":
    main()
