#!/usr/bin/env bash
# master-process-vault.sh - Przetwarzanie całego vaultu z AI-tagowaniem
set -euo pipefail

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly CYAN='\033[0;36m'
readonly NC='\033[0m'
readonly BOLD='\033[1m'

EWW_ROOT="/home/jakubc/git/eww"
PROCESSED=0
TOTAL=0
ERRORS=0

# Progress bar
show_progress() {
    local current=$1
    local total=$2
    local width=50
    local percentage=$((current * 100 / total))
    local filled=$((current * width / total))
    local empty=$((width - filled))
    
    printf "\r${CYAN}["
    printf "%${filled}s" | tr ' ' '▓'
    printf "%${empty}s" | tr ' ' '░'
    printf "]${NC} ${BOLD}%d/%d${NC} (${YELLOW}%d%%${NC})" "$current" "$total" "$percentage"
}

# Generuj 7 tagów na podstawie kontekstu pliku (AI-like)
generate_contextual_tags() {
    local file="$1"
    local content
    local tags=()
    
    # Przeczytaj pierwsze 20 linii dla kontekstu
    content=$(head -20 "$file" 2>/dev/null | tr '[:upper:]' '[:lower:]')
    local filename=$(basename "$file" .md)
    local dirpath=$(dirname "$file")
    
    # GRUPA 1: Lokalizacja (mandatory)
    case "$dirpath" in
        */usr/jakubc*) tags+=("jakubc") ;;
        */usr/karinam*) tags+=("karinam" "candy") ;;
        */docs*) tags+=("eww" "documentation") ;;
        */config*) tags+=("eww" "config") ;;
        */business*) tags+=("eww" "business") ;;
        */core*) tags+=("eww" "core") ;;
        */tools*) tags+=("eww" "tools") ;;
        */scripts*) tags+=("eww" "automation") ;;
    esac
    
    # GRUPA 2: Kategoria specjalna
    if [[ "$dirpath" =~ star.?wars ]]; then
        tags+=("star-wars" "fun")
    elif [[ "$dirpath" =~ lego ]]; then
        tags+=("lego" "fun")
    elif [[ "$dirpath" =~ [Rr]ecycl ]]; then
        tags+=("recycling" "ecology")
    elif [[ "$dirpath" =~ [Aa]vocado ]]; then
        tags+=("avocado" "food")
    fi
    
    # GRUPA 3: Typ zawartości (AI-based keywords)
    if echo "$content" | grep -qi "study\|learn\|tutorial\|course"; then
        tags+=("study")
    fi
    if echo "$content" | grep -qi "project\|repo\|repository"; then
        tags+=("project")
    fi
    if echo "$content" | grep -qi "idea\|concept\|brain"; then
        tags+=("idea")
    fi
    if echo "$content" | grep -qi "recipe\|ingredient\|cook"; then
        tags+=("recipe")
    fi
    if echo "$content" | grep -qi "note\|meeting\|summary"; then
        tags+=("note")
    fi
    if echo "$content" | grep -qi "ai\|llm\|gpt\|claude\|copilot"; then
        tags+=("ai")
    fi
    if echo "$content" | grep -qi "code\|script\|program\|function"; then
        tags+=("code")
    fi
    if echo "$content" | grep -qi "setup\|install\|config"; then
        tags+=("setup")
    fi
    if echo "$content" | grep -qi "fix\|bug\|issue\|problem"; then
        tags+=("fix")
    fi
    if echo "$content" | grep -qi "obsidian\|vault\|plugin"; then
        tags+=("obsidian")
    fi
    
    # GRUPA 4: Status
    if echo "$content" | grep -qi "wip\|draft\|todo"; then
        tags+=("wip")
    elif echo "$content" | grep -qi "done\|complete\|finished"; then
        tags+=("done")
    fi
    
    # Usuń duplikaty i ogranicz do 7
    local unique_tags=($(printf '%s\n' "${tags[@]}" | sort -u | head -7))
    
    # Wypełnij do 7 jeśli brakuje
    while [ ${#unique_tags[@]} -lt 7 ]; do
        if [[ "$filename" =~ index|INDEX ]]; then
            unique_tags+=("index")
        elif [[ "$filename" =~ readme|README ]]; then
            unique_tags+=("readme")
        elif [[ "$filename" =~ vault ]]; then
            unique_tags+=("vault")
        else
            unique_tags+=("misc")
        fi
        unique_tags=($(printf '%s\n' "${unique_tags[@]}" | sort -u))
    done
    
    # Wyświetl jako YAML
    printf "tags:\n"
    for tag in "${unique_tags[@]:0:7}"; do
        printf "  - %s\n" "$tag"
    done
}

# Utwórz/zaktualizuj YAML frontmatter
update_yaml_frontmatter() {
    local file="$1"
    local tmpfile="${file}.tmp"
    
    # Generuj tagi
    local yaml_tags
    yaml_tags=$(generate_contextual_tags "$file")
    
    # Sprawdź czy już ma frontmatter
    if head -1 "$file" 2>/dev/null | grep -q "^---$"; then
        # Ma frontmatter - zaktualizuj tagi
        awk -v tags="$yaml_tags" '
        BEGIN { in_fm=0; tags_section=0; tags_printed=0 }
        /^---$/ { 
            if (NR==1) { in_fm=1; print; next }
            else if (in_fm) { 
                if (!tags_printed) { print tags }
                in_fm=0; print; next 
            }
        }
        in_fm && /^tags:/ { 
            tags_section=1
            if (!tags_printed) { print tags; tags_printed=1 }
            next
        }
        in_fm && tags_section && /^  -/ { next }
        in_fm && tags_section && !/^  -/ { tags_section=0 }
        { print }
        ' "$file" > "$tmpfile"
    else
        # Brak frontmatter - dodaj
        {
            echo "---"
            echo "$yaml_tags"
            echo "created: $(date -r "$file" +%Y-%m-%d)"
            echo "updated: $(date +%Y-%m-%d)"
            echo "author: jakubc"
            echo "---"
            echo ""
            cat "$file"
        } > "$tmpfile"
    fi
    
    mv "$tmpfile" "$file"
}

# Generuj backlinki dla pliku
generate_backlinks() {
    local file="$1"
    local filename=$(basename "$file" .md)
    local backlinks=()
    
    # Szukaj plików linkujących do tego
    while IFS= read -r linking_file; do
        local link_name=$(basename "$linking_file" .md)
        backlinks+=("[[${link_name}]]")
    done < <(grep -l "\[\[${filename}\]\]" $(find "$EWW_ROOT" -name "*.md" ! -path "*/.git/*" ! -path "*/.obsidian/*" ! -path "*/archive/*") 2>/dev/null | head -5)
    
    if [ ${#backlinks[@]} -gt 0 ]; then
        echo ""
        echo "## 🔗 Backlinks"
        echo ""
        printf '%s\n' "${backlinks[@]}"
    fi
}

# Przetwórz pojedynczy plik MD
process_md_file() {
    local file="$1"
    local show_tags="${2:-false}"
    
    # Aktualizuj YAML
    update_yaml_frontmatter "$file"
    
    # Opcjonalnie dodaj backlinki (jeśli plik nie ma sekcji Backlinks)
    if ! grep -q "## 🔗 Backlinks" "$file"; then
        local backlinks
        backlinks=$(generate_backlinks "$file")
        if [ -n "$backlinks" ]; then
            echo "$backlinks" >> "$file"
        fi
    fi
    
    # Wyświetl tagi jeśli requested
    if [ "$show_tags" = "true" ]; then
        local tags=$(grep "^  - " "$file" | head -7 | tr -d ' ' | tr '\n' ' ')
        echo -e "  ${YELLOW}Tags: ${tags}${NC}"
    fi
}

# Utwórz folder note
create_folder_note() {
    local folder="$1"
    local folder_name=$(basename "$folder")
    local note_path="${folder}/${folder_name}.md"
    
    # Sprawdź czy już istnieje
    if [ -f "$note_path" ]; then
        return 0  # Skip if exists
    fi
    
    # Lista plików w folderze
    local files=()
    while IFS= read -r file; do
        local fname=$(basename "$file" .md)
        files+=("- [[${fname}]]")
    done < <(find "$folder" -maxdepth 1 -name "*.md" -type f ! -name "${folder_name}.md" | sort)
    
    # Lista subfolderów
    local subdirs=()
    while IFS= read -r subdir; do
        local dname=$(basename "$subdir")
        subdirs+=("- 📁 [[${dname}/${dname}]]")
    done < <(find "$folder" -mindepth 1 -maxdepth 1 -type d ! -name ".*" | sort)
    
    # Utwórz folder note
    cat > "$note_path" << EOF
---
tags:
  - folder-note
  - index
  - ${folder_name}
created: $(date +%Y-%m-%d)
author: jakubc
---

# 📁 ${folder_name}

## 📋 Opis

Folder zawiera $(echo "${files[@]}" | wc -w) plików i $(echo "${subdirs[@]}" | wc -w) podfolderów.

## 📄 Pliki

$(printf '%s\n' "${files[@]}")

$(if [ ${#subdirs[@]} -gt 0 ]; then
    echo "## 📂 Podfoldery"
    echo ""
    printf '%s\n' "${subdirs[@]}"
fi)

---

*Wygenerowano automatycznie przez master-process-vault.sh*
EOF
}

# MAIN PROCESSING
main() {
    local show_tags="${1:-true}"
    
    echo -e "${BOLD}${BLUE}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║     🚀 MASTER VAULT PROCESSOR - AI Tagging + Indexing     ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    # Faza 1: Przetwarzanie plików MD
    echo -e "${BOLD}${CYAN}📝 FAZA 1: Przetwarzanie plików MD${NC}"
    
    local md_files=()
    while IFS= read -r -d '' file; do
        md_files+=("$file")
    done < <(find "$EWW_ROOT" -name "*.md" -type f \
        ! -path "*/.git/*" \
        ! -path "*/.obsidian/*" \
        ! -path "*/archive/*" \
        -print0 | sort -z)
    
    TOTAL=${#md_files[@]}
    echo -e "${YELLOW}Znaleziono: $TOTAL plików${NC}"
    echo ""
    
    for file in "${md_files[@]}"; do
        ((PROCESSED++)) || true
        show_progress $PROCESSED $TOTAL
        
        if ! process_md_file "$file" "$show_tags"; then
            ((ERRORS++)) || true
        fi
    done
    
    echo ""
    echo -e "${GREEN}✅ Przetworzono $PROCESSED plików (błędy: $ERRORS)${NC}"
    echo ""
    
    # Faza 2: Tworzenie folder notes
    echo -e "${BOLD}${CYAN}📁 FAZA 2: Generowanie folder notes${NC}"
    
    local folders=()
    while IFS= read -r -d '' folder; do
        folders+=("$folder")
    done < <(find "$EWW_ROOT" -type d \
        ! -path "*/.git/*" \
        ! -path "*/.obsidian/*" \
        ! -path "*/archive/*" \
        -mindepth 1 \
        -print0 | sort -z)
    
    local folder_total=${#folders[@]}
    local folder_processed=0
    
    echo -e "${YELLOW}Znaleziono: $folder_total folderów${NC}"
    echo ""
    
    for folder in "${folders[@]}"; do
        ((folder_processed++)) || true
        show_progress $folder_processed $folder_total
        
        create_folder_note "$folder"
    done
    
    echo ""
    echo -e "${GREEN}✅ Utworzono $folder_processed folder notes${NC}"
    echo ""
    
    # Podsumowanie
    echo -e "${BOLD}${GREEN}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║                    ✨ COMPLETED ✨                         ║"
    echo "╠════════════════════════════════════════════════════════════╣"
    echo "║  📝 Pliki MD:        $PROCESSED/$TOTAL"
    echo "║  📁 Folder notes:    $folder_processed/$folder_total"
    echo "║  ❌ Błędy:           $ERRORS"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Uruchom
main "$@"
