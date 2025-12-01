#!/usr/bin/env bash
set -euo pipefail

# Sprawdza spójność wersji:
# - Git tag (wymagany) -> oczekiwana wersja
# - Plik VERSION
# - Frontmatter wybranych plików Markdown

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
VERSION_FILE="$REPO_ROOT/VERSION"
FILES=(
  "$REPO_ROOT/README.md"
  "$REPO_ROOT/AGENTS.md"
  "$REPO_ROOT/INDEX.md"
  "$REPO_ROOT/GOALS.md"
  "$REPO_ROOT/ZERO-WASTE-POLICY.md"
)

die() { printf "❌ %s\n" "$*" >&2; exit 1; }

latest_tag() {
  git -C "$REPO_ROOT" describe --tags --abbrev=0 --match 'v[0-9]*' 2>/dev/null || true
}

tag="$(latest_tag)"
[[ -n "$tag" ]] || die "Brak taga vX.Y.Z – utwórz go przed wersjonowaniem (np. git tag v0.0.0.5)."
expected_version="${tag#v}"

read_file_version() {
  sed -n '1,40p' "$1" | awk -F': *' '/^version:/ {print $2; exit}'
}

file_has_version() {
  local file="$1"
  local v
  v="$(read_file_version "$file")"
  [[ -n "$v" ]] || die "Brak pola version: w $file"
  if [[ "$v" != "$expected_version" ]]; then
    die "Niespójna wersja w $file (jest $v, oczekiwane $expected_version)"
  fi
}

actual_version="$(tr -d ' \t\r\n' < "$VERSION_FILE")"
[[ "$actual_version" == "$expected_version" ]] || die "VERSION ($actual_version) != tag ($expected_version)"

for f in "${FILES[@]}"; do
  [[ -f "$f" ]] || die "Brak pliku do sprawdzenia: $f"
  file_has_version "$f"
done

printf "✅ Wersja spójna: %s\n" "$expected_version"
