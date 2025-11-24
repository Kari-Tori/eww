#!/usr/bin/env bash
# Obsidian Git - commit z limitem 18 plików na batch
# Rozwiązuje problem "too many to handle" w graph rendering

set -euo pipefail

readonly VAULT_DIR="/home/jakubc/git/eww"
readonly MAX_FILES_PER_COMMIT=18
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

cd "$VAULT_DIR"

# Sprawdź czy są zmiany
if ! git diff --quiet || ! git diff --cached --quiet || [[ -n $(git ls-files --others --exclude-standard) ]]; then
    echo -e "${BLUE}📝 Wykryto zmiany w vault...${NC}"
    
    # Dodaj wszystko do staging
    git add -A
    
    # Pobierz listę zmienionych plików
    mapfile -t changed_files < <(git diff --cached --name-only)
    total_files=${#changed_files[@]}
    
    if [[ $total_files -eq 0 ]]; then
        echo "✅ Brak zmian do commita"
        exit 0
    fi
    
    echo -e "${BLUE}📊 Znaleziono ${total_files} zmian${NC}"
    
    # Jeśli <= 18 plików, jeden commit
    if [[ $total_files -le $MAX_FILES_PER_COMMIT ]]; then
        commit_msg="docs: ${total_files} plików - $(date '+%Y-%m-%d %H:%M:%S')"
        git commit -m "$commit_msg"
        echo -e "${GREEN}✅ Commit: ${commit_msg}${NC}"
    else
        # Podziel na batche po 18 plików
        num_commits=$(( (total_files + MAX_FILES_PER_COMMIT - 1) / MAX_FILES_PER_COMMIT ))
        echo -e "${BLUE}🔀 Dzielę na ${num_commits} commitów (max ${MAX_FILES_PER_COMMIT} plików/commit)${NC}"
        
        # Reset staging
        git restore --staged .
        
        batch=1
        for ((i=0; i<total_files; i+=MAX_FILES_PER_COMMIT)); do
            # Pobierz batch plików
            batch_files=("${changed_files[@]:i:MAX_FILES_PER_COMMIT}")
            batch_count=${#batch_files[@]}
            
            # Dodaj tylko ten batch
            for file in "${batch_files[@]}"; do
                git add "$file"
            done
            
            # Commit
            commit_msg="docs: batch ${batch}/${num_commits} - ${batch_count} plików - $(date '+%Y-%m-%d %H:%M:%S')"
            git commit -m "$commit_msg"
            echo -e "${GREEN}✅ Commit ${batch}/${num_commits}: ${batch_count} plików${NC}"
            
            ((batch++))
        done
    fi
    
    echo -e "${GREEN}🎉 Wszystkie zmiany zacommitowane!${NC}"
else
    echo "✅ Brak zmian w vault"
fi
