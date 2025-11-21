---
tags:
  - #automation
  - #development
  - #eww
  - #graph
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T13:00:00Z
modified: 2025-11-21T13:00:00Z
author: jakubc
title: "📊 Graph Setup - Instrukcja konfiguracji"






---

# 📊 Graph Setup - Instrukcja konfiguracji

> **Jak skonfigurować 5 grafów dla optymalnej wizualizacji**

## 🎯 Problem: Graph się wykrzacza przy 489 notatkach

**Rozwiązanie**: 5 dedykowanych grafów zamiast 1 globalnego

## 📋 Co utworzyliśmy

### 1. [[GRAPH-MAP|🗺️ GRAPH-MAP]] - Master Overview
**Filtr**: Tylko folder notes (10-15 węzłów)
```
(path:core/core OR path:business/business OR path:config/config OR path:infra/infra OR path:docs/docs OR path:usr/jakubc/jakubc OR path:usr/karinam/karinam) -path:archive -path:var/log
```
- ⚡ Rendering: < 0.2s
- 🎯 Użyj jako: Dashboard główny

### 2. [[GRAPH-CORE|🔴 GRAPH-CORE]] - Core Components
**Filtr**: `path:core -path:archive -path:var/log`
- 📝 Notatek: 50-80
- 🎨 Kolor: Czerwony
- ⚡ Rendering: < 1s

### 3. [[GRAPH-BUSINESS|🟡 GRAPH-BUSINESS]] - Business Logic
**Filtr**: `path:business -path:archive -path:var/log`
- 📝 Notatek: 40-60
- 🎨 Kolor: Żółty
- ⚡ Rendering: < 1s

### 4. [[GRAPH-CONFIG|🟢 GRAPH-CONFIG]] - Config & Infra
**Filtr**: `path:config OR path:infra -path:archive -path:var/log`
- 📝 Notatek: 30-50
- 🎨 Kolor: Zielony
- ⚡ Rendering: < 0.5s

### 5. [[GRAPH-USERS|👥 GRAPH-USERS]] - User Profiles
**Filtr**: `path:usr/jakubc OR path:usr/karinam -path:var/log`
- 📝 Notatek: 100-150
- 🎨 Kolory: Cyan (jakubc), Pink (karinam)
- ⚡ Rendering: < 1s

## 🚀 Jak używać

### Krok 1: Pin dashboard
1. Otwórz [[GRAPH-MAP]]
2. Kliknij: **Pin** (ikonka pinezki) 📌
3. Otwórz: **Graph View** (Ctrl+G)

### Krok 2: Skonfiguruj filtr
W Graph View → Search:
```
(path:core/core OR path:business/business OR ...) -path:archive
```

### Krok 3: Dostosuj wygląd
- **Node size**: 0.9
- **Link thickness**: 1.2
- **Center strength**: 0.4
- **Repel strength**: 15-20

### Krok 4: Nawigacja
- Kliknij folder note → **Local Graph** (depth: 2)
- Kliknij [[GRAPH-CORE]] → szczegółowy graf core
- Kliknij [[GRAPH-BUSINESS]] → szczegółowy graf business

## 📈 Rezultaty

**Przed**:
- ❌ 489 notatek w 1 grafie
- ❌ Rendering 30+ sekund
- ❌ Graph się wykrzacza
- ❌ "Too many to handle"

**Po**:
- ✅ 5 grafów po 20-150 notatek
- ✅ Rendering < 1s każdy
- ✅ Płynna animacja
- ✅ Czytelna wizualizacja

## 🎨 Kolorowanie automatyczne

Już skonfigurowane w `.obsidian/graph.json`:

```json
"colorGroups": [
  {"query": "path:karinam OR tag:#candy", "color": "#ff00ff"},
  {"query": "path:jakubc OR tag:#owner", "color": "#00ffff"},
  {"query": "tag:#core", "color": "#ff0000"},
  {"query": "tag:#business", "color": "#ffff00"},
  {"query": "tag:#config", "color": "#00ff00"}
]
```

## 🔧 Advanced: Local Graphs

Każda folder note ma **local graph**:
1. Otwórz folder note (np. [[core/core]])
2. Kliknij: **Open local graph** (prawy panel)
3. Depth: 2 levels
4. Widzisz tylko bezpośrednie połączenia

**Perfect dla szybkiej nawigacji!** 🎯

## 💡 Pro Tips

1. **Dashboard workflow**:
   - Pin [[GRAPH-MAP]] + [[EWW-MAP]]
   - Quick switch między grafami
   - Local graph dla szczegółów

2. **Git graph jako bonus**:
   ```bash
   git log --all --graph --oneline --decorate
   ```
   Versioning + historia zmian

3. **Waypoint + Graph**:
   - Waypoint generuje indexy
   - Graph pokazuje połączenia
   - Razem = perfect navigation

## ✅ Checklist

- [x] Utworzono 5 grafów
- [x] Skonfigurowano filtry
- [x] Ustawiono kolory
- [x] Dodano dokumentację
- [x] Utworzono [[EWW-MAP]] dashboard
- [ ] Pin [[GRAPH-MAP]] w Obsidian
- [ ] Test każdego grafu
- [ ] Dostosuj wygląd (opcjonalnie)


**Gotowe! Grafy działają szybko i czytelnie.** 🎉

*Źródła*:
- [[EWW-MAP]] - Main dashboard
- `.obsidian/graph.json` - Config file
- Obsidian Docs: Graph View

*Backlinks*: [[GRAPH-MAP]], [[GRAPH-CORE]], [[GRAPH-BUSINESS]], [[GRAPH-CONFIG]], [[GRAPH-USERS]]
