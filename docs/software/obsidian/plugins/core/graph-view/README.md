---
version: 0.0.2
tags:
  - #obsidian
  - #graph
  - #docs
  - #folder_note
  - #eww
  - #secondbrain
created: 2025-11-24
modified: 2025-11-28
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
- Dokumentacja: `docs/infra/software/obsidian/plugins/core/graph-view/`

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

- **[[CHANGELOG]]** - Historia zmian z datami i konfiguracjami
  - Porównanie wszystkich wersji konfiguracji
  - Parametry fizyki dla różnych rozmiarów vault
  - Ewolucja ustawień widoczności

- **[[graph-view-limits]]** - Limity techniczne i wydajnościowe
  - Hardcoded limits (maxNodes, rendering)
  - Benchmarki dla różnych rozmiarów vault
  - Strategie optymalizacji (filtry, multi-graph)
  - Znane problemy i obejścia
  - Tabela decyzyjna: co robić przy X plikach

- **[[graph-view-next]]** - Zaawansowane możliwości i przyszłość 🚀
  - CSS customization (animacje, gradienty, efekty)
  - Community plugins (Graph Analysis, Extended Graph, Breadcrumbs)
  - Advanced techniques (pseudo-3D, time-based viz, AI insights)
  - Future features (native 3D, timeline view, collaboration)
  - Roadmap dla eww project (4 fazy rozwoju)

### 🗄️ Archiwum (legacy docs)

- **[[archives/README]]** - 13 archiwalnych dokumentów (92KB)
  - GRAPH-BACKLINK-HUB-*.md - Analiza hub'ów backlinkowych
  - GRAPH-CONFIG-DOCS.md - Dokumentacja konfiguracji
  - GRAPH-*-FIX*.md - Dokumenty naprawcze
  - graph-rules.md, workspace-graph-optimization.md - Legacy optymalizacja

**Status**: Zarchiwizowane 2025-11-23 - zobacz `archives/README.md` dla szczegółów

---

## 🔗 Powiązane

- [[docs/infra/software/obsidian/]] - Dokumentacja Obsidian
- [[.obsidian/]] - Katalog konfiguracji vault
- [[EWW-MAP]] - Mapa projektu
- [[dev/scripts/graph-switch.sh]] - Skrypt do przełączania presetów

---

**Lokalizacja konfiguracji:** `.obsidian/graph.json`
**Backupy:** `.obsidian/backups/graph.json.*`
**Presety:** `.obsidian/graph-*.json`
**Data ostatniej aktualizacji:** 2025-11-23

## 🔗 Backlinks

- [[INDEX]]
- [[docs]]
- [[EWW-MAP]]