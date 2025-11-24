#!/usr/bin/env bash
set -euo pipefail

# Usuwa pobraną dokumentację Obsidian, zostając tylko nasze configi

readonly REPO_ROOT="/home/jakubc/git/eww"
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[0;33m'
readonly NC='\033[0m'

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $*"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $*"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $*"
}

cd "$REPO_ROOT"

# Lista folderów do usunięcia
FOLDERS_TO_DELETE=(
    "docs/infra/software/obsidian/official-en"
    "docs/infra/software/obsidian/official-pl"
    "docs/infra/software/obsidian/resources/hub"
    "docs/infra/software/obsidian/resources/api"
    "docs/infra/software/obsidian/resources/awesome"
    "docs/infra/software/obsidian/resources/releases"
    "docs/infra/software/obsidian/plugins/core/original"
)

# Pokaż co zostanie usunięte
echo "🗑️  Foldery do usunięcia:"
echo ""
total_size=0
for folder in "${FOLDERS_TO_DELETE[@]}"; do
    if [[ -d "$folder" ]]; then
        size=$(du -sh "$folder" 2>/dev/null | cut -f1)
        count=$(find "$folder" -name "*.md" 2>/dev/null | wc -l)
        echo "  ❌ $folder ($size, $count plików .md)"
    fi
done

echo ""
log_warn "To usunie ~86MB pobranej dokumentacji Obsidian!"
echo ""

# Potwierdzenie
read -p "Kontynuować? (y/N): " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    log_warn "Anulowano."
    exit 0
fi

echo ""
log_warn "Usuwanie..."

# Usuń foldery
for folder in "${FOLDERS_TO_DELETE[@]}"; do
    if [[ -d "$folder" ]]; then
        rm -rf "$folder"
        log_success "Usunięto: $folder"
    else
        log_warn "Nie znaleziono: $folder"
    fi
done

# Cleanup pustych folderów
find docs/infra/software/obsidian/resources -type d -empty -delete 2>/dev/null || true
find docs/infra/software/obsidian/plugins -type d -empty -delete 2>/dev/null || true

echo ""
log_success "Cleanup zakończony!"

# Pokaż co zostało
echo ""
echo "✅ Pozostawione w docs/infra/software/obsidian/:"
find docs/infra/software/obsidian -maxdepth 1 -name "*.md" -type f | while read f; do
    echo "  📄 $(basename "$f")"
done

echo ""
find docs/infra/software/obsidian -maxdepth 1 -type d | grep -v "^docs/infra/software/obsidian$" | while read d; do
    echo "  📁 $(basename "$d")/"
done

echo ""
echo "📊 Nowa liczba plików .md w docs/infra/software/obsidian/:"
find docs/infra/software/obsidian -name "*.md" 2>/dev/null | wc -l

