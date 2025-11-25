#!/usr/bin/env bash
set -euo pipefail

# Wywołaj workflow 'generate-plugins' przez gh CLI i śledź run
# Użycie:
#   ./scripts/gh_run_generate_plugins.sh [REF] [REPO]
#   REF  - gałąź/commit (domyślnie 'main')
#   REPO - opcjonalnie owner/repo (np. karinam/eww). Jeśli pusty, gh użyje bieżącego repo.

usage() {
  cat <<EOF
Użycie: $0 [REF] [REPO]
Przykład:
  $0 main karinam/eww
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

readonly REF="${1:-main}"
readonly REPO_ARG="${2:-}"

echo "[EWW] Wywołuję workflow 'generate-plugins' dla ref: $REF ${REPO_ARG:+(repo: $REPO_ARG)}"

# Wywołanie workflow
if [[ -n "$REPO_ARG" ]]; then
  gh workflow run generate-plugins --ref "$REF" --repo "$REPO_ARG"
  echo "[EWW] Workflow wysłany, śledzę run..."
  gh run watch --repo "$REPO_ARG"
else
  gh workflow run generate-plugins --ref "$REF"
  echo "[EWW] Workflow wysłany, śledzę run..."
  gh run watch
fi

echo "[EWW] Gotowe."
