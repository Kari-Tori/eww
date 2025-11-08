#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
README="$ROOT_DIR/README.md"
VERSION_FILE="$ROOT_DIR/VERSION"
DOC_RELEASE="$ROOT_DIR/docs/release-0.0.0.1.md"

fail_count=0
echo "Checking README consistency and minimal release docs..."

if [ ! -f "$VERSION_FILE" ]; then
	echo "[FAIL] VERSION file missing: $VERSION_FILE"
	fail_count=$((fail_count + 1))
else
	version=$(tr -d ' \n\r' <"$VERSION_FILE")
	echo "Found VERSION: $version"
fi

if [ ! -f "$README" ]; then
	echo "[FAIL] README not found at $README"
	exit 2
fi

grep -q "Wersja:" "$README" || {
	echo "[FAIL] README missing 'Wersja:' line"
	fail_count=$((fail_count + 1))
}

if [ -n "${version:-}" ]; then
	if grep -q "Wersja:.*$version" "$README"; then
		echo "[OK] README shows same version as VERSION"
	else
		echo "[FAIL] README version does not match VERSION ($version)"
		fail_count=$((fail_count + 1))
	fi
fi

grep -q "## Quick start" "$README" || {
	echo "[FAIL] README missing '## Quick start' section"
	fail_count=$((fail_count + 1))
}
grep -q "## Funkcje i lista weryfikacji" "$README" || {
	echo "[FAIL] README missing '## Funkcje i lista weryfikacji'"
	fail_count=$((fail_count + 1))
}

if [ -f "$DOC_RELEASE" ]; then
	echo "[OK] Release doc exists: $(basename "$DOC_RELEASE")"
else
	echo "[FAIL] Release doc missing: docs/release-0.0.0.1.md"
	fail_count=$((fail_count + 1))
fi

printf "\nSummary:\n"
if [ "$fail_count" -eq 0 ]; then
	echo "All checks passed ✅"
	exit 0
else
	echo "$fail_count check(s) failed ❌"
	exit 3
fi
