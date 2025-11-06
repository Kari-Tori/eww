#!/usr/bin/env bash
# Network diagnostics → logs/diag-network-*.log
set -Eeuo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=eww_common.sh
. "$SCRIPT_DIR/eww_common.sh"

ROOT="$(git_root)"
OUT="$ROOT/logs/diag-network-$(date +%F_%H%M%S).log"
EWW_LOG="${EWW_LOG:-"$OUT"}"

log "Diag-network start"
have ip && run ip -brief address || true
have ip && run ip route || true
have resolvectl && run resolvectl status || { [ -f /etc/resolv.conf ] && run cat /etc/resolv.conf || true; }

# basic reachability
have ping && run ping -c 2 1.1.1.1 || true
have ping && run ping -c 2 8.8.8.8 || true
have curl && run curl -I https://example.org || true

# listening ports (first 20)
have ss && { log "Listening TCP ports"; ss -ltnp | head -n 20 | sed "s/^/| /"; } || true

log "Diag-network done → $OUT"
