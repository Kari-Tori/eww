#!/usr/bin/env bash
set -euo pipefail

cd /home/jakubc/git/eww

# Aplikuj batche
echo "📦 Aplikuję batche..."
for batch_file in /tmp/batch_*.txt; do
    batch_date=$(head -n1 "$batch_file")
    batch_num=$(basename "$batch_file" .txt | sed 's/batch_//')
    
    # Dodaj pliki z batcha (sprawdzaj czy istnieją)
    file_count=0
    while IFS= read -r file; do
        if [[ -f "$file" ]]; then
            git add "$file"
            ((file_count++))
        fi
    done < <(tail -n +2 "$batch_file")
    
    # Commit tylko jeśli są pliki
    if [[ $file_count -gt 0 ]]; then
        hour=$(printf '%02d' $((batch_num % 24)))
        git commit -m "feat: batch ${batch_num} - ${file_count} files" \
            --date="${batch_date}T${hour}:00:00" || true
        echo "✓ Batch ${batch_num}: ${file_count} plików (${batch_date})"
    fi
done

echo ""
echo "✅ Historia zbudowana! Commity:"
git log --oneline --graph | head -15
echo ""
echo "📊 Statystyki:"
echo "Commitów: $(git rev-list --count HEAD)"
echo "Plików: $(git ls-files | wc -l)"
