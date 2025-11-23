---
tags:
  - #documentation
  - #graph
  - #structure
  - #folder_note
created: 2025-11-23T00:00:00Z
modified: 2025-11-23T00:00:00Z
author: jakubc
title: "Schemat kolorów dla struktury grafu projektu EWW"
---

# Schemat kolorów dla struktury grafu projektu EWW

## Paleta kolorów

Poniższa tabela definiuje kolorystykę używaną do identyfikacji struktur w grafie projektu.

| Nr  | Kolor | Klucz       | Kod     | Tags                                            | Lokalizacja                            | Opis                                      |
| --- | ----- | ----------- | ------- | ----------------------------------------------- | -------------------------------------- | ----------------------------------------- |
| 1   | ⚫     | archives           | #000000 | archives, backup, old, deprecated                     | docs/archive/, usr/jakubc/workspace/archive/ | Archiwalne pliki, stare backupy           |
| 2   | ⚪     | structure          | #ffffff | structure, index, readme, documentation, root         | README.md, INDEX.md, CHANGELOG.md    | Struktura projektu, indexy, główne docs   |
| 3   | 🔴    | logs               | #ff0000 | logs, output, ci, workflows, manifests                | core/var/logs/, core/var/status/, .github/workflows/ | Logi systemowe, manifesty, output, CI/CD  |
| 4   | 🟠    | infra              | #ff6600 | infra, ansible, systemd, deployment, services         | docs/infra/, core/systemd/, .vscode/ | Infrastruktura, ansible, services         |
| 5   | 🟡    | config             | #ffff00 | config, yaml, settings, environment                   | core/, .github/, .gitignore          | Pliki konfiguracyjne, ustawienia, CI      |
| 6   | 🟢    | eww                | #66ff00 | eww, core, version, workspace, root                   | core/, Makefile, CHANGELOG.md        | Rdzeń projektu EWW, core komponenty       |
| 7   | 🟢    | business    | #00ff00 | business, governance, processes, methodologies  | business/, business/governance/        | Procesy biznesowe, governance, metodyki   |
| 8   | 🔵    | tools              | #00ffcc | tools, scripts, bin, lib, playbooks, automation       | dev/scripts/, dev/bin/, dev/lib/     | Narzędzia deweloperskie, playbooki, testy |
| 9   | 🔵    | gerc        | #00ffff | gerc, hardware, workstation, pulseaudio         | docs/infra/hardware/workstations/gerc/ | Stacja robocza GERC (dokumentacja HW)     |
| 10  | 🔵    | jakubc             | #0066ff | jakubc, user, tasks, study, todo                      | usr/jakubc/, usr/jakubc/workspace/, usr/jakubc/flowers/ | Pliki użytkownika jakubc, zadania         |
| 11  | 🔵    | dev                | #0000ff | dev, development, projects, poc, tests                | dev/, dev/Playbooks/, dev/docs/      | Warsztat deweloperski, PoC, projekty      |
| 12  | 🟣    | docs               | #9900ff | docs, documentation, guide, wiki, references          | docs/, docs/guide/, docs/reports/    | Dokumentacja, wiki, przewodniki           |
| 13  | 🟣    | secondbrain        | #ff00ff | secondbrain, notes, knowledge, para, obsidian         | dev/Projects/Secondbrain/, .obsidian/ | Projekt secondbrain, notatki, wiedza      |
| 14  | 🟣    | karinam            | #ff0099 | karinam, user, backup, desktop                        | usr/karinam/, usr/karinam/devices/, usr/karinam/.desktop-local-backup/ | Pliki użytkownika karinam, backupy        |
| Nr  | Kolor | Nazwa       | Kod     | Tags                                            | Lokalizacja                            | Opis                                      |

## Zastosowanie

Kolory te są używane do:

- Wizualizacji struktury projektu w grafach
- Identyfikacji kategorii plików i katalogów
- Ułatwienia nawigacji w złożonej strukturze repozytorium
- Spójnego tagowania elementów projektu

## 🚀 ULTIMATE GRAPH SETUP - ZAINSTALOWANE!

### ✅ Aktywna konfiguracja (od 2025-11-23)

**Preset**: ULTIMATE PERFORMANCE dla 927 plików markdown

### 📦 FAZA 1 IMPLEMENTACJI - UKOŃCZONA! ✅

**Data**: 2025-11-23  
**Status**: 🟢 COMPLETE

**Zrealizowane**:
- ✅ Versjonowanie: `.obsidian/graph-versions/` + daily snapshots
- ✅ Script: `dev/scripts/graph-snapshot.sh` (działa!)
- ✅ Script: `dev/scripts/graph-history.sh`
- ✅ Script: `dev/scripts/sync-graph-colors.sh`
- ✅ Systemd: `core/systemd/graph-snapshot.timer` + `.service`
- ✅ Template: `core/tmp/templates/note-template.md` (YAML frontmatter)
- ✅ Pierwszy snapshot: `graph-2025-11-23.json` (committed)

**Parametry**:
```json
{
  "search": "-path:core/var/logs -path:core/var/status -path:.git",
  "showAttachments": false,
  "hideUnresolved": true,
  "showOrphans": false,
  "textFadeMultiplier": -0.5,
  "nodeSizeMultiplier": 1.5,
  "lineSizeMultiplier": 2,
  "centerStrength": 0.4,
  "repelStrength": 12,
  "linkStrength": 0.6,
  "linkDistance": 280
}
```

**Korzyści**:
- ⚡ Wykluczenie logów/cache → +15% szybkości
- 📊 Bez załączników → czytelniejszy graf
- 🎯 Ukryte martwe linki i sieroty → tylko połączone notatki
- 👁️ Zawsze widoczne etykiety → `-0.5`
- 📏 Większe węzły (1.5x) i grubsze linie (2x)
- 🎨 Kompaktowy layout (280px) + silne centrum (0.4)
- ⚖️ Zbalansowana fizyka (repel:12, link:0.6)

### 📦 Dostępne presety

Wszystkie presety w: `.obsidian/graph-*.json`

1. **ULTIMATE** (aktywny) - `.obsidian/graph.json`
2. **BUSINESS** - `.obsidian/graph-business.json` - tylko business/
3. **JAKUBC** - `.obsidian/graph-jakubc.json` - usr/jakubc/ + #secondbrain
4. **DEV** - `.obsidian/graph-dev.json` - dev/ (scripts, lib, Playbooks)
5. **MINIMAL** - `.obsidian/graph-minimal.json` - tylko indexy
6. **PERFORMANCE** - `.obsidian/graph-performance.json` - max wydajność

### 🔧 Szybkie przełączanie

**Skrypt**: `dev/scripts/graph-switch.sh`

```bash
# Interaktywnie
./dev/scripts/graph-switch.sh

# Bezpośrednio
./dev/scripts/graph-switch.sh business
./dev/scripts/graph-switch.sh jakubc
./dev/scripts/graph-switch.sh dev
```

### 📚 Pełna dokumentacja

Zobacz: `.obsidian/graph-presets.md` - wszystkie presety, pro tips, troubleshooting

## Kategorie główne

### 🔴 Logi i CI/CD

- **🔴 Logi** (#ff0000) - core/var/logs/, workflows CI/CD

### 🟠🟡 Infrastruktura i konfiguracja

- **🟠 Infrastruktura** (#ff6600) - docs/infra/, ansible, systemd, vale
- **🟡 Konfiguracja** (#ffff00) - core/, dev/cfg/, .github/, .githooks/, yaml/yml

### 🟢 Rdzeń i biznes

- **🟢 Radioactive Lime - EWW** (#66ff00) - core/, VERSION, workspace
- **🟢 Pure Green - Business** (#00ff00) - business/, governance, processes, metodyki

### 🔵 Development i narzędzia

- **🔵 Electric Turquoise - Tools** (#00ffcc) - dev/bin/, dev/lib/, dev/scripts/, playbooki, testy
- **🔵 Pure Cyan - GERC** (#00ffff) - stacja robocza, hardware docs, pulseaudio
- **🔵 Electric Blue - Jakubc** (#0066ff) - usr/jakubc/, tasks, study, TODO
- **🔵 Pure Blue - Dev** (#0000ff) - dev/, Development, Projects, tests

### 🟣 Dokumentacja i użytkownicy

- **🟣 Neon Purple - Docs** (#9900ff) - docs/, guide, references, reports
- **🟣 Pure Magenta - SecondBrain** (#ff00ff) - dev/Projects/Secondbrain/, PARA metodyka
- **🟣 Shocking Pink - Karinam** (#ff0099) - usr/karinam/, backupy

### ⚫⚪ Struktura i archiwa

- **⚫ Archiwa** (#000000) - docs/archive/, business/archive/
- **⚪ Struktura** (#ffffff) - README, INDEX, dokumenty główne

## Obsidian Graph Groups - Definicje kolorów

```json
{
  "collapse-filter": false,
  "search": "",
  "showTags": true,
  "showAttachments": false,
  "hideUnresolved": true,
  "showOrphans": false,
  "collapse-color-groups": false,
  "colorGroups": [
    {
      "query": "tag:#folder_note",
      "color": {
        "a": 1,
        "rgb": 5227511
      }
    },
    {
      "query": "path:docs/archive OR path:usr/jakubc/workspace/archive",
      "color": {
        "a": 1,
        "rgb": 0
      }
    },
    {
      "query": "file:README OR file:INDEX OR file:CHANGELOG",
      "color": {
        "a": 1,
        "rgb": 16777215
      }
    },
    {
      "query": "path:core/var/logs OR path:core/var/status OR path:.github/workflows",
      "color": {
        "a": 1,
        "rgb": 16711680
      }
    },
    {
      "query": "path:docs/infra OR path:core/systemd OR path:.vscode",
      "color": {
        "a": 1,
        "rgb": 16737280
      }
    },
    {
      "query": "path:core OR path:.github OR file:.gitignore OR tag:#config",
      "color": {
        "a": 1,
        "rgb": 16776960
      }
    },
    {
      "query": "path:core OR file:Makefile OR file:CHANGELOG OR tag:#eww OR tag:#core",
      "color": {
        "a": 1,
        "rgb": 6748928
      }
    },
    {
      "query": "path:business OR tag:#business",
      "color": {
        "a": 1,
        "rgb": 65280
      }
    },
    {
      "query": "path:dev/scripts OR path:dev/bin OR path:dev/lib OR tag:#tools",
      "color": {
        "a": 1,
        "rgb": 65484
      }
    },
    {
      "query": "path:docs/infra/hardware/workstations/gerc OR tag:#gerc OR tag:#GERC",
      "color": {
        "a": 1,
        "rgb": 65535
      }
    },
    {
      "query": "path:usr/jakubc OR tag:#jakubc",
      "color": {
        "a": 1,
        "rgb": 26367
      }
    },
    {
      "query": "path:dev OR tag:#dev OR tag:#development",
      "color": {
        "a": 1,
        "rgb": 255
      }
    },
    {
      "query": "path:docs OR tag:#docs OR tag:#documentation",
      "color": {
        "a": 1,
        "rgb": 10027007
      }
    },
    {
      "query": "path:dev/Projects/Secondbrain OR path:.obsidian OR tag:#secondbrain",
      "color": {
        "a": 1,
        "rgb": 16711935
      }
    },
    {
      "query": "path:usr/karinam OR tag:#karinam",
      "color": {
        "a": 1,
        "rgb": 16711833
      }
    },
    {
      "query": "tag:#star-wars OR path:usr/jakubc/star_wars",
      "color": {
        "a": 1,
        "rgb": 14263361
      }
    },
    {
      "query": "tag:#lego OR path:usr/jakubc/lego",
      "color": {
        "a": 1,
        "rgb": 16040461
      }
    },
    {
      "query": "tag:#Asus_Z77 OR path:docs/infra/hardware/asus_z77",
      "color": {
        "a": 1,
        "rgb": 12604881
      }
    }
  ],
  "collapse-display": false,
  "showArrow": true,
  "textFadeMultiplier": 0,
  "nodeSizeMultiplier": 1.2,
  "lineSizeMultiplier": 1,
  "collapse-forces": false,
  "centerStrength": 0.1,
  "repelStrength": 20,
  "linkStrength": 0.3,
  "linkDistance": 500,
  "scale": 1,
  "close": false
}
```

- **⚪ Struktura** (#ffffff) - README, INDEX, dokumenty główne
