#!/usr/bin/env bash
set -Euo pipefail
if [[ -n "${EWW_BANNER_SHOWN-}" ]]; then
  return 0 2>/dev/null || exit 0
fi
export EWW_BANNER_SHOWN=1
printf "\n╭─ %s@%s • %s\n" "$(whoami)" "$(hostname)" "$(date "+%F %T")"
printf "╰─ Miłego dnia • E-Waste Workshop\n\n"
