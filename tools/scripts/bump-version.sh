#!/usr/bin/env bash
# File: scripts/bump-version.sh
# Author: 
# Created: 
# Updated: 
# Description: bash
# Tags:
# bash
# script
# semver
# versioning
# Prosty skrypt do aktualizacji pliku VERSION, dopisania wpisu w CHANGELOG
# i opcjonalnego utworzenia branche/commit/tag/push/PR.
#
# Użycie (przykład):
#   ./scripts/bump-version.sh 0.0.0.2 -m "Fix init on Kubuntu" --branch --push --tag --pr
# Opcje:
#   -m|--message  : wiadomość opisująca zmiany (wpis do changeloga)
#   --branch      : utwórz branch release/vX.Y.Z
#   --push        : wypchnij branch i tagi do origin
#   --tag         : utwórz tag vX.Y.Z
#   --pr          : spróbuj utworzyć PR (wymaga `gh` CLI)
#   --dry-run     : pokaż, co by się stało, nie wykonuj operacji git/push

set -euo pipefail

usage() {
  cat <<-USAGE
Usage: $0 NEW_VERSION [-m|--message "changelog message"] [--branch] [--push] [--tag] [--pr] [--dry-run]

Example:
  $0 0.0.0.2 -m "Fix init on Kubuntu" --branch --push --tag --pr
USAGE
}

if [[ ${#} -lt 1 ]]; then
  usage
  exit 2
fi

NEW_VERSION=$1; shift

MSG=""
DO_BRANCH=0
DO_PUSH=0
DO_TAG=0
DO_PR=0
DRY_RUN=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    -m|--message)
      MSG="$2"; shift 2;;
    --branch)
      DO_BRANCH=1; shift;;
    --push)
      DO_PUSH=1; shift;;
    --tag)
      DO_TAG=1; shift;;
    --pr)
      DO_PR=1; shift;;
    --dry-run)
      DRY_RUN=1; shift;;
    -h|--help)
      usage; exit 0;;
    *)
      echo "Unknown option: $1" >&2; usage; exit 2;;
  esac
done

REPO_ROOT="$(dirname "${BASH_SOURCE[0]}")/.."
REPO_ROOT="$(realpath "$REPO_ROOT")"
VERSION_FILE="$REPO_ROOT/VERSION"
CHANGELOG="$REPO_ROOT/CHANGELOG.md"

echo "Target version: $NEW_VERSION"
echo "Message: ${MSG:-<none>}"
echo "Actions: branch=$DO_BRANCH push=$DO_PUSH tag=$DO_TAG pr=$DO_PR dry-run=$DRY_RUN"

if [[ $DRY_RUN -eq 1 ]]; then
  echo "DRY RUN: no git actions will be performed"
fi

printf "\nUpdating %s\n" "$VERSION_FILE"
if [[ $DRY_RUN -eq 0 ]]; then
  printf "%s\n" "$NEW_VERSION" > "$VERSION_FILE"
else
  echo "DRY: would write '$NEW_VERSION' to $VERSION_FILE"
fi

# Prepend changelog entry
DATE="$(date -u +%Y-%m-%d)"
CHANGE_ENTRY="## [$NEW_VERSION] - $DATE\n\n- ${MSG:-MVP release}\n\n"

printf "\nUpdating %s\n" "$CHANGELOG"
if [[ $DRY_RUN -eq 0 ]]; then
  # Prepend entry under top of file
  if [[ -f "$CHANGELOG" ]]; then
    # keep existing content
    TMP="$(mktemp)"
    printf "%s\n" "$CHANGE_ENTRY" > "$TMP"
    cat "$CHANGELOG" >> "$TMP"
    mv "$TMP" "$CHANGELOG"
  else
    printf "%s\n" "# Changelog\n\n$CHANGE_ENTRY" > "$CHANGELOG"
  fi
  else
    printf "DRY: would prepend to %s:\n%s\n" "$CHANGELOG" "$CHANGE_ENTRY"
fi

BRANCH_NAME="release/v$NEW_VERSION"
CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo main)"

if [[ $DO_BRANCH -eq 1 ]]; then
  printf "\nCreating branch: %s\n" "$BRANCH_NAME"
  if [[ $DRY_RUN -eq 0 ]]; then
    git checkout -b "$BRANCH_NAME"
  else
    echo "DRY: git checkout -b $BRANCH_NAME"
  fi
fi

COMMIT_MSG="chore(release): $NEW_VERSION"
if [[ -n "$MSG" ]]; then
  COMMIT_MSG+=" - $MSG"
fi

printf "\nStaging files and committing\n"
if [[ $DRY_RUN -eq 0 ]]; then
  git add "$VERSION_FILE" "$CHANGELOG"
  git commit -m "$COMMIT_MSG"
else
  printf "DRY: git add %s %s && git commit -m '%s'\n" "$VERSION_FILE" "$CHANGELOG" "$COMMIT_MSG"
fi

if [[ $DO_TAG -eq 1 ]]; then
  printf "\nCreating tag v%s\n" "$NEW_VERSION"
  if [[ $DRY_RUN -eq 0 ]]; then
    git tag -a "v$NEW_VERSION" -m "Release $NEW_VERSION"
  else
    printf "DRY: git tag -a v%s -m 'Release %s'\n" "$NEW_VERSION" "$NEW_VERSION"
  fi
fi

if [[ $DO_PUSH -eq 1 ]]; then
  printf "\nPushing branch and tags to origin\n"
  if [[ $DRY_RUN -eq 0 ]]; then
    git push origin --set-upstream "${BRANCH_NAME:-$CURRENT_BRANCH}"
    if [[ $DO_TAG -eq 1 ]]; then
      git push origin --tags
    fi
  else
    echo "DRY: git push origin --set-upstream ${BRANCH_NAME:-$CURRENT_BRANCH}"
    if [[ $DO_TAG -eq 1 ]]; then
      echo "DRY: git push origin --tags"
    fi
  fi
fi

if [[ $DO_PR -eq 1 ]]; then
  if command -v gh >/dev/null 2>&1; then
    printf "\nCreating PR via gh\n"
    PR_TITLE="$COMMIT_MSG"
    PR_BODY="$MSG"
    if [[ $DRY_RUN -eq 0 ]]; then
      gh pr create --fill --title "$PR_TITLE" --body "$PR_BODY"
    else
      printf "DRY: gh pr create --title '%s' --body '%s'\n" "$PR_TITLE" "$PR_BODY"
    fi
  else
    echo "gh CLI not found; cannot create PR automatically. Install GitHub CLI or create PR manually." >&2
  fi
fi

printf "\nDone. New version: %s\n" "$NEW_VERSION"

exit 0
