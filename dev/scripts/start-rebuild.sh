#!/usr/bin/env bash
set -euo pipefail

echo "🔍 Stan przed rebuild:"
echo "  Commits: $(git log --oneline 2>/dev/null | wc -l)"
echo "  Pliki MD: $(find . -name "*.md" ! -path "./.obsidian/*" ! -path "./archive/*" | wc -l)"
echo ""

read -p "❓ Czy zresetować historię Git i odbudować z max 18 plików/commit? (tak/nie): " answer

if [[ "$answer" == "tak" ]]; then
    echo "🚀 Uruchamiam rebuild..."
    ./rebuild-git-history.sh
else
    echo "❌ Anulowano"
fi
