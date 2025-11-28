#!/usr/bin/env bash
# Automatyczny commit przy zamykaniu Obsidiana
set -euo pipefail

VAULT_PATH="/home/jakubc/git/eww"
cd "$VAULT_PATH"

# Sprawdź czy są zmiany
if [[ -z "$(git status --porcelain)" ]]; then
    echo "Brak zmian do commitowania"
    exit 0
fi

# Auto-stage wszystkich zmian
git add -A

# Commit (hook automatycznie ograniczy do 18 plików)
git commit -m "auto: zmiany przy zamykaniu Obsidiana - $(date '+%Y-%m-%d %H:%M')"

# Push jeśli skonfigurowane
# git push origin master 2>/dev/null || true

echo "✅ Auto-commit wykonany"
