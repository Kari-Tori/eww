#!/usr/bin/env bash
set -euo pipefail

# Update file_count dla wszystkich folder_notes z tag #folder_note

readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $*"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $*"
}

# Znajdź wszystkie folder_notes
log_info "Szukam folder_notes z tag #folder_note..."

find . -name "*.md" -type f -not -path "./.git/*" -not -path "./archive/*" | while read -r note; do
    if grep -q "tags:" "$note" && grep -q "#folder_note" "$note"; then
        folder=$(dirname "$note")
        count=$(find "$folder" -name "*.md" -type f | wc -l)
        
        # Update file_count w YAML
        if grep -q "^file_count:" "$note"; then
            sed -i "s/^file_count: .*/file_count: $count/" "$note"
            log_success "Updated $note → file_count: $count"
        else
            # Dodaj file_count po tags
            sed -i "/^tags:/a file_count: $count" "$note"
            log_success "Added file_count to $note → $count"
        fi
    fi
done

log_info "Done!"
