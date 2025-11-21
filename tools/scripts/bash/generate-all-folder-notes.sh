#!/usr/bin/env bash
# generate-all-folder-notes.sh - Generowanie folder notes dla wszystkich katalogów
set -euo pipefail

readonly EWW_ROOT="$(pwd)"
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $*"; }
log_success() { echo -e "${GREEN}[OK]${NC} $*"; }
log_warn() { echo -e "${YELLOW}[SKIP]${NC} $*"; }

# Funkcja: Określ kategorię na podstawie ścieżki
get_category() {
    local path="$1"
    
    if [[ "$path" =~ ^\./(business|Business) ]]; then echo "business"
    elif [[ "$path" =~ ^\./(dev|development) ]]; then echo "development"
    elif [[ "$path" =~ ^\./(docs|documentation) ]]; then echo "documentation"
    elif [[ "$path" =~ ^\./(usr|users) ]]; then echo "personal"
    elif [[ "$path" =~ ^\./(core|lib|bin) ]]; then echo "core"
    elif [[ "$path" =~ ^\./(infra|infrastructure) ]]; then echo "infrastructure"
    elif [[ "$path" =~ ^\./(projects) ]]; then echo "project"
    else echo "general"
    fi
}

# Funkcja: Generuj folder note
generate_folder_note() {
    local dir="$1"
    local dirname=$(basename "$dir")
    local folder_note="$dir/$dirname.md"
    local category=$(get_category "$dir")
    
    # Pomiń jeśli już istnieje
    if [[ -f "$folder_note" ]]; then
        log_warn "$dirname.md już istnieje"
        return
    fi
    
    log_info "Tworzę $dirname.md"
    
    # Zbierz pliki MD (nie folder note)
    local files=()
    while IFS= read -r -d '' file; do
        local fname=$(basename "$file")
        [[ "$fname" == "$dirname.md" ]] && continue
        files+=("$file")
    done < <(find "$dir" -maxdepth 1 -type f -name "*.md" -print0 2>/dev/null | sort -z)
    
    # Zbierz podfoldery
    local subdirs=()
    while IFS= read -r -d '' subdir; do
        subdirs+=("$subdir")
    done < <(find "$dir" -maxdepth 1 -mindepth 1 -type d ! -name ".*" -print0 2>/dev/null | sort -z)
    
    # Określ opis folderu
    local description="Katalog \`$dirname\`"
    
    # Generuj folder note
    cat > "$folder_note" <<EOF
---
title: "$dirname"
description: "Folder note dla $dirname"
category: folder-note
tags:
  - folder-note
  - index
  - $category
created: $(date +%Y-%m-%d)
updated: $(date +%Y-%m-%d)
author: EWW Team
source: "[[docs/INDEX]]"
cssclasses:
  - eww-folder-note
---

# 📁 $dirname

> **Folder Note** - centralny index dla katalogu \`$dirname/\`

## 📋 Cel folderu

$description zawiera $([ ${#files[@]} -gt 0 ] && echo "${#files[@]} plików" || echo "podfoldery") związanych z tematyką $(echo $category | sed 's/-/ /g').

**Przeznaczenie:**
EOF

    # Dodaj opis na podstawie kategorii
    case "$category" in
        business)
            echo "- Dokumenty biznesowe, operacje, finanse" >> "$folder_note"
            echo "- Procesy sprzedażowe i zarządzanie" >> "$folder_note"
            ;;
        development)
            echo "- Projekty deweloperskie i playbooki" >> "$folder_note"
            echo "- Kod źródłowy i dokumentacja techniczna" >> "$folder_note"
            ;;
        documentation)
            echo "- Dokumentacja projektowa i techniczna" >> "$folder_note"
            echo "- Przewodniki, referencje i zasoby" >> "$folder_note"
            ;;
        personal)
            echo "- Profile użytkowników i workspace" >> "$folder_note"
            echo "- Notatki osobiste i vault Obsidian" >> "$folder_note"
            ;;
        core)
            echo "- Komponenty podstawowe systemu" >> "$folder_note"
            echo "- Biblioteki, templates, polityki" >> "$folder_note"
            ;;
        infrastructure)
            echo "- Konfiguracja infrastruktury" >> "$folder_note"
            echo "- Ansible, deployment, systemd" >> "$folder_note"
            ;;
        project)
            echo "- Projekty i inicjatywy" >> "$folder_note"
            echo "- Skrypty inicjalizacyjne" >> "$folder_note"
            ;;
        *)
            echo "- Pliki i zasoby ogólnego przeznaczenia" >> "$folder_note"
            ;;
    esac
    
    cat >> "$folder_note" <<EOF

---

## 📄 Pliki w folderze

EOF

    # Lista plików z opisami
    if [ ${#files[@]} -gt 0 ]; then
        for file in "${files[@]}"; do
            local fname=$(basename "$file" .md)
            local fdesc=""
            
            # Spróbuj wyciągnąć opis z frontmatter
            if grep -q "^description:" "$file" 2>/dev/null; then
                fdesc=$(grep "^description:" "$file" | head -1 | sed 's/description: *//;s/"//g' || echo "")
            fi
            
            # Jeśli brak opisu, użyj nazwy pliku
            [[ -z "$fdesc" ]] && fdesc="${fname//_/ }"
            
            echo "- [[${fname}]] - ${fdesc}" >> "$folder_note"
        done
    else
        echo "*Brak plików MD w tym folderze.*" >> "$folder_note"
    fi
    
    cat >> "$folder_note" <<EOF

## 📂 Podfoldery

EOF

    # Lista podfolderów
    if [ ${#subdirs[@]} -gt 0 ]; then
        for subdir in "${subdirs[@]}"; do
            local subname=$(basename "$subdir")
            echo "- 📂 [[${subname}/${subname}|${subname}]] - Subfolder" >> "$folder_note"
        done
    else
        echo "*Brak podfolderów.*" >> "$folder_note"
    fi
    
    # Backlink do parent
    local parent_dir=$(dirname "$dir")
    local parent_name=$(basename "$parent_dir")
    
    if [[ "$parent_dir" != "." && "$parent_dir" != "$EWW_ROOT" ]]; then
        cat >> "$folder_note" <<EOF

## 🔗 Nawigacja

- ⬆️ [[${parent_name}/${parent_name}|${parent_name}]] - Folder nadrzędny
- 🏠 [[docs/INDEX|INDEX]] - Główny index

EOF
    else
        cat >> "$folder_note" <<EOF

## 🔗 Nawigacja

- 🏠 [[docs/INDEX|INDEX]] - Główny index

EOF
    fi
    
    # Stopka
    cat >> "$folder_note" <<EOF
---

**Lokalizacja:** \`${dir#./}\`  
**Zaktualizowano:** $(date +%Y-%m-%d)  
**Typ:** Folder Note
EOF
    
    log_success "$dirname.md utworzony"
}

# Main
cat <<'BANNER'
╔════════════════════════════════════════════════════════════════╗
║                                                                ║
║        📁 GENEROWANIE FOLDER NOTES                             ║
║                                                                ║
╚════════════════════════════════════════════════════════════════╝
BANNER

echo ""
log_info "Szukam folderów bez folder notes..."
echo ""

created=0
skipped=0

# Pomiń te katalogi
SKIP_DIRS="\.git|\.github|\.githooks|\.obsidian|\.vscode|\.continue|\.vale|\.space|\.makemd|archive|node_modules"

# Znajdź wszystkie katalogi
while IFS= read -r -d '' dir; do
    # Pomiń specjalne
    [[ "$dir" =~ $SKIP_DIRS ]] && continue
    
    # Pomiń root
    [[ "$dir" == "." ]] && continue
    
    dirname=$(basename "$dir")
    
    # Sprawdź czy ma folder note
    if [[ -f "$dir/$dirname.md" ]]; then
        ((skipped++))
        continue
    fi
    
    # Generuj
    generate_folder_note "$dir" && ((created++))
    
done < <(find . -type d -print0 | sort -z)

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
log_success "Zakończono!"
echo ""
echo "📊 Statystyki:"
echo "   • Utworzonych:  $created"
echo "   • Pominiętych:  $skipped (już istnieją)"
echo ""

