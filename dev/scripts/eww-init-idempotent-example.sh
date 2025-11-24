#!/usr/bin/env bash
# File: scripts/eww-init-idempotent-example.sh
# Author: 
# Created: 
# Updated: 
# Description: bash
# Tags:
# bash
# initialization
# script
set -Euo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../lib/idempotent.sh"

ensure_lock "eww-init"
ensure_dir "/git/eww" 0755
ensure_dir "/git/eww/logs" 0755
ensure_dir "$HOME/.local/bin" 0755
ensure_pkg git

# utrzymuj dokładnie taką treść init-eww.sh jak poniżej
# shellcheck disable=SC2016
ensure_file "/git/eww/init-eww.sh" '#!/usr/bin/env bash
set -Euo pipefail
if [[ -n "${EWW_BANNER_SHOWN-}" ]]; then
  return 0 2>/dev/null || exit 0
fi
export EWW_BANNER_SHOWN=1
printf "\n╭─ %s@%s • %s\n" "$(whoami)" "$(hostname)" "$(date "+%F %T")"
printf "╰─ Miłego dnia • E-Waste Workshop\n\n"
' 0755


ensure_symlink "/git/eww/init-eww.sh" "$HOME/.local/bin/init-eww"
ok "done"
