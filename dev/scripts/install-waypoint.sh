#!/usr/bin/env bash
# Instalacja Waypoint plugin dla Obsidian
set -euo pipefail

VAULT="${1:-/home/jakubc/git/eww}"
PLUGIN_DIR="$VAULT/.obsidian/plugins/waypoint"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

echo "📥 Pobieram pliki pluginu Waypoint z GitHub..."
RELEASE_URL="https://api.github.com/repos/IdreesInc/Waypoint/releases/latest"
RELEASE_DATA="$(curl -s "$RELEASE_URL")"

# Pobierz wszystkie pliki pluginu
echo "⬇️  Pobieranie main.js..."
curl -sL "$(echo "$RELEASE_DATA" | grep -o 'https://.*main\.js' | head -1)" -o "$TMP_DIR/main.js"

echo "⬇️  Pobieranie manifest.json..."
curl -sL "$(echo "$RELEASE_DATA" | grep -o 'https://.*manifest\.json' | head -1)" -o "$TMP_DIR/manifest.json"

echo "⬇️  Pobieranie styles.css..."
curl -sL "$(echo "$RELEASE_DATA" | grep -o 'https://.*styles\.css' | head -1)" -o "$TMP_DIR/styles.css" 2>/dev/null || echo "styles.css not found (optional)"

echo "📦 Kopiuję do pluginu..."
mkdir -p "$PLUGIN_DIR"
cp "$TMP_DIR/main.js" "$PLUGIN_DIR/"
cp "$TMP_DIR/manifest.json" "$PLUGIN_DIR/"
[[ -f "$TMP_DIR/styles.css" ]] && cp "$TMP_DIR/styles.css" "$PLUGIN_DIR/"

echo "✅ Waypoint zainstalowany w: $PLUGIN_DIR"
echo "   Przeładuj Obsidiana i włącz Waypoint w Community plugins."
