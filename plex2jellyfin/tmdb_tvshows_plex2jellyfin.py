import os
import re
from plexapi.server import PlexServer
import requests

# -------------------------------------------------------------------
# Configuration
# -------------------------------------------------------------------
PLEX_URL = "http://server:32400"
PLEX_TOKEN = "your-token"

JELLYFIN_URL = "http://server:8096"
JELLYFIN_API_KEY = "YOUR_API_KEY"

# Path translation/normalization (if Plex and Jellyfin use different mount points)
# Example: replace Plex path prefix "/data/media" with Jellyfin's "/mnt/media"
PATH_REPLACEMENTS = {
    "/volume1/video/MOVIES": "/media/movies",
    "/volume1/video/ANIME": "/media/anime",
    "/volume1/video/SERIES": "/media/series",
    "/volume1/video/DOCUS": "/media/docus",
}

# Set DRY_RUN = False to execute actual updates on Jellyfin
DRY_RUN = False

JELLYFIN_HEADERS = {
    "X-Emby-Token": JELLYFIN_API_KEY,
    "Authorization": f'MediaBrowser Client="Python", Device="Script", DeviceId="plex-jellyfin-tv-diff", Version="1.0.0", Token="{JELLYFIN_API_KEY}"',
    "Accept": "application/json",
    "Content-Type": "application/json"
}

# -------------------------------------------------------------------
# Helper Functions
# -------------------------------------------------------------------
def get_relative_show_path(full_path: str) -> str:
    """
    Extracts the relative path starting from the show directory name.
    Example: '/mnt/media/shows/Breaking Bad/Season 01/ep1.mkv' -> 'breaking bad'
    """
    if not full_path:
        return ""

    # Standardize path separators
    norm = os.path.normpath(full_path).replace("\\", "/").strip("/")
    parts = norm.split("/")

    # Search for season folder to identify show root directory
    for idx, part in enumerate(parts):
        if re.match(r'^(season\s*\d+|s\d+)', part, re.IGNORECASE):
            if idx > 0:
                return parts[idx - 1].lower()

    # Fallback: Return parent folder name if no season folder structure is found
    if len(parts) >= 2:
        return parts[-2].lower()
    return norm.lower()


def extract_plex_tmdb_id(show_item) -> str | None:
    """Extract TMDb ID from Plex TV Show Guids."""
    if hasattr(show_item, 'guids'):
        for guid_obj in show_item.guids:
            guid_str = getattr(guid_obj, 'id', '')
            if 'tmdb://' in guid_str:
                return guid_str.split('tmdb://')[-1]

    guid_str = getattr(show_item, 'guid', '')
    if 'themoviedb://' in guid_str:
        match = re.search(r'themoviedb://(\d+)', guid_str)
        if match:
            return match.group(1)
    return None


def fetch_plex_tv_shows():
    """Fetch all TV Series from Plex mapped by relative show folder name."""
    print("[+] Connecting to Plex...")
    plex = PlexServer(PLEX_URL, PLEX_TOKEN)
    plex_map = {}

    show_sections = [s for s in plex.library.sections() if s.type == 'show']

    for section in show_sections:
        print(f"    - Processing Plex TV Library: '{section.title}'")
        for show in section.all():
            tmdb_id = extract_plex_tmdb_id(show)

            # Retrieve file paths associated with episodes to extract the show directory name
            episodes = show.episodes()
            if episodes and hasattr(episodes[0], 'media'):
                sample_file = episodes[0].media[0].parts[0].file
                rel_key = get_relative_show_path(sample_file)

                if rel_key:
                    plex_map[rel_key] = {
                        "title": show.title,
                        "tmdb_id": tmdb_id,
                        "sample_path": sample_file
                    }
    return plex_map


def fetch_jellyfin_tv_shows():
    """Fetch all Series from Jellyfin mapped by relative show folder name."""
    print("[+] Connecting to Jellyfin...")
    url = f"{JELLYFIN_URL.rstrip('/')}/Items"
    params = {
        "Recursive": "true",
        "Fields": "Path,ProviderIds",
        "IncludeItemTypes": "Series"
    }

    response = requests.get(url, headers=JELLYFIN_HEADERS, params=params)
    response.raise_for_status()
    data = response.json().get("Items", [])

    jellyfin_map = {}
    for series in data:
        tmdb_id = series.get("ProviderIds", {}).get("Tmdb")
        title = series.get("Name")
        series_path = series.get("Path")

        if series_path:
            # Extract show directory name from the Series item path
            rel_key = os.path.basename(os.path.normpath(series_path)).lower()
            jellyfin_map[rel_key] = {
                "title": title,
                "tmdb_id": str(tmdb_id) if tmdb_id else None,
                "raw_path": series_path,
                "item_obj": series
            }
    return jellyfin_map


def update_jellyfin_series_tmdb(series_obj, new_tmdb_id):
    """Update TMDb ID on Jellyfin Series and trigger a metadata refresh."""
    item_id = series_obj["Id"]

    # 1. Update ProviderIds dictionary
    provider_ids = series_obj.get("ProviderIds", {})
    provider_ids["Tmdb"] = str(new_tmdb_id)
    series_obj["ProviderIds"] = provider_ids

    # 2. Save changes to Jellyfin
    update_url = f"{JELLYFIN_URL.rstrip('/')}/Items/{item_id}"
    res = requests.post(update_url, headers=JELLYFIN_HEADERS, json=series_obj)
    res.raise_for_status()

    # 3. Trigger Full Series Metadata Refresh
    refresh_url = f"{JELLYFIN_URL.rstrip('/')}/Items/{item_id}/Refresh"
    refresh_params = {
        "MetadataRefreshMode": "FullRefresh",
        "ImageRefreshMode": "FullRefresh",
        "ReplaceAllMetadata": "true"
    }
    ref_res = requests.post(refresh_url, headers=JELLYFIN_HEADERS, params=refresh_params)
    ref_res.raise_for_status()


# -------------------------------------------------------------------
# Execution
# -------------------------------------------------------------------
def sync_tv_show_ids():
    plex_shows = fetch_plex_tv_shows()
    jellyfin_shows = fetch_jellyfin_tv_shows()

    mismatches = []

    for rel_folder, p_show in plex_shows.items():
        j_show = jellyfin_shows.get(rel_folder)

        if j_show:
            p_tmdb = p_show["tmdb_id"]
            j_tmdb = j_show["tmdb_id"]

            if p_tmdb and p_tmdb != j_tmdb:
                mismatches.append({
                    "title": p_show["title"],
                    "folder": rel_folder,
                    "plex_tmdb": p_tmdb,
                    "jellyfin_tmdb": j_tmdb or "None",
                    "jellyfin_obj": j_show["item_obj"]
                })

    print("\n" + "=" * 80)
    print(f" Found {len(mismatches)} TV Show mismatch(es) to update on Jellyfin")
    print("=" * 80 + "\n")

    if not mismatches:
        print("All TV shows matched between Plex and Jellyfin already share identical TMDb IDs!")
        return

    for idx, item in enumerate(mismatches, start=1):
        print(f"[{idx}/{len(mismatches)}] {item['title']}")
        print(f"  Folder Match  : {item['folder']}")
        print(f"  Current (JF)  : TMDb {item['jellyfin_tmdb']}")
        print(f"  Target (Plex) : TMDb {item['plex_tmdb']}")

        if DRY_RUN:
            print("  [DRY RUN] Skipping actual API update.\n")
        else:
            try:
                update_jellyfin_series_tmdb(item["jellyfin_obj"], item["plex_tmdb"])
                print("  [SUCCESS] Updated TMDb ID & triggered TV show metadata refresh.\n")
            except Exception as e:
                print(f"  [ERROR] Failed to update: {e}\n")

    if DRY_RUN:
        print("=" * 80)
        print("Notice: DRY_RUN is set to True. Set DRY_RUN = False in the script to commit updates.")
        print("=" * 80)


if __name__ == "__main__":
    sync_tv_show_ids()
