#!/usr/bin/env bash
set -euo pipefail

# TEST - podgląd bez zmian
echo "🔍 TEST PODGLĄD"
TMP=$(mktemp)
trap 'rm -f "$TMP"' EXIT

find . -type f -name "*.md" \
  ! -path "./.git/*" ! -path "./archive/*" ! -path "./Tags/*" \
  ! -path "./.obsidian/*" ! -path "./var/*" ! -path "./usr/*" \
  -printf "%T@ %p\n" 2>/dev/null | sort -n > "$TMP"

total=$(wc -l < "$TMP")
echo "📁 Plików: $total"
echo ""

# Grupuj po datach
declare -A dates
while IFS= read -r line; do
  timestamp=$(echo "$line" | awk '{print $1}')
  file_date=$(date -d "@${timestamp%.*}" '+%Y-%m-%d')
  dates[$file_date]=$((${dates[$file_date]:-0} + 1))
done < "$TMP"

echo "📊 Podział po datach:"
for date in "${!dates[@]}"; do
  count=${dates[$date]}
  if [[ $count -le 18 ]]; then
    echo "  $date: $count plików → 1 commit"
  else
    chunks=$(( (count + 17) / 18 ))
    echo "  $date: $count plików → $chunks commitów"
  fi
done | sort

echo ""
commits=0
for count in "${dates[@]}"; do
  if [[ $count -le 18 ]]; then
    ((commits++))
  else
    commits=$((commits + (count + 17) / 18))
  fi
done

echo "✨ RAZEM: $commits commitów z $total plików"
