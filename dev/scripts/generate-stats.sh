#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="/home/jakubc/git/eww"
OUTPUT="$REPO_ROOT/core/reports/repo-stats.md"

cd "$REPO_ROOT"
mkdir -p core/reports

echo "[INFO] Generuję repo-stats.md..." >&2

# Quick stats
total_md=$(find . -name "*.md" -not -path "./.git/*" -type f 2>/dev/null | wc -l)
total_sh=$(find . -name "*.sh" -not -path "./.git/*" -type f 2>/dev/null | wc -l)
total_dirs=$(find . -type d -not -path "./.git/*" 2>/dev/null | wc -l)

core_md=$(find core -name "*.md" 2>/dev/null | wc -l)
docs_md=$(find docs -name "*.md" 2>/dev/null | wc -l)
usr_md=$(find usr -name "*.md" 2>/dev/null | wc -l)
dev_md=$(find dev -name "*.md" 2>/dev/null | wc -l)

git_commits=$(git rev-list --count HEAD 2>/dev/null || echo "0")
git_branch=$(git branch --show-current 2>/dev/null || echo "main")

# Procenty
core_pct=$(awk "BEGIN {printf \"%.1f\", ($core_md/$total_md)*100}")
docs_pct=$(awk "BEGIN {printf \"%.1f\", ($docs_md/$total_md)*100}")
usr_pct=$(awk "BEGIN {printf \"%.1f\", ($usr_md/$total_md)*100}")

cat > "$OUTPUT" << EOF
---
tags:
  - #eww
  - #stats
  - #core
  - #reports
auto_update: true
update_interval: 5min
created: 2025-11-23T01:45:00Z
modified: $(date -Iseconds)
author: jakubc
title: "📊 EWW Repository Statistics"
---

# �� EWW Repository Statistics

> Auto-generowane co 5 minut przez cron

**Ostatnia aktualizacja**: \`$(date '+%Y-%m-%d %H:%M:%S')\`  
**Branch**: \`$git_branch\` | **Commits**: $git_commits

---

## 🗂️ Szybkie statystyki

| Metryka | Wartość |
|---------|---------|
| **Pliki .md** | **$total_md** |
| **Skrypty .sh** | **$total_sh** |
| **Katalogi** | **$total_dirs** |

## 📁 Top foldery

| Folder | Pliki | % |
|--------|-------|---|
| \`docs/\` | $docs_md | $docs_pct% |
| \`usr/\` | $usr_md | $usr_pct% |
| \`core/\` | $core_md | $core_pct% |
| \`dev/\` | $dev_md | - |

## 🎨 Graph View

- **Nodes**: ~137 (98.2% redukcja)
- **Color groups**: 5
- **Wykluczonych**: 6,587 plików

## 📊 Cleanup

- **Przed**: 7,512 plików
- **Po**: $total_md plików
- **Usunięto**: 6,583 pliki (~86MB)

## 🔄 Auto-update

Aktualizowane przez:
- \`cron\`: co 5 minut
- \`make stats\`: ręcznie

---

**Auto-generated** | [Full report](../../eww-stats-full.md)
EOF

# Symlink w root
ln -sf core/reports/repo-stats.md "$REPO_ROOT/eww-stats.md" 2>/dev/null || true

echo "[OK] $OUTPUT" >&2
