import os
import sys
import re
import base64
import argparse
import requests

# -------------------------------------------------------------------
# Configuration
# -------------------------------------------------------------------
PLEX_URL = "http://server:32400"
PLEX_TOKEN = "plex-token"

JELLYFIN_URL = "http://server:8096"
JELLYFIN_API_KEY = "YOUR_API_KEY"

# Headers
PLEX_HEADERS = {
    "X-Plex-Token": PLEX_TOKEN,
    "Accept": "application/json"
}

JELLYFIN_HEADERS = {
    "X-Emby-Token": JELLYFIN_API_KEY,
    "Authorization": f'MediaBrowser Client="Python", Device="PosterSync", DeviceId="plex-jellyfin-poster-sync", Version="1.0.0", Token="{JELLYFIN_API_KEY}"'
}

# -------------------------------------------------------------------
# Helper Functions
# -------------------------------------------------------------------
def extract_tvdb_id(guids: list) -> str:
    """Extracts numeric TVDB ID from Plex GUIDs list."""
    for guid_obj in guids:
        guid_str = guid_obj.get("id", "")
        match = re.search(r'tvdb://(\d+)', guid_str, re.IGNORECASE)
        if match:
            return match.group(1)
    return ""


def get_plex_show_by_tvdb(tvdb_id: str) -> dict:
    """Queries Plex library sections for a TV show matching the target TVDB ID."""
    sections_url = f"{PLEX_URL.rstrip('/')}/library/sections"
    res = requests.get(sections_url, headers=PLEX_HEADERS)
    res.raise_for_status()
    sections = res.json().get("MediaContainer", {}).get("Directory", [])

    matched_show = None

    for section in sections:
        if section.get("type") == "show":
            sec_id = section["key"]
            all_shows_url = f"{PLEX_URL.rstrip('/')}/library/sections/{sec_id}/all"
            s_res = requests.get(all_shows_url, headers=PLEX_HEADERS)
            if s_res.status_code != 200:
                continue

            shows = s_res.json().get("MediaContainer", {}).get("Metadata", [])
            for show in shows:
                rating_key = show["ratingKey"]
                details_url = f"{PLEX_URL.rstrip('/')}/library/metadata/{rating_key}"
                d_res = requests.get(details_url, headers=PLEX_HEADERS)
                if d_res.status_code == 200:
                    full_show = d_res.json()["MediaContainer"]["Metadata"][0]
                    found_id = extract_tvdb_id(full_show.get("Guid", []))
                    if found_id == str(tvdb_id):
                        matched_show = full_show
                        break
            if matched_show:
                break

    if not matched_show:
        return None

    rating_key = matched_show["ratingKey"]

    # Fetch seasons for this show from Plex
    seasons_url = f"{PLEX_URL.rstrip('/')}/library/metadata/{rating_key}/children"
    seasons_res = requests.get(seasons_url, headers=PLEX_HEADERS)
    seasons_res.raise_for_status()
    seasons = seasons_res.json().get("MediaContainer", {}).get("Metadata", [])

    return {
        "title": matched_show["title"],
        "thumb": matched_show.get("thumb"),
        "tvdb_id": str(tvdb_id),
        "seasons": [
            {
                "title": s.get("title"),
                "index": s.get("index"),
                "thumb": s.get("thumb")
            }
            for s in seasons if s.get("thumb")
        ]
    }


def get_jellyfin_show_by_tvdb(tvdb_id: str) -> dict:
    """Finds matching TV show in Jellyfin by TVDB ID."""
    url = f"{JELLYFIN_URL.rstrip('/')}/Items"
    params = {
        "Recursive": "true",
        "Fields": "ProviderIds",
        "IncludeItemTypes": "Series"
    }

    res = requests.get(url, headers=JELLYFIN_HEADERS, params=params)
    res.raise_for_status()
    items = res.json().get("Items", [])

    jf_show = None
    for item in items:
        p_ids = item.get("ProviderIds", {})
        if p_ids.get("Tvdb") == str(tvdb_id) or p_ids.get("TVDB") == str(tvdb_id):
            jf_show = item
            break

    if not jf_show:
        return None

    series_id = jf_show["Id"]

    # Fetch seasons in Jellyfin
    seasons_url = f"{JELLYFIN_URL.rstrip('/')}/Shows/{series_id}/Seasons"
    s_res = requests.get(seasons_url, headers=JELLYFIN_HEADERS)
    s_res.raise_for_status()
    jf_seasons = s_res.json().get("Items", [])

    season_map = {}
    for s in jf_seasons:
        idx = s.get("IndexNumber")
        if idx is not None:
            season_map[idx] = s["Id"]

    return {
        "series_id": series_id,
        "title": jf_show.get("Name"),
        "seasons": season_map
    }


def download_image(plex_thumb_path: str) -> tuple[bytes, str]:
    """Downloads raw image binary data from Plex and detects its MIME type."""
    img_url = f"{PLEX_URL.rstrip('/')}{plex_thumb_path}"
    res = requests.get(img_url, headers=PLEX_HEADERS)
    res.raise_for_status()

    # Detect MIME type from Plex HTTP response header
    content_type = res.headers.get("Content-Type", "image/jpeg").split(";")[0].strip()
    return res.content, content_type


def upload_poster_to_jellyfin(jf_item_id: str, image_bytes: bytes, content_type: str = "image/jpeg"):
    """
    Uploads primary poster to Jellyfin.
    Encodes image to Base64 to prevent 500 'invalid format' parsing errors.
    """
    upload_url = f"{JELLYFIN_URL.rstrip('/')}/Items/{jf_item_id}/Images/Primary"

    # Base64 encode raw binary image data
    base64_payload = base64.b64encode(image_bytes).decode("utf-8")

    headers = dict(JELLYFIN_HEADERS)
    headers["Content-Type"] = content_type

    # 1. Post Base64 encoded string payload
    res = requests.post(upload_url, headers=headers, data=base64_payload)

    # 2. Fallback attempt using raw bytes if Base64 parsing is rejected
    if res.status_code in (400, 500):
        res = requests.post(upload_url, headers=headers, data=image_bytes)

    res.raise_for_status()


def sync_single_show(tvdb_id: str, dry_run: bool):
    """Executes poster synchronization for a single TVDB ID."""
    print(f"\n" + "=" * 60)
    print(f"[*] Processing TVDB ID: {tvdb_id}")
    print("=" * 60)

    plex_show = get_plex_show_by_tvdb(tvdb_id)
    if not plex_show:
        print(f"[!] Error: Show with TVDB ID '{tvdb_id}' not found in Plex.")
        return

    print(f"[+] Found Plex Show: '{plex_show['title']}' with {len(plex_show['seasons'])} season(s).")

    jf_show = get_jellyfin_show_by_tvdb(tvdb_id)
    if not jf_show:
        print(f"[!] Error: Could not find matching show in Jellyfin for TVDB ID '{tvdb_id}'.")
        return

    print(f"[+] Matched Jellyfin Show: '{jf_show['title']}' (Series ID: {jf_show['series_id']})")

    # 1. Sync Main Series Poster
    if plex_show["thumb"]:
        print(f"[*] Syncing Series Poster...")
        if dry_run:
            print("  [DRY RUN] Would download Plex poster and upload to Jellyfin Series.")
        else:
            try:
                img_bytes, content_type = download_image(plex_show["thumb"])
                upload_poster_to_jellyfin(jf_show["series_id"], img_bytes, content_type)
                print("  [SUCCESS] Series poster updated on Jellyfin.")
            except Exception as e:
                print(f"  [ERROR] Failed to update series poster: {e}")

    # 2. Sync Season Posters
    for season in plex_show["seasons"]:
        s_index = season["index"]
        s_title = season["title"]
        s_thumb = season["thumb"]

        jf_season_id = jf_show["seasons"].get(s_index)
        if not jf_season_id:
            print(f"[!] Warning: Season index {s_index} ('{s_title}') not found in Jellyfin. Skipping.")
            continue

        print(f"[*] Syncing {s_title} (Season {s_index})...")
        if dry_run:
            print(f"  [DRY RUN] Would update poster for Jellyfin Season ID: {jf_season_id}")
        else:
            try:
                img_bytes, content_type = download_image(s_thumb)
                upload_poster_to_jellyfin(jf_season_id, img_bytes, content_type)
                print(f"  [SUCCESS] {s_title} poster updated on Jellyfin.")
            except Exception as e:
                print(f"  [ERROR] Failed to update {s_title} poster: {e}")


# -------------------------------------------------------------------
# Main Execution
# -------------------------------------------------------------------
def main():
    parser = argparse.ArgumentParser(description="Sync TV show and season posters from Plex to Jellyfin using TVDB IDs.")
    parser.add_argument("tvdb_ids", nargs="*", help="One or more space-separated TVDB IDs (e.g., 81189 73739)")
    parser.add_argument("-f", "--file", type=str, help="Path to a text file containing TVDB IDs")
    parser.add_argument("--apply", action="store_true", help="Execute real updates on Jellyfin (default is dry-run)")
    args = parser.parse_args()

    target_ids = list(args.tvdb_ids)

    # Read IDs from text file if provided
    if args.file:
        if not os.path.isfile(args.file):
            print(f"[!] Error: File '{args.file}' not found.")
            sys.exit(1)
        with open(args.file, "r", encoding="utf-8") as f:
            content = f.read()
            file_ids = re.split(r'[\s,]+', content)
            target_ids.extend([i.strip() for i in file_ids if i.strip()])

    # Deduplicate while preserving order
    unique_ids = list(dict.fromkeys(target_ids))

    if not unique_ids:
        print("[!] Error: No TVDB IDs specified. Pass them as arguments or via '--file'.")
        parser.print_help()
        sys.exit(1)

    dry_run = not args.apply
    if dry_run:
        print("\n=== RUNNING IN DRY-RUN MODE (No changes will be applied). Use '--apply' to make updates. ===")

    for tvdb_id in unique_ids:
        sync_single_show(tvdb_id, dry_run)


if __name__ == "__main__":
    main()
