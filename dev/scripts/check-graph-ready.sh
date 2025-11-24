#!/usr/bin/env bash
set -euo pipefail

echo "=== GOTOWE DO TESTU W OBSIDIAN ==="
echo ""
echo "📊 Statystyki repo:"
echo "  • Commits: $(git log --oneline | wc -l)"
echo "  • Plików MD: $(find . -name "*.md" ! -path "./.obsidian/*" ! -path "./archive/*" | wc -l)"
echo "  • Max plików/commit: 18"
echo ""
echo "🎯 Commity z największą liczbą plików:"
git log --all --numstat --format="%H %s" | \
    awk 'NF==3 {files++} NF==2 {print files, $0; files=0}' | \
    sort -rn | head -10
echo ""
echo "📅 Timeline commitów:"
git log --oneline --graph --date=short --format="%h %ad %s" | head -20
echo ""
echo "✅ KROK 1: Zamknij Obsidiana (jeśli otwarty)"
echo "✅ KROK 2: Otwórz vault: /home/jakubc/git/eww"
echo "✅ KROK 3: Otwórz Graph View (Ctrl+G)"
echo "✅ KROK 4: Sprawdź czy graph się ładuje (powinno być ~477 plików)"
echo ""
echo "🔍 Debug w Obsidian:"
echo "  • Ctrl+Shift+I → Console"
echo "  • Sprawdź błędy związane z graph rendering"
echo ""
