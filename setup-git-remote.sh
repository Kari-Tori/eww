#!/usr/bin/env bash
# Setup Git remote dla eww vault
set -euo pipefail

echo "🔍 Sprawdzam czy repo istnieje na GitHub..."

# Sprawdź czy gh jest zalogowane
if ! gh auth status &>/dev/null; then
    echo "❌ Zaloguj się do GitHub CLI:"
    echo "   gh auth login"
    exit 1
fi

# Sprawdź czy repo eww istnieje
if gh repo view jakubc/eww &>/dev/null; then
    echo "✅ Repo jakubc/eww istnieje!"
    REPO_URL="git@github.com:jakubc/eww.git"
else
    echo "📝 Tworzę nowe prywatne repo jakubc/eww..."
    gh repo create eww --private --description "E-Waste Workshop - narzędzia Bash + Obsidian vault" --source=. --remote=origin
    REPO_URL="git@github.com:jakubc/eww.git"
fi

# Dodaj remote jeśli nie ma
if ! git remote get-url origin &>/dev/null; then
    echo "➕ Dodaję remote origin..."
    git remote add origin "$REPO_URL"
else
    echo "✅ Remote origin już istnieje"
fi

echo ""
echo "🎯 GOTOWE! Możesz teraz:"
echo "   git push -u origin master"
echo ""
echo "🔧 W Obsidian włącz plugin Obsidian Git:"
echo "   Settings → Community Plugins → Obsidian Git → Enable"
