#!/usr/bin/env bash
# Multi-Graph Preset Switcher - OBEJŚCIE dla braku batching
# Każdy preset = max 250 nodes = fast render

OBSIDIAN_DIR="/home/karinam/git/eww/.obsidian"

echo "🎯 Multi-Graph Strategy - wybierz preset:"
echo ""
echo "1) CORE (path:core)                    ~60 nodes"
echo "2) BUSINESS (path:business)            ~100 nodes"
echo "3) DOCS (path:docs)                    ~150 nodes"
echo "4) DEV (path:dev)                      ~200 nodes"
echo "5) USR/KARINAM (path:usr/karinam)      ~50 nodes"
echo "6) USR/JAKUBC (path:usr/jakubc)        ~150 nodes"
echo "7) FOLDER NOTES (tag:#folder_note)     ~60 nodes"
echo "8) ALL (no filter)                     934 nodes ⚠️"
echo ""
read -p "Wybór (1-8): " choice

case $choice in
    1)
        SEARCH='path:core -path:core/var/logs -path:core/var/status'
        NAME="CORE"
        ;;
    2)
        SEARCH='path:business -path:business/archive'
        NAME="BUSINESS"
        ;;
    3)
        SEARCH='path:docs -path:docs/archive'
        NAME="DOCS"
        ;;
    4)
        SEARCH='path:dev -path:dev/tests'
        NAME="DEV"
        ;;
    5)
        SEARCH='path:usr/karinam'
        NAME="KARINAM"
        ;;
    6)
        SEARCH='path:usr/jakubc -path:usr/jakubc/workspace/archive'
        NAME="JAKUBC"
        ;;
    7)
        SEARCH='tag:#folder_note OR file:README OR file:INDEX'
        NAME="FOLDER_NOTES"
        ;;
    8)
        SEARCH=''
        NAME="ALL"
        ;;
    *)
        echo "❌ Nieprawidłowy wybór"
        exit 1
        ;;
esac

echo "✅ Ustawiam preset: $NAME"

# Backup current
cp "$OBSIDIAN_DIR/graph.json" "$OBSIDIAN_DIR/graph.json.bak"

# Update search filter
jq --arg search "$SEARCH" '.search = $search' "$OBSIDIAN_DIR/graph.json" > "$OBSIDIAN_DIR/graph.json.tmp"
mv "$OBSIDIAN_DIR/graph.json.tmp" "$OBSIDIAN_DIR/graph.json"

echo "✅ Gotowe!"
echo "📌 Preset: $NAME"
echo "🔍 Filter: $SEARCH"
echo ""
echo "Teraz:"
echo "1. Restart Obsidiana (lub reload graph)"
echo "2. Otwórz Graph View (Ctrl+G)"
echo "3. Graf wyrenderuje się <2s dzięki limitowi 250 nodes"
