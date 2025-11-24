#!/usr/bin/env bash
# Szybkie generowanie folder notes
set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

REPO_ROOT="/home/jakubc/git/eww"
CREATED=0

echo "🗂️  Generowanie folder notes..."

find "$REPO_ROOT" -type d \
    ! -path "*/.git/*" \
    ! -path "*/.obsidian/*" \
    ! -path "*/.github/*" \
    ! -path "*/archive/*" \
    ! -path "*/Tags/*" \
    ! -path "*/.vale/*" \
    ! -path "*/.makemd/*" \
    ! -path "*/.continue/*" \
    ! -path "*/.vscode/*" \
    ! -path "$REPO_ROOT" \
    | while read -r folder; do
    
    folder_name=$(basename "$folder")
    folder_note="$folder/$folder_name.md"
    
    # Pomiń jeśli istnieje
    [ -f "$folder_note" ] && continue
    
    # Utwórz folder note
    cat > "$folder_note" << ENDNOTE
---
created: $(date -I)
modified: $(date -I)
author: jakubc
type: folder-note
tags:
  - #index
  - #folder-note
  - #eww
---

# 📁 $folder_name

> Folder note for $folder_name

## 📑 Zawartość

$(find "$folder" -maxdepth 1 -type f -name "*.md" ! -name "$folder_name.md" -exec basename {} \; | sed 's/^/- [[/' | sed 's/$/]]/')

## 📁 Podfoldery

$(find "$folder" -maxdepth 1 -type d ! -path "$folder" -exec basename {} \; | sed 's/^/- [[/' | sed 's|$|]]|')

ENDNOTE
    
    echo -e "${GREEN}✓${NC} $folder_name"
    ((CREATED++)) || true
    
done

echo ""
echo -e "${YELLOW}Utworzono: $CREATED folder notes${NC}"
