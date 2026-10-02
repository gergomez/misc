import sys
import os
import re
import json
import argparse
import requests
from collections import defaultdict

# -------------------------------------------------------------------
# Fix Console Encoding (Windows UTF-8 Compatibility)
# -------------------------------------------------------------------
if sys.stdout.encoding and sys.stdout.encoding.lower() != 'utf-8':
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')
if sys.stderr.encoding and sys.stderr.encoding.lower() != 'utf-8':
    sys.stderr.reconfigure(encoding='utf-8', errors='replace')

# -------------------------------------------------------------------
# Configuration Defaults
# -------------------------------------------------------------------
JELLYFIN_URL = "http://server:8096"
JELLYFIN_API_KEY = "YOUR_API_KEY"
JELLYFIN_USERNAME = "your_user"

MAPPING_FILE = "collection_mappings.json"

# Headers
JELLYFIN_HEADERS = {
    "X-Emby-Token": JELLYFIN_API_KEY,
    "Authorization": f'MediaBrowser Client="Python", Device="CollectionBuilder", DeviceId="jellyfin-auto-collections", Version="1.0.0", Token="{JELLYFIN_API_KEY}"',
    "Content-Type": "application/json"
}


# -------------------------------------------------------------------
# Helper Functions
# -------------------------------------------------------------------
def get_jellyfin_user_id(username: str) -> str:
    """Retrieves Jellyfin User ID for target username."""
    url = f"{JELLYFIN_URL.rstrip('/')}/Users"
    res = requests.get(url, headers=JELLYFIN_HEADERS)
    res.raise_for_status()
    for user in res.json():
        if user.get("Name", "").lower() == username.lower():
            return user["Id"]
    raise ValueError(f"Jellyfin user '{username}' not found.")


def clean_collection_name(folder_name: str) -> str:
    """Cleans year ranges, resolutions, or unwanted tags from subfolder names."""
    cleaned = re.sub(r'[\(\[\{]\d{4}(-\d{4})?[\)\]\}]', '', folder_name)
    cleaned = re.sub(r'[\(\[\{].*?[\)\]\}]', '', cleaned)
    return cleaned.strip()


def load_or_create_mappings(grouped_movies: dict, min_movies: int) -> dict:
    """
    Loads mapping file or creates it if it doesn't exist.
    Adds new folders, setting enabled=False if count < min_movies.
    """
    mappings = {}

    if os.path.exists(MAPPING_FILE):
        try:
            with open(MAPPING_FILE, "r", encoding="utf-8") as f:
                mappings = json.load(f)
            print(f"[+] Loaded existing mapping file: '{MAPPING_FILE}'")
        except Exception as e:
            print(f"[!] Warning: Could not read mapping file '{MAPPING_FILE}'. Recreating... ({e})")

    file_updated = False

    for folder, movies in sorted(grouped_movies.items()):
        movie_count = len(movies)
        should_enable = movie_count >= min_movies

        if folder not in mappings:
            mappings[folder] = {
                "collection_name": clean_collection_name(folder),
                "enabled": should_enable
            }
            file_updated = True
        else:
            if "_comment" in mappings[folder]:
                del mappings[folder]["_comment"]
                file_updated = True

    if file_updated or not os.path.exists(MAPPING_FILE):
        with open(MAPPING_FILE, "w", encoding="utf-8") as f:
            json.dump(mappings, f, indent=4, ensure_ascii=False)
        print(f"[+] Saved mapping configuration to: '{MAPPING_FILE}'")

    return mappings


def get_movies_grouped_by_subfolder(user_id: str) -> tuple:
    """Queries Jellyfin for Movies and groups them by parent subfolder name."""
    print("[+] Fetching movies catalog from Jellyfin...")
    url = f"{JELLYFIN_URL.rstrip('/')}/Users/{user_id}/Items"
    params = {
        "Recursive": "true",
        "Fields": "Path",
        "IncludeItemTypes": "Movie"
    }
    res = requests.get(url, headers=JELLYFIN_HEADERS, params=params)
    res.raise_for_status()

    movies = res.json().get("Items", [])
    print(f"[+] Found {len(movies)} movie(s) in Jellyfin.")

    subfolder_groups = defaultdict(list)
    discovered_folders = set()

    for movie in movies:
        file_path = movie.get("Path")
        movie_id = movie.get("Id")
        title = movie.get("Name")

        if not file_path:
            continue

        parent_dir = os.path.dirname(os.path.normpath(file_path))
        grandparent_dir = os.path.dirname(parent_dir)
        subfolder_name = os.path.basename(parent_dir)

        if subfolder_name and grandparent_dir:
            discovered_folders.add(subfolder_name)
            subfolder_groups[subfolder_name].append({
                "id": movie_id,
                "title": title,
                "file_path": file_path
            })

    return subfolder_groups, discovered_folders


def get_existing_collections_with_items() -> dict:
    """
    Fetches all existing collections and maps lowercase collection names
    to a dict containing collection ID and a set of item IDs currently inside.
    """
    print("[+] Fetching existing collections and their contents...")
    url = f"{JELLYFIN_URL.rstrip('/')}/Items"
    params = {
        "Recursive": "true",
        "IncludeItemTypes": "BoxSet"
    }
    res = requests.get(url, headers=JELLYFIN_HEADERS, params=params)
    res.raise_for_status()

    collections = res.json().get("Items", [])
    existing = {}

    for col in collections:
        col_id = col["Id"]
        col_name = col["Name"]

        # Query items inside this collection
        col_items_url = f"{JELLYFIN_URL.rstrip('/')}/Items"
        col_params = {
            "ParentId": col_id,
            "Recursive": "true"
        }
        item_res = requests.get(col_items_url, headers=JELLYFIN_HEADERS, params=col_params)
        item_res.raise_for_status()

        item_ids = {item["Id"] for item in item_res.json().get("Items", [])}
        existing[col_name.lower()] = {
            "id": col_id,
            "name": col_name,
            "item_ids": item_ids
        }

    print(f"[+] Found {len(existing)} existing collection(s) in Jellyfin.")
    return existing


def sync_collection(collection_name: str, target_movie_ids: list, existing_collections: dict, dry_run: bool):
    """
    Creates collection if missing, or adds missing movie IDs to an existing collection.
    """
    col_name_lower = collection_name.lower()
    target_id_set = set(target_movie_ids)

    # Case 1: Collection already exists
    if col_name_lower in existing_collections:
        col_info = existing_collections[col_name_lower]
        collection_id = col_info["id"]
        current_item_ids = col_info["item_ids"]

        # Calculate missing movie IDs
        missing_ids = list(target_id_set - current_item_ids)

        if not missing_ids:
            print(f"  [OK] Collection '{collection_name}' is already up to date ({len(current_item_ids)} items).")
            return

        print(f"  [UPDATE] Found {len(missing_ids)} missing movie(s) for collection '{collection_name}'.")

        if dry_run:
            print(f"  [DRY RUN] Would ADD {len(missing_ids)} missing movie(s) to collection ID: {collection_id}")
            return

        url = f"{JELLYFIN_URL.rstrip('/')}/Collections/{collection_id}/Items"
        params = {"Ids": ",".join(missing_ids)}
        res = requests.post(url, headers=JELLYFIN_HEADERS, params=params)
        res.raise_for_status()
        print(f"  [SUCCESS] Added {len(missing_ids)} missing movie(s) to '{collection_name}'.")

    # Case 2: Create new collection
    else:
        print(f"  [CREATE] Collection '{collection_name}' does not exist.")

        if dry_run:
            print(f"  [DRY RUN] Would CREATE NEW collection '{collection_name}' with {len(target_movie_ids)} movie(s).")
            return

        url = f"{JELLYFIN_URL.rstrip('/')}/Collections"
        params = {
            "Name": collection_name,
            "Ids": ",".join(target_movie_ids)
        }
        res = requests.post(url, headers=JELLYFIN_HEADERS, params=params)
        res.raise_for_status()
        print(f"  [SUCCESS] Created collection '{collection_name}' with {len(target_movie_ids)} movie(s).")


# -------------------------------------------------------------------
# Main Execution
# -------------------------------------------------------------------
def main():
    parser = argparse.ArgumentParser(description="Create and sync Jellyfin movie collections using editable folder mappings.")
    parser.add_argument("--apply", action="store_true", help="Apply updates to Jellyfin (default is dry-run mode)")
    parser.add_argument("--min-movies", type=int, default=2, help="Minimum number of movies required to enable collection creation (default: 2)")
    args = parser.parse_args()

    dry_run = not args.apply

    if dry_run:
        print("\n=== RUNNING IN DRY-RUN MODE (No changes applied). Pass '--apply' to execute. ===\n")

    try:
        user_id = get_jellyfin_user_id(JELLYFIN_USERNAME)
        print(f"[+] Matched Jellyfin User '{JELLYFIN_USERNAME}' (ID: {user_id})")
    except Exception as e:
        print(f"[!] Error: {e}")
        sys.exit(1)

    grouped_movies, _ = get_movies_grouped_by_subfolder(user_id)
    mappings = load_or_create_mappings(grouped_movies, args.min_movies)
    existing_collections = get_existing_collections_with_items()

    processed_count = 0

    for subfolder_name, movies in sorted(grouped_movies.items()):
        folder_config = mappings.get(subfolder_name, {})

        if not folder_config.get("enabled", True):
            print(f"\n[-] Skipping folder '{subfolder_name}' (enabled: false in {MAPPING_FILE})")
            continue

        target_collection_name = folder_config.get("collection_name", clean_collection_name(subfolder_name))

        processed_count += 1
        movie_ids = [m["id"] for m in movies]

        print(f"\n[*] Syncing Folder: '{subfolder_name}' ---> Collection: '{target_collection_name}' ({len(movies)} movies found)")
        for m in movies:
            print(f"    - {m['title']} ({m['file_path']})")

        try:
            sync_collection(target_collection_name, movie_ids, existing_collections, dry_run)
        except Exception as e:
            print(f"  [ERROR] Failed to sync collection '{target_collection_name}': {e}")

    print("\n" + "=" * 60)
    print(f"Summary: Evaluated {processed_count} collection mapping(s) against Jellyfin.")
    print("=" * 60)


if __name__ == "__main__":
    main()
