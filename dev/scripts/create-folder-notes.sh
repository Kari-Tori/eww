#!/usr/bin/env bash
set -euo pipefail

# Tworzy folder_note dla każdego folderu w repo
# Format: folder_name/folder_name.md z YAML folder_stats

readonly REPO_ROOT="/home/jakubc/git/eww"
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[0;33m'
readonly NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $*" >&2
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $*" >&2
}

log_skip() {
    echo -e "${YELLOW}[SKIP]${NC} $*" >&2
}

# Kolory dla głównych folderów
declare -A FOLDER_COLORS=(
    ["core"]="65331"
    ["business"]="2664719"
    ["config"]="5526612"
    ["dev"]="6737151"
    ["docs"]="1334271"
    ["usr"]="16711680"
    ["tools"]="6287"
    ["scripts"]="10944256"
    ["archive"]="8421504"
)

get_folder_color() {
    local folder="$1"
    local base_folder
    
    # Wyciągnij pierwszy segment ścieżki
    base_folder=$(echo "$folder" | cut -d'/' -f1)
    
    # Zwróć kolor lub default
    echo "${FOLDER_COLORS[$base_folder]:-8421504}"
}

create_folder_note() {
    local folder_path="$1"
    local folder_name=$(basename "$folder_path")
    local note_path="$folder_path/${folder_name}.md"
    
    # Sprawdź czy już istnieje
    if [[ -f "$note_path" ]]; then
        log_skip "$note_path exists"
        return 0
    fi
    
    # Policz pliki
    local md_count=$(find "$folder_path" -maxdepth 1 -name "*.md" -type f 2>/dev/null | wc -l)
    local total_count=$(find "$folder_path" -maxdepth 1 -type f 2>/dev/null | wc -l)
    local dir_count=$(find "$folder_path" -maxdepth 1 -type d 2>/dev/null | wc -l)
    dir_count=$((dir_count - 1))  # Odejmij sam folder
    
    # Pobierz kolor
    local folder_color=$(get_folder_color "$folder_path")
    
    # Utwórz folder_note
    cat > "$note_path" << EOF
---
tags:
  - #folder_note
  - #${folder_name}
folder_color: $folder_color
folder_stats:
  md_files: $md_count
  total_files: $total_count
  subdirs: $dir_count
created: $(date -Iseconds)
modified: $(date -Iseconds)
author: jakubc
title: "${folder_name^} - Folder Note"
---

# ${folder_name^}

> Automatycznie wygenerowana notatka folderu

## 📊 Statystyki

- **Pliki Markdown**: $md_count
- **Wszystkie pliki**: $total_count
- **Podfoldery**: $dir_count
- **Kolor**: RGB $folder_color

## 📝 Zawartość

<!-- Auto-generated content -->

---

**Auto-generated** by \`scripts/create-folder-notes.sh\`  
**Last updated**: $(date -Iseconds)
EOF
    
    log_success "Created $note_path"
}

update_folder_stats() {
    local note_path="$1"
    local folder_path=$(dirname "$note_path")
    
    # Policz pliki
    local md_count=$(find "$folder_path" -maxdepth 1 -name "*.md" -type f 2>/dev/null | wc -l)
    local total_count=$(find "$folder_path" -maxdepth 1 -type f 2>/dev/null | wc -l)
    local dir_count=$(find "$folder_path" -maxdepth 1 -type d 2>/dev/null | wc -l)
    dir_count=$((dir_count - 1))
    
    # Update YAML
    sed -i "/^folder_stats:/,/^[^ ]/ {
        s/md_files: .*/md_files: $md_count/
        s/total_files: .*/total_files: $total_count/
        s/subdirs: .*/subdirs: $dir_count/
    }" "$note_path"
    
    sed -i "s/^modified: .*/modified: $(date -Iseconds)/" "$note_path"
    
    log_success "Updated $note_path"
}

main() {
    cd "$REPO_ROOT"
    
    local mode="${1:-create}"
    
    case "$mode" in
        create)
            log_info "Tworzę folder_notes dla wszystkich folderów..."
            
            # Znajdź wszystkie foldery (nie .git, nie archive)
            find . -type d \
                -not -path "./.git/*" \
                -not -path "./archive/*" \
                -not -path "./.obsidian/cache/*" \
                -not -path "./.obsidian/plugins/*" \
                -not -path "./.obsidian/themes/*" \
                2>/dev/null | while read -r folder; do
                
                # Pomiń root i ukryte
                [[ "$folder" == "." ]] && continue
                [[ "$(basename "$folder")" == .* ]] && continue
                
                create_folder_note "$folder"
            done
            ;;
            
        update)
            log_info "Aktualizuję folder_stats we wszystkich folder_notes..."
            
            find . -type f -name "*.md" 2>/dev/null | while read -r note; do
                # Sprawdź czy to folder_note
                if grep -q "tags:" "$note" && grep -q "#folder_note" "$note"; then
                    local folder_name=$(basename "$(dirname "$note")")
                    local note_name=$(basename "$note" .md)
                    
                    # Sprawdź czy nazwa zgadza się (folder_name.md)
                    if [[ "$folder_name" == "$note_name" ]]; then
                        update_folder_stats "$note"
                    fi
                fi
            done
            ;;
            
        *)
            echo "Usage: $0 [create|update]"
            echo "  create - Utwórz folder_notes dla wszystkich folderów"
            echo "  update - Aktualizuj folder_stats w istniejących folder_notes"
            exit 1
            ;;
    esac
    
    log_info "Done!"
}

main "$@"
