---
tags:
  - #obsidian
  - #graph
  - #configuration
created: 2025-11-27
modified: 2025-11-27
author: karinam
title: "Obsidian Graph - Centralna konfiguracja"
---

# Obsidian Graph - Centralna konfiguracja

## 📂 Struktura

```
graph/
├── presets/              # Presety konfiguracyjne (JSON)
├── backups/             # Ręczne backupy przed zmianami
├── versions/            # Automatyczne snapshoty daily (systemd)
├── styles/              # Style CSS dla Graph View
├── docs/                # Szczegółowa dokumentacja
└── README.md            # Ten plik
```

## 🎯 Presety (presets/)

Gotowe konfiguracje Graph View do szybkiego przełączania:

| Preset | Opis | Nodes | Użycie |
|--------|------|-------|--------|
| **ultimate.json** | Cała struktura, zoptymalizowany | ~927 | Domyślny, aktywny |
| **business.json** | Tylko business/ + governance | ~100 | Analiza biznesowa |
| **dev.json** | Katalog dev/ (scripts, lib) | ~200 | Rozwój narzędzi |
| **jakubc.json** | Pliki jakubc + secondbrain | ~150 | Praca jakubc |
| **karinam.json** | Pliki karinam | ~50 | Praca karinam |
| **minimal.json** | Tylko indexy i folder notes | ~60 | Quick overview |
| **performance.json** | Maksymalna wydajność | varies | Duże vaults |

### Pliki pomocnicze:
- **optimization.json** - Parametry optymalizacji
- **exclude.json** - Globalne wykluczenia (logi, cache)
- **colors.json** - Schemat kolorystyczny (14 kategorii)
- **local.json** - Konfiguracja lokalna (git-ignored)

### Jak użyć:
```bash
# Przełącz na wybrany preset
cp presets/ultimate.json ../../.obsidian/graph.json

# Lub ścieżka bezwzględna
cp /home/karinam/git/eww/dev/obsidian/graph/presets/business.json \
   /home/karinam/git/eww/.obsidian/graph.json
```

## 🎨 Style CSS (styles/)

- **colors.css** - Kolory węzłów i linków (14 kategorii)
- **style.css** - Główne style Graph View
- **timeline.css** - Style dla osi czasu

### Instalacja snippetów:
```bash
# Skopiuj do snippets Obsidian
cp styles/*.css ../../.obsidian/snippets/

# Włącz w: Settings → Appearance → CSS snippets
```

## 💾 Backupy (backups/)

Ręczne snapshoty przed większymi zmianami.

### Naming convention:
```
{opis}-{YYYYMMDD-HHMMSS}.json

Przykłady:
- before-colors-20251126-135243.json
- ultra-compact-20251126-140103.json
- working-config-20251201-103000.json
```

### Tworzenie backupu:
```bash
cd /home/karinam/git/eww/.obsidian
cp graph.json ../dev/obsidian/graph/backups/my-backup-$(date +%Y%m%d-%H%M%S).json
```

## 📅 Versions (versions/)

Automatyczne daily snapshoty przez systemd timer.

### Struktura:
- `YYYY-MM-DD.json` - snapshot danego dnia
- `history.md` - historia zmian

### Systemd automation:
```bash
# Units w: /home/karinam/git/eww/core/systemd/
# - graph-snapshot.timer
# - graph-snapshot.service

# Script: /home/karinam/git/eww/dev/scripts/graph-snapshot.sh
```

### Retencja:
- Ostatnie 30 dni: wszystkie
- Ostatnie 90 dni: co 7. dzień
- Starsze: co 30. dzień

## 📚 Dokumentacja (docs/)

Szczegółowe przewodniki:

- **graph-presets.md** - Pełna dokumentacja wszystkich presetów (321 linii)
- **graph-preset-info.md** - Quick reference aktywnego presetu
- **README.md** (preset) - Guide presetów
- **README.md** (backups) - Workflow backupów
- **README.md** (versions) - Automatyzacja snapshots

**Główny przewodnik**: `/docs/graph.md`

## 🚀 ULTIMATE Preset (aktywny)

### Parametry:
```json
{
  "search": "-path:core/var/logs -path:core/var/status -path:.git",
  "showAttachments": false,
  "hideUnresolved": true,
  "showOrphans": false,
  "textFadeMultiplier": -0.5,
  "nodeSizeMultiplier": 1.5,
  "lineSizeMultiplier": 2,
  "centerStrength": 0.15,
  "repelStrength": 12,
  "linkStrength": 0.6,
  "linkDistance": 120
}
```

### Korzyści:
- ✅ Wykluczenie logów/cache → +15% szybkości
- ✅ Bez załączników → czytelniejszy
- ✅ Ukryte martwe linki i sieroty
- ✅ Zawsze widoczne etykiety (-0.5)
- ✅ Większe węzły (1.5x), grubsze linie (2x)
- ✅ Kompaktowy layout (120px)
- ✅ Zbalansowana fizyka (repel:12, link:0.6)

**Render**: <3s dla 927 plików markdown ⚡

## 🎨 Schemat kolorów

| Kolor | Kategoria | RGB | Query | Lokalizacja |
|-------|-----------|-----|-------|-------------|
| ⚫ | archives | #000000 | path:docs/archive | Archiwum |
| ⚪ | structure | #ffffff | file:README OR INDEX | Struktura |
| 🔴 | logs | #ff0000 | path:core/var/logs | Logi |
| 🟠 | infra | #ff6600 | path:docs/infra | Infrastruktura |
| 🟡 | config | #ffff00 | path:core OR .github | Config |
| 🟢 | eww | #66ff00 | tag:#eww OR core | Core EWW |
| 🟢 | business | #00ff00 | path:business/ | Biznes |
| 🔵 | tools | #00ffcc | path:dev/scripts | Narzędzia |
| 🔵 | dev | #0000ff | path:dev/ | Development |
| 🟣 | docs | #9900ff | path:docs/ | Dokumentacja |
| 🟣 | secondbrain | #ff00ff | tag:#secondbrain | Notatki |

Pełna definicja w: `presets/colors.json`

## 🔧 Workflow

### 1. Normalna praca
```bash
# Graph działa z ULTIMATE preset
# Daily snapshots automatyczne (systemd)
```

### 2. Przed większymi zmianami
```bash
# Utwórz backup ręczny
cp ../../.obsidian/graph.json backups/before-my-changes-$(date +%Y%m%d-%H%M%S).json

# Edytuj graph.json w Obsidian
# Settings → Graph View → Dostosuj parametry

# Test
# Sprawdź wydajność i wygląd
```

### 3. Przywracanie
```bash
# Z backupu
cp backups/before-colors-20251126-135243.json ../../.obsidian/graph.json

# Z versioned snapshot
cp versions/2025-11-23.json ../../.obsidian/graph.json

# Z presetu
cp presets/minimal.json ../../.obsidian/graph.json
```

### 4. Tworzenie nowego presetu
```bash
# 1. Skonfiguruj Graph View w Obsidian
# 2. Skopiuj konfigurację
cp ../../.obsidian/graph.json presets/my-preset.json

# 3. Commit
git add presets/my-preset.json
git commit -m "feat(graph): dodaj preset my-preset"
```

## 📊 Monitorowanie wydajności

| Czas renderowania | Status | Akcja |
|-------------------|--------|-------|
| <1s | ✅ Doskonały | - |
| 1-3s | ✅ Dobry | - |
| 3-5s | ⚠️ Wolny | Rozważ optymalizację |
| >5s | ❌ Problem | Użyj mniejszego presetu |

### Optymalizacja:
- Zwiększ wykluczenia w `search`
- `hideUnresolved: true`
- `showOrphans: false`
- `showAttachments: false`
- Zmniejsz `nodeSizeMultiplier` i `lineSizeMultiplier`

## 🔗 Linki

- **Główny guide**: `/docs/graph.md`
- **Limity techniczne**: `/dev/obsidian/OBSIDIAN-GRAPH-LIMITS.md`
- **Script snapshot**: `/dev/scripts/graph-snapshot.sh`
- **Systemd units**: `/core/systemd/graph-snapshot.*`

## 📝 Historia

- **2025-11-27**: Konsolidacja w jeden katalog `graph/`, standard nazewnictwa
- **2025-11-26**: Backupy przed zmianami kolorów
- **2025-11-23**: ULTIMATE preset, versjonowanie, systemd timer

---

**Wszystko w jednym miejscu. Prosta struktura. Jasne nazwy.** ✨
