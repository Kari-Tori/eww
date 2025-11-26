#!/usr/bin/env bash
# add-folder-note-tags.sh - Dodaj tag #folder_note do wszystkich folder notes
set -euo pipefail

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

log_info() {
    echo -e "${BLUE}[EWW]${NC} $*"
}

log_success() {
    echo -e "${GREEN}[EWW]${NC} ✅ $*"
}

log_warn() {
    echo -e "${YELLOW}[EWW]${NC} ⚠️  $*"
}

# Sprawdź czy plik ma tag #folder_note
has_folder_note_tag() {
    local file="$1"
    grep -q "tag:#folder_note\|tags:.*#folder_note\|#folder-note" "$file" 2>/dev/null
}

# Dodaj tag do sekcji tags w frontmatter
add_tag_to_frontmatter() {
    local file="$1"
    
    # Sprawdź czy ma już tag
    if has_folder_note_tag "$file"; then
        log_info "Ma już tag: $file"
        return 0
    fi
    
    # Sprawdź czy ma frontmatter
    if ! head -1 "$file" | grep -q "^---$"; then
        log_warn "Brak frontmatter: $file"
        return 1
    fi
    
    # Znajdź linię z tags:
    if grep -q "^tags:" "$file"; then
        # Dodaj do istniejącej sekcji tags
        sed -i '/^tags:/a\  - #folder_note' "$file"
        log_success "Dodano tag: $file"
    else
        # Dodaj nową sekcję tags po ---
        sed -i '/^---$/a tags:\n  - #folder_note' "$file"
        log_success "Utworzono tags i dodano: $file"
    fi
}

main() {
    log_info "📁 Dodawanie tagu #folder_note do folder notes"
    echo
    
    local total=0
    local updated=0
    local skipped=0
    
    # Znajdź wszystkie folder notes
    while IFS= read -r file; do
        [[ -z "$file" ]] && continue
        [[ "$file" == *"/archive/"* ]] && continue
        [[ "$file" == *"/var/log/"* ]] && continue
        [[ "$file" == *"/.obsidian/"* ]] && continue
        [[ "$file" == *"/.continue/"* ]] && continue
        [[ "$file" == *"/.vscode/"* ]] && continue
        
        dir=$(dirname "$file")
        base=$(basename "$file" .md)
        dirbase=$(basename "$dir")
        
        # Sprawdź czy nazwa pliku == nazwa folderu
        if [[ "$base" == "$dirbase" ]] && [[ "$dir" != "." ]]; then
            ((total++))
            
            if add_tag_to_frontmatter "$file"; then
                ((updated++))
            else
                ((skipped++))
            fi
        fi
    done < <(find . -type f -name "*.md" 2>/dev/null)
    
    echo
    log_success "Przetworzono: $total folder notes"
    echo "  ✅ Zaktualizowano: $updated"
    echo "  ⏭️  Pominięto: $skipped"
}

main "$@"
