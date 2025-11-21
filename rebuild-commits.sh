#!/usr/bin/env bash
set -euo pipefail

# 🔄 ODBUDOWA HISTORII GIT - bazując na datach plików
# Max 18 plików/commit, grupowanie po dniu
readonly MAX_FILES=18
readonly TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

echo "🔄 ODBUDOWA HISTORII GIT (max $MAX_FILES plików/commit)"
echo ""

# Backup
echo "💾 Tworzę backup..."
git branch "backup-rebuild-$(date +%Y%m%d-%H%M%S)" 2>/dev/null || true

# Zbierz pliki z datami (modified time)
echo "📁 Analizuję daty plików..."
find . -type f -name "*.md" \
  ! -path "./.git/*" ! -path "./archive/*" ! -path "./Tags/*" ! -path "./.obsidian/*" \
  -printf "%T@ %p\n" | sort -n > "$TMP_DIR/files_dates.txt"

total=$(wc -l < "$TMP_DIR/files_dates.txt")
echo "✅ Znaleziono: $total plików MD"

if [[ $total -eq 0 ]]; then
  echo "⚠️  Brak plików do commitowania"
  exit 0
fi

# Reset Git
echo "🗑️  Reset repozytorium..."
rm -rf .git
git init -q
git config user.name "Jakub C" 2>/dev/null || true
git config user.email "jakubc@eww.local" 2>/dev/null || true

# Grupuj po dniach
echo "📅 Grupuję pliki po datach..."
current_date=""
declare -a batch_files=()
declare -a batch_dates=()
commit_count=0

while IFS= read -r line; do
  timestamp=$(echo "$line" | awk '{print $1}')
  filepath=$(echo "$line" | cut -d' ' -f2-)
  
  # Konwertuj na datę YYYY-MM-DD
  file_date=$(date -d "@${timestamp%.*}" '+%Y-%m-%d')
  file_time=$(date -d "@${timestamp%.*}" '+%H:%M:%S')
  
  # Nowy dzień? Commituj poprzednią grupę
  if [[ -n "$current_date" ]] && [[ "$current_date" != "$file_date" ]] && [[ ${#batch_files[@]} -gt 0 ]]; then
    # Commit grupy (może podzielić na chunki)
    batch_size=${#batch_files[@]}
    
    if [[ $batch_size -le $MAX_FILES ]]; then
      # Jeden commit
      git add "${batch_files[@]}"
      GIT_AUTHOR_DATE="$current_date 12:00:00" \
      GIT_COMMITTER_DATE="$current_date 12:00:00" \
      git commit -q -m "docs: aktualizacja $current_date ($batch_size plików)

Pliki z dnia $current_date"
      ((commit_count++))
      echo "  📝 Commit #$commit_count: $current_date ($batch_size plików)"
    else
      # Podziel na chunki po MAX_FILES
      chunks=$(( (batch_size + MAX_FILES - 1) / MAX_FILES ))
      echo "  📦 $current_date: $batch_size plików → $chunks commitów"
      
      for ((chunk=0; chunk<chunks; chunk++)); do
        start=$((chunk * MAX_FILES))
        chunk_files=("${batch_files[@]:$start:$MAX_FILES}")
        chunk_size=${#chunk_files[@]}
        
        git add "${chunk_files[@]}"
        hour=$(printf "%02d" $((12 + chunk)))
        GIT_AUTHOR_DATE="$current_date $hour:00:00" \
        GIT_COMMITTER_DATE="$current_date $hour:00:00" \
        git commit -q -m "docs: aktualizacja $current_date (część $((chunk+1))/$chunks, $chunk_size plików)"
        ((commit_count++))
        echo "    📝 Commit #$commit_count: $current_date $hour:00 ($chunk_size plików)"
      done
    fi
    
    batch_files=()
  fi
  
  current_date="$file_date"
  batch_files+=("$filepath")
  
done < "$TMP_DIR/files_dates.txt"

# Ostatnia grupa
if [[ ${#batch_files[@]} -gt 0 ]]; then
  batch_size=${#batch_files[@]}
  
  if [[ $batch_size -le $MAX_FILES ]]; then
    git add "${batch_files[@]}"
    GIT_AUTHOR_DATE="$current_date 12:00:00" \
    GIT_COMMITTER_DATE="$current_date 12:00:00" \
    git commit -q -m "docs: aktualizacja $current_date ($batch_size plików)"
    ((commit_count++))
    echo "  📝 Commit #$commit_count: $current_date ($batch_size plików)"
  else
    chunks=$(( (batch_size + MAX_FILES - 1) / MAX_FILES ))
    echo "  📦 $current_date: $batch_size plików → $chunks commitów"
    
    for ((chunk=0; chunk<chunks; chunk++)); do
      start=$((chunk * MAX_FILES))
      chunk_files=("${batch_files[@]:$start:$MAX_FILES}")
      chunk_size=${#chunk_files[@]}
      
      git add "${chunk_files[@]}"
      hour=$(printf "%02d" $((12 + chunk)))
      GIT_AUTHOR_DATE="$current_date $hour:00:00" \
      GIT_COMMITTER_DATE="$current_date $hour:00:00" \
      git commit -q -m "docs: aktualizacja $current_date (część $((chunk+1))/$chunks, $chunk_size plików)"
      ((commit_count++))
      echo "    📝 Commit #$commit_count: $current_date $hour:00 ($chunk_size plików)"
    done
  fi
fi

# Dodaj pozostałe pliki
echo ""
echo "📦 Dodaję pozostałe pliki..."
git add .
GIT_AUTHOR_DATE="$(date '+%Y-%m-%d %H:%M:%S')" \
GIT_COMMITTER_DATE="$(date '+%Y-%m-%d %H:%M:%S')" \
git commit -q -m "chore: add configuration and scripts" 2>/dev/null || true

echo ""
echo "✅ GOTOWE!"
echo "   Commitów: $commit_count"
echo "   Plików: $total"
echo ""
echo "📊 Podgląd historii:"
git log --oneline --graph | head -15
