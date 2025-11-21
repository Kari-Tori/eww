---
tags:
  - #automation
  - #development
  - #eww
  - #knowledge
  - #linux
  - #productivity
  - #secondbrain
title: INBOX ANALYSIS 20251121
description: Analiza Inbox'ów - Kompleksowa
type: file
category: docs
filepath: docs/trash-recovery/INBOX_ANALYSIS_20251121.md
color: green
author: jakubc
owner: jakubc
created: 2025-11-21
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
  - akcja
  - uwaga
aliases:
related:
  - docs/FULL-INDEX.md
dependencies:
sources:
  - docs/trash-recovery/INBOX_ANALYSIS_20251121.md
backlinks: []
context: "E-Waste Workshop - Bash toolkit for Kubuntu environment setup"
project: eww
repository: https://github.com/Kari-Tori/eww-1






---



# Analiza Inbox'ów - Kompleksowa

## Podsumowanie
Znaleziono **6 inbox'ów**:
1. `archive/Archives Inbox/` - 5.7MB, 67 plików
2. `projects/e-waste-workshop/Inbox/` - 32KB, 4 pliki
3. `usr/jakubc/Inbox/` - ignorowany (prywatny)
4. `usr/karinam/Inbox/` - ignorowany (prywatny)
5. `usr/karinam/Archives/Archives Inbox/` - ignorowany (prywatny)
6. `usr/karinam/Kari Aedila/Inbox/` - ignorowany (prywatny)

**Uwaga**: Inbox'y w `usr/*/` są ignorowane przez `.gitignore` (prywatne dane).

---

## 1. archive/Archives Inbox/ (67 plików, 5.7MB)

### Klasyfikacja zawartości:

#### 📚 Dokumentacja metodyk i strategii (→ docs/)
- `DevOps_Methodology.md` - Filozofia DevOps Wielkiego Implementatora
- `PARA_Metodyka_SecondBrain.md` - System organizacji Second Brain
- `Strategia_Blitzscaling_Uniwersalna.md` - Strategia blitzscalingu
- `Obsidian Dashboard.md` - Dashboard vault Obsidian
- `CopyCode_Cursor_Workflow.md` - Workflow z Cursor

**Akcja**: → `docs/methodologies/`

#### 👥 Profile i tips team (→ docs/team/ lub usr/)
- `Karina_ESFP-T_Profil_E-Waste_Workshop.md` - Profil Kariny
- `Karina Tips.md`, `Karina Tips 2.md` - Wskazówki dla Kariny
- `_Karina_Bash_NOTE.md` - Notatki Bash
- `ADHD_General.md` - Ogólne info ADHD

**Akcja**: → `docs/team/karinam/`

#### 📖 Dokumenty referencyjne (→ docs/)
- `Obsidian_Links.md` - Linki Obsidian
- `ctrl_h_dolphin.md` - Tips Dolphin
- `Study.md` - Studia
- `proces operacyjny.md` - Proces operacyjny
- `wykonawca.md` - Dokumentacja wykonawcy

**Akcja**: → `docs/references/`

#### 📅 Daily notes (→ archive/daily-notes/)
Daty: 2025-04-29, 05-02, 05-03, 05-05, 05-06, 05-12, 14.05, 15.05, 16.05, 04.06-09.06, 26.06, 27.06, 28.06

**Akcja**: → `archive/daily-notes/2025/`

#### 🗂️ Index i metadata (→ archive/)
- `Index.md`, `_Index_of_01_INBOX.md`, `_Index_of_E-Waste Workshop Vault.md`
- `Archives Inbox.md`, `Inbox.md.md`
- `(Poprzedni) README.md`

**Akcja**: → `archive/indexes/` lub usunąć jeśli puste

#### 💰 Płatności i biznes (→ bussiness/)
- `payments.md` - Płatności
- `1Taat.md` - Projekt 1Taat

**Akcja**: → `bussiness/Finanse/` i `archive/05_PROJECTS/`

#### ✅ Tasks snapshoty (→ archive/)
- `Tasks Plugin - Review and check your Statuses 2025-05-01 22-41-*.md` (3 pliki)
- `Todo.md`

**Akcja**: → `archive/tasks-snapshots/` lub usunąć

#### 🖼️ Screenshots (→ archive/ lub usunąć)
- `screenshot.png`, `screenshot 1-4.png` (5 plików)

**Akcja**: ❌ USUNĄĆ (niepotrzebne screenshoty)

#### 🗑️ Pliki śmieciowe
- `Bez nazwy.md`, `Bez nazwy 1.md`
- Sync conflicts: `2025-05-02.sync-conflict-*.md`, `2025-05-06.sync-conflict-*.md`
- `Daily Notes/Bez nazwy.md`

**Akcja**: ❌ USUNĄĆ

---

## 2. projects/e-waste-workshop/Inbox/ (4 pliki, 32KB)

### Klasyfikacja:

#### 🎮 Grywalizacja i motywacja (→ bussiness/Operacje/)
- `EWW_Motywacja_Grywalizacja.md` - 320 linii, system Habitica + Gather Town + KPI
  - Mapowanie KPI⇄XP
  - Integracja Odoo → n8n → Habitica
  - Karty postaci, levele, odznaki

**Akcja**: → `bussiness/Operacje/Gamification/`

#### 🏗️ Systemy wewnętrzne (→ docs/infra/)
- `Systems_Deep_Dive.md` - Architektura Secondbrain/Bastion
  - VM: Synapser, Cortex, Hippocampus, Prefrontal, OrbitalFrontal
  - 8 warstw Bastion
  - VLAN, monitoring, backup

**Akcja**: → `docs/infra/architecture/`

#### 📊 Status i dashboardy (→ var/ lub docs/)
- `EWW_System_Style_Status_2025-11-01_114327.md` - Status systemu
- `eww_weekly_dashboard_iso_w_45_03_09_11.md` - Dashboard tygodniowy

**Akcja**: → `var/status/` lub `docs/dashboards/`

---

## Plan przenoszenia

### Struktura docelowa:

```
docs/
├── methodologies/          # Metodyki (PARA, DevOps, Blitzscaling)
├── team/
│   └── karinam/           # Profile i tips Kariny
├── references/            # Dokumenty referencyjne
├── infra/
│   └── architecture/      # Systems Deep Dive
└── dashboards/            # Dashboard templates

bussiness/
├── Operacje/
│   └── Gamification/      # EWW Motywacja & Grywalizacja
└── Finanse/               # Payments

archive/
├── daily-notes/
│   └── 2025/              # Daily notes z maja-czerwca
├── indexes/               # Index pliki
├── tasks-snapshots/       # Task snapshoty
└── 05_PROJECTS/
    └── 1Taat/             # Projekt 1Taat

var/
└── status/                # System status snapshoty
```

### Akcje szczegółowe:

#### ✅ PRZENIEŚ - Wartościowe dokumenty (28 plików)

**Metodyki i strategie** (5 plików):
```bash
mkdir -p docs/methodologies
mv "archive/Archives Inbox/DevOps_Methodology.md" docs/methodologies/
mv "archive/Archives Inbox/PARA_Metodyka_SecondBrain.md" docs/methodologies/
mv "archive/Archives Inbox/PARA_Metodyka_SecondBrain 1.md" docs/methodologies/ 2>/dev/null || true
mv "archive/Archives Inbox/Strategia_Blitzscaling_Uniwersalna.md" docs/methodologies/
mv "archive/Archives Inbox/Obsidian Dashboard.md" docs/methodologies/
mv "archive/Archives Inbox/CopyCode_Cursor_Workflow.md" docs/methodologies/
```

**Team docs** (5 plików):
```bash
mkdir -p docs/team/karinam
mv "archive/Archives Inbox/Karina_ESFP-T_Profil_E-Waste_Workshop.md" docs/team/karinam/
mv "archive/Archives Inbox/Karina Tips.md" docs/team/karinam/
mv "archive/Archives Inbox/Karina Tips 2.md" docs/team/karinam/
mv "archive/Archives Inbox/_Karina_Bash_NOTE.md" docs/team/karinam/
mv "archive/Archives Inbox/ADHD_General.md" docs/team/
```

**References** (5 plików):
```bash
mkdir -p docs/references
mv "archive/Archives Inbox/Obsidian_Links.md" docs/references/
mv "archive/Archives Inbox/ctrl_h_dolphin.md" docs/references/
mv "archive/Archives Inbox/Study.md" docs/references/
mv "archive/Archives Inbox/proces operacyjny.md" docs/references/
mv "archive/Archives Inbox/wykonawca.md" docs/references/
```

**Infrastruktura** (2 pliki):
```bash
mkdir -p docs/infra/architecture
mv "projects/e-waste-workshop/Inbox/Systems_Deep_Dive.md" docs/infra/architecture/
mv "projects/e-waste-workshop/Inbox/EWW_System_Style_Status_2025-11-01_114327.md" var/status/
```

**Grywalizacja** (1 plik):
```bash
mkdir -p bussiness/Operacje/Gamification
mv "projects/e-waste-workshop/Inbox/EWW_Motywacja_Grywalizacja.md" bussiness/Operacje/Gamification/
```

**Finanse i projekty** (2 pliki):
```bash
mv "archive/Archives Inbox/payments.md" bussiness/Finanse/
mkdir -p archive/05_PROJECTS/1Taat
mv "archive/Archives Inbox/1Taat.md" archive/05_PROJECTS/1Taat/
```

**Dashboardy** (1 plik):
```bash
mkdir -p docs/dashboards
mv "projects/e-waste-workshop/Inbox/eww_weekly_dashboard_iso_w_45_03_09_11.md" docs/dashboards/
```

**Daily notes** (20 plików):
```bash
mkdir -p archive/daily-notes/2025/{04,05,06}
mv "archive/Archives Inbox/2025-04-29.md" archive/daily-notes/2025/04/
mv "archive/Archives Inbox/2025-05-"*.md archive/daily-notes/2025/05/ 2>/dev/null || true
mv "archive/Archives Inbox/"*.05.2025.md archive/daily-notes/2025/05/ 2>/dev/null || true
mv "archive/Archives Inbox/"*.06.2025.md archive/daily-notes/2025/06/ 2>/dev/null || true
mv "archive/Archives Inbox/Daily Notes/"*.md archive/daily-notes/2025/06/ 2>/dev/null || true
```

#### ❌ USUŃ - Śmieciowe pliki (15+ plików)

```bash
# Pliki bez nazwy
rm -f "archive/Archives Inbox/Bez nazwy.md"
rm -f "archive/Archives Inbox/Bez nazwy 1.md"
rm -f "archive/Archives Inbox/Daily Notes/Bez nazwy.md"

# Sync conflicts
rm -f "archive/Archives Inbox/"*sync-conflict*.md

# Screenshots
rm -f "archive/Archives Inbox/screenshot"*.png

# Puste indexy (po weryfikacji)
rm -f "archive/Archives Inbox/Inbox.md.md"
rm -f "archive/Archives Inbox/.keep"
```

#### 📋 ARCHIWUJ - Metadata i snapshoty (8 plików)

```bash
mkdir -p archive/indexes archive/tasks-snapshots

# Indexy
mv "archive/Archives Inbox/Index.md" archive/indexes/
mv "archive/Archives Inbox/_Index_of_01_INBOX.md" archive/indexes/
mv "archive/Archives Inbox/_Index_of_E-Waste Workshop Vault.md" archive/indexes/
mv "archive/Archives Inbox/Archives Inbox.md" archive/indexes/
mv "archive/Archives Inbox/(Poprzedni) README.md" archive/indexes/

# Task snapshoty
mv "archive/Archives Inbox/Tasks Plugin"*.md archive/tasks-snapshots/ 2>/dev/null || true
mv "archive/Archives Inbox/Todo.md" archive/tasks-snapshots/
```

---

## Podsumowanie akcji

**Wartościowe dokumenty**: 28 plików → przeniesione do struktury głównej  
**Daily notes**: 20 plików → `archive/daily-notes/2025/`  
**Metadata**: 8 plików → `archive/indexes/` i `archive/tasks-snapshots/`  
**Śmieciowe**: 15+ plików → USUNIĘTE  

**Efekt końcowy**:
- ✅ Dokumentacja uporządkowana w `docs/`
- ✅ Operacje biznesowe w `bussiness/`
- ✅ Archiwum w `archive/`
- ✅ Status w `var/`
- ✅ Inbox'y opróżnione i gotowe do usunięcia
