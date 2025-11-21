#!/usr/bin/env bash
# File: scripts/generate_code_plugins_md.sh
# Author: 
# Created: 
# Updated: 
# Description: bash
# Tags:
# bash
# ide
# script
# vscode
set -euo pipefail

# Skrypt generuje listę zainstalowanych wtyczek Obsidian dla danego vaulta
# Użycie:
#   ./scripts/generate_code_plugins_md.sh [VAULT_PATH] [OUTPUT_FILE]
# Domyślnie:
#   VAULT_PATH = bieżący katalog (repo root)
#   OUTPUT_FILE = docs/software/code/plugins/installed_pluggins.md

eww::usage() {
    cat <<EOF
Użycie: $0 [VAULT_PATH] [OUTPUT_FILE]
Opis:
  Generuje sekcję "Zainstalowane wtyczki" na podstawie katalogu VAULT_PATH/.obsidian/plugins
Przykład:
  $0 ~/Obsidian/code docs/software/code/plugins/installed_pluggins.md
EOF
}

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
    eww::usage
    exit 0
fi

readonly VAULT_PATH="${1:-$PWD}"
readonly OUTPUT_FILE="${2:-$PWD/docs/software/code/plugins/installed_pluggins.md}"
readonly PLUGINS_DIR="$VAULT_PATH/.obsidian/plugins"

if [[ ! -d "$PLUGINS_DIR" ]]; then
    printf "[EWW] Brak katalogu wtyczek: %s\n" "$PLUGINS_DIR" >&2
    exit 0
fi

# Odczyt pola z manifest.json; używa jq jeśli dostępne, fallback grep
eww::read_manifest_field() {
    local manifest="$1"
    local field="$2"
    if command -v jq >/dev/null 2>&1; then
        jq -r --arg f "$field" '.[$f] // ""' "$manifest" 2>/dev/null || echo ""
    else
        grep -oP "\"${field}\"\\s*:\\s*\"\\K[^\"]+" "$manifest" 2>/dev/null || echo ""
    fi
}

# Formatuje linię listy wtyczek
eww::format_plugin_line() {
    local dir="$1"
    local manifest="$dir/manifest.json"
    local id name desc version

    id="$(basename "$dir")"
    if [[ -f "$manifest" ]]; then
        name="$(eww::read_manifest_field "$manifest" "name")"
        desc="$(eww::read_manifest_field "$manifest" "description")"
        version="$(eww::read_manifest_field "$manifest" "version")"
    fi

    if [[ -z "${name:-}" ]]; then
        name="$id"
    fi

    local line="$name"
    if [[ -n "${version:-}" ]]; then
        line+=" ($version)"
    fi
    if [[ -n "${desc:-}" ]]; then
        line+=" — $desc"
    fi

    printf "%s\n" "$line"
}

# Zbierz wtyczki
counter=0
mapfile -t output_lines < <(for d in "$PLUGINS_DIR"/*; do
    [[ -d "$d" ]] || continue
    ((counter++))
    printf "%d. %s\n" "$counter" "$(eww::format_plugin_line "$d")"
done)

if [[ $counter -eq 0 ]]; then
    printf "[EWW] Nie wykryto wtyczek w: %s\n" "$PLUGINS_DIR" >&2
    exit 0
fi

START_MARKER="<!-- EWW-PLUGINS-START -->"
END_MARKER="<!-- EWW-PLUGINS-END -->"

section="$START_MARKER"$'\n'"## Zainstalowane wtyczki (auto-generated)"$'\n'
for ln in "${output_lines[@]}"; do
    section+="$ln"$'\n'
done
section+="$END_MARKER"$'\n'

# Upewnij się, że katalog docelowy istnieje
mkdir -p "$(dirname "$OUTPUT_FILE")"

if [[ -f "$OUTPUT_FILE" && -s "$OUTPUT_FILE" ]]; then
    if grep -q "$START_MARKER" "$OUTPUT_FILE" 2>/dev/null; then
        awk -v s="$START_MARKER" -v e="$END_MARKER" -v new_section="$section" '
            BEGIN{inside=0}
            {
                if(index($0,s)){ print new_section; inside=1; next }
                if(index($0,e)){ inside=0; next }
                if(inside==0){ print $0 }
            }' "$OUTPUT_FILE" > "$OUTPUT_FILE.tmp" && mv "$OUTPUT_FILE.tmp" "$OUTPUT_FILE"
        printf "[EWW] Zaktualizowano sekcję w: %s\n" "$OUTPUT_FILE"
    else
        printf "\n%s\n" "$section" >> "$OUTPUT_FILE"
        printf "[EWW] Dodano sekcję do: %s\n" "$OUTPUT_FILE"
    fi
else
    # Nowy plik z podstawową strukturą i sekcją
    cat > "$OUTPUT_FILE" <<EOF
---
title: Zainstalowane / rekomendowane wtyczki — Code (specjalne)
generated: $(date -I)
---
$section
EOF
    printf "[EWW] Utworzono plik: %s\n" "$OUTPUT_FILE"
fi

exit 0
