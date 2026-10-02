import os
import re
from plexapi.server import PlexServer
import requests

DRY_RUN = True

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

JELLYFIN_HEADERS = {
    "X-Emby-Token": JELLYFIN_API_KEY,
    "Authorization": f'MediaBrowser Client="Python", Device="Script", DeviceId="plex-jf-ordering-sync", Version="1.1.0", Token="{JELLYFIN_API_KEY}"',
    "Accept": "application/json",
    "Content-Type": "application/json"
}

# -------------------------------------------------------------------
# Helper Functions
# -------------------------------------------------------------------
def normalize_and_translate_path(path: str) -> str:
    """Standardizes path slashes and applies PATH_REPLACEMENTS."""
    if not path:
        return ""

    norm = os.path.normpath(path).replace("\\", "/")

    for old_prefix, new_prefix in PATH_REPLACEMENTS.items():
        old_prefix_norm = os.path.normpath(old_prefix).replace("\\", "/")
        new_prefix_norm = os.path.normpath(new_prefix).replace("\\", "/")

        if norm.lower().startswith(old_prefix_norm.lower()):
            norm = new_prefix_norm + norm[len(old_prefix_norm):]
            break

    return norm.lower()


def get_series_path_from_file(file_path: str) -> str:
    """Extracts full show root directory path from an episode file path."""
    if not file_path:
        return ""

    translated_path = normalize_and_translate_path(file_path)
    parts = translated_path.split("/")

    for idx, part in enumerate(parts):
        if re.match(r'^(season\s*\d+|s\d+|specials)', part, re.IGNORECASE):
            if idx > 0:
                return "/".join(parts[:idx])

    if len(parts) >= 2:
        return "/".join(parts[:-1])
    return translated_path


def extract_plex_provider_ids(show_item) -> dict:
    """Extracts TVDb and TMDB IDs from Plex show Guids."""
    ids = {"tvdb": None, "tmdb": None}

    if hasattr(show_item, 'guids'):
        for guid_obj in show_item.guids:
            guid_str = getattr(guid_obj, 'id', '')
            if 'tvdb://' in guid_str:
                ids["tvdb"] = guid_str.split('tvdb://')[-1]
            elif 'tmdb://' in guid_str:
                ids["tmdb"] = guid_str.split('tmdb://')[-1]

    guid_str = getattr(show_item, 'guid', '')
    if not ids["tvdb"] and 'thetvdb://' in guid_str:
        match = re.search(r'thetvdb://(\d+)', guid_str)
        if match:
            ids["tvdb"] = match.group(1)
    if not ids["tmdb"] and 'themoviedb://' in guid_str:
        match = re.search(r'themoviedb://(\d+)', guid_str)
        if match:
            ids["tmdb"] = match.group(1)

    return ids


def translate_plex_ordering(plex_order: str) -> tuple[str, str]:
    """
    Translates Plex showOrdering setting into:
    1. Jellyfin DisplayOrder ('Aired', 'Absolute', 'Dvd')
    2. Primary Provider Type ('TVDb' or 'TMDB')
    """
    if not plex_order:
        return "Aired", "TVDb"

    order_lower = plex_order.lower()

    if "absolute" in order_lower:
        return "Absolute", "TVDb"
    elif "dvd" in order_lower:
        return "Dvd", "TVDb"
    elif "tmdb" in order_lower:
        # Jellyfin uses standard Aired order structure for TMDB metadata
        return "Aired", "TMDB"
    else:
        return "Aired", "TVDb"


def fetch_plex_tv_data() -> dict:
    """Fetches TV series from Plex mapped by full translated show path."""
    print("[+] Connecting to Plex...")
    plex = PlexServer(PLEX_URL, PLEX_TOKEN)
    plex_map = {}

    show_sections = [s for s in plex.library.sections() if s.type == 'show']

    for section in show_sections:
        print(f"    - Processing Plex TV Library: '{section.title}'")
        for show in section.all():
            provider_ids = extract_plex_provider_ids(show)
            raw_ordering = getattr(show, 'showOrdering', None) or getattr(show, 'episodeOrdering', None)
            jf_ordering, source_agent = translate_plex_ordering(raw_ordering)

            episodes = show.episodes()
            if episodes and hasattr(episodes[0], 'media'):
                sample_file = episodes[0].media[0].parts[0].file
                series_full_path = get_series_path_from_file(sample_file)

                if series_full_path:
                    plex_map[series_full_path] = {
                        "title": show.title,
                        "tvdb_id": provider_ids["tvdb"],
                        "tmdb_id": provider_ids["tmdb"],
                        "display_order": jf_ordering,
                        "source_agent": source_agent,
                        "raw_ordering": raw_ordering
                    }
    return plex_map


def fetch_jellyfin_tv_data() -> dict:
    """Fetches TV series from Jellyfin mapped by their full normalized directory path."""
    print("[+] Connecting to Jellyfin...")
    url = f"{JELLYFIN_URL.rstrip('/')}/Items"
    params = {
        "Recursive": "true",
        "Fields": "Path,ProviderIds,DisplayOrder",
        "IncludeItemTypes": "Series"
    }

    res = requests.get(url, headers=JELLYFIN_HEADERS, params=params)
    res.raise_for_status()
    data = res.json().get("Items", [])

    jellyfin_map = {}
    for series in data:
        p_ids = series.get("ProviderIds", {})
        tvdb_id = p_ids.get("Tvdb")
        tmdb_id = p_ids.get("Tmdb")
        series_path = series.get("Path")
        display_order = series.get("DisplayOrder", "Aired")

        if series_path:
            clean_path = os.path.normpath(series_path).replace("\\", "/").lower()
            jellyfin_map[clean_path] = {
                "title": series.get("Name"),
                "tvdb_id": str(tvdb_id) if tvdb_id else None,
                "tmdb_id": str(tmdb_id) if tmdb_id else None,
                "display_order": display_order,
                "item_obj": series
            }
    return jellyfin_map


def update_jellyfin_series(series_obj, new_tvdb_id, new_tmdb_id, new_display_order):
    """Updates Provider IDs & DisplayOrder on Jellyfin and triggers a metadata refresh."""
    item_id = series_obj["Id"]
    provider_ids = series_obj.get("ProviderIds", {})

    # Set TVDb and TMDB Provider IDs
    if new_tvdb_id:
        provider_ids["Tvdb"] = str(new_tvdb_id)
    if new_tmdb_id:
        provider_ids["Tmdb"] = str(new_tmdb_id)

    series_obj["ProviderIds"] = provider_ids
    series_obj["DisplayOrder"] = new_display_order

    # Save changes to Jellyfin
    update_url = f"{JELLYFIN_URL.rstrip('/')}/Items/{item_id}"
    res = requests.post(update_url, headers=JELLYFIN_HEADERS, json=series_obj)
    res.raise_for_status()


# -------------------------------------------------------------------
# Execution
# -------------------------------------------------------------------
def main():
    plex_shows = fetch_plex_tv_data()
    jellyfin_shows = fetch_jellyfin_tv_data()

    to_update = []

    for path, p_show in plex_shows.items():
        j_show = jellyfin_shows.get(path)

        if j_show:
            p_tvdb = p_show["tvdb_id"]
            p_tmdb = p_show["tmdb_id"]
            p_order = p_show["display_order"]

            j_tvdb = j_show["tvdb_id"]
            j_tmdb = j_show["tmdb_id"]
            j_order = j_show["display_order"]

            tvdb_mismatch = (p_tvdb and p_tvdb != j_tvdb)
            tmdb_mismatch = (p_tmdb and p_tmdb != j_tmdb)
            order_mismatch = (p_order != j_order)

            if tvdb_mismatch or tmdb_mismatch or order_mismatch:
                to_update.append({
                    "title": p_show["title"],
                    "path": path,
                    "source_agent": p_show["source_agent"],
                    "plex_tvdb": p_tvdb or "None",
                    "jellyfin_tvdb": j_tvdb or "None",
                    "plex_tmdb": p_tmdb or "None",
                    "jellyfin_tmdb": j_tmdb or "None",
                    "plex_order": p_order,
                    "jellyfin_order": j_order,
                    "jellyfin_obj": j_show["item_obj"]
                })

    print("\n" + "=" * 80)
    print(f" Found {len(to_update)} TV show(s) requiring synchronization on Jellyfin")
    print("=" * 80 + "\n")

    if not to_update:
        print("All TV shows are fully synchronized across Plex and Jellyfin!")
        return

    for idx, item in enumerate(to_update, start=1):
        print(f"[{idx}/{len(to_update)}] {item['title']}")
        print(f"  Plex Agent Mode : {item['source_agent']}")
        print(f"  Matched Path    : {item['path']}")
        print(f"  TVDb ID         : Plex={item['plex_tvdb']} | Jellyfin={item['jellyfin_tvdb']}")
        print(f"  TMDB ID         : Plex={item['plex_tmdb']} | Jellyfin={item['jellyfin_tmdb']}")
        print(f"  Display Order   : Plex={item['plex_order']} | Jellyfin={item['jellyfin_order']}")

        if DRY_RUN:
            print("  [DRY RUN] Update skipped.\n")
        else:
            try:
                update_jellyfin_series(
                    item["jellyfin_obj"],
                    item["plex_tvdb"] if item["plex_tvdb"] != "None" else None,
                    item["plex_tmdb"] if item["plex_tmdb"] != "None" else None,
                    item["plex_order"]
                )
                print("  [SUCCESS] Series updated & metadata refresh queued.\n")
            except Exception as e:
                print(f"  [ERROR] Failed to update series: {e}\n")

    if DRY_RUN:
        print("=" * 80)
        print("Notice: DRY_RUN is True. Set DRY_RUN = False in the script to save changes.")
        print("=" * 80)


if __name__ == "__main__":
    main()
