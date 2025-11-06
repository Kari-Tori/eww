#!/usr/bin/env bash
# =============================================================================
# init-git.sh — zero‑config: logi + wersjonowanie + autocommit
# =============================================================================
# Bez flag i zmiennych środowiskowych.
# Stałe:
#   REPO=/git/eww.git
#   LOGDIR=/git/eww.git/logs
#   EXCLUDE_REGEX='\.git|(^|/)site/|node_modules/|__pycache__/|\.idea/|\.vscode/'
#   MESSAGE_PREFIX='auto'
#   POLL_INTERVAL=2
# Działanie:
#   1) ensure /git, utwórz REPO i LOGDIR
#   2) przekieruj stdout/stderr do LOGFILE oraz na konsolę
#   3) git init (main) jeśli brak repo, identity + .gitignore
#   4) fetch+status+meta, pierwszy commit
#   5) watcher: inotifywait → autocommit; fallback: polling
# =============================================================================
set -Eeuo pipefail

on_err(){ echo "[FAIL] line $LINENO: $BASH_COMMAND" >&2; }
trap on_err ERR

PASSED=0; FAILED=0; WARN=0
say(){ printf '== %s ==
' "$*"; }
ok(){  printf '[PASS] %s
' "$*"; ((PASSED++)); }
ko(){  printf '[FAIL] %s
' "$*"; ((FAILED++)); }
wn(){  printf '[WARN] %s
' "$*"; ((WARN++)); }
step(){ local label="$1"; shift; local cmd="$*"; say "$label"; if bash -lc "$cmd"; then ok "$label"; else ko "$label"; fi }

on_exit(){ printf '--- SUMMARY: PASS=%d FAIL=%d WARN=%d ---
' "$PASSED" "$FAILED" "$WARN"; }
trap on_exit EXIT

# Stałe
REPO="/git/eww.git"
LOGDIR="$REPO/logs"
LOGFILE="$LOGDIR/init-git.log"
EXCLUDE_REGEX='\.git|(^|/)site/|node_modules/|__pycache__/|\.idea/|\.vscode/'
MESSAGE_PREFIX="auto"
POLL_INTERVAL=2

# 1) ensure /git, repo i logi
step "ensure /git" 'sudo mkdir -p /git && sudo chown "$(id -u)":"$(id -g)" /git'
step "ensure repo dir" 'mkdir -p '"$REPO"''
step "ensure logs dir" 'mkdir -p '"$LOGDIR"''

# 2) przekierowanie logów (po utworzeniu LOGDIR)
exec > >(tee -a "$LOGFILE") 2>&1
say "Log: $LOGFILE"

say "Repo: $REPO"
cd "$REPO" || { echo "ERR: cd $REPO" >&2; exit 1; }

# 3) git init + identity + .gitignore
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  wn "repo już istnieje"
else
  step "git init (main)" 'git init -b main 2>/dev/null || { git init && git symbolic-ref HEAD refs/heads/main; }'
fi

name="$(git config --get user.name || true)"; email="$(git config --get user.email || true)"
if [[ -z "$name" || -z "$email" ]]; then
  wn "brak user.name/user.email — ustawiam lokalnie"
  git config user.name "EWW Auto"
  git config user.email "eww@local"
  ok "git identity ustawiona"
fi

if [[ ! -f .gitignore ]]; then
  cat > .gitignore <<'GI'
site/
node_modules/
__pycache__/
*.log
*.tmp
*.bak
.DS_Store
.idea/
.vscode/
GI
  ok ".gitignore utworzony"
else
  wn ".gitignore istnieje"
fi

# 4) meta + pierwszy commit
step "git fetch" 'git fetch --all --tags --prune --quiet || true'
say "git status"; git status -s || true
origin="$(git remote get-url origin 2>/dev/null || echo 'none')"
branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo '-')"
head="$(git rev-parse --short HEAD 2>/dev/null || echo '-')"
printf 'Remote : %s
Branch : %s
HEAD   : %s
' "$origin" "$branch" "$head"

if ! git diff --quiet || ! git diff --cached --quiet; then
  git add -A
  msg="$MESSAGE_PREFIX: $(date +'%F %T')"
  if git commit -m "$msg" --quiet; then ok "commit: $msg"; else wn "brak zmian do commita"; fi
else
  wn "clean — brak zmian"
fi

# 5) watcher: inotify → autocommit; fallback: polling
if command -v inotifywait >/dev/null 2>&1; then
  say "watcher: inotifywait (exclude: $EXCLUDE_REGEX)"
  inotifywait -mr -e modify,create,delete,move --format '%w%f %e' --exclude "$EXCLUDE_REGEX" "$REPO" | \
  while read -r path event; do
    [[ "$path" =~ /\.git(/|$) ]] && continue
    git add -A
    msg="$MESSAGE_PREFIX: ${event,,} ${path#$REPO/}"
    git commit -m "$msg" --quiet || true
    printf '[PASS] %s
' "autocommit: $msg"
  done
else
  wn "inotifywait brak — polling ${POLL_INTERVAL}s"
  last=""
  while true; do
    snap="$(git ls-files -m -o --exclude-standard; git ls-files -d)"
    if [[ "$snap" != "$last" ]]; then
      git add -A
      msg="$MESSAGE_PREFIX: poll $(date +'%F %T')"
      git commit -m "$msg" --quiet || true
      printf '[PASS] %s
' "autocommit: $msg"
      last="$snap"
    fi
    sleep "$POLL_INTERVAL"
  done
fi
