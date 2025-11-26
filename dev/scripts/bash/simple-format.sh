#!/usr/bin/env bash
# File: scripts/bash/simple-format.sh
# Author: 
# Created: 
# Updated: 
# Description: bash
# Tags:
# bash
# script
# simple-format.sh - Prosty skrypt formatowania bez komplikacji
set -euo pipefail

readonly EWW_ROOT="/home/jakubc/git/eww"

processed=0
updated=0
skipped=0

echo "🚀 Formatowanie plików Markdown..."
echo ""

find "$EWW_ROOT" -type f -name "*.md" 2>/dev/null | while IFS= read -r file; do
    # Pomiń specjalne katalogi
    [[ "$file" =~ \.git/|node_modules/|archive/|\.obsidian/|\.vscode/|\.space/|\.vale/|\.makemd/|\.continue/|\.githooks/|\.stfolder/|imported-vault/ ]] && continue
    
    ((processed++))
    
    # Progress co 50 plików
    if (( processed % 50 == 0 )); then
        echo "📊 Progress: $processed plików"
    fi
    
    # Sprawdź frontmatter
    if head -n 1 "$file" 2>/dev/null | grep -q "^---$"; then
        ((skipped++))
        continue
    fi
    
    # Określ kategorię
    category="general"
    if [[ "$file" =~ /business/ ]]; then
        category="business"
        tags="business operacje finanse"
    elif [[ "$file" =~ /dev/ ]]; then
        category="development"
        tags="development code infrastructure"
    elif [[ "$file" =~ /docs/ ]]; then
        category="documentation"
        tags="docs knowledge wiki"
    elif [[ "$file" =~ /usr/ ]]; then
        category="personal"
        tags="personal workspace notes"
    elif [[ "$file" =~ /core/ ]]; then
        category="core"
        tags="system config core"
    else
        tags="general"
    fi
    
    filename=$(basename "$file" .md)
    relpath="${file#$EWW_ROOT/}"
    
    echo "  ✨ Aktualizuję: $relpath"
    
    # Wczytaj zawartość
    content=$(<"$file")
    
    # Generuj frontmatter
    {
        cat <<EOF
---
title: "${filename//_/ }"
category: $category
tags:
$(echo "$tags" | tr ' ' '\n' | head -7 | sed 's/^/  - /')
created: $(date -r "$file" +%Y-%m-%d 2>/dev/null || date +%Y-%m-%d)
updated: $(date +%Y-%m-%d)
author: $(git log -1 --format='%an' "$file" 2>/dev/null || echo "EWW Team")
cssclasses:
  - eww-doc
---

EOF
        echo "$content"
    } > "$file.tmp"
    
    if mv "$file.tmp" "$file" 2>/dev/null; then
        ((updated++))
    fi
done

echo ""
echo "✅ Zakończono:"
echo "   • Sprawdzono:    $processed"
echo "   • Zaktualizowano: $updated"
echo "   • Pominięto:     $skipped"
