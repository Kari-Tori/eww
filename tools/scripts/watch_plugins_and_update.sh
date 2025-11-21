#!/usr/bin/env bash
# File: scripts/watch_plugins_and_update.sh
# Author: 
# Created: 
# Updated: 
# Description: bash
# Tags:
# bash
# script
set -euo pipefail

# Skrypt wywołuje aktualizator listy wtyczek (jednorazowo).
# Użycie:
#   ./scripts/watch_plugins_and_update.sh [VAULT_PATH] [OUTPUT_FILE]
# Domyślnie:
#   VAULT_PATH = "$HOME/Obsidian/code"
#   OUTPUT_FILE = "/home/karinam/git/eww/docs/software/code/plugins/installed_pluggins.md"

eww::log() { printf "[EWW] %s\n" "$*"; }
eww::err() { printf "[EWW] BŁĄD: %s\n" "$*" >&2; }

readonly VAULT_PATH="${1:-$HOME/Obsidian/code}"
readonly OUTPUT_FILE="${2:-/home/karinam/git/eww/docs/software/code/plugins/installed_pluggins.md}"
readonly SCRIPTS_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
readonly UPDATE_SCRIPT1="$SCRIPTS_DIR/find_copy_describe_plugins.sh"
readonly UPDATE_SCRIPT2="$SCRIPTS_DIR/generate_code_plugins_md.sh"

# Wybierz dostępny skrypt aktualizujący
if [[ -x "$UPDATE_SCRIPT1" ]]; then
    readonly UPDATE_SCRIPT="$UPDATE_SCRIPT1"
elif [[ -x "$UPDATE_SCRIPT2" ]]; then
    readonly UPDATE_SCRIPT="$UPDATE_SCRIPT2"
else
    eww::err "Brak skryptu aktualizującego w $SCRIPTS_DIR (oczekiwano find_copy_describe_plugins.sh lub generate_code_plugins_md.sh)."
    exit 1
fi

if [[ ! -d "$VAULT_PATH" ]]; then
    eww::err "Vault nie istnieje: $VAULT_PATH"
    exit 1
fi

eww::log "Uruchamiam aktualizację wtyczek dla vault: $VAULT_PATH"
# Uruchom skrypt aktualizujący (przekazujemy vault i output)
if ! "$UPDATE_SCRIPT" "$VAULT_PATH" "$OUTPUT_FILE"; then
    eww::err "Aktualizacja zakończona niepowodzeniem"
    exit 1
fi

eww::log "Aktualizacja pliku: $OUTPUT_FILE zakończona pomyślnie"
exit 0
