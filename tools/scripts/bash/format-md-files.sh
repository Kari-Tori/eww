#!/usr/bin/env bash
# File: scripts/bash/format-md-files.sh
# Author: 
# Created: 
# Updated: 
# Description: bash
# Tags:
# bash
# script
# format-md-files.sh - Formatowanie wszystkich plików Markdown w repozytorium
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly EWW_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Kolory tagów dla Obsidian
readonly TAG_COLORS=(
    "red" "orange" "yellow" "green" "cyan" 
    "blue" "purple" "pink" "gray"
)

# Standardowe tagi tematyczne
declare -A TOPIC_TAGS=(
    ["business"]="business,finanse,operacje"
    ["dev"]="development,code,infrastructure"
    ["docs"]="dokumentacja,knowledge,wiki"
    ["usr"]="personal,workspace,vault"
    ["core"]="system,config,templates"
)

# Funkcja: Generuj YAML frontmatter
generate_frontmatter() {
    local file="$1"
    local filename=$(basename "$file" .md)
    local dirname=$(basename "$(dirname "$file")")
    local relpath="${file#$EWW_ROOT/}"
    
    # Określ kategorię na podstawie ścieżki
    local category="general"
    local tags=()
    
    if [[ "$relpath" =~ ^business/ ]]; then
        category="business"
        tags=(business operacje finanse)
    elif [[ "$relpath" =~ ^dev/ ]]; then
        category="development"
        tags=(development infrastructure code)
    elif [[ "$relpath" =~ ^docs/ ]]; then
        category="documentation"
        tags=(docs knowledge wiki)
    elif [[ "$relpath" =~ ^usr/ ]]; then
        category="personal"
        tags=(personal workspace notes)
    elif [[ "$relpath" =~ ^core/ ]]; then
        category="core"
        tags=(system config core)
    fi
    
    # Dodaj specyficzne tagi
    if [[ "$filename" =~ Dashboard|dashboard ]]; then
        tags+=(dashboard)
    fi
    if [[ "$filename" =~ SOP|sop ]]; then
        tags+=(sop procedure)
    fi
    if [[ "$filename" =~ README|Index|INDEX ]]; then
        tags+=(index overview)
    fi
    
    # Ogranicz do 7 tagów
    tags=("${tags[@]:0:7}")
    
    # Generuj YAML
    cat <<EOF
---
title: "${filename//_/ }"
category: $category
tags:
$(for tag in "${tags[@]}"; do echo "  - $tag"; done)
created: $(date -r "$file" +%Y-%m-%d 2>/dev/null || date +%Y-%m-%d)
updated: $(date +%Y-%m-%d)
author: $(git log -1 --format='%an' "$file" 2>/dev/null || echo "EWW Team")
source: "[[INDEX]]"
cssclasses:
  - eww-doc
---

EOF
}

# Funkcja: Dodaj ikonki na podstawie kontekstu
add_icons() {
    local content="$1"
    
    # Dodaj ikonki do nagłówków
    content="${content//## Dashboard/## 📊 Dashboard}"
    content="${content//## TODO/## ✅ TODO}"
    content="${content//## SOP/## 📋 SOP}"
    content="${content//## Architecture/## 🏗️ Architecture}"
    content="${content//## Development/## 💻 Development}"
    content="${content//## Business/## 💼 Business}"
    content="${content//## Finance/## 💰 Finance}"
    content="${content//## Notes/## 📝 Notes}"
    content="${content//## Project/## 🚀 Project}"
    
    echo "$content"
}

# Funkcja: Przetwórz pojedynczy plik
process_file() {
    local file="$1"
    
    # Wczytaj treść
    local content=$(<"$file")
    
    # Generuj frontmatter
    local frontmatter=$(generate_frontmatter "$file")
    
    # Dodaj ikonki (tylko jeśli nie ma już)
    if ! echo "$content" | grep -q "📊\|📋\|🏗️\|💻\|💼"; then
        content=$(add_icons "$content")
    fi
    
    # Zapisz
    {
        echo -n "$frontmatter"
        echo "$content"
    } > "$file.tmp"
    
    mv "$file.tmp" "$file"
}

# Główna pętla
main() {
    echo "🚀 Rozpoczynam formatowanie plików Markdown..."
    echo ""
    
    local processed=0
    local updated=0
    local skipped=0
    
    while IFS= read -r file; do
        # Pomiń katalogi specjalne
        [[ "$file" =~ \.git/|node_modules/|archive/|\.obsidian/|\.vscode/|\.space/|\.vale/|\.makemd/|\.continue/|\.githooks/ ]] && continue
        
        ((processed++))
        
        # Pokaż progress co 50 plików
        if (( processed % 50 == 0 )); then
            echo "📊 Progress: $processed plików sprawdzono (zaktualizowano: $updated, pominięto: $skipped)"
        fi
        
        # Sprawdź czy plik ma już frontmatter
        if head -n 1 "$file" 2>/dev/null | grep -q "^---$"; then
            ((skipped++))
            continue
        fi
        
        echo "  ✨ [$processed] Aktualizuję: ${file#$EWW_ROOT/}"
        process_file "$file" && ((updated++))
    done < <(find "$EWW_ROOT" -type f -name "*.md" 2>/dev/null)
    
    echo ""
    echo "✅ Zakończono:"
    echo "   • Sprawdzono:    $processed plików"
    echo "   • Zaktualizowano: $updated plików"
    echo "   • Pominięto:     $skipped plików (już mają frontmatter)"
}

main "$@"
