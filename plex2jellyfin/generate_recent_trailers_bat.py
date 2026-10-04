import os
import argparse
import requests
from datetime import datetime, timedelta, timezone

# ==========================================
# CONFIGURATION
# ==========================================
JELLYFIN_URL = "http://server:8096"
JELLYFIN_API_KEY = "YOUR_API_KEY"
TMDB_API_KEY = "YOUR_TMDB_API_KEY"          # TMDB v3 API Key

OUTPUT_BAT_FILE = "download_trailers.bat"

# Map Jellyfin Linux mount paths to Windows drive paths if needed:
PATH_REPLACEMENTS = {
    "/media/movies/": "Z:\\HD\\"
}

# ==========================================
# HELPER FUNCTIONS
# ==========================================

def parse_jellyfin_date(date_str):
    """Parses Jellyfin ISO 8601 date strings into a UTC datetime object (Python 3.10 compatible)."""
    if not date_str:
        return None
    try:
        clean_str = date_str.replace("Z", "+00:00")

        # Handle fractional seconds (e.g. .19269)
        if "." in clean_str:
            base, rest = clean_str.split(".", 1)
            if "+" in rest:
                sub_sec, tz = rest.split("+", 1)
                tz_str = f"+{tz}"
            else:
                sub_sec = rest
                tz_str = "+00:00"

            # Truncate to 6 digits or pad with zeros so Python 3.10 accepts it as valid microseconds
            sub_sec = sub_sec[:6].ljust(6, '0')
            clean_str = f"{base}.{sub_sec}{tz_str}"

        return datetime.fromisoformat(clean_str).astimezone(timezone.utc)
    except Exception as e:
        print(f"  [!] Date parse error for '{date_str}': {e}")
        return None


def get_recent_jellyfin_movies(hours_lookback):
    """Fetch movie items added to Jellyfin in the last N hours that lack a local trailer."""
    headers = {
        "X-Emby-Token": JELLYFIN_API_KEY,
        "Authorization": f'MediaBrowser Client="Python", Device="WatchSync", DeviceId="plex-jellyfin-watch-sync", Version="1.0.0", Token="{JELLYFIN_API_KEY}"'
    }
    url = f"{JELLYFIN_URL.rstrip('/')}/Items"

    cutoff_time = datetime.now(timezone.utc) - timedelta(hours=hours_lookback)
    min_date_created = cutoff_time.strftime("%Y-%m-%dT%H:%M:%SZ")

    params = {
        "IncludeItemTypes": "Movie",
        "Recursive": "true",
        "MinDateCreated": min_date_created,
        "HasTrailer": "false",  # Directly queries Jellyfin for movies WITHOUT local trailers
        "SortBy": "DateCreated",
        "SortOrder": "Descending",
        "Fields": "Path,RemoteTrailers,ProviderIds,DateCreated"
    }

    response = requests.get(url, headers=headers, params=params)
    response.raise_for_status()
    all_items = response.json().get("Items", [])

    print(f"Server returned {len(all_items)} item(s) without local trailers. Filtering dates locally...")

    recent_movies = []
    for item in all_items:
        date_created_str = item.get("DateCreated")
        date_created = parse_jellyfin_date(date_created_str)

        if date_created and date_created >= cutoff_time:
            recent_movies.append(item)

    return recent_movies, cutoff_time

def get_tmdb_trailer_url(tmdb_id):
    """Fetch the official YouTube trailer URL for a movie directly from TMDB API."""
    if not TMDB_API_KEY or TMDB_API_KEY == "YOUR_TMDB_API_KEY":
        return None

    url = f"https://api.themoviedb.org/3/movie/{tmdb_id}/videos"
    params = {"api_key": TMDB_API_KEY, "language": "en-US"}

    try:
        res = requests.get(url, params=params, timeout=5)
        if res.status_code == 200:
            results = res.json().get("results", [])
            trailers = [
                v for v in results
                if v.get("site") == "YouTube" and v.get("type") == "Trailer"
            ]
            if trailers:
                official = [t for t in trailers if t.get("official")]
                key = (official[0] if official else trailers[0])["key"]
                return f"https://www.youtube.com/watch?v={key}"
    except Exception as e:
        print(f"  [!] TMDB lookup failed for ID {tmdb_id}: {e}")
    return None


def resolve_local_path(path):
    """Map Jellyfin server paths to local Windows paths if necessary."""
    for remote, local in PATH_REPLACEMENTS.items():
        if path.startswith(remote):
            path = path.replace(remote, local, 1)
    return os.path.normpath(path)


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
        provider_ids = movie.get("ProviderIds", {})
        tmdb_id = provider_ids.get("Tmdb")

        if not path:
            continue

        local_path = resolve_local_path(path)

        youtube_url = None

        # 1. Try finding YouTube URL from Jellyfin RemoteTrailers
        for trailer in remote_trailers:
            url = trailer.get("Url", "")
            if "youtube.com" in url or "youtu.be" in url:
                youtube_url = url
                break

        # 2. Fallback to TMDB API if Jellyfin RemoteTrailers is empty
        if not youtube_url and tmdb_id:
            print(f"[{idx}/{len(movies)}] No remote trailer in Jellyfin DB. Fetching from TMDB (ID: {tmdb_id})...")
            youtube_url = get_tmdb_trailer_url(tmdb_id)

        if not youtube_url:
            print(f"[{idx}/{len(movies)}] Skipping (No YouTube trailer found in Jellyfin or TMDB): {name}")
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
