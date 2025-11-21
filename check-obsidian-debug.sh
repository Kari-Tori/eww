#!/usr/bin/env bash
# Sprawdź logi Obsidiana i konfigurację graph

echo "=== OBSIDIAN GRAPH CONFIG ==="
if [[ -f .obsidian/graph.json ]]; then
    cat .obsidian/graph.json | jq '.'
else
    echo "Brak graph.json"
fi

echo ""
echo "=== APP.JSON SETTINGS ==="
if [[ -f .obsidian/app.json ]]; then
    cat .obsidian/app.json | jq '.maxPreviewImageSize, .maxPreviewFileSize, .maxLinkSuggestionsSize'
fi

echo ""
echo "=== LICZBA PLIKÓW ==="
find . -name "*.md" ! -path "./.obsidian/*" ! -path "./archive/*" | wc -l

echo ""
echo "=== WORKSPACE ==="
if [[ -f .obsidian/workspace.json ]]; then
    cat .obsidian/workspace.json | jq '.active, .lastOpenFiles[0:5]'
fi
