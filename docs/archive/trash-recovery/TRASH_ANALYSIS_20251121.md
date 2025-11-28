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
title: TRASH ANALYSIS 20251121
description: Analiza trash-backup-2025-11-21
type: file
category: docs
filepath: docs/trash-recovery/TRASH_ANALYSIS_20251121.md
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
  - rozmiar
aliases:
related:
  - docs/FULL-INDEX.md
dependencies:
sources:
  - docs/trash-recovery/TRASH_ANALYSIS_20251121.md
backlinks: []
context: "E-Waste Workshop - Bash toolkit for Kubuntu environment setup"
project: eww
repository: https://github.com/Kari-Tori/eww-1






created: 2025-11-21T14:12:29Z
modified: 2025-11-24T22:34:18Z
author: jakubc
---



# Analiza trash-backup-2025-11-21

## Podsumowanie
- **Lokalizacja**: `archive/trash-backup-2025-11-21/karinam-trash/`
- **Liczba plików**: 266
- **Rozmiar**: 1.8MB
- **Źródło**: Karina Mirowska vault trash

## Zidentyfikowane struktury

### 1. Projekty (wartościowe)
- `02_DELIVERY/` - KPI, milestones, review-log
- `05_PROJECTS/` - projekty w trakcie
- Dashboard.md - Secondbrain Dashboard (Lenovo M710Q)

### 2. Skrypty instalacyjne
Skrypty provision dla VM/Services:
- `09_SCRIPTS/bastion_provision.sh`
- `Services/VM200_netbox/install_netbox.sh`
- `Services/VM210_snipeit/install_snipeit.sh`
- `Services/VM170_grafana_prom/install_prometheus.sh`
- `Services/VM170_grafana_prom/install_grafana.sh`
- `Services/VM220_backstage/install_backstage.sh`
- `Services/VM160_kuma/install_kuma.sh`
- `Services 2/SB110_paperless/install_paperless.sh`
- `Services 2/SB120_recoll/install_recoll.sh`
- `Services 2/SB100_syncthing/install_syncthing.sh`

### 3. Konfiguracje
- `status/*.json` - statusy systemów (secondbrain, bastion, lab-ai)
- `Ansible/group_vars/all.yml`
- `style-settings.json` - Obsidian

### 4. Dokumentacja techniczna
- `Sony_Bravia_KDL-49WD754_Spec.md`
- `GERC_Display_Report_All_Monitors.md`
- `ASUS_Z77/` - dokumentacja płyty głównej

### 5. Śmieci (do usunięcia)
- Duplikaty folderów: `00_CORE 2`, `00_CORE 3`, `Services 2`, `status 2`
- Sync conflicts: `karinam_*.sync-conflict-*`
- Templaty testowe: `templates_variants/jakubc_new_note_*`
- Puste pliki: `SOP.md`, `Bez nazwy.md`

## Rekomendacje

### ✅ Zachować (przenieść do głównego repo)
1. **Skrypty instalacyjne** → `infra/ansible/roles/` lub `docs/infra/services/`
2. **Status JSONs** → `var/status/` (jako szablony)
3. **Dashboard.md** → `docs/projects/secondbrain/`

### ❌ Usunąć
- Wszystkie duplikaty folderów
- Sync conflicts
- Puste pliki markdown
- Templaty testowe

## Akcje do wykonania

```bash
# 1. Zachować wartościowe skrypty
mkdir -p docs/infra/services/
cp -r archive/trash-backup-2025-11-21/karinam-trash/Services/* docs/infra/services/ 2>/dev/null || true

# 2. Zachować statusy jako przykłady
mkdir -p var/status/examples/
cp archive/trash-backup-2025-11-21/karinam-trash/status/*.json var/status/examples/ 2>/dev/null || true

# 3. Usunąć cały trash
rm -rf archive/trash-backup-2025-11-21/
```

## Notatki
- Większość zawartości to stare wersje projektów Kariny (Secondbrain, Bastion, Lab-AI)
- Skrypty instalacyjne mogą być przydatne jako referencyjna dokumentacja
- Status JSONs pokazują strukturę monitoringu infrastruktury
