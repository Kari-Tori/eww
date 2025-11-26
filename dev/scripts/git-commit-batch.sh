#!/usr/bin/env bash
# git-commit-batch.sh - Commituj pliki w porcjach po max 18
set -euo pipefail

readonly MAX_FILES="${MAX_FILES:-18}"
readonly EWW_ROOT="${EWW_ROOT:-$(pwd)}"

cd "$EWW_ROOT" || exit 1

# Kolory
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $*"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $*"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $*"
}

# Unstage wszystko i dodaj ponownie (zapewnia spójność)
if [[ -n "$(git diff --cached --name-only)" ]]; then
    git reset --quiet 2>/dev/null || true
fi

# Pobierz WSZYSTKIE zmiany (modified, deleted, untracked)
mapfile -t all_changes < <(git status --porcelain | sed 's/^...//' | grep -v '^$' 2>/dev/null || true)

total_files=${#all_changes[@]}

if [[ $total_files -eq 0 ]]; then
    log_info "Brak zmian do commitowania"
    exit 0
fi

log_info "Znaleziono $total_files zmian(y) do commitowania"

# Oblicz liczbę batchy
batches=$(( (total_files + MAX_FILES - 1) / MAX_FILES ))

log_info "Podzielono na $batches batch(y) po max $MAX_FILES plików"

# Commituj w batchach
batch_num=1
committed_batches=0

for ((i=0; i<total_files; i+=MAX_FILES)); do
    batch_files=("${all_changes[@]:i:MAX_FILES}")
    batch_size=${#batch_files[@]}
    
    log_info "Batch $batch_num/$batches ($batch_size plików)..."
    
    # Stage tylko te pliki z batcha
    git add "${batch_files[@]}" 2>/dev/null || true
    
    # Commit z datą i liczbą plików
    commit_date=$(date '+%Y-%m-%d %H:%M:%S')
    commit_msg="docs: batch $batch_num/$batches - $batch_size plików - $commit_date"
    
    if git commit -m "$commit_msg" --quiet 2>/dev/null; then
        log_success "Batch $batch_num/$batches: committed ✓"
        ((committed_batches++))
        
        # Pokaż pliki w batchu (opcjonalnie)
        if [[ "${VERBOSE:-0}" == "1" ]]; then
            printf '%s\n' "${batch_files[@]}" | sed 's/^/  - /'
        fi
    else
        log_warn "Batch $batch_num/$batches: pominięto (brak zmian lub błąd)"
    fi
    
    ((batch_num++))
done

log_success "Zakończono: $committed_batches/$batches batch(y) committed, $total_files plików"

# Pokaż ostatnie commity
if [[ $committed_batches -gt 0 ]]; then
    echo ""
    log_info "Ostatnie commity:"
    git --no-pager log --oneline -n "$committed_batches" --color=always --graph || true
fi
