#!/usr/bin/env bash
# File: scripts/bash/eww-format-all.sh
# Author: 
# Created: 
# Updated: 
# Description: bash
# Tags:
# bash
# script
# eww-format-all.sh - Główny orchestrator formatowania dokumentacji
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly EWW_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $*"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $*"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $*"
}

main() {
    cat <<'EOF'
╔════════════════════════════════════════════════════════════╗
║     🎨 EWW DOCUMENTATION FORMATTER                         ║
║     Formatowanie wszystkich plików Markdown                ║
╚════════════════════════════════════════════════════════════╝

EOF
    
    log_info "Katalog główny: $EWW_ROOT"
    echo ""
    
    # Faza 1: Tworzenie folder notes
    log_info "FAZA 1/2: Tworzenie folder notes..."
    echo ""
    if "$SCRIPT_DIR/create-folder-notes.sh"; then
        log_success "Folder notes utworzone"
    else
        log_warn "Błąd przy tworzeniu folder notes"
    fi
    
    echo ""
    echo "─────────────────────────────────────────────────────────"
    echo ""
    
    # Faza 2: Formatowanie plików
    log_info "FAZA 2/2: Formatowanie plików Markdown..."
    echo ""
    if "$SCRIPT_DIR/format-md-files.sh"; then
        log_success "Pliki sformatowane"
    else
        log_warn "Błąd przy formatowaniu plików"
    fi
    
    echo ""
    echo "─────────────────────────────────────────────────────────"
    echo ""
    
    # Statystyki
    local total_md=$(find "$EWW_ROOT" -type f -name "*.md" ! -path "*/.git/*" ! -path "*/archive/*" | wc -l)
    local with_frontmatter=$(find "$EWW_ROOT" -type f -name "*.md" ! -path "*/.git/*" ! -path "*/archive/*" -exec head -n 1 {} \; | grep -c "^---$" || true)
    
    cat <<EOF
╔════════════════════════════════════════════════════════════╗
║                    ✅ FORMATOWANIE ZAKOŃCZONE               ║
╚════════════════════════════════════════════════════════════╝

📊 Statystyki:
   • Plików MD ogółem:      $total_md
   • Z frontmatter:         $with_frontmatter
   • Pokrycie:              $((with_frontmatter * 100 / total_md))%

🎯 Następne kroki:
   1. Przejrzyj zmiany: git diff
   2. Sprawdź przykładowe pliki
   3. Zatwierdź zmiany: git add . && git commit

EOF
}

main "$@"
