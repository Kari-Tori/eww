---
tags:
  - #obsidian
  - #graph
  - #docs
  - #folder_note
  - #eww
  - #secondbrain
created: 2025-11-22T19:29:00Z
modified: 2025-11-23T17:30:00Z
author: jakubc
title: "Obsidian Graph - Dokumentacja i instalacja"
owner: jakubc
---

# Obsidian Graph - Dokumentacja i instalacja

## 🚀 Quick Start

### Aktualna konfiguracja (2025-11-23)

**Preset**: ULTIMATE PERFORMANCE dla 927 plików markdown

**Ustawienia aktywne**:
```json
{
  "showTags": true,          // ✅ Wyświetl tagi
  "showAttachments": true,   // ✅ Wyświetl załączniki
  "hideUnresolved": false,   // ✅ Pokaż nieistniejące pliki (martwe linki)
  "showOrphans": true        // ✅ Pokaż niepowiązane pliki
}
```

**Gdzie są pliki**:
- Konfiguracja: `.obsidian/graph.json`
- Presety: `.obsidian/graph-*.json`
- Skrypt: `dev/scripts/graph-switch.sh`
- Dokumentacja: `docs/infra/software/obsidian/graph/`

### Jak używać

```bash
# Przełącz preset
./dev/scripts/graph-switch.sh

# Uruchom Obsidiana
obsidian &

# W Obsidianie: Ctrl+G (otwórz graf)
```

---

## 📚 Dokumentacja - Co gdzie i po co

### 🎯 Instalacja i setup (NOWE - 2025-11-23)

- **[[installation-guide]]** - Pełny przewodnik instalacji ULTIMATE setup
  - Gdzie są pliki i co robią
  - Jak instalować ręcznie i automatycznie
  - Po co każde ustawienie (showTags, showAttachments, hideUnresolved, showOrphans)
  - Parametry fizyki grafu i dlaczego takie wartości

- **[[presets]]** - 6 presetów specjalistycznych
  - ULTIMATE (domyślny, 927 plików)
  - BUSINESS (tylko business/)
  - JAKUBC (usr/jakubc/ + #secondbrain)
  - DEV (dev/ - scripts, lib, Playbooks)
  - MINIMAL (tylko indexy)
  - PERFORMANCE (max wydajność)

- **[[colors]]** - Schemat 18 kolorów
  - Tabela wszystkich grup kolorów
  - Kody RGB i HEX
  - Mapowanie kategorii → ścieżki → tagi

### 🎯 Zasady kanoniczne (legacy)

- **[[graph-rules]]** - **GŁÓWNY DOKUMENT** - Zasady konfiguracji grup kolorów, statystyki tagów, procedury aktualizacji

### 🔧 Konfiguracja (legacy)
- **[[GRAPH-CONFIG-DOCS]]** - Dokumentacja konfiguracji grafu
- **[[GRAPH-GROUPS-FINAL]]** - Finalne grupy kolorów
- **[[GRAPH-TAG-GROUPS]]** - Grupy tagów
- **[[GRAPH-TAGS-EXTENDED]]** - Rozszerzone tagi

### 🔨 Fix & Troubleshooting
- **[[GRAPH-FIX-INSTRUCTIONS]]** - Instrukcje naprawy grafu
- **[[graph-fix]]** - Skrypt naprawy
- **[[graph-fix-strategy]]** - Strategia naprawy
- **[[GRAPH-RENDER-FIX]]** - Naprawa renderowania

### 🔗 Backlinks & Hubs
- **[[GRAPH-BACKLINK-HUB-A]]** - Hub backlinków A
- **[[GRAPH-BACKLINK-HUB-B]]** - Hub backlinków B
- **[[GRAPH-BACKLINK-HUB-C]]** - Hub backlinków C

### ⚡ Optymalizacja
- **[[workspace-graph-optimization]]** - Optymalizacja workspace grafu

## 📁 Pliki konfiguracyjne (w .obsidian/)

```
.obsidian/
├── graph.json                    # Główna konfiguracja grafu
├── graph-colors.json             # Extended colors
├── graph-exclude.json            # Wykluczenia
├── graph-local.json              # Ustawienia lokalne
├── graph-optimization.json       # Optymalizacje
├── graph-performance.json        # Performance settings
├── backups/
│   ├── graph.json.20251121_184648
│   ├── graph.json.20251121_184809
│   └── graph.json.20251122_192312
└── snippets/
    ├── graph-colors.css          # Style CSS
    └── graph-style.css
```

## 🎨 Aktualne grupy kolorów (2025-11-22)

| Grupa | Query | Kolor | Plików |
|-------|-------|-------|--------|
| folder_note | `tag:#folder_note` | Szary | 296 |
| eww/core | `tag:#eww OR tag:#automation OR tag:#secondbrain` | Zielony | ~2000 |
| jakubc | `tag:#jakubc OR path:usr/jakubc/` | Cyjan | 130 |
| karinam | `tag:#karinam OR path:usr/karinam/` | Magenta | 25 |
| star-wars | `tag:#star-wars OR path:usr/jakubc/star_wars/` | Żółty | 108 |
| lego | `tag:#lego OR path:usr/jakubc/lego/` | Pomarańczowy | 8 |
| docs | `tag:#docs OR tag:#knowledge OR path:docs/` | Niebieski | ~900 |
| infrastructure | `tag:#infrastructure OR tag:#Asus_Z77 OR tag:#GERC` | Fioletowy | 122 |
| scripts | `tag:#scripts OR tag:#bash OR path:scripts/` | Czerwony | 26 |
| development | `tag:#development OR tag:#git OR path:dev/` | Turkusowy | 462 |
| todo | `tag:#todo OR tag:#productivity` | Pomarańczowy | 81 |
| config | `tag:#config OR path:config/` | Brązowy | 10 |

Pełne szczegóły w [[graph-rules]].

## 🔄 Procedura aktualizacji grup

1. Analiza tagów w repo
2. Backup `.obsidian/graph.json`
3. Edycja grup w GUI lub ręcznie
4. Weryfikacja i test
5. Commit zmian
6. Aktualizacja [[graph-rules]]

## 📊 Narzędzia

### Analiza tagów
```bash
cd /home/jakubc/git/eww
grep -r "^  - #" --include="*.md" . | sed 's/.*- //' | sort | uniq -c | sort -rn
```

### Backup grafu
```bash
cp .obsidian/graph.json .obsidian/backups/graph.json.$(date +%Y%m%d_%H%M%S)
```

### Weryfikacja
```bash
cat .obsidian/graph.json | jq '.colorGroups | length'
```

## 🔗 Powiązane

- [[docs/infra/software/obsidian/]] - Dokumentacja Obsidian
- [[.obsidian/]] - Katalog konfiguracji
- [[EWW-MAP]] - Mapa projektu

## 📝 Historia

| Data | Wydarzenie |
|------|-----------|
| 2025-11-22 | Reorganizacja - utworzono katalog docs/infra/software/obsidian/graph/ |
| 2025-11-22 | Utworzono graph-rules.md jako kanoniczne źródło |
| 2025-11-21 | Ostatnia ręczna konfiguracja grup |

---

**Główny dokument:** [[graph-rules]]
**Lokalizacja konfiguracji:** `/.obsidian/graph.json`
**Backupy:** `/.obsidian/backups/`
