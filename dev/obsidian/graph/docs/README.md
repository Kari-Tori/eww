---
tags:
  - #obsidian
  - #graph
  - #presets
  - #documentation
created: 2025-11-27
modified: 2025-11-27
author: karinam
title: "Obsidian Graph - Presety konfiguracyjne"
---

# Obsidian Graph - Presety konfiguracyjne

## 📂 Struktura katalogów

```
dev/obsidian/
├── graph/                    # Presety graph (JSON + CSS)
├── graph-backups/           # Ręczne backupy (z nazwami opisowymi)
├── graph-versions/          # Snapshoty wersjonowane (daily)
├── graph-presets.md         # Pełna dokumentacja presetów
└── graph-preset-info.md     # Aktualne info o aktywnym presecie
```

## 🎯 Presety dostępne w tym katalogu

### Główne presety:
- **graph-ultimate.json** - Preset ULTIMATE PERFORMANCE (zoptymalizowany pod 927 plików)
- **graph-business.json** - Tylko katalog business/ + governance
- **graph-dev.json** - Katalog dev/ (scripts, lib, playbooks)
- **graph-jakubc.json** - Pliki użytkownika jakubc + secondbrain
- **graph-karinam.json** - Pliki użytkownika karinam
- **graph-minimal.json** - Tylko indexy i folder notes
- **graph-performance.json** - Maksymalna wydajność
- **graph-local.json** - Konfiguracja lokalna (git-ignored)

### Pliki pomocnicze:
- **graph-optimization.json** - Parametry optymalizacyjne
- **graph-exclude.json** - Globalne wykluczenia (logi, cache, .git)
- **graph-colors.json** - Schemat kolorystyczny (14 kategorii)

### Style CSS:
- **graph-style.css** - Główne style graph view
- **graph-colors.css** - Kolory węzłów i linków
- **graph-timeline.css** - Style dla graph timeline

## 🔧 Jak używać presetów

### Metoda 1: Ręczne przełączanie
```bash
# Kopiuj wybrany preset do głównego graph.json
cp graph/graph-ultimate.json ../.obsidian/graph.json
```

### Metoda 2: Skrypt (jeśli istnieje)
```bash
./dev/scripts/graph-switch.sh ultimate
```

## 📊 ULTIMATE PERFORMANCE Preset

**Zoptymalizowany pod 927 plików markdown**

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
- ✅ Kompaktowy layout (120px distance)
- ✅ Zbalansowana fizyka

## 📚 Dokumentacja

- **Pełna dokumentacja**: `../graph-presets.md` (321 linii)
- **Aktualne info**: `../graph-preset-info.md` (46 linii)
- **Główny przewodnik**: `/docs/graph.md`
- **Limity techniczne**: `../OBSIDIAN-GRAPH-LIMITS.md`

## 🔄 Versjonowanie

- **Snapshoty daily**: `../graph-versions/graph-YYYY-MM-DD.json`
- **Backupy ręczne**: `../graph-backups/graph-backup-*.json`
- **Script snapshot**: `/dev/scripts/graph-snapshot.sh`
- **Systemd timer**: `/core/systemd/graph-snapshot.timer`

## 🎨 Schemat kolorów

Kolory definiowane w `graph-colors.json`:

| Kolor | Kategoria | RGB | Lokalizacja |
|-------|-----------|-----|-------------|
| ⚫ | archives | #000000 | archive/ |
| ⚪ | structure | #ffffff | README, INDEX |
| 🔴 | logs | #ff0000 | core/var/logs/ |
| 🟠 | infra | #ff6600 | docs/infra/ |
| 🟡 | config | #ffff00 | core/, .github/ |
| 🟢 | eww | #66ff00 | core/, Makefile |
| 🟢 | business | #00ff00 | business/ |
| 🔵 | tools | #00ffcc | dev/scripts/ |
| 🔵 | dev | #0000ff | dev/ |
| 🟣 | docs | #9900ff | docs/ |
| 🟣 | secondbrain | #ff00ff | dev/Projects/Secondbrain/ |

## ⚙️ Konfiguracja globalna

Plik wykluczeń `graph-exclude.json`:
```json
{
  "exclude_paths": [
    "core/var/logs",
    "core/var/status",
    ".git",
    "node_modules",
    ".obsidian/plugins",
    ".obsidian/themes"
  ]
}
```

## 🚀 Best Practices

1. **Daily snapshots**: Automatyczne przez systemd timer
2. **Ręczne backupy**: Przed większymi zmianami (do `graph-backups/`)
3. **Naming convention**: `graph-backup-{opis}-{YYYYMMDD-HHMMSS}.json`
4. **Testing**: Zawsze testuj preset przed commitem
5. **Performance**: Monitoruj czas renderowania (<3s OK, >5s problem)

## 📝 Historia zmian

- **2025-11-27**: Uporządkowanie struktury, utworzenie README
- **2025-11-26**: Backupy przed zmianami kolorów
- **2025-11-23**: Wdrożenie ULTIMATE preset, versjonowanie, systemd timer
