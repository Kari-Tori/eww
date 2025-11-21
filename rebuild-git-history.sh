#!/usr/bin/env bash
# Odbudowa historii Git z limitem 18 plików na commit
set -euo pipefail

readonly MAX_FILES_PER_COMMIT=18
readonly TEMP_DATES="/tmp/eww-file-dates.txt"
readonly BACKUP_DIR="/tmp/eww-backup-$(date +%s)"

echo "🔍 Tworzę backup aktualnego repo..."
mkdir -p "$BACKUP_DIR"
cp -r .git "$BACKUP_DIR/"

echo "📊 Zbieram daty plików..."
find . -type f \
  \( -name "*.md" -o -name "*.sh" -o -name "*.yaml" -o -name "*.json" -o -name "Makefile" \) \
  ! -path "./.git/*" \
  ! -path "./archive/*" \
  ! -path "./.obsidian/plugins/*/node_modules/*" \
  -printf "%T@ %TY-%Tm-%Td %p\n" | sort -n > "$TEMP_DATES"

echo "📈 Znaleziono $(wc -l < "$TEMP_DATES") plików"

# Backup wszystkich plików
echo "💾 Backup plików przed resetem..."
git ls-files -z | xargs -0 tar czf "$BACKUP_DIR/files.tar.gz"

# Reset do pierwszego commita lub stwórz nowy
echo "🔄 Reset Git history..."
git checkout --orphan new-history 2>/dev/null || true

# Wyczyść staging
git rm -rf . 2>/dev/null || true
rm -rf .git
git init

# Konfiguracja
git config user.name "${GIT_AUTHOR_NAME:-jakubc}"
git config user.email "${GIT_AUTHOR_EMAIL:-jakub@eww.local}"

# Przywróć pliki
echo "📦 Przywracam pliki..."
tar xzf "$BACKUP_DIR/files.tar.gz"

# Dodaj podstawowe pliki najpierw
echo "📝 Pierwszy commit: inicjalizacja..."
git add .gitignore README.md Makefile 2>/dev/null || true
GIT_AUTHOR_DATE="2025-11-01T09:00:00" \
GIT_COMMITTER_DATE="2025-11-01T09:00:00" \
git commit -m "chore: initial commit - project structure" || true

# Grupuj pliki po datach
echo "🗓️  Grupuję pliki chronologicznie..."
current_date=""
files_batch=()
batch_num=1

while IFS= read -r line; do
  timestamp=$(echo "$line" | awk '{print $1}')
  date=$(echo "$line" | awk '{print $2}')
  file=$(echo "$line" | cut -d' ' -f3-)
  
  # Pomiń już zacommitowane
  [[ "$file" == "./.gitignore" || "$file" == "./README.md" || "$file" == "./Makefile" ]] && continue
  
  # Nowy dzień?
  if [[ "$current_date" != "$date" ]]; then
    # Commit poprzedniej batchy
    if [[ ${#files_batch[@]} -gt 0 ]]; then
      echo "  📅 $current_date: ${#files_batch[@]} plików (batch $batch_num)"
      
      # Podziel na porcje max 18
      for ((i=0; i<${#files_batch[@]}; i+=MAX_FILES_PER_COMMIT)); do
        chunk=("${files_batch[@]:i:MAX_FILES_PER_COMMIT}")
        git add "${chunk[@]}" 2>/dev/null || true
        
        commit_date="${current_date}T$(printf '%02d' $((9 + batch_num % 15))):00:00"
        GIT_AUTHOR_DATE="$commit_date" \
        GIT_COMMITTER_DATE="$commit_date" \
        git commit -m "feat(pre-mvp): batch $batch_num - ${#chunk[@]} files" || true
        
        ((batch_num++))
      done
    fi
    
    current_date="$date"
    files_batch=()
  fi
  
  files_batch+=("$file")
  
done < "$TEMP_DATES"

# Ostatnia batcha
if [[ ${#files_batch[@]} -gt 0 ]]; then
  echo "  📅 $current_date: ${#files_batch[@]} plików (batch $batch_num)"
  for ((i=0; i<${#files_batch[@]}; i+=MAX_FILES_PER_COMMIT)); do
    chunk=("${files_batch[@]:i:MAX_FILES_PER_COMMIT}")
    git add "${chunk[@]}" 2>/dev/null || true
    
    commit_date="${current_date}T$(printf '%02d' $((9 + batch_num % 15))):00:00"
    GIT_AUTHOR_DATE="$commit_date" \
    GIT_COMMITTER_DATE="$commit_date" \
    git commit -m "feat(pre-mvp): batch $batch_num - ${#chunk[@]} files" || true
    
    ((batch_num++))
  done
fi

# Dodaj pozostałe pliki (jeśli są)
if [[ -n "$(git status --porcelain)" ]]; then
  echo "📦 Dodaję pozostałe pliki..."
  git add .
  git commit -m "chore: finalize repository structure" || true
fi

echo ""
echo "✅ Historia odbudowana!"
echo "📊 Statystyki:"
git log --oneline | wc -l | xargs echo "   Commits:"
echo "   Backup: $BACKUP_DIR"
echo ""
echo "🔍 Podgląd historii:"
git log --oneline --graph | head -20

