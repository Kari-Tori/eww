#!/usr/bin/env bash
# Git repo summary → logs/git-scan-*.log
set -Eeuo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=eww_common.sh
. "$SCRIPT_DIR/eww_common.sh"

ROOT="$(git_root)"
OUT="$ROOT/logs/git-scan-$(date +%F_%H%M%S).log"
EWW_LOG="${EWW_LOG:-"$OUT"}"

cd "$ROOT"
log "Git-scan start"
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  log "Not a git repository: $ROOT"
  exit 0
fi

BRANCH="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo 'detached')"
log "Branch: $BRANCH"
run git status --porcelain=v1 --branch

log "Last 5 commits"
git --no-pager log --oneline -n 5 | sed "s/^/| /"

log "Diff summary vs HEAD"
git --no-pager diff --stat | tail -n +1 | sed "s/^/| /" || true

# counts
ADDED=$(git status --porcelain | grep -c '^A ' || true)
MOD=$(git status --porcelain | grep -c '^ M' || true)
NEW=$(git status --porcelain | grep -c '^\?\?' || true)
log "Changes: added=$ADDED modified=$MOD untracked=$NEW"

# size of repo working tree
log "Working tree size (top level)"
du -sh . 2>/dev/null | sed "s/^/| /"

log "Git-scan done → $OUT"
