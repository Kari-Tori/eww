#!/usr/bin/env bash
set -euo pipefail

cd /home/jakubc/git/eww

echo "📦 Commitowanie w batchach po 18 plików..."

batch_num=0
for batch_file in /tmp/batch_*.txt; do
    ((batch_num++))
    batch_date=$(head -n1 "$batch_file")
    hour=$(printf '%02d' $((batch_num % 24)))
    
    # Resetuj staging
    git reset HEAD . 2>/dev/null || true
    
    # Dodaj pliki z batcha
    count=0
    while IFS= read -r file; do
        if [[ -f "$file" ]]; then
            git add "$file" && ((count++))
        fi
    done < <(tail -n +2 "$batch_file")
    
    if [[ $count -gt 0 ]]; then
        git commit -m "feat(pre-mvp): batch $batch_num ($count files)" \
            --date="${batch_date}T${hour}:00:00"
        echo "✓ Commit $batch_num: $count plików"
    fi
done

echo ""
echo "✅ Gotowe!"
git log --oneline | head -10
