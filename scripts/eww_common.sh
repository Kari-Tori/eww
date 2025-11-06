#!/usr/bin/env bash
# EWW common helpers
set -Eeuo pipefail

# Resolve script dir and repo root (parent of scripts)
_script="${BASH_SOURCE[0]}"
while [ -h "$_script" ]; do
  _dir="$(cd -P "$(dirname "$_script")" && pwd)"
  _script="$(readlink "$_script")"
  [[ $_script != /* ]] && _script="$_dir/$_script"
done
SCRIPT_DIR="$(cd -P "$(dirname "$_script")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

LOG_DIR="${EWW_LOG_DIR:-"$REPO_ROOT/logs"}"
mkdir -p "$LOG_DIR"

ts() { date +"%Y-%m-%d %H:%M:%S %z"; }

# log to stdout and optional file if EWW_LOG is set
log() {
  echo "[$(ts)] $*"
  if [[ -n "${EWW_LOG:-}" ]]; then
    echo "[$(ts)] $*" >> "$EWW_LOG"
  fi
}

# run and stream output
run() {
  log "$ $*"
  "$@" | sed "s/^/| /" || true
}

have() { command -v "$1" >/dev/null 2>&1; }

git_root() {
  if have git && git -C "$REPO_ROOT" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    git -C "$REPO_ROOT" rev-parse --show-toplevel
  else
    echo "$REPO_ROOT"
  fi
}
