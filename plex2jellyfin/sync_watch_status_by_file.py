import sys
import os
import argparse
from datetime import datetime, timedelta
import requests

# -------------------------------------------------------------------
# Configuration Defaults
# -------------------------------------------------------------------
PLEX_URL = "http://server:32400"
PLEX_TOKEN = "plex-token"

JELLYFIN_URL = "http://server:8096"
JELLYFIN_API_KEY = "YOUR_API_KEY"
JELLYFIN_USERNAME = "your-user"

# Path translation dictionary: { "Plex_Path_Prefix": "Jellyfin_Path_Prefix" }
PATH_MAPPINGS = {
    "/volume1/video/MOVIES": "/media/movies",
    "/volume1/video/ANIME": "/media/anime",
    "/volume1/video/SERIES": "/media/series",
    "/volume1/video/DOCUS": "/media/docus",
}

ALLOWED_PLEX_SECTIONS = {"movie", "show"}
ALLOWED_JELLYFIN_TYPES = "Movie,Episode"

DEFAULT_DAYS_CUTOFF = 30

# Headers
PLEX_HEADERS = {
    "X-Plex-Token": PLEX_TOKEN,
    "Accept": "application/json"
}

JELLYFIN_HEADERS = {
    "X-Emby-Token": JELLYFIN_API_KEY,
    "Authorization": f'MediaBrowser Client="Python", Device="WatchSync", DeviceId="plex-jellyfin-watch-sync", Version="1.0.0", Token="{JELLYFIN_API_KEY}"'
}


# -------------------------------------------------------------------
# Helper Functions
# -------------------------------------------------------------------
def translate_path(plex_path: str) -> str:
    """Translates a Plex file path to the corresponding Jellyfin file path."""
    normalized_path = os.path.normpath(plex_path)

    for plex_prefix, jellyfin_prefix in PATH_MAPPINGS.items():
        norm_plex_prefix = os.path.normpath(plex_prefix)
        if normalized_path.startswith(norm_plex_prefix):
            rel_path = os.path.relpath(normalized_path, norm_plex_prefix)
            translated = os.path.join(jellyfin_prefix, rel_path)
            return os.path.normpath(translated)

    return normalized_path


def get_jellyfin_user_id(username: str) -> str:
    """Retrieves Jellyfin User ID for target username."""
    url = f"{JELLYFIN_URL.rstrip('/')}/Users"
    res = requests.get(url, headers=JELLYFIN_HEADERS)
    res.raise_for_status()
    for user in res.json():
        if user.get("Name", "").lower() == username.lower():
            return user["Id"]
    raise ValueError(f"Jellyfin user '{username}' not found.")


def get_plex_items_with_file_paths() -> list:
    """Fetches movies and individual TV episodes with file paths directly from Plex."""
    print("[+] Querying Plex libraries (TV Shows and Movies only)...")
    sections_url = f"{PLEX_URL.rstrip('/')}/library/sections"
    res = requests.get(sections_url, headers=PLEX_HEADERS)
    res.raise_for_status()
    sections = res.json().get("MediaContainer", {}).get("Directory", [])

    plex_items = []

    for section in sections:
        sec_id = section["key"]
        sec_type = section.get("type")
        sec_title = section.get("title")

        if sec_type not in ALLOWED_PLEX_SECTIONS:
            print(f"[-] Skipping non-video Plex section: '{sec_title}' ({sec_type})")
            continue

        if sec_type == "movie":
            all_url = f"{PLEX_URL.rstrip('/')}/library/sections/{sec_id}/all?type=1"
        elif sec_type == "show":
            all_url = f"{PLEX_URL.rstrip('/')}/library/sections/{sec_id}/all?type=4"

        s_res = requests.get(all_url, headers=PLEX_HEADERS)
        if s_res.status_code != 200:
            continue

        items = s_res.json().get("MediaContainer", {}).get("Metadata", [])
        print(f"[+] Library '{sec_title}': Scanned {len(items)} media item(s).")

        for item in items:
            view_count = item.get("viewCount", 0)
            view_offset = item.get("viewOffset", 0)  # ms
            last_viewed_at = item.get("lastViewedAt")  # Unix timestamp

            if view_count > 0 or view_offset > 0:
                grandparent = item.get("grandparentTitle", "")
                title = f"{grandparent} - {item.get('title')}" if grandparent else item.get("title")

                media_list = item.get("Media", [])
                for media in media_list:
                    parts = media.get("Part", [])
                    for part in parts:
                        raw_file_path = part.get("file")
                        if raw_file_path:
                            plex_items.append({
                                "title": title,
                                "type": item.get("type"),
                                "plex_file_path": raw_file_path,
                                "translated_path": translate_path(raw_file_path),
                                "view_count": view_count,
                                "view_offset_ms": view_offset,
                                "last_viewed_at": last_viewed_at
                            })

    return plex_items


def get_jellyfin_file_map(user_id: str) -> dict:
    """Retrieves Jellyfin items restricted strictly to Movies and Episodes."""
    print("[+] Fetching Jellyfin Movie & TV Episode catalog...")
    url = f"{JELLYFIN_URL.rstrip('/')}/Users/{user_id}/Items"
    params = {
        "Recursive": "true",
        "Fields": "Path,UserData",
        "IncludeItemTypes": ALLOWED_JELLYFIN_TYPES
    }
    res = requests.get(url, headers=JELLYFIN_HEADERS, params=params)
    res.raise_for_status()

    items = res.json().get("Items", [])
    file_map = {}

    for item in items:
        file_path = item.get("Path")
        if file_path:
            norm_path = os.path.normpath(file_path)
            file_map[norm_path] = item

    return file_map


def update_jellyfin_watch_state(user_id: str, jf_item_id: str, view_count: int, view_offset_ms: int, last_viewed_at: int, days_cutoff: int, dry_run: bool):
    """Updates watch status, play count, position, and watch date according to strict watch/in-progress rules."""

    is_expired = False
    last_viewed_iso = None

    if last_viewed_at:
        last_viewed_dt = datetime.fromtimestamp(last_viewed_at)
        cutoff_dt = datetime.now() - timedelta(days=days_cutoff)
        if last_viewed_dt < cutoff_dt:
            is_expired = True

        last_viewed_iso = datetime.utcfromtimestamp(last_viewed_at).strftime('%Y-%m-%dT%H:%M:%S.000Z')

    # RULE 1: Watched items (view_count > 0) are ALWAYS marked as watched and date/play count updated
    if view_count > 0:
        played_url = f"{JELLYFIN_URL.rstrip('/')}/Users/{user_id}/PlayedItems/{jf_item_id}"
        userdata_url = f"{JELLYFIN_URL.rstrip('/')}/Users/{user_id}/Items/{jf_item_id}/UserData"

        params = {}
        if last_viewed_iso:
            params["DatePlayed"] = last_viewed_iso

        if dry_run:
            print(f"  [DRY RUN] Would mark as WATCHED with DatePlayed={last_viewed_iso} and PlayCount={view_count}.")
        else:
            # Mark played state with preserved watch date
            res_played = requests.post(played_url, headers=JELLYFIN_HEADERS, params=params)
            res_played.raise_for_status()

            # Explicitly sync total PlayCount and LastPlayedDate in UserData
            userdata_payload = {
                "Played": True,
                "PlayCount": view_count,
                "LastPlayedDate": last_viewed_iso,
                "PlaybackPositionTicks": 0
            }
            res_ud = requests.post(userdata_url, headers=JELLYFIN_HEADERS, json=userdata_payload)
            res_ud.raise_for_status()

            print(f"  [SUCCESS] Marked as WATCHED (PlayCount: {view_count}, Date: {last_viewed_iso}).")
        return

    # RULE 2: In-Progress items (view_count == 0 and view_offset_ms > 0)
    if view_count == 0 and view_offset_ms > 0:
        unplayed_url = f"{JELLYFIN_URL.rstrip('/')}/Users/{user_id}/PlayedItems/{jf_item_id}"
        userdata_url = f"{JELLYFIN_URL.rstrip('/')}/Users/{user_id}/Items/{jf_item_id}/UserData"

        # Case 2A: In-progress older than cutoff -> Reset position and mark unwatched
        if is_expired:
            if dry_run:
                print(f"  [DRY RUN] In-progress item last viewed > {days_cutoff} days ago ({datetime.fromtimestamp(last_viewed_at).strftime('%Y-%m-%d')}). Would mark UNWATCHED and clear position.")
            else:
                res_del = requests.delete(unplayed_url, headers=JELLYFIN_HEADERS)
                res_del.raise_for_status()

                payload = {
                    "Played": False,
                    "PlayCount": 0,
                    "PlaybackPositionTicks": 0,
                    "IsFavorite": False
                }
                res_pos = requests.post(userdata_url, headers=JELLYFIN_HEADERS, json=payload)
                res_pos.raise_for_status()

                print(f"  [SUCCESS] In-progress > {days_cutoff} days ago. Marked UNWATCHED & cleared position.")

        # Case 2B: In-progress within cutoff -> Keep resume position active
        else:
            ticks = view_offset_ms * 10000
            payload = {
                "PlaybackPositionTicks": ticks,
                "IsFavorite": False
            }
            if dry_run:
                print(f"  [DRY RUN] Would update active resume position to {view_offset_ms // 1000}s ({ticks} ticks).")
            else:
                res = requests.post(userdata_url, headers=JELLYFIN_HEADERS, json=payload)
                res.raise_for_status()
                print(f"  [SUCCESS] Updated active resume position to {view_offset_ms // 1000}s.")


# -------------------------------------------------------------------
# Main Execution
# -------------------------------------------------------------------
def main():
    parser = argparse.ArgumentParser(description="Sync watch status, play count, position, and date from Plex to Jellyfin.")
    parser.add_argument("--apply", action="store_true", help="Apply updates to Jellyfin (default is dry-run mode)")
    parser.add_argument("--days", type=int, default=DEFAULT_DAYS_CUTOFF, help=f"Set custom day cutoff threshold for in-progress items (default: {DEFAULT_DAYS_CUTOFF})")
    args = parser.parse_args()

    days_cutoff = args.days
    dry_run = not args.apply

    if dry_run:
        print(f"\n=== RUNNING IN DRY-RUN MODE (In-Progress Cutoff: {days_cutoff} days). Pass '--apply' to execute. ===\n")

    try:
        jf_user_id = get_jellyfin_user_id(JELLYFIN_USERNAME)
        print(f"[+] Matched Jellyfin User '{JELLYFIN_USERNAME}' (ID: {jf_user_id})")
    except Exception as e:
        print(f"[!] Error: {e}")
        sys.exit(1)

    plex_items = get_plex_items_with_file_paths()
    print(f"\n[+] Found {len(plex_items)} watched/in-progress TV/Movie file(s) in Plex.")

    jf_file_map = get_jellyfin_file_map(jf_user_id)
    print(f"[+] Indexed {len(jf_file_map)} TV/Movie media file(s) from Jellyfin.\n")

    matched_count = 0

    for item in plex_items:
        trans_path = item["translated_path"]
        jf_match = jf_file_map.get(trans_path)

        if jf_match:
            matched_count += 1
            jf_id = jf_match["Id"]
            print(f"[*] Matched [{item['type'].upper()}]: '{item['title']}'")
            print(f"    Plex File:     {item['plex_file_path']}")
            print(f"    Jellyfin File: {trans_path}")

            try:
                update_jellyfin_watch_state(
                    user_id=jf_user_id,
                    jf_item_id=jf_id,
                    view_count=item["view_count"],
                    view_offset_ms=item["view_offset_ms"],
                    last_viewed_at=item["last_viewed_at"],
                    days_cutoff=days_cutoff,
                    dry_run=dry_run
                )
            except Exception as e:
                print(f"  [ERROR] Failed to update Jellyfin: {e}")
        else:
            print(f"[!] No match for TV/Movie file:")
            print(f"    Plex File:       {item['plex_file_path']}")
            print(f"    Translated Path: {trans_path}")

    print("\n" + "=" * 60)
    print(f"Summary: Synchronized {matched_count} out of {len(plex_items)} TV/Movie file(s).")
    print("=" * 60)


if __name__ == "__main__":
    main()
