#!/usr/bin/env bash
# File: scripts/bash/create-folder-notes.sh
# Author: 
# Created: 
# Updated: 
# Description: bash
# Tags:
# bash
# script
# create-folder-notes.sh - Tworzenie folder notes dla wszystkich katalogów
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly EWW_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Funkcja: Generuj folder note
generate_folder_note() {
    local dir="$1"
    local dirname=$(basename "$dir")
    local folder_note="$dir/$dirname.md"
    
    # Pomiń jeśli folder note już istnieje
    if [[ -f "$folder_note" ]]; then
        echo "  ⏭️  $dirname.md już istnieje"
        return
    fi
    
    echo "  ✨ Tworzę $dirname.md"
    
    # Lista plików w katalogu
    local files=()
    while IFS= read -r file; do
        files+=("$(basename "$file")")
    done < <(find "$dir" -maxdepth 1 -type f -name "*.md" ! -name "$dirname.md" | sort)
    
    # Lista podkatalogów
    local subdirs=()
    while IFS= read -r subdir; do
        subdirs+=("$(basename "$subdir")")
    done < <(find "$dir" -maxdepth 1 -type d ! -path "$dir" | sort)
    
    # Generuj zawartość
    cat > "$folder_note" <<EOF
---
title: "$dirname"
category: folder-note
tags:
  - index
  - overview
  - folder-note
created: $(date +%Y-%m-%d)
updated: $(date +%Y-%m-%d)
author: EWW Team
cssclasses:
  - eww-folder-note
---

# 📁 $dirname

> Folder note dla katalogu \`$dirname\`

## 📋 Opis

Katalog \`$dirname\` zawiera:

EOF
    
    # Dodaj pliki
    if [[ ${#files[@]} -gt 0 ]]; then
        cat >> "$folder_note" <<EOF

## 📄 Pliki

EOF
        for file in "${files[@]}"; do
            local filename="${file%.md}"
            echo "- [[${filename}]] - ${filename//_/ }" >> "$folder_note"
        done
    fi
    
    # Dodaj podfoldery
    if [[ ${#subdirs[@]} -gt 0 ]]; then
        cat >> "$folder_note" <<EOF

## 📂 Podfoldery

EOF
        for subdir in "${subdirs[@]}"; do
            echo "- [[${subdir}/${subdir}|${subdir}]] - Subfolder" >> "$folder_note"
        done
    fi
    
    # Dodaj backlink
    local parent_dir=$(dirname "$dir")
    local parent_name=$(basename "$parent_dir")
    if [[ "$parent_dir" != "$EWW_ROOT" ]]; then
        cat >> "$folder_note" <<EOF

## 🔗 Backlinks

- ⬆️ [[${parent_name}/${parent_name}|${parent_name}]] - Katalog nadrzędny

EOF
    fi
    
    # Dodaj stopkę
    cat >> "$folder_note" <<EOF

---

**Źródło:** [[INDEX]]  
**Zaktualizowano:** $(date +%Y-%m-%d)
EOF
}

# Główna pętla
main() {
    echo "🚀 Tworzę folder notes..."
    
    local count=0
    while IFS= read -r dir; do
        # Pomiń specjalne katalogi
        [[ "$dir" =~ \.git/|node_modules/|archive/|\.obsidian/|\.vscode/|\.space/ ]] && continue
        [[ "$dir" == "." ]] && continue
        
        echo "📁 $(basename "$dir")"
        generate_folder_note "$dir"
        ((count++))
    done < <(find "$EWW_ROOT" -type d | sort)
    
    echo ""
    echo "✅ Utworzono $count folder notes"
}

main "$@"
