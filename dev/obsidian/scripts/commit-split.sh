#!/usr/bin/env bash
# commit-split.sh - Dzieli zmiany na commity max 18 plików
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

# Pobierz listę zmienionych plików
mapfile -t FILES < <(git status --porcelain | awk '{print $2}' | sort)
TOTAL=${#FILES[@]}

if [[ $TOTAL -eq 0 ]]; then
    echo "✅ Brak zmian"
    exit 0
fi

echo "📊 Znaleziono $TOTAL zmian(y)"

# Maksymalnie 18 plików na commit
MAX_FILES=18
COMMITS=$(( (TOTAL + MAX_FILES - 1) / MAX_FILES ))

echo "🔄 Podzielę na $COMMITS commit(ów)"

for ((i=0; i<COMMITS; i++)); do
    START=$((i * MAX_FILES))
    END=$((START + MAX_FILES))
    
    # Wybierz zakres plików
    BATCH=("${FILES[@]:$START:$MAX_FILES}")
    COUNT=${#BATCH[@]}
    
    # Dodaj do staging
    git add "${BATCH[@]}"
    
    # Commit
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    if [[ $COMMITS -gt 1 ]]; then
        MSG="docs: update $COUNT files (batch $((i+1))/$COMMITS) - $TIMESTAMP"
    else
        MSG="docs: update $COUNT files - $TIMESTAMP"
    fi
    
    git commit -m "$MSG"
    echo "✅ Commit $((i+1))/$COMMITS: $COUNT plików"
done

echo "🎉 Gotowe! Utworzono $COMMITS commit(ów)"
