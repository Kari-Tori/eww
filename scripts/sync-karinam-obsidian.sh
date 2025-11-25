#!/usr/bin/env bash
set -euo pipefail

# Prosty helper rsyncujący katalog usr/karinam poza desktopem między lokalnym repo
# a katalogiem ~/git/eww/usr/karinam na hoście Kariny.
# Domyślnie: push (lokalnie -> zdalnie). Użycie: ./scripts/sync-karinam-obsidian.sh [push|pull] [--dry-run]

eww::log() { printf "[EWW] %s\n" "$*"; }
eww::err() { printf "[EWW] BŁĄD: %s\n" "$*" >&2; }

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOCAL_ROOT="${REPO_ROOT}/usr/karinam"
REMOTE_USER="${REMOTE_USER:-karinam}"
REMOTE_HOST="${REMOTE_HOST:-192.168.0.77}"
REMOTE_ROOT="${REMOTE_ROOT:-/home/karinam/git/eww/usr/karinam}"
SSH_PORT="${SSH_PORT:-22}"
DRY_RUN=false
MODE="push"

usage() {
  cat <<USAGE
Użycie: ${0##*/} [push|pull] [--dry-run]
  push       - synchronizuje lokalne zmiany do ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_ROOT}
  pull       - pobiera zmiany zdalne do ${LOCAL_ROOT}
  --dry-run  - pokazuje komendę rsync bez wykonywania jej
Zmienne środowiskowe: REMOTE_* / SSH_PORT
USAGE
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      push|pull)
        MODE="$1"
        shift
        ;;
      --dry-run)
        DRY_RUN=true
        shift
        ;;
      help|-h|--help)
        usage
        exit 0
        ;;
      *)
        usage
        exit 1
        ;;
    esac
  done
}

if ! command -v rsync >/dev/null 2>&1; then
  eww::err "rsync nie jest zainstalowany"
  exit 1
fi

parse_args "$@"

mkdir -p "${LOCAL_ROOT}"

EXCLUDES=(
  --exclude '.git/'
  --exclude 'devices/asus_z77/desktop/'
  --exclude 'devices/asus_z77/desktop/**'
)

RSYNC_COMMON=(
  -az
  --delete
  --human-readable
  --compress
  --links
)

SSH_CMD="ssh -p ${SSH_PORT}"

if [[ "${MODE}" == "push" ]]; then
  SRC="${LOCAL_ROOT}/"
  DST="${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_ROOT}/"
else
  SRC="${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_ROOT}/"
  DST="${LOCAL_ROOT}/"
fi

CMD=(rsync "${RSYNC_COMMON[@]}" -e "${SSH_CMD}" "${EXCLUDES[@]}" "${SRC}" "${DST}")
eww::log "Tryb: ${MODE}, synchronizacja ${SRC} → ${DST}"
if [[ "${DRY_RUN}" == true ]]; then
  eww::log "--dry-run: ${CMD[*]}"
  exit 0
fi

eww::log "Uruchamiam: ${CMD[*]}"
"${CMD[@]}"
