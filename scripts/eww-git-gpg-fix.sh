#!/usr/bin/env bash
set -Euo pipefail
cd /git/eww
export GPG_TTY=$(tty)
git config user.name  "Jakub Celmer"
git config user.email "astriblast@gmail.com"
git config --unset gpg.format 2>/dev/null || true
git config gpg.program gpg
git config commit.gpgsign true
git config tag.gpgSign  true
FPR_FULL="$(gpg --with-colons --fingerprint 64350F8E46AB5B48 | awk -F: '/^fpr:/{print $10; exit}')"
git config user.signingkey "$FPR_FULL"
echo "OK: git+gpg skonfigurowane dla $(pwd)"
