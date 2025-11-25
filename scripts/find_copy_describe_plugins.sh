#!/usr/bin/env bash
set -euo pipefail

# Skrypt:
#  - wyszukuje plik zawierający listę wtyczek w VAULT_PATH (np. "installed_pluggins.md")
#  - kopiuje jego zawartość do docs/software/code/plugins/installed_pluggins.md
#  - dopisuje sekcję "Opis wtyczek" próbując odczytać opisy z manifest.json
#
# Użycie:
#   ./scripts/find_copy_describe_plugins.sh [VAULT_PATH] [OUTPUT_FILE]
# Domyślnie:
#   VAULT_PATH = bieżący katalog (repo root)
#   OUTPUT_FILE = docs/software/code/plugins/installed_pluggins.md

eww::usage() {
    cat <<EOF
Użycie: $0 [VAULT_PATH] [OUTPUT_FILE]
Opis:
  Znajdź plik z listą wtyczek w VAULT_PATH, skopiuj zawartość do OUTPUT_FILE
  i dopisz sekcję "Opis wtyczek" (gdzie możliwe, pobrane z manifest.json).
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    eww::usage
    exit 0
fi

readonly VAULT_PATH="${1:-$PWD}"
readonly OUTPUT_FILE="${2:-$PWD/docs/software/code/plugins/installed_pluggins.md}"
readonly SEARCH_PATTERNS=("installed_pluggins.md" "installed_plugins.md" "plugins.md" "community-plugins.md")
readonly PLUGINS_DIR="$VAULT_PATH/.obsidian/plugins"

# Znajdź plik źródłowy z listą wtyczek
eww::find_source() {
    local base="$1"
    for p in "${SEARCH_PATTERNS[@]}"; do
        if [[ -f "$base/$p" ]]; then
            printf "%s\n" "$base/$p"
            return 0
        fi
    done

    local found
    found="$(find "$base" -maxdepth 4 -type f \( -iname "installed_pluggins.md" -o -iname "installed_plugins.md" -o -iname "plugins.md" -o -iname "community-plugins.md" \) 2>/dev/null | head -n1 || true)"
    if [[ -n "$found" ]]; then
        printf "%s\n" "$found"
        return 0
    fi

    return 1
}

# Odczyt pola z manifest.json (jq lub grep fallback)
eww::read_manifest_field() {
    local manifest="$1"
    local field="$2"
    if [[ ! -f "$manifest" ]]; then
        echo ""
        return 0
    fi
    if command -v jq >/dev/null 2>&1; then
        jq -r --arg f "$field" '.[$f] // ""' "$manifest" 2>/dev/null || echo ""
    else
        grep -oP "\"${field}\"\\s*:\\s*\"\\K[^\"]+" "$manifest" 2>/dev/null || echo ""
    fi
}

# Znajdź manifest.json dla danej nazwy wtyczki
eww::find_plugin_manifest_by_name() {
    local want="$1"
    if [[ ! -d "$PLUGINS_DIR" ]]; then
        return 1
    fi
    shopt -s nullglob
    for d in "$PLUGINS_DIR"/*; do
        if [[ -d "$d" && -f "$d/manifest.json" ]]; then
            local mname
            mname="$(eww::read_manifest_field "$d/manifest.json" "name" || true)"
            if [[ -n "$mname" && "${mname,,}" == "${want,,}" ]]; then
                printf "%s\n" "$d/manifest.json"
                shopt -u nullglob
                return 0
            fi
            local dname
            dname="$(basename "$d")"
            if [[ "${dname,,}" == "${want,,}" ]]; then
                printf "%s\n" "$d/manifest.json"
                shopt -u nullglob
                return 0
            fi
        fi
    done
    shopt -u nullglob
    return 1
}

# Parsuj linie numerowane i zwróć nazwy wtyczek (bez opisu)
eww::extract_plugin_names() {
    local content="$1"
    printf "%s\n" "$content" | sed -n 's/^[[:space:]]*[0-9]\+\.[[:space:]]*\(.*\)$/\1/p' | sed -E 's/[[:space:]]+[—-].*$//; s/\s*\(.*\)$//'
}

main() {
    local src
    if ! src="$(eww::find_source "$VAULT_PATH")"; then
        printf "[EWW] Nie znaleziono pliku z listą wtyczek w: %s\n" "$VAULT_PATH" >&2
        return 1
    fi

    printf "[EWW] Znaleziono plik źródłowy: %s\n" "$src"

    local content
    content="$(cat "$src")"

    # Przygotuj sekcję opisu
    local desc_section
    desc_section="## Opis wtyczek (wygenerowane)"$'\n\n'
    mapfile -t names < <(eww::extract_plugin_names "$content" | sed '/^\s*$/d')

    if [[ ${#names[@]} -eq 0 ]]; then
        desc_section+=$'\n'"Brak zrozumiałych linii numerowanych do parsowania nazw wtyczek."$'\n'
    else
        for nm in "${names[@]}"; do
            local manifest
            if manifest="$(eww::find_plugin_manifest_by_name "$nm" 2>/dev/null || true)"; then
                local mdesc mver
                mdesc="$(eww::read_manifest_field "$manifest" "description" || true)"
                mver="$(eww::read_manifest_field "$manifest" "version" || true)"
                if [[ -n "$mdesc" ]]; then
                    desc_section+="- $nm"
                    if [[ -n "$mver" ]]; then
                        desc_section+=" ($mver)"
                    fi
                    desc_section+=" — $mdesc"$'\n'
                else
                    desc_section+="- $nm — brak opisu w manifest.json"
                    if [[ -n "$mver" ]]; then
                        desc_section+=" ($mver)"
                    fi
                    desc_section+=$'\n'
                fi
            else
                desc_section+="- $nm — (brak dodatkowego opisu lub nie znaleziono manifestu)"$'\n'
            fi
        done
    fi

    # Przygotuj sekcję wynikową z markerami
    local START_MARKER="<!-- EWW-PLUGINS-START -->"
    local END_MARKER="<!-- EWW-PLUGINS-END -->"
    local section
    section="$START_MARKER"$'\n'
    section+="## Skopiowana zawartość z: $src"$'\n\n'
    section+="$content"$'\n\n'
    section+="$desc_section"$'\n'
    section+="$END_MARKER"$'\n'

    mkdir -p "$(dirname "$OUTPUT_FILE")"

    if [[ -f "$OUTPUT_FILE" && grep -q "$START_MARKER" "$OUTPUT_FILE" 2>/dev/null ]]; then
        awk -v s="$START_MARKER" -v e="$END_MARKER" -v new_section="$section" '
            BEGIN{inside=0}
            {
                if(index($0,s)){ print new_section; inside=1; next }
                if(index($0,e)){ inside=0; next }
                if(inside==0){ print $0 }
            }' "$OUTPUT_FILE" > "$OUTPUT_FILE.tmp" && mv "$OUTPUT_FILE.tmp" "$OUTPUT_FILE"
        printf "[EWW] Zaktualizowano sekcję w: %s\n" "$OUTPUT_FILE"
    else
        if [[ ! -f "$OUTPUT_FILE" ]]; then
            cat > "$OUTPUT_FILE" <<EOF
---
title: Zainstalowane / rekomendowane wtyczki — Code (specjalne)
generated: $(date -I)
---
EOF
        fi
        printf "\n%s\n" "$section" >> "$OUTPUT_FILE"
        printf "[EWW] Dodano nową sekcję do: %s\n" "$OUTPUT_FILE"
    fi

    return 0
}

main "$@"
