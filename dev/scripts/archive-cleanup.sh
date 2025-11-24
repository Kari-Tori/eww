#!/usr/bin/env bash
# File: scripts/archive-cleanup.sh
# Author: 
# Created: 
# Updated: 
# Description: bash
# Tags:
# bash
# cleanup
# maintenance
# script
# archive-cleanup.sh - Czyszczenie archive/ wg analizy ARCHIVES_ANALYSIS_20251121.md
# Autor: Analiza AI
# Data: 2025-11-21
# Opis: Usuwa backupy, logi i śmieciowe pliki z archive/ (~2.2GB oszczędności)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
readonly PROJECT_ROOT

cd "$PROJECT_ROOT"

echo "🧹 Czyszczenie archive/ - według ARCHIVES_ANALYSIS_20251121.md"
echo "📍 Lokalizacja: $PROJECT_ROOT"
echo ""

# Pokaż rozmiar przed
echo "📊 Rozmiar archive/ PRZED czyszczeniem:"
du -sh archive/
echo ""

read -p "❓ Kontynuować czyszczenie? (usuniemy ~2.2GB) [y/N]: " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Anulowano"
    exit 0
fi

echo ""
echo "🧹 Etap 1: Usuwanie backupów i logów (2.2GB)"

# Usuń największe backupy
if [[ -d archive/gerc-backup-2025-11-21 ]]; then
    echo "  🗑️  Usuwam gerc-backup-2025-11-21/ (1.9GB)..."
    rm -rf archive/gerc-backup-2025-11-21/
fi

if [[ -d archive/logs-2025-11-21 ]]; then
    echo "  🗑️  Usuwam logs-2025-11-21/ (133MB)..."
    rm -rf archive/logs-2025-11-21/
fi

if [[ -d archive/trash-backup-2025-11-21 ]]; then
    echo "  🗑️  Usuwam trash-backup-2025-11-21/ (1.8MB)..."
    rm -rf archive/trash-backup-2025-11-21/
fi

if [[ -d archive/gerc-backup ]]; then
    echo "  🗑️  Usuwam gerc-backup/ (672KB)..."
    rm -rf archive/gerc-backup/
fi

if [[ -d archive/reports-backup-2025-11-21 ]]; then
    echo "  🗑️  Usuwam reports-backup-2025-11-21/ (32KB)..."
    rm -rf archive/reports-backup-2025-11-21/
fi

echo "✅ Usunięto ~2.2GB backupów i logów"
echo ""

echo "🧹 Etap 2: Usuwanie plików śmieciowych"

# Usuń śmieciowe pliki (bezpieczne z nullglob)
shopt -s nullglob

# Bez nazwy
for f in archive/Bez\ nazwy*.md archive/Bez\ nazwy.base archive/Bez\ nazwy.canvas; do
    [[ -f "$f" ]] && { echo "  🗑️  $f"; rm -f "$f"; }
done

# Zdjęcia diagnostyczne
for f in archive/IMG_*.jpg; do
    [[ -f "$f" ]] && { echo "  🗑️  $f"; rm -f "$f"; }
done

# Sync conflicts
for f in archive/*sync-conflict*.md; do
    [[ -f "$f" ]] && { echo "  🗑️  $f"; rm -f "$f"; }
done

# Screenshoty
for f in archive/screenshot*.png; do
    [[ -f "$f" ]] && { echo "  🗑️  $f"; rm -f "$f"; }
done

# Canvas files
for f in archive/*.canvas; do
    [[ -f "$f" ]] && { echo "  🗑️  $f"; rm -f "$f"; }
done

# Manifesty
for f in archive/manifest_v*.md; do
    [[ -f "$f" ]] && { echo "  🗑️  $f"; rm -f "$f"; }
done

# Pojedyncze pliki
[[ -f "archive/Vault.md" ]] && { echo "  🗑️  Vault.md"; rm -f archive/Vault.md; }
[[ -f "archive/202507022342.md" ]] && { echo "  🗑️  202507022342.md"; rm -f archive/202507022342.md; }
[[ -f "archive/29-06-25-nocka.md" ]] && { echo "  🗑️  29-06-25-nocka.md"; rm -f archive/29-06-25-nocka.md; }
[[ -f "archive/archive.md" ]] && [[ ! -s "archive/archive.md" ]] && { echo "  🗑️  archive.md (pusty)"; rm -f archive/archive.md; }

shopt -u nullglob

echo "✅ Usunięto pliki śmieciowe"
echo ""

echo "📊 Rozmiar archive/ PO czyszczeniu:"
du -sh archive/
echo ""

echo "✅ Czyszczenie zakończone!"
echo "💾 Zaoszczędzono ~2.2GB (67% oryginalnego rozmiaru z 3.3GB)"
echo ""
echo "📋 Zachowano wartościowe foldery:"
echo "   ✅ 05_PROJECTS/ (862MB) - projekty"
echo "   ✅ old-vaults/ (350MB) - stary vault"
echo "   ✅ 04_TEAM/ (118MB) - dane team"
echo "   ✅ 09_ARCHIWE/ (14MB) - archiwum"
echo "   ✅ obsidian-configs/ (2.3MB) - konfigi"
echo "   ✅ 06_DOCS/ + 00_CORE/ + pozostałe struktury"
