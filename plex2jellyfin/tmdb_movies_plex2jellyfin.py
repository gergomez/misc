import os
import re
from plexapi.server import PlexServer
import requests

# -------------------------------------------------------------------
# Configuration
# -------------------------------------------------------------------
PLEX_URL = "http://server:32400"
PLEX_TOKEN = "plex-token"

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
    "Authorization": f'MediaBrowser Client="Python", Device="Script", DeviceId="plex-jellyfin-diff", Version="1.0.0", Token="{JELLYFIN_API_KEY}"',
    "Accept": "application/json",
    "Content-Type": "application/json"
}

# -------------------------------------------------------------------
# Helper Functions
# -------------------------------------------------------------------
def normalize_path(path: str) -> str:
    """Standardize path strings across OS and mount mappings."""
    if not path:
        return ""
    norm = os.path.normpath(path).replace("\\", "/")
    for old_prefix, new_prefix in PATH_REPLACEMENTS.items():
        if norm.startswith(old_prefix):
            norm = norm.replace(old_prefix, new_prefix, 1)
    return norm.lower()


def extract_plex_tmdb_id(item) -> str | None:
    """Extract TMDb ID from Plex movie Guids."""
    if hasattr(item, 'guids'):
        for guid_obj in item.guids:
            guid_str = getattr(guid_obj, 'id', '')
            if 'tmdb://' in guid_str:
                return guid_str.split('tmdb://')[-1]

    guid_str = getattr(item, 'guid', '')
    if 'themoviedb://' in guid_str:
        match = re.search(r'themoviedb://(\d+)', guid_str)
        if match:
            return match.group(1)
    return None


def fetch_plex_movies():
    """Fetch MOVIE items only and map normalized file paths to metadata from Plex."""
    print("[+] Connecting to Plex...")
    plex = PlexServer(PLEX_URL, PLEX_TOKEN)
    plex_map = {}

    # Filter libraries specifically for movie type
    movie_sections = [s for s in plex.library.sections() if s.type == 'movie']

    for section in movie_sections:
        print(f"    - Processing Plex Movie Library: '{section.title}'")
        for item in section.all():
            tmdb_id = extract_plex_tmdb_id(item)
            for media in getattr(item, 'media', []):
                for part in getattr(media, 'parts', []):
                    clean_path = normalize_path(part.file)
                    plex_map[clean_path] = {
                        "title": item.title,
                        "tmdb_id": tmdb_id,
                        "raw_path": part.file
                    }
    return plex_map


def fetch_jellyfin_movies():
    """Fetch MOVIE items only and map normalized file paths to full Jellyfin items."""
    print("[+] Connecting to Jellyfin...")
    url = f"{JELLYFIN_URL.rstrip('/')}/Items"
    params = {
        "Recursive": "true",
        "Fields": "Path,ProviderIds,MediaSources",
        "IncludeItemTypes": "Movie"  # Restrict strictly to Movies
    }

    response = requests.get(url, headers=JELLYFIN_HEADERS, params=params)
    response.raise_for_status()
    data = response.json().get("Items", [])

    jellyfin_map = {}
    for item in data:
        tmdb_id = item.get("ProviderIds", {}).get("Tmdb")
        title = item.get("Name")

        paths = []
        if item.get("Path"):
            paths.append(item["Path"])
        for source in item.get("MediaSources", []):
            if source.get("Path"):
                paths.append(source["Path"])

        for file_path in set(paths):
            clean_path = normalize_path(file_path)
            jellyfin_map[clean_path] = {
                "title": title,
                "tmdb_id": str(tmdb_id) if tmdb_id else None,
                "raw_path": file_path,
                "item_obj": item
            }
    return jellyfin_map


def update_jellyfin_tmdb_id(item_obj, new_tmdb_id):
    """Update TMDb ID on Jellyfin and trigger a metadata refresh."""
    item_id = item_obj["Id"]

    # 1. Update ProviderIds dictionary
    provider_ids = item_obj.get("ProviderIds", {})
    provider_ids["Tmdb"] = str(new_tmdb_id)
    item_obj["ProviderIds"] = provider_ids

    # 2. POST updated item object back
    update_url = f"{JELLYFIN_URL.rstrip('/')}/Items/{item_id}"
    res = requests.post(update_url, headers=JELLYFIN_HEADERS, json=item_obj)
    res.raise_for_status()

    # 3. Trigger Metadata & Artwork Refresh
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
def sync_movie_ids():
    plex_movies = fetch_plex_movies()
    jellyfin_movies = fetch_jellyfin_movies()

    mismatches = []

    for path, p_item in plex_movies.items():
        j_item = jellyfin_movies.get(path)

        if j_item:
            p_tmdb = p_item["tmdb_id"]
            j_tmdb = j_item["tmdb_id"]

            if p_tmdb and p_tmdb != j_tmdb:
                mismatches.append({
                    "title": p_item["title"],
                    "path": p_item["raw_path"],
                    "plex_tmdb": p_tmdb,
                    "jellyfin_tmdb": j_tmdb or "None",
                    "jellyfin_obj": j_item["item_obj"]
                })

    print("\n" + "=" * 80)
    print(f" Found {len(mismatches)} movie mismatch(es) to update on Jellyfin")
    print("=" * 80 + "\n")

    if not mismatches:
        print("All movie file matches between Plex and Jellyfin already share identical TMDb IDs!")
        return

    for idx, item in enumerate(mismatches, start=1):
        print(f"[{idx}/{len(mismatches)}] {item['title']}")
        print(f"  Path          : {item['path']}")
        print(f"  Current (JF)  : TMDb {item['jellyfin_tmdb']}")
        print(f"  Target (Plex) : TMDb {item['plex_tmdb']}")

        if DRY_RUN:
            print("  [DRY RUN] Skipping actual API update.\n")
        else:
            try:
                update_jellyfin_tmdb_id(item["jellyfin_obj"], item["plex_tmdb"])
                print("  [SUCCESS] Updated TMDb ID & triggered movie metadata refresh.\n")
            except Exception as e:
                print(f"  [ERROR] Failed to update: {e}\n")

    if DRY_RUN:
        print("=" * 80)
        print("Notice: DRY_RUN is set to True. Change DRY_RUN = False in the script to write changes.")
        print("=" * 80)


if __name__ == "__main__":
    sync_movie_ids()
