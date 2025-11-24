#!/usr/bin/env bash
# Hook wykonywany przy zamykaniu Obsidiana
# Commituje zmiany z limitem 18 plików na commit

set -euo pipefail

readonly VAULT_DIR="/home/jakubc/git/eww"
readonly COMMIT_SCRIPT="${VAULT_DIR}/scripts/obsidian-commit-split.sh"

echo "🚪 Obsidian zamykany - sprawdzam zmiany..."

# Uruchom skrypt commitowania
if [[ -x "$COMMIT_SCRIPT" ]]; then
    "$COMMIT_SCRIPT"
else
    echo "❌ Skrypt commit nie jest wykonywalny: $COMMIT_SCRIPT"
    exit 1
fi
