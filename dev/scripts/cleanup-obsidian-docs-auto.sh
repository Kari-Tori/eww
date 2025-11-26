#!/usr/bin/env bash
set -euo pipefail

# Automatyczne usunięcie bez potwierdzenia (dla make clean-obsidian-docs)

readonly REPO_ROOT="/home/jakubc/git/eww"

cd "$REPO_ROOT"

FOLDERS_TO_DELETE=(
    "docs/infra/software/obsidian/official-en"
    "docs/infra/software/obsidian/official-pl"
    "docs/infra/software/obsidian/resources/hub"
    "docs/infra/software/obsidian/resources/api"
    "docs/infra/software/obsidian/resources/awesome"
    "docs/infra/software/obsidian/resources/releases"
    "docs/infra/software/obsidian/plugins/core/original"
)

echo "[INFO] Usuwanie pobranej dokumentacji Obsidian..."

for folder in "${FOLDERS_TO_DELETE[@]}"; do
    if [[ -d "$folder" ]]; then
        rm -rf "$folder"
        echo "[OK] Usunięto: $folder"
    fi
done

find docs/infra/software/obsidian/resources -type d -empty -delete 2>/dev/null || true
find docs/infra/software/obsidian/plugins -type d -empty -delete 2>/dev/null || true

echo "[OK] Cleanup zakończony. Pozostało $(find docs/infra/software/obsidian -name "*.md" 2>/dev/null | wc -l) plików .md"

