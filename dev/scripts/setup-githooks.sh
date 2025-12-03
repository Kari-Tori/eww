#!/usr/bin/env bash
# setup-githooks.sh - Konfiguruje Git hooks dla wszystkich użytkowników repo
#
# Automatycznie wykonywane przez make install-hooks
# Wymaga uruchomienia raz po sklonowaniu repo

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
HOOKS_DIR="$REPO_ROOT/.githooks"

echo "🔧 Konfiguracja Git hooks dla eww..."

# Ustaw ścieżkę hooków na .githooks
git config core.hooksPath "$HOOKS_DIR"

# Sprawdź czy semver jest zainstalowane
if ! command -v semver &>/dev/null; then
    echo "⚠️  UWAGA: semver nie jest zainstalowane!"
    echo "   Zainstaluj: npm install -g semver"
    echo "   lub: brew install semver (macOS)"
    echo ""
    echo "   Pre-commit hook będzie działał z ograniczoną funkcjonalnością."
fi

# Sprawdź wykonalność hooków
if [[ -f "$HOOKS_DIR/pre-commit" ]]; then
    chmod +x "$HOOKS_DIR/pre-commit"
    echo "✅ Hook pre-commit aktywny"
fi

echo ""
echo "✅ Git hooks skonfigurowane pomyślnie!"
echo "   Hooks będą działać przy każdym commicie."
echo ""
echo "   Możesz pominąć hook jednorazowo przez:"
echo "   git commit --no-verify"
