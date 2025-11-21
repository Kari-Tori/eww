#!/usr/bin/env bash
# File: dev/Playbooks/script.sh
# Author: 
# Created: 
# Updated: 
# Description: simple lock
set -Eeuo pipefail
IFS=$'\n\t'
umask 022

VERSION="0.1.0"
SCRIPT_NAME="$(basename "$0")"
TMPDIR="$(mktemp -d)"
LOCK_FILE="/tmp/${SCRIPT_NAME}.lock"
DRY_RUN=0
VERBOSE=0

cleanup() {
  rm -rf "$TMPDIR" || true
  [[ -f "$LOCK_FILE" ]] && rm -f "$LOCK_FILE"
}
trap cleanup EXIT
trap 'echo "[ERR] Line $LINENO"; exit 1' ERR

log()  { [[ $VERBOSE -eq 1 ]] && echo "[INFO] $*" >&2; }
err()  { echo "[ERR] $*" >&2; }
run()  { if [[ $DRY_RUN -eq 1 ]]; then echo "[DRY] $*"; else "$@"; fi; }
need() { command -v "$1" >/dev/null 2>&1 || { err "Missing: $1"; exit 127; }; }

usage() {
cat <<'EOF'
script.sh v0.1.0
Usage: script.sh [options] [args...]
Options:
  -n        dry-run
  -v        verbose
  -h        help
Examples:
  ./script.sh -n
EOF
}

while getopts ":nvh" opt; do
  case "$opt" in
    n) DRY_RUN=1 ;;
    v) VERBOSE=1 ;;
    h) usage; exit 0 ;;
    \?) err "Unknown option: -$OPTARG"; usage; exit 2 ;;
  esac
done
shift $((OPTIND-1))

# simple lock
if ! ( set -o noclobber; : > "$LOCK_FILE" ) 2>/dev/null; then
  err "Already running: $SCRIPT_NAME"
  exit 9
fi

# preflight
need awk
need sed

main() {
  log "Start in $TMPDIR"
  # TODO: implement your playbook steps here
  log "Done"
}

main "$@"
