#!/usr/bin/env bash
set -Eeuo pipefail
p(){ echo "EWW: PASS: $*"; exit 0; }
f(){ echo "EWW: FAIL: $*" >&2; exit 1; }
i(){ echo "EWW: INFO: $*"; }

OWNER="${EWW_OWNER:-}"; REPO="${EWW_REPO:-}"
USER_NAME="${EWW_USER:-admin}"; PAT="${EWW_PAT:-}"
HOST="${EWW_HOST:-localhost:3000}"; BRANCH="${EWW_BRANCH:-main}"

[[ -n "$OWNER" && -n "$REPO" ]] || f "set EWW_OWNER and EWW_REPO"
[[ -n "$PAT" ]] || f "set EWW_PAT (Personal Access Token)"
[[ "$OWNER" == *"<"* || "$REPO" == *"<"* ]] && f "remove angle brackets"

HTTP_URL="http://${HOST}/${OWNER}/${REPO}.git"
curl -fsS -H "Authorization: token ${PAT}" "http://${HOST}/api/v1/user" >/dev/null \
  || f "PAT invalid for http://${HOST}"

git remote set-url origin "$HTTP_URL" >/dev/null 2>&1 || true
git push "http://${USER_NAME}:${PAT}@${HOST}/${OWNER}/${REPO}.git" "$BRANCH" || f "push branch"
git push "http://${USER_NAME}:${PAT}@${HOST}/${OWNER}/${REPO}.git" --tags     || f "push tags"
p "published HTTP → ${OWNER}/${REPO} ${BRANCH}"
