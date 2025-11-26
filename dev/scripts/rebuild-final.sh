#!/usr/bin/env bash

cd /home/jakubc/git/eww

batch_num=0
for batch_file in /tmp/batch_*.txt; do
    batch_num=$((batch_num + 1))
    batch_date=$(head -n1 "$batch_file")
    hour=$(printf '%02d' $((batch_num % 24)))
    
    # Reset staging
    git reset HEAD . > /dev/null 2>&1
    
    # Add files
    tail -n +2 "$batch_file" | xargs -I {} git add {} 2>/dev/null
    
    # Commit
    git commit -m "feat(pre-mvp): batch $batch_num" \
        --date="${batch_date}T${hour}:00:00" > /dev/null 2>&1
    
    echo "✓ Batch $batch_num"
done

echo ""
git log --oneline | head -10
