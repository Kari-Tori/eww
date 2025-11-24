#!/usr/bin/env bash
# daily-graph-commit.sh - Daily auto-commit grafu z max 18 nodes per commit
# Jeśli zmian > 18, dzieli na porcje i commituje w pętli
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
readonly MAX_NODES_PER_COMMIT=18

# Kolory
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
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

# Policz zmiany w grafie
count_changed_nodes() {
    cd "$PROJECT_ROOT"

    # Pliki zmienione w .obsidian/graph*
    local graph_changes
    graph_changes=$(git diff --name-only .obsidian/graph*.json 2>/dev/null | wc -l)

    # Folder notes zmienione
    local folder_note_changes
    folder_note_changes=$(git diff --name-only | grep -E "\.md$" | \
        xargs -I{} grep -l "type.*folder.*note\|#folder.note" {} 2>/dev/null | wc -l)

    echo $((graph_changes + folder_note_changes))
}

# Commit porcji zmian
commit_batch() {
    local batch_num="$1"
    local total_batches="$2"
    local files=("${@:3}")

    log_info "Commit batch $batch_num/$total_batches (${#files[@]} plików)..."

    cd "$PROJECT_ROOT"

    for file in "${files[@]}"; do
        git add "$file"
    done

    git commit -m "chore(graph): daily update batch $batch_num/$total_batches

Automatyczny commit grafu Obsidian (max $MAX_NODES_PER_COMMIT nodes)
Batch: $batch_num z $total_batches
" || true

    log_success "Batch $batch_num/$total_batches committed"
}

# Main
main() {
    log_info "Daily graph auto-commit..."

    cd "$PROJECT_ROOT"

    # Pobierz wszystkie zmienione pliki związane z grafem
    local changed_files=()

    # Graph JSON
    while IFS= read -r file; do
        [ -n "$file" ] && changed_files+=("$file")
    done < <(git diff --name-only .obsidian/graph*.json 2>/dev/null || true)

    # Waypoint JSON
    while IFS= read -r file; do
        [ -n "$file" ] && changed_files+=("$file")
    done < <(git diff --name-only .obsidian/plugins/waypoint/data.json 2>/dev/null || true)

    # Folder notes
    while IFS= read -r file; do
        if grep -l "type.*folder.*note\|#folder.note" "$file" 2>/dev/null >/dev/null; then
            changed_files+=("$file")
        fi
    done < <(git diff --name-only | grep -E "\.md$" || true)

    local total_changes=${#changed_files[@]}

    if [ "$total_changes" -eq 0 ]; then
        log_info "Brak zmian w grafie"
        return 0
    fi

    log_info "Znaleziono $total_changes zmienionych plików"

    # Sprawdź czy trzeba podzielić na batche
    if [ "$total_changes" -le "$MAX_NODES_PER_COMMIT" ]; then
        # Jeden commit
        log_info "Commit wszystkich zmian (≤$MAX_NODES_PER_COMMIT)..."
        commit_batch 1 1 "${changed_files[@]}"
    else
        # Podziel na batche
        local total_batches=$(( (total_changes + MAX_NODES_PER_COMMIT - 1) / MAX_NODES_PER_COMMIT ))

        log_warn "Zmian ($total_changes) > $MAX_NODES_PER_COMMIT"
        log_warn "Dzielę na $total_batches batchy..."

        local batch_num=1
        local batch_files=()

        for file in "${changed_files[@]}"; do
            batch_files+=("$file")

            if [ "${#batch_files[@]}" -eq "$MAX_NODES_PER_COMMIT" ]; then
                commit_batch "$batch_num" "$total_batches" "${batch_files[@]}"
                batch_files=()
                ((batch_num++)) || true
            fi
        done

        # Ostatni batch (jeśli są pozostałe pliki)
        if [ "${#batch_files[@]}" -gt 0 ]; then
            commit_batch "$batch_num" "$total_batches" "${batch_files[@]}"
        fi
    fi

    log_success "Daily graph commit zakończony!"
}

main "$@"
