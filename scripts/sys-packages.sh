#!/usr/bin/env bash
# Check baseline dev/ops packages presence
set -Eeuo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=eww_common.sh
. "$SCRIPT_DIR/eww_common.sh"

ROOT="$(git_root)"
OUT="$ROOT/logs/sys-packages-$(date +%F_%H%M%S).log"
EWW_LOG="${EWW_LOG:-"$OUT"}"

REQ=(
  build-essential git curl wget aria2 neovim tmux htop btop tree jq ripgrep fd-find
  unzip zip xz-utils p7zip-full python3 python3-venv python3-pip pipx
  pkg-config cmake ninja-build ca-certificates gnupg lsb-release
  net-tools iperf3 nmap traceroute dnsutils usbutils pciutils lshw inxi lm-sensors smartmontools nvme-cli
  rsyslog logrotate bash-completion moreutils ufw openssh-client
)

log "Checking required packages"
MISSING=()
for p in "${REQ[@]}"; do
  if dpkg -s "$p" >/dev/null 2>&1; then
    printf "[OK] %s\n" "$p"
  else
    printf "[MISSING] %s\n" "$p"
    MISSING+=("$p")
  fi
done | sed "s/^/| /"

if [ "${#MISSING[@]}" -gt 0 ]; then
  log "Missing packages count: ${#MISSING[@]}"
  echo "sudo apt update && sudo apt install -y \
  ${MISSING[@]}" | sed "s/^/| /"
else
  log "All baseline packages present"
fi

log "sys-packages done → $OUT"
