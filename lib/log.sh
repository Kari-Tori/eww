#!/usr/bin/env bash
# Lightweight logger helper for eww
# - Appends messages to a per-user log file by default
# - Honors EWW_LOG_FILE (empty disables file logging) and EWW_NO_LOG=1

: "${EWW_LOG_FILE:=${XDG_STATE_HOME:-$HOME/.local/state}/eww/init-eww.log}"
mkdir -p "$(dirname "$EWW_LOG_FILE")" 2>/dev/null || true

log() {
  local level="$1"; shift
  local ts
  ts=$(date --iso-8601=seconds 2>/dev/null || date '+%Y-%m-%dT%H:%M:%S%z')
  local msg="$*"
  printf '%s [%s] %s\n' "$ts" "$level" "$msg" >&2
  if [ -n "${EWW_NO_LOG:-}" ] && [ "${EWW_NO_LOG}" -ne 0 ] 2>/dev/null; then
    return 0
  fi
  if [ -n "${EWW_LOG_FILE:-}" ]; then
    printf '%s [%s] %s\n' "$ts" "$level" "$msg" >>"$EWW_LOG_FILE" 2>/dev/null || true
  fi
}

info()  { log INFO "$@"; }
warn()  { log WARN "$@"; }
error() { log ERROR "$@"; }
debug() { [ -n "${EWW_DEBUG:-}" ] && log DEBUG "$@"; }

# exported helper: czysci stare logi (opcjonalnie, nie wywołuje się domyślnie)
eww_log_rotate() {
  # Prosty rotator: przenieś obecny plik do .old z timestamp
  if [ -n "${EWW_LOG_FILE:-}" ] && [ -f "$EWW_LOG_FILE" ]; then
    mv "$EWW_LOG_FILE" "${EWW_LOG_FILE}.$(date +%Y%m%d%H%M%S)" 2>/dev/null || true
  fi
}

export -f log info warn error debug eww_log_rotate 2>/dev/null || true
