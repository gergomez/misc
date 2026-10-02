import os
import sys
import shutil
import sqlite3
import argparse
from datetime import datetime, timedelta

# ==========================================
# CONFIGURATION
# ==========================================

# Path to jellyfin.db on your host machine
DB_PATH = r"jellyfin.db"

# ==========================================
# HELPER FUNCTIONS
# ==========================================

def create_db_backup(db_path: str):
    """Creates a timestamped backup copy of jellyfin.db."""
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_path = f"{db_path}.backup_{timestamp}"
    shutil.copy2(db_path, backup_path)
    print(f"[+] Backup created at: {backup_path}")


# ==========================================
# MAIN EXECUTION
# ==========================================

def main():
    parser = argparse.ArgumentParser(
        description="Find and remove orphaned trailer records in jellyfin.db whose OwnerId does not point to a valid movie."
    )
    parser.add_argument("--apply", action="store_true", help="Apply changes to jellyfin.db (default is dry-run mode)")
    parser.add_argument("--dry-run", action="store_true", help="Explicitly enable dry-run mode (default behavior)")
    parser.add_argument("--hours", type=float, default=None, help="Limit check to trailers created/modified in the last X hours")
    args = parser.parse_args()

    # Dry run is true by default unless --apply is passed
    dry_run = not args.apply

    if dry_run:
        print("\n=== DRY-RUN MODE (No changes written). Pass '--apply' to delete orphan records. ===\n")
    else:
        print("\n=== APPLY MODE: Writing changes to SQLite DB ===\n")

    if not os.path.exists(DB_PATH):
        print(f"[!] Database file not found at: {DB_PATH}")
        sys.exit(1)

    if not dry_run:
        create_db_backup(DB_PATH)

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # Base query for selecting trailer items with an OwnerId set
    query = """
        SELECT Id, Name, Path, OwnerId, DateCreated
        FROM BaseItems
        WHERE (Type LIKE '%Trailer%' OR ExtraType = 2 OR UnratedType = 'Trailer')
          AND OwnerId IS NOT NULL AND OwnerId != ''
    """
    params = []

    if args.hours is not None:
        cutoff_dt = datetime.utcnow() - timedelta(hours=args.hours)
        cutoff_str = cutoff_dt.strftime('%Y-%m-%d %H:%M:%S')
        query += " AND (DateCreated >= ? OR DateModified >= ?)"
        params.extend([cutoff_str, cutoff_str])
        print(f"[+] Filtering trailers created/modified in the last {args.hours} hour(s)...")

    print("[+] Fetching trailer records from BaseItems...")
    cursor.execute(query, params)
    trailers = cursor.fetchall()
    print(f"[+] Found {len(trailers)} trailer candidate(s) with an OwnerId link.\n")

    orphaned_count = 0

    for trailer_id, trailer_name, trailer_path, owner_id, date_created in trailers:
        # Check if the parent item (Movie) exists in BaseItems
        cursor.execute("SELECT Id, Name FROM BaseItems WHERE Id = ?", (owner_id,))
        parent_movie = cursor.fetchone()

        if not parent_movie:
            orphaned_count += 1
            print(f"[-] Orphaned Trailer Found:")
            print(f"    Trailer ID:   {trailer_id}")
            print(f"    Trailer Path: {trailer_path}")
            print(f"    Missing Movie OwnerId: {owner_id}")

            if dry_run:
                print("    [DRY-RUN] Would delete trailer record from database (file unaffected).\n")
            else:
                cursor.execute("DELETE FROM BaseItems WHERE Id = ?", (trailer_id,))
                print("    [+] Deleted orphaned trailer record from database.\n")

    if not dry_run and orphaned_count > 0:
        conn.commit()
        print("=" * 60)
        print(f"Successfully deleted {orphaned_count} orphaned trailer record(s) from SQLite.")
        print("Please restart your Jellyfin server to refresh the in-memory cache.")
        print("=" * 60)
    elif dry_run:
        print("=" * 60)
        print(f"Dry-run complete. Found {orphaned_count} orphaned trailer record(s).")
        print("Run with '--apply' to execute database changes.")
        print("=" * 60)
    else:
        print("=" * 60)
        print("No orphaned trailers found. Database is clean.")
        print("=" * 60)

    conn.close()


if __name__ == "__main__":
    main()
