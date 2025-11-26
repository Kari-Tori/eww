#!/usr/bin/env bash
set -euo pipefail

find . -name "*.md" -type f | while read -r file; do
  [[ "$file" == *"/archive/"* ]] && continue
  [[ "$file" == *"/var/log/"* ]] && continue
  
  dir=$(dirname "$file")
  base=$(basename "$file" .md)
  dirbase=$(basename "$dir")
  
  # Sprawdź czy to folder note
  if [[ "$base" == "$dirbase" ]] && [[ "$dir" != "." ]]; then
    # Sprawdź czy ma frontmatter i tags
    if head -1 "$file" 2>/dev/null | grep -q "^---$"; then
      # Sprawdź czy ma tag
      if ! grep -q "#folder_note" "$file" 2>/dev/null; then
        # Sprawdź czy ma sekcję tags
        if grep -q "^tags:" "$file" 2>/dev/null; then
          echo "$file"
        fi
      fi
    fi
  fi
done
