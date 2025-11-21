#!/usr/bin/env bash
# File: scripts/eww-git-gpg-fix (1).sh
# Author: 
# Created: 
# Updated: 
# Description: bash
# Tags:
# bash
# bugfix
# repair
# script
set -Eeuo pipefail
cd "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")"/.. && pwd)"
git config --unset gpg.format 2>/dev/null || true
echo "GPG fix applied"
