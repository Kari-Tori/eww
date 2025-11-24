#!/usr/bin/env bash
# Generowanie folder notes dla wszystkich folderów
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Kolory
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly CYAN='\033[0;36m'
readonly NC='\033[0m'

# Liczniki
TOTAL_FOLDERS=0
CREATED=0
SKIPPED=0

# Wykluczone foldery
readonly EXCLUDED_DIRS=(".git" ".obsidian" ".github" ".githooks" ".makemd" ".continue" "archive" "Tags" ".vale")

# Sprawdź czy folder jest wykluczony
is_excluded() {
    local dir="$1"
    for excluded in "${EXCLUDED_DIRS[@]}"; do
        if [[ "$dir" == *"/$excluded"* ]] || [[ "$dir" == "./$excluded" ]]; then
            return 0
        fi
    done
    return 1
}

# Generuj opis folderu na podstawie zawartości
generate_folder_description() {
    local folder_path="$1"
    local folder_name=$(basename "$folder_path")
    
    # Analiza zawartości
    local file_count=$(find "$folder_path" -maxdepth 1 -type f -name "*.md" 2>/dev/null | wc -l)
    local subdir_count=$(find "$folder_path" -maxdepth 1 -type d ! -path "$folder_path" 2>/dev/null | wc -l)
    
    # Generuj kontekstowy opis
    case "$folder_name" in
        jakubc)
            echo "Osobisty vault Jakuba Czajkowskiego - projekty, notatki, zasoby wiedzy."
            ;;
        karinam)
            echo "Osobisty vault Kariny M - projekty, notatki, przestrzeń robocza."
            ;;
        star_wars|"Star Wars")
            echo "Uniwersum Star Wars - statki, postacie, miejsca, technologie z galaktyki dalekiej."
            ;;
        ships)
            echo "Katalog statków kosmicznych - myśliwce, krążowniki, transportowce."
            ;;
        business)
            echo "Dokumentacja biznesowa - strategia, procesy, modele."
            ;;
        core)
            echo "Rdzeń repozytorium - kluczowe komponenty i biblioteki."
            ;;
        config)
            echo "Pliki konfiguracyjne - ustawienia narzędzi, środowiska, automatyzacji."
            ;;
        docs)
            echo "Dokumentacja projektu - przewodniki, specyfikacje, instrukcje."
            ;;
        infra)
            echo "Infrastruktura - serwery, sieć, deployment, CI/CD."
            ;;
        tools)
            echo "Narzędzia i skrypty pomocnicze - automatyzacja, utylity."
            ;;
        scripts)
            echo "Skrypty Bash - automatyzacja zadań, workflow."
            ;;
        dev)
            echo "Development - projekty deweloperskie, eksperymenty, prototypy."
            ;;
        var)
            echo "Zmienne dane - logi, cache, temporary files."
            ;;
        workflows)
            echo "GitHub Actions workflows - CI/CD, automatyzacja."
            ;;
        *)
            echo "Folder $folder_name - zawiera $file_count plików MD i $subdir_count podfolderów."
            ;;
    esac
}

# Generuj tagi dla folderu
generate_folder_tags() {
    local folder_path="$1"
    local tags=("#index" "#folder-note")
    
    # Tagi na podstawie ścieżki
    if [[ "$folder_path" == *"/jakubc/"* ]]; then
        tags+=("#jakubc")
    fi
    if [[ "$folder_path" == *"/karinam/"* ]]; then
        tags+=("#karinam")
    fi
    if [[ "$folder_path" == *"/business"* ]]; then
        tags+=("#business")
    fi
    if [[ "$folder_path" == *"/core"* ]]; then
        tags+=("#core")
    fi
    if [[ "$folder_path" == *"/docs"* ]]; then
        tags+=("#documentation")
    fi
    if [[ "$folder_path" == *"/infra"* ]]; then
        tags+=("#infrastructure")
    fi
    if [[ "$folder_path" == *"star"* ]] || [[ "$folder_path" == *"Star"* ]]; then
        tags+=("#star-wars")
    fi
    
    # Zawsze #eww
    tags+=("#eww")
    
    # Usuń duplikaty i ogranicz do 7
    local unique=($(printf '%s\n' "${tags[@]}" | sort -u | head -7))
    printf '%s\n' "${unique[@]}"
}

# Generuj index plików w folderze
generate_file_index() {
    local folder_path="$1"
    
    echo "## 📑 Index plików"
    echo ""
    
    # Lista plików MD (bez folder note)
    local folder_name=$(basename "$folder_path")
    local has_files=0
    
    while IFS= read -r file; do
        local filename=$(basename "$file")
        
        # Pomiń folder note
        if [ "$filename" == "$folder_name.md" ]; then
            continue
        fi
        
        has_files=1
        
        # Pobierz tytuł z pliku (pierwsza linia bez #)
        local title=$(head -20 "$file" | grep -m1 "^#" | sed 's/^#* *//' || echo "$filename")
        
        echo "- [[$filename|$title]]"
    done < <(find "$folder_path" -maxdepth 1 -type f -name "*.md" | sort)
    
    if [ $has_files -eq 0 ]; then
        echo "*Brak plików.*"
    fi
    
    echo ""
    
    # Lista podfolderów
    local has_subdirs=0
    echo "## 📁 Podfoldery"
    echo ""
    
    while IFS= read -r subdir; do
        has_subdirs=1
        local subdir_name=$(basename "$subdir")
        echo "- [[${subdir_name}/${subdir_name}|📁 $subdir_name]]"
    done < <(find "$folder_path" -maxdepth 1 -type d ! -path "$folder_path" | sort)
    
    if [ $has_subdirs -eq 0 ]; then
        echo "*Brak podfolderów.*"
    fi
}

# Utwórz folder note
create_folder_note() {
    local folder_path="$1"
    local folder_name=$(basename "$folder_path")
    local folder_note="$folder_path/$folder_name.md"
    
    # Pomiń jeśli już istnieje
    if [ -f "$folder_note" ]; then
        return 1
    fi
    
    # Generuj zawartość
    local description=$(generate_folder_description "$folder_path")
    local tags_array=($(generate_folder_tags "$folder_path"))
    local today=$(date -I)
    
    # Utwórz plik
    cat > "$folder_note" << EOF
---
created: $today
modified: $today
author: jakubc
type: folder-note
tags:
$(printf '  - %s\n' "${tags_array[@]}")
---

# 📁 $folder_name

> $description

$(generate_file_index "$folder_path")

---

**Utworzono:** $today  
**Autor:** jakubc  
**Typ:** Folder Note
EOF
    
    return 0
}

# Progress bar
progress_bar() {
    local current=$1
    local total=$2
    local folder_name="$3"
    local width=40
    local percentage=$((current * 100 / total))
    local completed=$((width * current / total))
    
    printf "\r${BLUE}[${GREEN}"
    printf "%${completed}s" | tr ' ' '█'
    printf "${BLUE}"
    printf "%$((width - completed))s" | tr ' ' '░'
    printf "${BLUE}]${NC} %3d%% ${YELLOW}%d/%d${NC} ${CYAN}| %s${NC}" \
        "$percentage" "$current" "$total" "$folder_name"
}

# Główna funkcja
main() {
    echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${NC}  ${YELLOW}🗂️  GENEROWANIE FOLDER NOTES${NC}                        ${BLUE}║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    # Znajdź wszystkie foldery
    mapfile -t folders < <(find "$REPO_ROOT" -type d ! -path "$REPO_ROOT" | sort)
    
    # Odfiltruj wykluczone
    local valid_folders=()
    for folder in "${folders[@]}"; do
        if ! is_excluded "$folder"; then
            valid_folders+=("$folder")
        fi
    done
    
    TOTAL_FOLDERS=${#valid_folders[@]}
    
    echo -e "${YELLOW}📁 Znaleziono: ${BLUE}$TOTAL_FOLDERS${NC} folderów do przetworzenia"
    echo -e "${YELLOW}🤖 Generowanie folder notes z AI opisami...${NC}"
    echo ""
    
    current=0
    for folder in "${valid_folders[@]}"; do
        ((current++))
        
        folder_name=$(basename "$folder")
        progress_bar "$current" "$TOTAL_FOLDERS" "$folder_name"
        
        if create_folder_note "$folder"; then
            ((CREATED++))
        else
            ((SKIPPED++))
        fi
        
        # Checkpoint co 25 folderów
        if ((current % 25 == 0)); then
            echo ""
            echo -e "  ${GREEN}✓${NC} Checkpoint: ${YELLOW}$CREATED${NC} utworzonych, ${CYAN}$SKIPPED${NC} pominiętych"
        fi
    done
    
    echo ""
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║${NC}  ${YELLOW}✅ GENEROWANIE ZAKOŃCZONE!${NC}                          ${GREEN}║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  📊 ${BLUE}Przetworzonych folderów:${NC}  ${YELLOW}$TOTAL_FOLDERS${NC}"
    echo -e "  ✨ ${BLUE}Utworzono folder notes:${NC}   ${GREEN}$CREATED${NC}"
    echo -e "  ⏭️  ${BLUE}Pominięto (już były):${NC}    ${CYAN}$SKIPPED${NC}"
    echo ""
}

main "$@"
