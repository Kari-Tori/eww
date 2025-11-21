#!/usr/bin/env bash
# normalize-vault.sh - Normalizacja wszystkich plików MD w vault
set -euo pipefail

readonly VAULT_ROOT="${1:-/home/jakubc/git/eww}"
readonly DRY_RUN="${2:-false}"

# Kolory tagów/grup
declare -A TAG_COLORS=(
    ["eww"]="#00ff00"           # neonowy zielony - core repo
    ["jakubc"]="#ff0000"        # neonowy czerwony
    ["karinam"]="#ff69b4"       # candy pink
    ["star-wars"]="#ffff00"     # fun yellow
    ["recycling"]="#32cd32"     # zielony recykling
    ["lego"]="#ffd700"          # złoty
    ["avocado"]="#228b22"       # ciemny zielony
    ["ai"]="#00ffff"            # cyan
    ["hardware"]="#ff8c00"      # pomarańczowy
    ["obsidian"]="#9370db"      # fioletowy
    ["config"]="#4169e1"        # royal blue
    ["infra"]="#808080"         # szary
)

# Definiuj główne grupy tagów (max 7 na plik)
get_tags_for_path() {
    local file_path="$1"
    local tags=()
    
    # Bazowe tagi wg lokalizacji
    if [[ "$file_path" =~ usr/jakubc ]]; then
        tags+=("jakubc" "usr")
    elif [[ "$file_path" =~ usr/karinam ]]; then
        tags+=("karinam" "usr")
    fi
    
    if [[ "$file_path" =~ star_wars ]]; then
        tags+=("star-wars" "fun")
    fi
    
    if [[ "$file_path" =~ docs ]]; then
        tags+=("eww" "docs")
    elif [[ "$file_path" =~ config ]]; then
        tags+=("eww" "config")
    elif [[ "$file_path" =~ business ]]; then
        tags+=("eww" "business")
    elif [[ "$file_path" =~ core ]]; then
        tags+=("eww" "core")
    fi
    
    if [[ "$file_path" =~ hardware ]]; then
        tags+=("hardware")
    fi
    
    if [[ "$file_path" =~ recycling|recycle ]]; then
        tags+=("recycling")
    fi
    
    if [[ "$file_path" =~ lego|LEGO ]]; then
        tags+=("lego")
    fi
    
    if [[ "$file_path" =~ avocado ]]; then
        tags+=("avocado")
    fi
    
    if [[ "$file_path" =~ AI|ai ]]; then
        tags+=("ai")
    fi
    
    if [[ "$file_path" =~ obsidian|Obsidian ]]; then
        tags+=("obsidian")
    fi
    
    # Dodaj uniwersalne
    tags+=("2025" "index" "ready")
    
    # Ogranicz do 7
    tags=("${tags[@]:0:7}")
    
    # Usuń duplikaty
    local unique_tags=($(printf "%s\n" "${tags[@]}" | sort -u))
    
    printf "%s\n" "${unique_tags[@]:0:7}"
}

# Normalizuj pojedynczy plik
normalize_file() {
    local file="$1"
    local rel_path="${file#$VAULT_ROOT/}"
    
    echo "🔧 Przetwarzam: $rel_path"
    
    # Pobierz tagi
    local tags
    mapfile -t tags < <(get_tags_for_path "$rel_path")
    
    # Autor wg ścieżki
    local author="jakubc"
    [[ "$rel_path" =~ karinam ]] && author="karinam"
    
    # Daty z git (lub fallback)
    local created modified
    created=$(git log --follow --format=%aI --reverse "$file" 2>/dev/null | head -1 || echo "2025-11-21")
    modified=$(git log -1 --format=%aI "$file" 2>/dev/null || echo "2025-11-21")
    created="${created%%T*}"
    modified="${modified%%T*}"
    
    # Sprawdź czy ma frontmatter
    if ! head -1 "$file" | grep -q "^---"; then
        # Dodaj nowy frontmatter
        local temp_file=$(mktemp)
        {
            echo "---"
            echo "tags:"
            for tag in "${tags[@]}"; do
                echo "  - $tag"
            done
            echo "created: $created"
            echo "modified: $modified"
            echo "author: $author"
            echo "status: active"
            echo "---"
            echo ""
            cat "$file"
        } > "$temp_file"
        
        [[ "$DRY_RUN" == "false" ]] && mv "$temp_file" "$file" || rm "$temp_file"
        
    else
        # Aktualizuj istniejący (zachowaj resztę zawartości)
        echo "  ↳ Aktualizuję frontmatter"
        # TODO: parsowanie i update YAML
    fi
}

# Utwórz folder note
create_folder_note() {
    local folder="$1"
    local folder_name=$(basename "$folder")
    local folder_note="$folder/${folder_name}.md"
    
    [[ -f "$folder_note" ]] && return 0
    
    echo "📝 Tworzę folder note: $folder_note"
    
    local tags
    mapfile -t tags < <(get_tags_for_path "$folder")
    
    local author="jakubc"
    [[ "$folder" =~ karinam ]] && author="karinam"
    
    if [[ "$DRY_RUN" == "false" ]]; then
        cat > "$folder_note" << EOF
---
tags:
$(for tag in "${tags[@]}"; do echo "  - $tag"; done)
created: 2025-11-21
modified: 2025-11-21
author: $author
status: folder-note
---

# 📁 $folder_name

> [!info] Opis folderu
> Ten folder zawiera pliki związane z: $folder_name

## 📂 Zawartość

### Pliki:

EOF
        # Dodaj index plików
        find "$folder" -maxdepth 1 -name "*.md" ! -name "${folder_name}.md" | sort | while read -r md_file; do
            local basename=$(basename "$md_file" .md)
            echo "- [[$basename]] - TODO: dodaj opis" >> "$folder_note"
        done
        
        echo "" >> "$folder_note"
        echo "---" >> "$folder_note"
        echo "*Folder note wygenerowana automatycznie: 2025-11-21*" >> "$folder_note"
    fi
}

# MAIN
main() {
    cd "$VAULT_ROOT"
    
    echo "=== NORMALIZACJA VAULT ==="
    echo "Vault: $VAULT_ROOT"
    echo "Dry run: $DRY_RUN"
    echo ""
    
    # 1. Utwórz folder notes
    echo "📁 Tworzę folder notes..."
    find . -type d -not -path "./.git/*" -not -path "./archive/*" -not -path "./.obsidian/*" | while read -r dir; do
        [[ "$dir" == "." ]] && continue
        create_folder_note "$dir"
    done
    
    # 2. Normalizuj wszystkie pliki MD
    echo ""
    echo "📄 Normalizuję pliki MD..."
    find . -type f -name "*.md" -not -path "./.git/*" -not -path "./archive/*" | while read -r file; do
        normalize_file "$file"
    done
    
    echo ""
    echo "✅ GOTOWE!"
}

main "$@"
