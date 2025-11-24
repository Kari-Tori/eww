#!/usr/bin/env bash
# File: scripts/gh_trigger_generate_plugins.sh
# Author: 
# Created: 
# Updated: 
# Description: bash
# Tags:
# bash
# script
set -euo pipefail

# Helper: wywołaj workflow generate-code-plugins przez gh CLI i śledź run
# Użycie:
#   ./scripts/gh_trigger_generate_plugins.sh [REF] [VAULT_PATH] [EMBED] [REPO]
# Przykład:
#   ./scripts/gh_trigger_generate_plugins.sh main "/home/karinam/Obsidian/code" true karinam/eww

REF="${1:-main}"
VAULT_PATH_ARG="${2:-}"
EMBED_ARG="${3:-false}"
REPO_ARG="${4:-}"

if ! command -v gh >/dev/null 2>&1; then
  echo "[EWW] gh CLI nie znalezione. Zainstaluj i zaloguj: gh auth login" >&2
  exit 1
fi

CMD=(gh workflow run generate-code-plugins --ref "$REF")
if [[ -n "$VAULT_PATH_ARG" ]]; then
  CMD+=( --field "vault_path=$VAULT_PATH_ARG" )
fi
CMD+=( --field "embed=$EMBED_ARG" )

if [[ -n "$REPO_ARG" ]]; then
  CMD+=( --repo "$REPO_ARG" )
fi

echo "[EWW] Wywołuję workflow: ${CMD[*]}"
"${CMD[@]}"

# Śledź run (użyje repo konfigurowanego wyżej lub bieżącego)
if [[ -n "$REPO_ARG" ]]; then
  gh run watch --repo "$REPO_ARG"
else
  gh run watch
fi
