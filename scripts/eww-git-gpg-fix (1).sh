#!/usr/bin/env bash
set -Eeuo pipefail
cd "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")"/.. && pwd)"
git config --unset gpg.format 2>/dev/null || true
echo "GPG fix applied"
