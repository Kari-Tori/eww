#!/usr/bin/env bash
set -euo pipefail

# Safe archive helper for backup files. Default: dry-run (list candidates).
# Use --apply to actually move files into archive/backups.

ARCHIVE_DIR="$(dirname "$0")/../archive/backups"
DRY_RUN=1

usage(){
  cat <<EOF
Usage: $0 [--apply|--list]

--list   Show candidate files (default)
--apply  Move candidates into ${ARCHIVE_DIR} (creates dir if needed)
EOF
}

if [[ ${#} -gt 0 ]]; then
  case "$1" in
    --apply) DRY_RUN=0 ;;
    --list) DRY_RUN=1 ;;
    -h|--help) usage; exit 0 ;;
    *) usage; exit 2 ;;
  esac
fi

mkdir -p "$ARCHIVE_DIR"

shopt -s nullglob

# Collect only regular files matching common backup patterns. Skip archive dir.
files=()
for f in init-eww.sh.bak* *.bak *' (1)'; do
  # skip non-existing expansions
  [[ -e "$f" ]] || continue
  # only regular files
  [[ -f "$f" ]] || continue
  case "$f" in
    archive/*) continue ;;
  esac
  files+=("$f")
done

if [[ ${#files[@]} -eq 0 ]]; then
  echo "No backup candidates found."
  exit 0
fi

echo "Found ${#files[@]} candidate(s):"
printf '  %s
' "${files[@]}"

if [[ $DRY_RUN -eq 1 ]]; then
  echo
  echo "Dry run — no files moved. Run with --apply to move the files to: $ARCHIVE_DIR"
  exit 0
fi

echo
echo "Applying — moving files to $ARCHIVE_DIR"
for f in "${files[@]}"; do
  ts=$(date +%Y%m%d%H%M%S)
  base=$(basename "$f")
  dest="$ARCHIVE_DIR/${base}.archived.${ts}"
  echo "  mv '$f' -> '$dest'"
  mv -- "$f" "$dest"
done

echo "Done."
