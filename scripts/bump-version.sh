#!/usr/bin/env bash
# Prosty skrypt do aktualizacji pliku VERSION i (opcjonalnie) automatycznego commita
# Użycie: ./scripts/bump-version.sh 0.0.0.2

set -euo pipefail

if [[ ${#} -ne 1 ]]; then
  echo "Usage: $0 NEW_VERSION" >&2
  exit 2
fi

NEW_VERSION=$1

VERSION_FILE="$(dirname "${BASH_SOURCE[0]}")/../VERSION"
VERSION_FILE="$(realpath "$VERSION_FILE")"

echo "$NEW_VERSION" > "$VERSION_FILE"
echo "Updated $VERSION_FILE -> $NEW_VERSION"

echo "If you want to commit and tag, run:"
echo "  git add $VERSION_FILE CHANGELOG.md && git commit -m 'chore(release): $NEW_VERSION' && git tag -a v$NEW_VERSION -m 'Release $NEW_VERSION'"

exit 0
