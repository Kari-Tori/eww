#!/usr/bin/env bash
set -euo pipefail

# Setup cron do auto-update repo-stats.md co 5 minut

readonly REPO_ROOT="/home/jakubc/git/eww"
readonly CRON_JOB="*/5 * * * * cd $REPO_ROOT && bash scripts/generate-stats.sh >/dev/null 2>&1"

echo "[INFO] Konfiguruję cron dla auto-update stats..."

# Sprawdź czy już istnieje
if crontab -l 2>/dev/null | grep -q "generate-stats.sh"; then
    echo "[WARN] Cron job już istnieje"
    crontab -l | grep "generate-stats.sh"
    exit 0
fi

# Dodaj do crontab
(crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -

echo "[OK] Dodano cron job:"
echo "     $CRON_JOB"
echo ""
echo "Sprawdź: crontab -l"
