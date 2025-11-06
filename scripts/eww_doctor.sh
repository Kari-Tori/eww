#!/usr/bin/env bash
set -Eeuo pipefail
p(){ echo "EWW: PASS: $*"; exit 0; }
f(){ echo "EWW: FAIL: $*" >&2; exit 1; }
i(){ echo "EWW: INFO: $*"; }
err=0
for c in git python3 pip mkdocs pre-commit; do command -v "$c" >/dev/null || { echo "[MISS] $c"; err=1; }; done
test -x ./init-eww.sh || { echo "[MISS] ./init-eww.sh"; err=1; }
test -f VERSION || { echo "[MISS] VERSION"; err=1; }
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || { echo "[MISS] git repo"; err=1; }
i "origin: $(git remote get-url origin 2>/dev/null || echo none)"
((err==0)) && p "doctor OK" || f "doctor found issues"
