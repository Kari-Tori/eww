#!/usr/bin/env bash
set -euo pipefail

# Pomocniczy skrypt montujący desktop Kariny przez sshfs.
# Domyślny katalog: usr/karinam/devices/asus_z77/desktop

eww::log() { printf "[EWW] %s\n" "$*"; }
eww::err() { printf "[EWW] BŁĄD: %s\n" "$*" >&2; }

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOCAL_PATH="${REPO_ROOT}/usr/karinam/devices/asus_z77/desktop"
REMOTE_USER="${REMOTE_USER:-karinam}"
REMOTE_HOST="${REMOTE_HOST:-192.168.0.77}"
REMOTE_PATH="${REMOTE_PATH:-/home/karinam/devices/asus_z77/desktop}"
SSH_PORT="${SSH_PORT:-22}"
SSHFS_OPTIONS="${SSHFS_OPTIONS:-reconnect,ServerAliveInterval=15,ServerAliveCountMax=3}"
DRY_RUN=false
MODE="mount"

usage() {
  cat <<USAGE
Użycie: ${0##*/} [start|mount|stop|umount|status|help]
Domyślnie montuje:
  sshfs ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH} -> ${LOCAL_PATH}
Tryby:
  start|mount   - montuje katalog (domyślny tryb)
  stop|umount   - odmontowuje katalog (fusermount/umount)
  status        - sprawdza stan montażu
  help          - ten komunikat
Opcje:
  --dry-run     - nie wykonuje komend, tylko je wypisuje
Zmienne środowiskowe: REMOTE_* / SSH_PORT / SSHFS_OPTIONS
USAGE
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      start|mount)
        MODE="mount"
        shift
        ;;
      stop|umount)
        MODE="umount"
        shift
        ;;
      status)
        MODE="status"
        shift
        ;;
      help|-h|--help)
        usage
        exit 0
        ;;
      --dry-run)
        DRY_RUN=true
        shift
        ;;
      *)
        usage
        exit 1
        ;;
    esac
  done
}

is_mounted() {
  if command -v mountpoint >/dev/null 2>&1; then
    mountpoint -q "${LOCAL_PATH}"
  else
    mount | awk '{print $3}' | grep -Fxq "${LOCAL_PATH}"
  fi
}

mount_desktop() {
  if is_mounted; then
    eww::log "${LOCAL_PATH} już jest zamontowany"
    return 0
  fi
  mkdir -p "${LOCAL_PATH}"
  local cmd=(sshfs "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}" "${LOCAL_PATH}" -p "${SSH_PORT}" -o "${SSHFS_OPTIONS}")
  eww::log "${cmd[*]}"
  if [[ "${DRY_RUN}" == true ]]; then
    eww::log "--dry-run: komenda nie została wykonana"
    return 0
  fi
  if ! command -v sshfs >/dev/null 2>&1; then
    eww::err "sshfs nie jest dostępne"
    return 1
  fi
  "${cmd[@]}"
}

unmount_desktop() {
  if ! is_mounted; then
    eww::log "${LOCAL_PATH} nie jest zamontowany"
    return 0
  fi
  local cmd
  if command -v fusermount >/dev/null 2>&1; then
    cmd=(fusermount -u "${LOCAL_PATH}")
  else
    cmd=(umount "${LOCAL_PATH}")
  fi
  eww::log "${cmd[*]}"
  if [[ "${DRY_RUN}" == true ]]; then
    eww::log "--dry-run: odmontowanie nie zostało wykonane"
    return 0
  fi
  "${cmd[@]}"
}

parse_args "$@"

case "${MODE}" in
  mount)
    mount_desktop
    ;;
  umount)
    unmount_desktop
    ;;
  status)
    if is_mounted; then
      eww::log "${LOCAL_PATH} jest aktualnie zamontowany"
      exit 0
    else
      eww::log "${LOCAL_PATH} nie jest zamontowany"
      exit 1
    fi
    ;;
  *)
    eww::err "Nieznany tryb: ${MODE}"
    usage
    exit 1
    ;;
esac
