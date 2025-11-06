#!/usr/bin/env bash
# System quick diagnostics → logs/diag-basic-*.log
set -Eeuo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=eww_common.sh
. "$SCRIPT_DIR/eww_common.sh"

ROOT="$(git_root)"
OUT="$ROOT/logs/diag-basic-$(date +%F_%H%M%S).log"
EWW_LOG="${EWW_LOG:-"$OUT"}"

log "Diag-basic start"
run date
run hostnamectl || hostname
run uname -a
have lsb_release && run lsb_release -a || true
run whoami; run id
run uptime

# Memory, disk, cpu
have free && run free -h || true
run df -h
have lsblk && run lsblk || true
have lscpu && run lscpu || true

# Top processes snapshot
log "Top CPU processes"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 10 | sed "s/^/| /"

log "Top MEM processes"
ps -eo pid,comm,%mem,%cpu --sort=-%mem | head -n 10 | sed "s/^/| /"

log "Kernel messages (last 50)"
dmesg | tail -n 50 | sed "s/^/| /" || true

log "Diag-basic done → $OUT"
