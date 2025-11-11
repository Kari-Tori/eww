#!/usr/bin/env bash
# migrate-daily-from-import.sh
# Przenosi pliki .md z ImportedNotes/07_Codziennie do przegladu/ do Daily/
# Nadaje nazwy daily-YYYY-MM-DD.md na podstawie daty w nazwie lub mtime pliku.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_DIR="$ROOT_DIR/ImportedNotes/07_Codziennie do przegladu"
DEST_DIR="$ROOT_DIR/Daily"

mkdir -p "$DEST_DIR"

if [[ ! -d "$SRC_DIR" ]]; then
  echo "Brak katalogu źródłowego: $SRC_DIR" >&2
  exit 0
fi

shopt -s nullglob
count=0
for src in "$SRC_DIR"/*.md; do
  [[ -f "$src" ]] || continue
  filename="$(basename "$src")"

  # Spróbuj znaleźć datę YYYY-MM-DD w nazwie pliku
  if [[ "$filename" =~ ([0-9]{4}-[0-9]{2}-[0-9]{2}) ]]; then
    day="${BASH_REMATCH[1]}"
  else
    # użyj mtime pliku
    day="$(date -r "$src" +%Y-%m-%d)"
  fi

  dest_base="daily-$day.md"
  dest="$DEST_DIR/$dest_base"
  i=1
  while [[ -e "$dest" ]]; do
    dest="$DEST_DIR/daily-$day-$i.md"
    ((i++)) || true
  done

  # Dodaj nagłówek informujący o imporcie, jeśli brak frontmatter
  if ! sed -n '1,3p' "$src" | grep -q '^---'; then
    printf '---\nImportedFrom: ImportedVault/07_Codziennie do przegladu/%s\n---\n\n' "$filename" > /tmp/mig_hdr_$$.md
    cat "$src" >> /tmp/mig_hdr_$$.md
    mv /tmp/mig_hdr_$$.md "$src"
  fi

  mv "$src" "$dest"
  echo "Przeniesiono: $filename -> $(basename "$dest")"
  ((count++))
done

echo "Przeniesiono $count plik(ów) do $DEST_DIR"
exit 0
