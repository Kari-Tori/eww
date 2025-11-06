#!/usr/bin/env bash
set -Eeuo pipefail
p(){ echo "EWW: PASS: $*"; exit 0; }
f(){ echo "EWW: FAIL: $*" >&2; exit 1; }
i(){ echo "EWW: INFO: $*"; }

BUMP="${1:-patch}"   # patch|minor|major|same
git rev-parse --show-toplevel >/dev/null 2>&1 || f "run inside a git repo"
[[ -f VERSION ]] || { echo "0.1.0" > VERSION; i "init VERSION 0.1.0"; }
CUR="$(tr -d '\n\r ' < VERSION)"
[[ "$CUR" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || f "invalid VERSION: $CUR"

IFS=. read -r MA MI PA <<<"$CUR"
case "$BUMP" in
  patch) NEXT="${MA}.${MI}.$((PA+1))" ;;
  minor) NEXT="${MA}.$((MI+1)).0" ;;
  major) NEXT="$((MA+1)).0.0" ;;
  same)  NEXT="$CUR" ;;
  *) f "unknown bump: $BUMP" ;;
esac
TAG="v${NEXT}"

[[ "$BUMP" != "same" ]] && echo "$NEXT" > VERSION
git add -A
git diff --cached --quiet || git commit -m "chore(version): bump ${BUMP} to ${TAG}"

if git rev-parse -q --verify "refs/tags/${TAG}" >/dev/null; then
  f "tag exists: ${TAG}"
else
  git tag -a "${TAG}" -m "release: ${TAG}"
fi

SHA="$(git rev-parse --short HEAD)"
p "version ${TAG} @ ${SHA}"
