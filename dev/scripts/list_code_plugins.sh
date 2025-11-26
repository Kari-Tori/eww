#!/usr/bin/env bash
# File: scripts/list_code_plugins.sh
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

# Skrypt listuje zainstalowane wtyczki Obsidian dla wskazanego vaulta.
# Użycie:
#   ./scripts/list_code_plugins.sh [VAULT_PATH]
# Domyślnie VAULT_PATH = /home/karinam/Obsidian/code

eww::log() { printf "[EWW] %s\n" "$*"; }
eww::err() { printf "[EWW] BŁĄD: %s\n" "$*" >&2; }

DEFAULT_VAULT="/home/karinam/Obsidian/code"
VAULT_PATH="${1:-$DEFAULT_VAULT}"
PLUGINS_DIR="$VAULT_PATH/.obsidian/plugins"

if [[ ! -d "$PLUGINS_DIR" ]]; then
  eww::err "Katalog wtyczek nie istnieje: $PLUGINS_DIR"
  exit 1
fi

# Odczyt pola z manifest.json; użyj jq jeśli dostępne, fallback sed
eww::read_manifest_field() {
  local manifest="$1"
  local field="$2"
  if [[ ! -f "$manifest" ]]; then
    printf ""
    return 0
  fi
  if command -v jq >/dev/null 2>&1; then
    jq -r --arg f "$field" '.[$f] // empty' "$manifest" 2>/dev/null || true
  else
    sed -nE "s/^[[:space:]]*\"$field\"[[:space:]]*:[[:space:]]*\"([^\"]*)\".*$/\1/p" "$manifest" 2>/dev/null || true
  fi
}

# Wypisz listę w formacie tekstowym
printf "Wtyczki w: %s\n\n" "$PLUGINS_DIR"
shopt -s nullglob
counter=0
for d in "$PLUGINS_DIR"/*; do
  [[ -d "$d" ]] || continue
  ((counter++))
  local_id="$(basename "$d")"
  manifest="$d/manifest.json"

  name="$(eww::read_manifest_field "$manifest" "name" || true)"
  ver="$(eww::read_manifest_field "$manifest" "version" || true)"
  desc="$(eww::read_manifest_field "$manifest" "description" || true)"

  [[ -n "$name" ]] || name="$local_id"
  line="🧩 $name"
  [[ -n "$ver" ]] && line+=" 🔖 ($ver)"
  [[ -n "$desc" ]] && line+=" — 📝 $desc"

  printf "%d. %s\n" "$counter" "$line"
done
shopt -u nullglob

if [[ $counter -eq 0 ]]; then
  printf "Brak wykrytych wtyczek w: %s\n" "$PLUGINS_DIR"
fi
