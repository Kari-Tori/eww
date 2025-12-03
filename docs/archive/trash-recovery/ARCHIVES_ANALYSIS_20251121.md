---
version: 0.0.4
title: "ARCHIVES_ANALYSIS_20251121"
created: 2025-11-21
modified: 2025-11-28
tags:
  - auto-versioned
---

created: 2025-11-21T14:12:29Z
modified: 2025-11-24T22:34:18Z
author: jakubc
---
tags:
  - #automation
  - #development
  - #eww
  - #knowledge
  - #linux
  - #productivity
  - #secondbrain
title: ARCHIVES ANALYSIS 20251121
description: Analiza archive/ - Kompleksowa
type: file
category: docs
filepath: docs/trash-recovery/ARCHIVES_ANALYSIS_20251121.md
color: green
owner: jakubc
updated: 2025-11-21
version: 1.0.0
language: pl
status: active
priority: normal
license: MIT
  - documentation
  - markdown
  - docs
  - knowledge
keywords:
  - lokalizacja
aliases:
related:
  - docs/FULL-INDEX.md
dependencies:
sources:
  - docs/trash-recovery/ARCHIVES_ANALYSIS_20251121.md
backlinks: []
context: "E-Waste Workshop - Bash toolkit for Kubuntu environment setup"
project: eww
repository: https://github.com/Kari-Tori/eww-1






created: 2025-11-21T14:12:29Z
modified: 2025-11-24T22:34:18Z
author: jakubc
---



# Analiza archive/ - Kompleksowa

## Podsumowanie ogólne
- **Lokalizacja**: `archive/`
- **Rozmiar całkowity**: 3.3GB
- **Główne komponenty**: 30+ folderów i plików

## Breakdown rozmiarów (top 15)

| Folder | Rozmiar | % całości | Typ zawartości |
|--------|---------|-----------|----------------|
| `gerc-backup-2025-11-21/` | 1.9GB | 58% | 🔴 BACKUP GERC (4090 plików) |
| `05_PROJECTS/` | 862MB | 26% | 🟡 Projekty (119 plików .md) |
| `old-vaults/` | 350MB | 11% | 🟡 Stary vault eww |
| `logs-2025-11-21/` | 133MB | 4% | �� Logi systemowe |
| `04_TEAM/` | 118MB | 3.6% | �� Dane team (karinam) |
| `09_ARCHIWE/` | 14MB | 0.4% | 🟢 Archiwum vault |
| `Archives Inbox/` | 5.7MB | 0.17% | 🟢 Inbox archiwum |
| `obsidian-configs/` | 2.3MB | 0.07% | 🟢 Konfiguracje Obsidian |
| `trash-backup-2025-11-21/` | 1.8MB | 0.05% | 🔴 TRASH (266 plików) |
| `06_DOCS/` | 1.1MB | 0.03% | 🟢 Dokumentacja |
| `gerc-backup/` | 672KB | 0.02% | 🔴 Starszy backup GERC |
| `00_CORE/` | 576KB | 0.02% | 🟢 Rdzeń vault |
| `03_DEV/` | 500KB | 0.015% | 🟢 Development |
| `Tags/` | 416KB | 0.013% | 🟢 Tagi Obsidian |
| `02_BUSINESS/` | 164KB | 0.005% | 🟢 Biznes |

## Analiza szczegółowa

### 1. 🔴 gerc-backup-2025-11-21/ (1.9GB) - DO USUNIĘCIA
**Opis**: Masywny backup systemu GERC z 2025-11-21
- 4090 plików
- Zawiera: `/GERC/Pobrane/Archives`, `/GERC/Pulpit/Archives`
- Duplikuje `/usr/jakubc/Inbox/GERC/`
- **Wartość**: Żadna - to tymczasowy backup przed czyszczeniem
- **Akcja**: ❌ **USUNĄĆ całość**

### 2. 🟡 05_PROJECTS/ (862MB) - PRZEJRZEĆ
**Opis**: 119 plików markdown projektów
**Projekty zidentyfikowane**:
- `Secondbrain/` - Server Lenovo M710Q, usługi
- `Hotel_TaTa/` - Projekt hotelowy
- `Cash4device_liquidation/` - Likwidacja biznesu
- `Hawthorn Road N18 1EY/` - Projekt nieruchomości
- `H2D Interface/` - Interface H2D
- `GERC/`, `GERC (X99)/` - Systemy GERC
- `ASUS Z77/` - Dokumentacja płyty głównej
- `Drukarki/`, `Orpington/`

**Wartość**: 🟡 Wysoka - aktywne/historyczne projekty
**Akcja**: 
- ✅ Zachować w `archive/`
- 📋 Lub przenieść wybrane do `/projects/` jeśli aktywne

### 3. 🟡 old-vaults/eww-vault-old/ (350MB) - PRZEJRZEĆ
**Opis**: Stary vault EWW przed reorganizacją
**Struktura**: Podobna do obecnej (bin/, lib/, scripts/, docs/, site/)
**Zawartość główna**:
- `site/` - 2.7MB (wygenerowana strona)
- `eww/` - 1.5MB (zagnieżdżenie)
- `Tags/` - 560KB
- Scripts i biblioteki - ~100KB

**Wartość**: 🟠 Średnia - może zawierać historyczne wersje kodu
**Akcja**:
- 🔍 Porównać z obecnym kodem (`diff -r`)
- ✅ Zachować jeśli unikalny kod
- ❌ Usunąć jeśli duplikat

### 4. 🟠 logs-2025-11-21/ (133MB) - DO USUNIĘCIA
**Opis**: Logi systemowe z listopada 2025
**Typy logów**:
- `fs-tree_*.txt.gz` - drzewa filesystem (skompresowane)
- `balooreset_*.log` - reset indexera KDE
- `shell-hardening-*.log` - hardening skryptów
- `scan-nonposix-*.log` - skanowanie POSIX
- `git-preinstall_*.log` - instalacja Git

**Wartość**: 🔴 Niska - logi z listopada, już nieaktualne
**Akcja**: ❌ **USUNĄĆ** (możliwe zachowanie tylko `latest.log`)

### 5. 🟢 04_TEAM/karinam/ (118MB) - WARTOŚCIOWE
**Opis**: Archiwum danych team member (Karina)
**Zawartość**:
- Dashboardy: `karinam_dashboard.md`, `Karinam Dashboard.canvas`
- Role: `Rola_Technik_FCGH.md`, `Rola_Sprzedawca.md`, `Rola_Personalna_Asystentka.md`
- Profile: `karinam_aboutme.md`, `karinam.md`, `karinam_feedback.md`
- Teoria: `Kajzen_Theory_Obsidian_Dashboard.md`, `Macierz_4K_*.md`
- Life areas: Health, Finance, Relationships, Learning
- System: `90_System/Periodic/Weekly/`
- **Plik wideo**: `IMG_9628.mov` (główny rozmiar)

**Wartość**: 🟢 Wysoka - historyczne dane team member
**Akcja**: ✅ **ZACHOWAĆ** (przenieść do `/usr/karinam/archive/` lub zostaw w archive/)

### 6. 🟢 09_ARCHIWE/ (14MB) - WARTOŚCIOWE
**Wartość**: 🟢 Archiwum vault
**Akcja**: ✅ ZACHOWAĆ

### 7. 🟢 Archives Inbox/ (5.7MB) - PRZEJRZEĆ
**Wartość**: 🟡 Inbox archiwum
**Akcja**: 🔍 Przejrzeć i scalić z głównymi folderami lub usunąć

### 8. �� obsidian-configs/ (2.3MB)
**Opis**: Konfiguracje Obsidian
**Wartość**: 🟢 Wysoka - referencje konfiguracyjne
**Akcja**: ✅ ZACHOWAĆ

### 9. 🔴 trash-backup-2025-11-21/ (1.8MB) - PRZEANALIZOWANE
**Status**: ✅ Już przeanalizowane w `TRASH_ANALYSIS_20251121.md`
**Akcja**: ❌ **USUNĄĆ** (po potwierdzeniu)

### 10. 🟢 Inne foldery strukturalne (łącznie ~3MB)
- `06_DOCS/` (1.1MB) - dokumentacja ✅ ZACHOWAĆ
- `gerc-backup/` (672KB) - stary backup ❌ USUNĄĆ jeśli jest nowszy
- `00_CORE/` (576KB) - rdzeń vault ✅ ZACHOWAĆ
- `03_DEV/` (500KB) - development ✅ ZACHOWAĆ
- `Tags/` (416KB) - tagi ✅ ZACHOWAĆ
- `02_BUSINESS/` (164KB) - biznes ✅ ZACHOWAĆ
- `reports-backup-2025-11-21/` (32KB) - backup raportów ❌ USUNĄĆ (mamy w `/reports/`)

### 11. 🗑️ Pliki śmieciowe w archive/
```
- Bez nazwy.md, Bez nazwy (1).md, Bez nazwy.base, Bez nazwy.canvas
- IMG_*.jpg (15 zdjęć diagnostycznych)
- *sync-conflict*.md (3 konflikty)
- screenshot.png, screenshot 1.png
- Vault.md (pusty)
- 202507022342.md, 29-06-25-nocka.md
- *.canvas (To My Bear.canvas, project_dashboard_enhanced.canvas)
- Manifests: manifest_v2.md, manifest_v3.md, manifest_v4.md
```

**Akcja**: ❌ **USUNĄĆ śmieciowe pliki**

## Rekomendacje końcowe

### ❌ DO USUNIĘCIA (2.2GB = 67% archive/)
```bash
# Największe oszczędności miejsca
rm -rf archive/gerc-backup-2025-11-21/      # 1.9GB
rm -rf archive/logs-2025-11-21/             # 133MB
rm -rf archive/trash-backup-2025-11-21/     # 1.8MB
rm -rf archive/gerc-backup/                 # 672KB (jeśli starszy)
rm -rf archive/reports-backup-2025-11-21/   # 32KB

# Pliki śmieciowe
rm -f archive/Bez\ nazwy*.{md,base,canvas}
rm -f archive/IMG_*.jpg
rm -f archive/*sync-conflict*.md
rm -f archive/screenshot*.png
rm -f archive/Vault.md
rm -f archive/*.canvas
rm -f archive/202507022342.md archive/29-06-25-nocka.md
```

### ✅ DO ZACHOWANIA (1.1GB = 33%)
```
✅ archive/05_PROJECTS/        862MB - projekty
✅ archive/old-vaults/          350MB - stary vault (po weryfikacji)
✅ archive/04_TEAM/             118MB - dane team
✅ archive/09_ARCHIWE/          14MB  - archiwum
✅ archive/Archives Inbox/      5.7MB - (po przejrzeniu)
✅ archive/obsidian-configs/    2.3MB - konfigi
✅ archive/06_DOCS/             1.1MB - docs
✅ archive/00_CORE/             576KB - rdzeń
✅ archive/03_DEV/              500KB - dev
✅ archive/Tags/                416KB - tagi
✅ archive/02_BUSINESS/         164KB - biznes
✅ archive/{backups,infra,keys,status,META,Diagnoza,...}
```

### 🔍 DO PRZEJRZENIA
1. `old-vaults/eww-vault-old/` - diff z obecnym kodem
2. `Archives Inbox/` - scalić lub usunąć
3. `05_PROJECTS/` - które projekty są aktywne?

## Akcje wykonane
1. ✅ Analiza 3.3GB archiwów
2. ✅ Breakdown rozmiarów (15 top pozycji)
3. ✅ Identyfikacja duplikatów i backupów
4. ✅ Klasyfikacja wartości (🔴 usunąć, 🟡 przejrzeć, �� zachować)

## Skrypt czyszczący

```bash
#!/usr/bin/env bash
# archive-cleanup.sh - Czyszczenie archive/ wg analizy

set -euo pipefail

cd /home/jakubc/git/eww

echo "🧹 Czyszczenie archive/ - etap 1: backupy i logi"

# Usuń największe backupy
rm -rf archive/gerc-backup-2025-11-21/      # 1.9GB
rm -rf archive/logs-2025-11-21/             # 133MB
rm -rf archive/trash-backup-2025-11-21/     # 1.8MB
rm -rf archive/gerc-backup/                 # 672KB
rm -rf archive/reports-backup-2025-11-21/   # 32KB

echo "✅ Usunięto ~2.2GB backupów i logów"

echo "🧹 Etap 2: pliki śmieciowe"

# Usuń śmieciowe pliki
rm -f archive/Bez\ nazwy*.md archive/Bez\ nazwy.base archive/Bez\ nazwy.canvas
rm -f archive/IMG_*.jpg
rm -f archive/*sync-conflict*.md
rm -f archive/screenshot*.png archive/screenshot\ 1.png
rm -f archive/Vault.md
rm -f archive/*.canvas
rm -f archive/202507022342.md archive/29-06-25-nocka.md
rm -f archive/manifest_v*.md

echo "✅ Usunięto ~25 plików śmieciowych"

echo "📊 Nowy rozmiar archive/:"
du -sh archive/

echo "✅ Czyszczenie zakończone!"
echo "💾 Zaoszczędzono ~2.2GB (67% oryginalnego rozmiaru)"