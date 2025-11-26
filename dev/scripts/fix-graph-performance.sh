#!/usr/bin/env bash
# fix-graph-performance.sh - Optymalizuj graph dla 510 plików
set -euo pipefail

OBSIDIAN_DIR="/home/jakubc/git/eww/.obsidian"

echo "🔧 OPTYMALIZACJA GRAPH PERFORMANCE"
echo ""

# Backup obecnej konfiguracji
echo "📦 Backup konfiguracji..."
cp "$OBSIDIAN_DIR/graph.json" "$OBSIDIAN_DIR/graph.json.backup-$(date +%s)"
cp "$OBSIDIAN_DIR/plugins/extended-graph/data.json" "$OBSIDIAN_DIR/plugins/extended-graph/data.json.backup-$(date +%s)"

# Optymalizuj Extended Graph
echo "⚡ Optymalizuję Extended Graph..."
cat > "$OBSIDIAN_DIR/plugins/extended-graph/data.json" <<'EOF'
{
  "maxNodes": 5000,
  "delay": 500,
  "recomputeStatsOnGraphChange": false,
  "fadeInElements": false,
  "enableFeatures": {
    "graph": {
      "auto-enabled": true,
      "tags": true,
      "properties": false,
      "property-key": false,
      "links": true,
      "linksSameColorAsNode": false,
      "folders": true,
      "imagesFromProperty": false,
      "imagesFromEmbeds": false,
      "imagesForAttachments": false,
      "focus": true,
      "shapes": false,
      "elements-stats": false,
      "names": true,
      "icons": true,
      "arrows": true,
      "layers": false
    }
  }
}
EOF

# Optymalizuj główny graph
echo "🎨 Optymalizuję główny graph..."
cat > "$OBSIDIAN_DIR/graph.json" <<'EOF'
{
  "collapse-filter": false,
  "search": "(path:core OR path:config OR path:business OR path:docs/getting-started OR path:docs/setup OR path:infra OR path:usr/jakubc/m18 OR path:usr/jakubc/health OR path:usr/jakubc/INDEX OR path:usr/jakubc/jakubc OR path:usr/karinam) -path:docs/infra/tags -path:archive -path:Tags -path:usr/jakubc/star_wars -file:backlinks -file:tags.md",
  "showTags": true,
  "showAttachments": false,
  "hideUnresolved": true,
  "showOrphans": false,
  "collapse-color-groups": false,
  "colorGroups": [
    {
      "query": "tag:#pink OR tag:#candy OR path:usr/karinam",
      "color": {"a": 1, "rgb": 16761035}
    },
    {
      "query": "tag:#blue OR path:usr/jakubc",
      "color": {"a": 1, "rgb": 5592575}
    },
    {
      "query": "tag:#eww OR path:core OR path:config OR path:business",
      "color": {"a": 1, "rgb": 10809863}
    },
    {
      "query": "tag:#green OR path:docs",
      "color": {"a": 1, "rgb": 5763719}
    },
    {
      "query": "tag:#folder-note",
      "color": {"a": 1, "rgb": 14701249}
    }
  ],
  "collapse-display": false,
  "showArrow": true,
  "textFadeMultiplier": -1,
  "nodeSizeMultiplier": 1.2,
  "lineSizeMultiplier": 1.5,
  "collapse-forces": false,
  "centerStrength": 0.3,
  "repelStrength": 15,
  "linkStrength": 0.7,
  "linkDistance": 300,
  "scale": 1,
  "close": false
}
EOF

echo ""
echo "✅ GOTOWE!"
echo ""
echo "📊 Co zmieniono:"
echo "  - Delay renderowania: 1000ms → 500ms"
echo "  - Wyłączono: properties, shapes, stats (szybszy rendering)"
echo "  - Dodano filtry: -path:star_wars (mniej nodów)"
echo "  - Zachowano: tags, icons, arrows, folders"
echo ""
echo "🔄 RESTART Obsidiana teraz!"
echo "   Graf powinien ładować się ~2-3x szybciej"
