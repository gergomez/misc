import os
import argparse
import requests
from datetime import datetime, timedelta, timezone
from dateutil import parser

# ==========================================
# CONFIGURATION
# ==========================================
JELLYFIN_URL = "http://server:8096"
JELLYFIN_API_KEY = "YOUR_API_KEY"

OUTPUT_BAT_FILE = "download_trailers.bat"

# If Jellyfin uses Linux paths (e.g., /media/movies) and your Windows machine uses drive letters (e.g., M:\movies):
PATH_REPLACEMENTS = {
    "/media/movies/": "Z:\\HD\\"
}

# ==========================================
# HELPER FUNCTIONS
# ==========================================

def parse_jellyfin_date(date_str):
    if not date_str:
        return None
    try:
        return parser.isoparse(date_str).astimezone(timezone.utc)
    except Exception as e:
        print(f"  [!] Date parse error for '{date_str}': {e}")
        return None


def get_recent_jellyfin_movies(hours_lookback):
    """Fetch movie items added to Jellyfin in the last N hours."""
    headers = {
        "X-Emby-Token": JELLYFIN_API_KEY,
        "Authorization": f'MediaBrowser Client="Python", Device="WatchSync", DeviceId="plex-jellyfin-watch-sync", Version="1.0.0", Token="{JELLYFIN_API_KEY}"'
    }
    url = f"{JELLYFIN_URL.rstrip('/')}/Items"

    # Calculate UTC cutoff time
    cutoff_time = datetime.now(timezone.utc) - timedelta(hours=hours_lookback)
    min_date_created = cutoff_time.strftime("%Y-%m-%dT%H:%M:%SZ")

    params = {
        "IncludeItemTypes": "Movie",
        "Recursive": "true",
        "MinDateCreated": min_date_created,
        "SortBy": "DateCreated",
        "SortOrder": "Descending",
        "Fields": "Path,RemoteTrailers,DateCreated"
    }

    response = requests.get(url, headers=headers, params=params)
    response.raise_for_status()
    all_items = response.json().get("Items", [])

    print(f"Server returned {len(all_items)} candidate item(s). Filtering locally...")

    recent_movies = []
    for item in all_items:
        date_created_str = item.get("DateCreated")
        date_created = parse_jellyfin_date(date_created_str)

        if date_created:
            if date_created >= cutoff_time:
                recent_movies.append(item)
            else:
                # Discard older items
                pass
        else:
            print(f"  [!] Warning: Missing or unparseable DateCreated for '{item.get('Name')}'. Skipping.")

    return recent_movies, cutoff_time


def resolve_local_path(path):
    """Map Jellyfin server paths to local Windows paths if necessary."""
    for remote, local in PATH_REPLACEMENTS.items():
        if path.startswith(remote):
            path = path.replace(remote, local, 1)
    return os.path.normpath(path)


def trailer_exists(movie_file_path):
    """Check if a trailer matching Jellyfin's naming pattern already exists."""
    folder = os.path.dirname(movie_file_path)
    base_name = os.path.splitext(os.path.basename(movie_file_path))[0]

    extensions = [".mp4", ".mkv", ".webm", ".avi"]
    for ext in extensions:
        if os.path.exists(os.path.join(folder, f"{base_name}-trailer{ext}")):
            return True
    return False


# ==========================================
# MAIN EXECUTION
# ==========================================

def main():
    parser = argparse.ArgumentParser(
        description="Generate a CP850 encoded batch script to download YouTube trailers for recent Jellyfin movies."
    )
    parser.add_argument(
        "-hr", "--hours",
        type=float,
        default=12.0,
        help="Number of hours to look back for newly added movies (default: 12)"
    )
    args = parser.parse_args()
    hours_lookback = args.hours

    print(f"Connecting to Jellyfin at {JELLYFIN_URL}...")

    try:
        movies, cutoff_time = get_recent_jellyfin_movies(hours_lookback)
    except Exception as e:
        print(f"[!] Error connecting to Jellyfin: {e}")
        return

    print(f"Cutoff Time (UTC): {cutoff_time.strftime('%Y-%m-%d %H:%M:%S UTC')}")
    print(f"Found {len(movies)} movie(s) added after cutoff time.\n")

    bat_commands = [
        "@echo off",
        "chcp 850 > nul",
        "echo ==========================================",
        f"echo Starting yt-dlp Trailer Downloads (Added last {hours_lookback}h, Max 1080p)",
        "echo ==========================================",
        ""
    ]

    pending_count = 0

    for idx, movie in enumerate(movies, start=1):
        name = movie.get("Name")
        path = movie.get("Path")
        date_created = movie.get("DateCreated", "N/A")
        remote_trailers = movie.get("RemoteTrailers", [])

        if not path:
            continue

        local_path = resolve_local_path(path)

        if trailer_exists(local_path):
            print(f"[{idx}/{len(movies)}] Skipping (Trailer exists): {name}")
            continue

        youtube_url = None

        for trailer in remote_trailers:
            url = trailer.get("Url", "")
            if "youtube.com" in url or "youtu.be" in url:
                youtube_url = url
                break

        if not youtube_url:
            print(f"[{idx}/{len(movies)}] Skipping (No YouTube trailer in Jellyfin): {name}")
            continue

        print(f"[{idx}/{len(movies)}] Adding to script: {name} (Added: {date_created})")

        output_prefix = os.path.splitext(local_path)[0]

        format_spec = "bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/bestvideo[height<=1080]+bestaudio/best[height<=1080]"

        cmd = f'yt-dlp --cookies cookies.txt --min-sleep-interval 1 --max-sleep-interval 3 --limit-rate 5M --no-playlist --format "{format_spec}" --output "{output_prefix}-trailer.mp4" "{youtube_url}"'

        clean_name = name.replace('"', '')
        bat_commands.append(f'echo Downloading trailer for: {clean_name}')
        bat_commands.append(cmd)
        bat_commands.append("")

        pending_count += 1

    bat_commands.append("echo ==========================================")
    bat_commands.append("echo All trailer downloads completed!")
    bat_commands.append("pause")

    with open(OUTPUT_BAT_FILE, "w", encoding="cp850", errors="ignore") as f:
        f.write("\n".join(bat_commands))

    print("\n" + "=" * 60)
    print(f"Done! Generated '{OUTPUT_BAT_FILE}' (CP850) with {pending_count} download command(s).")
    print("=" * 60)

if __name__ == "__main__":
    main()
