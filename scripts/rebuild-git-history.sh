#!/usr/bin/env bash
# rebuild-git-history.sh - Odbudowa historii Git z metadanych plików
set -euo pipefail

readonly MAX_FILES_PER_COMMIT=18
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
readonly TMP_DIR="/tmp/eww-rebuild-$$"

# Kolory
readonly RED='\033[0;31m'
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
    echo -e "${YELLOW}[WARN]${NC} $*" >&2
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $*" >&2
}

# Pobierz datę z frontmatter lub stat
get_file_date() {
    local file="$1"
    local date=""
    
    # Spróbuj wyciągnąć z YAML frontmatter
    if [[ -f "$file" ]]; then
        # Szukaj: created: YYYY-MM-DD lub date: YYYY-MM-DD
        date=$(awk '/^---$/,/^---$/ {
            if ($1 == "created:" || $1 == "date:") {
                print $2; exit
            }
        }' "$file" | head -1)
        
        # Jeśli nie ma w frontmatter, użyj daty modyfikacji pliku
        if [[ -z "$date" ]]; then
            date=$(stat -c '%y' "$file" | cut -d' ' -f1)
        fi
    fi
    
    echo "$date"
}

# Utwórz mapę: data -> lista plików
create_date_file_map() {
    local output_file="$1"
    
    log_info "Skanowanie plików MD..."
    
    > "$output_file"
    
    while IFS= read -r file; do
        local date
        date=$(get_file_date "$file")
        
        if [[ -n "$date" ]]; then
            echo "$date|$file" >> "$output_file"
        fi
    done < <(find "$REPO_ROOT" -name '*.md' -type f \
        ! -path '*/.obsidian/*' \
        ! -path '*/archive/*' \
        ! -path '*/.git/*')
    
    # Sortuj po dacie
    sort -t'|' -k1 -o "$output_file" "$output_file"
    
    local total
    total=$(wc -l < "$output_file")
    log_success "Znaleziono $total plików z datami"
}

# Podziel pliki na batche max 18 elementów
split_into_batches() {
    local date="$1"
    local files_list="$2"
    local batch_prefix="$3"
    
    local total_files
    total_files=$(echo "$files_list" | wc -w)
    
    if [[ $total_files -le $MAX_FILES_PER_COMMIT ]]; then
        # Jeden batch - każdy plik w osobnej linii
        for file in $files_list; do
            echo "$file"
        done > "${batch_prefix}_1.txt"
        echo "1"
        return
    fi
    
    # Podziel na równe części
    local num_batches
    num_batches=$(( (total_files + MAX_FILES_PER_COMMIT - 1) / MAX_FILES_PER_COMMIT ))
    
    local files_array=($files_list)
    local files_per_batch=$(( (total_files + num_batches - 1) / num_batches ))
    
    local batch_num=1
    local current_batch_file="${batch_prefix}_${batch_num}.txt"
    > "$current_batch_file"
    local count=0
    
    for file in "${files_array[@]}"; do
        echo "$file" >> "$current_batch_file"
        count=$((count + 1))
        
        if [[ $count -ge $files_per_batch ]]; then
            batch_num=$((batch_num + 1))
            current_batch_file="${batch_prefix}_${batch_num}.txt"
            > "$current_batch_file"
            count=0
        fi
    done
    
    echo "$num_batches"
}

# Generuj commit script
generate_commit_script() {
    local date_file_map="$1"
    local output_script="$2"
    
    log_info "Generowanie skryptu commitów..."
    
    cat > "$output_script" <<HEADER
#!/usr/bin/env bash
# Auto-generated Git history reconstruction script
set -euo pipefail

cd "$REPO_ROOT"

echo "🔄 ODBUDOWA HISTORII GIT"
echo "========================"
echo ""

HEADER

    local current_date=""
    local files_for_date=""
    local commit_num=0
    local batch_dir="$TMP_DIR/batches"
    mkdir -p "$batch_dir"
    
    while IFS='|' read -r date file; do
        if [[ "$date" != "$current_date" ]]; then
            # Zapisz poprzednią datę
            if [[ -n "$current_date" && -n "$files_for_date" ]]; then
                local num_batches
                num_batches=$(split_into_batches "$current_date" "$files_for_date" "$batch_dir/batch_${current_date}")
                
                for ((i=1; i<=num_batches; i++)); do
                    commit_num=$((commit_num + 1))
                    local batch_file="$batch_dir/batch_${current_date}_${i}.txt"
                    local file_count
                    file_count=$(wc -l < "$batch_file")
                    
                    # Generuj git add z każdym plikiem cytowanym
                    cat >> "$output_script" <<COMMIT
# Commit $commit_num - $current_date (batch $i/$num_batches, $file_count plików)
echo "📝 Commit $commit_num: $current_date (batch $i/$num_batches)"
COMMIT
                    
                    # Dodaj każdy plik osobno
                    while IFS= read -r file; do
                        echo "git add \"$file\"" >> "$output_script"
                    done < "$batch_file"
                    
                    cat >> "$output_script" <<COMMIT
GIT_AUTHOR_DATE="$current_date 12:00:00" \\
GIT_COMMITTER_DATE="$current_date 12:00:00" \\
git commit -m "docs: batch $i/$num_batches - $current_date ($file_count plików)" || true
echo ""

COMMIT
                done
            fi
            
            current_date="$date"
            files_for_date=""
        fi
        
        files_for_date="$files_for_date $file"
        
    done < "$date_file_map"
    
    # Ostatnia data
    if [[ -n "$current_date" && -n "$files_for_date" ]]; then
        local num_batches
        num_batches=$(split_into_batches "$current_date" "$files_for_date" "$batch_dir/batch_${current_date}")
        
        for ((i=1; i<=num_batches; i++)); do
            commit_num=$((commit_num + 1))
            local batch_file="$batch_dir/batch_${current_date}_${i}.txt"
            local file_count
            file_count=$(wc -l < "$batch_file")
            
            # Generuj git add z każdym plikiem cytowanym
            cat >> "$output_script" <<COMMIT
# Commit $commit_num - $current_date (batch $i/$num_batches, $file_count plików)
echo "📝 Commit $commit_num: $current_date (batch $i/$num_batches)"
COMMIT
            
            # Dodaj każdy plik osobno
            while IFS= read -r file; do
                echo "git add \"$file\"" >> "$output_script"
            done < "$batch_file"
            
            cat >> "$output_script" <<COMMIT
GIT_AUTHOR_DATE="$current_date 12:00:00" \\
GIT_COMMITTER_DATE="$current_date 12:00:00" \\
git commit -m "docs: batch $i/$num_batches - $current_date ($file_count plików)" || true
echo ""

COMMIT
        done
    fi
    
    cat >> "$output_script" <<'FOOTER'
echo "✅ Historia odbudowana! Total commits: COMMIT_COUNT"
echo ""
echo "Sprawdź: git log --oneline --graph --all"
FOOTER

    sed -i "s/COMMIT_COUNT/$commit_num/" "$output_script"
    chmod +x "$output_script"
    
    log_success "Wygenerowano skrypt: $output_script ($commit_num commitów)"
}

# Backup obecnej historii
backup_current_history() {
    log_info "Backup obecnej historii Git..."
    
    local backup_branch="backup-$(date +%Y%m%d-%H%M%S)"
    git branch "$backup_branch" 2>/dev/null || true
    
    log_success "Backup: git branch $backup_branch"
}

# Główna funkcja
main() {
    log_info "🚀 Rozpoczynam odbudowę historii Git..."
    echo ""
    
    mkdir -p "$TMP_DIR"
    trap "rm -rf '$TMP_DIR'" EXIT
    
    local date_map="$TMP_DIR/date_file_map.txt"
    local commit_script="$REPO_ROOT/rebuild-commits.sh"
    
    # Krok 1: Skanuj pliki
    create_date_file_map "$date_map"
    echo ""
    
    # Krok 2: Generuj skrypt commitów
    generate_commit_script "$date_map" "$commit_script"
    echo ""
    
    # Krok 3: Backup
    cd "$REPO_ROOT"
    backup_current_history
    echo ""
    
    # Podsumowanie
    echo ""
    log_success "✅ GOTOWE!"
    echo ""
    echo -e "${YELLOW}NASTĘPNE KROKI:${NC}"
    echo "1. Sprawdź: less $commit_script"
    echo "2. Reset repo: git reset --soft HEAD~20  # usuń ostatnie commity"
    echo "3. Odbuduj: ./rebuild-commits.sh"
    echo "4. Sprawdź: git log --oneline --graph --date-order"
    echo ""
    echo -e "${YELLOW}UWAGA:${NC} Backup: git branch backup-*"
}

main "$@"
