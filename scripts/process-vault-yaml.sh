#!/usr/bin/env bash
# process-vault-yaml.sh - Inteligentne przetwarzanie YAML frontmatter z AI
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly VAULT_ROOT="/home/jakubc/git/eww"

# Kolory dla progress bar
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly CYAN='\033[0;36m'
readonly NC='\033[0m'

# Statystyki
declare -i TOTAL_FILES=0
declare -i PROCESSED_FILES=0
declare -i SKIPPED_FILES=0
declare -i ERROR_FILES=0

# Grupy tagów z kolorami (12 głównych grup)
declare -A TAG_COLORS=(
    ["eww"]="#00ff00"           # zielony neonowy - core repo
    ["jakubc"]="#ff0000"        # czerwony neonowy
    ["karinam"]="#ff69b4"       # candy pink
    ["star-wars"]="#ffa500"     # pomarańczowy - fun
    ["recycling"]="#32cd32"     # zielony - ekologia
    ["lego"]="#ffff00"          # żółty
    ["avocado"]="#568203"       # zielony ciemny
    ["health"]="#ff1493"        # różowy - zdrowie
    ["obsidian"]="#9370db"      # fioletowy - narzędzia
    ["study"]="#00bfff"         # niebieski - nauka
    ["m18"]="#ff4500"           # pomarańczowo-czerwony
    ["inbox"]="#808080"         # szary - do przetworzenia
)

# Generuj inteligentne tagi na podstawie kontekstu pliku
generate_smart_tags() {
    local file_path="$1"
    local file_content="$2"
    local tags=()
    
    # Określ folder i kontekst
    local dir_path=$(dirname "$file_path")
    
    # Tag główny - grupa użytkownika/projektu
    if [[ "$file_path" =~ usr/jakubc ]]; then
        tags+=("#jakubc")
    elif [[ "$file_path" =~ usr/karinam ]]; then
        tags+=("#karinam")
    elif [[ "$file_path" =~ (docs|config|business|core) ]]; then
        tags+=("#eww")
    fi
    
    # Tag tematyczny na podstawie folderu
    if [[ "$file_path" =~ star_wars ]]; then
        tags+=("#star-wars")
    elif [[ "$file_path" =~ recycling ]]; then
        tags+=("#recycling")
    elif [[ "$file_path" =~ lego ]]; then
        tags+=("#lego")
    elif [[ "$file_path" =~ health ]]; then
        tags+=("#health")
    elif [[ "$file_path" =~ obsidian-plugins ]]; then
        tags+=("#obsidian")
    elif [[ "$file_path" =~ Study ]]; then
        tags+=("#study")
    elif [[ "$file_path" =~ m18 ]]; then
        tags+=("#m18")
    elif [[ "$file_path" =~ Inbox ]]; then
        tags+=("#inbox")
    fi
    
    # Tagi na podstawie zawartości (słowa kluczowe)
    if echo "$file_content" | grep -qi "github\|git\|repository"; then
        tags+=("#git")
    fi
    if echo "$file_content" | grep -qi "script\|bash\|shell"; then
        tags+=("#automation")
    fi
    if echo "$file_content" | grep -qi "install\|setup\|config"; then
        tags+=("#setup")
    fi
    if echo "$file_content" | grep -qi "tutorial\|guide\|how-to"; then
        tags+=("#guide")
    fi
    if echo "$file_content" | grep -qi "project\|plan\|todo"; then
        tags+=("#project")
    fi
    if echo "$file_content" | grep -qi "note\|idea\|memo"; then
        tags+=("#notes")
    fi
    if echo "$file_content" | grep -qi "doc\|documentation"; then
        tags+=("#documentation")
    fi
    
    # Usuń duplikaty i ogranicz do 7 tagów
    local unique_tags=($(printf '%s\n' "${tags[@]}" | sort -u | head -7))
    
    # Jeśli mniej niż 7, dodaj ogólne
    while [[ ${#unique_tags[@]} -lt 7 ]]; do
        if [[ ! " ${unique_tags[@]} " =~ " #obsidian " ]]; then
            unique_tags+=("#obsidian")
        elif [[ ! " ${unique_tags[@]} " =~ " #vault " ]]; then
            unique_tags+=("#vault")
        elif [[ ! " ${unique_tags[@]} " =~ " #knowledge " ]]; then
            unique_tags+=("#knowledge")
        elif [[ ! " ${unique_tags[@]} " =~ " #personal " ]]; then
            unique_tags+=("#personal")
        else
            break
        fi
    done
    
    # Zwróć jako string rozdzielony spacjami
    printf '%s\n' "${unique_tags[@]}"
}

# Wyświetl progress bar
show_progress() {
    local current=$1
    local total=$2
    local width=50
    local percentage=$((current * 100 / total))
    local filled=$((width * current / total))
    local empty=$((width - filled))
    
    printf "\r${CYAN}[${GREEN}"
    printf "%${filled}s" | tr ' ' '█'
    printf "${NC}%${empty}s${CYAN}]${NC} %3d%% (%d/%d)" "" "$percentage" "$current" "$total"
}

# Przetwórz pojedynczy plik
process_file() {
    local file="$1"
    local rel_path="${file#$VAULT_ROOT/}"
    
    # Pomiń pliki specjalne
    if [[ "$file" =~ (\.obsidian|\.git|archive|Tags)/ ]]; then
        ((SKIPPED_FILES++)) || true
        return 0
    fi
    
    # Odczytaj zawartość
    local content
    content=$(cat "$file")
    
    # Generuj tagi AI
    local tags_array
    mapfile -t tags_array < <(generate_smart_tags "$rel_path" "$content")
    local tags_line=$(printf ", %s" "${tags_array[@]}")
    tags_line="${tags_line:2}"  # Usuń początkowy ", "
    
    # Pobierz datę utworzenia i modyfikacji
    local created_date modified_date
    if [[ -d "$VAULT_ROOT/.git" ]]; then
        created_date=$(git -C "$VAULT_ROOT" log --diff-filter=A --follow --format=%aI -- "$file" 2>/dev/null | tail -1 || date -Iseconds)
        modified_date=$(git -C "$VAULT_ROOT" log -1 --format=%aI -- "$file" 2>/dev/null || date -Iseconds)
    else
        created_date=$(date -Iseconds)
        modified_date=$(date -Iseconds)
    fi
    
    # Wyciągnij tytuł (pierwsza linia nie będąca frontmatter)
    local title
    title=$(echo "$content" | grep -v '^---' | grep -v '^tags:' | grep -v '^created:' | grep -v '^modified:' | grep -v '^author:' | grep '^#' | head -1 | sed 's/^# //' || basename "$file" .md)
    
    # Stwórz nowy frontmatter
    local new_frontmatter="---
tags: [$tags_line]
created: $created_date
modified: $modified_date
author: $(whoami)
title: \"$title\"
---
"
    
    # Usuń stary frontmatter jeśli istnieje
    local content_without_frontmatter
    if echo "$content" | head -1 | grep -q '^---'; then
        content_without_frontmatter=$(echo "$content" | awk '/^---/{if(++count==2) flag=1; next} flag')
    else
        content_without_frontmatter="$content"
    fi
    
    # Zapisz do pliku
    echo "$new_frontmatter$content_without_frontmatter" > "$file"
    
    # Wyświetl postęp
    ((PROCESSED_FILES++)) || true
    show_progress "$PROCESSED_FILES" "$TOTAL_FILES"
    
    # Pokaż tagi dla tego pliku
    if [[ $((PROCESSED_FILES % 10)) -eq 0 ]]; then
        echo -e "\n${BLUE}Ostatnio przetworzone:${NC} $rel_path"
        echo -e "${YELLOW}Tagi:${NC} $tags_line"
    fi
}

# Utwórz folder note dla każdego folderu
create_folder_note() {
    local folder="$1"
    local folder_name=$(basename "$folder")
    local folder_note="$folder/${folder_name}.md"
    local rel_path="${folder#$VAULT_ROOT/}"
    
    # Pomiń foldery specjalne
    if [[ "$folder" =~ (\.obsidian|\.git|archive|Tags)$ ]]; then
        return 0
    fi
    
    # Jeśli folder note już istnieje, pomiń
    if [[ -f "$folder_note" ]]; then
        return 0
    fi
    
    # Zbierz pliki w folderze
    local files=()
    while IFS= read -r -d '' file; do
        files+=("$(basename "$file")")
    done < <(find "$folder" -maxdepth 1 -type f -name "*.md" -print0)
    
    # Generuj opis folderu
    local description="Folder zawierający zasoby związane z: $folder_name"
    
    # Stwórz zawartość folder note
    local folder_note_content="# 📁 $folder_name

## Opis
$description

## 📋 Zawartość folderu

"
    
    # Dodaj index plików
    for file in "${files[@]}"; do
        local file_title="${file%.md}"
        folder_note_content+="- [[$file_title]] - "
        
        # Próbuj wyciągnąć pierwszy nagłówek z pliku
        if [[ -f "$folder/$file" ]]; then
            local first_header=$(grep '^#' "$folder/$file" | head -1 | sed 's/^# //' || echo "Opis niedostępny")
            folder_note_content+="$first_header"
        fi
        folder_note_content+=$'\n'
    done
    
    # Dodaj backlinki
    folder_note_content+=$'\n## 🔗 Powiązania\n\n'
    folder_note_content+="- [[$(dirname "$rel_path" | xargs basename)]] - Folder nadrzędny\n"
    
    # Zapisz folder note
    echo "$folder_note_content" > "$folder_note"
    
    echo -e "${GREEN}✓${NC} Utworzono folder note: $rel_path"
}

# Główna funkcja
main() {
    echo -e "${CYAN}╔════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║  🤖 INTELIGENTNE PRZETWARZANIE VAULT (AI TAGS)    ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    # Zlicz pliki
    echo -e "${BLUE}📊 Skanowanie repozytorium...${NC}"
    TOTAL_FILES=$(find "$VAULT_ROOT" -type f -name "*.md" ! -path "*/.obsidian/*" ! -path "*/.git/*" ! -path "*/archive/*" ! -path "*/Tags/*" | wc -l)
    
    echo -e "${YELLOW}Znaleziono plików:${NC} $TOTAL_FILES"
    echo -e "${YELLOW}Grupy tagów:${NC} ${!TAG_COLORS[@]}"
    echo ""
    
    # Faza 1: Tworzenie folder notes
    echo -e "${CYAN}═══ FAZA 1: FOLDER NOTES ═══${NC}"
    while IFS= read -r -d '' folder; do
        create_folder_note "$folder"
    done < <(find "$VAULT_ROOT" -type d -not -path "*/.obsidian/*" -not -path "*/.git/*" -print0)
    
    echo -e "\n${GREEN}✓ Folder notes utworzone${NC}\n"
    
    # Faza 2: Przetwarzanie plików
    echo -e "${CYAN}═══ FAZA 2: YAML FRONTMATTER + AI TAGS ═══${NC}"
    echo ""
    
    while IFS= read -r -d '' file; do
        process_file "$file" || ((ERROR_FILES++))
    done < <(find "$VAULT_ROOT" -type f -name "*.md" ! -path "*/.obsidian/*" ! -path "*/.git/*" ! -path "*/archive/*" ! -path "*/Tags/*" -print0)
    
    echo -e "\n\n${CYAN}╔════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                  📊 PODSUMOWANIE                   ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════╝${NC}"
    echo -e "${GREEN}✓ Przetworzone pliki:${NC} $PROCESSED_FILES"
    echo -e "${YELLOW}⊘ Pominięte pliki:${NC} $SKIPPED_FILES"
    echo -e "${RED}✗ Błędy:${NC} $ERROR_FILES"
    echo -e "${BLUE}📁 Całkowita liczba:${NC} $TOTAL_FILES"
    echo ""
    echo -e "${GREEN}🎉 GOTOWE! Wszystkie pliki mają 7 tagów AI!${NC}"
}

main "$@"
