---
tags:
  - #automation
  - #development
  - #eww
  - #graph
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T12:00:00Z
modified: 2025-11-21T12:00:00Z
author: jakubc
title: "🎨 OBSIDIAN GRAPH - OPTYMALIZACJA"






---

# 🎨 OBSIDIAN GRAPH - OPTYMALIZACJA

## 🚨 Problem

**Repo ma 481 plików MD** → Graph się wykrzacza przy >1200 linkach

**Limit Obsidian Graph:**
- Teoretyczny max: ~2000 połączeń
- Praktyczny komfort: 500-800 połączeń
- Twoje repo: **15000+ połączeń** ❌


## ✅ Rozwiązania

### 1️⃣ **Waypoint - Limit plików**

Zmieniono w `.obsidian/plugins/waypoint/data.json`:
```json
"maxFiles": 30,    // było 1000
"maxDepth": 3      // było 5
```

**Efekt:** Waypoint skanuje max 30 plików na folder (zamiast 1000)


### 2️⃣ **Graph - Filtrowanie**

Użyj **Graph Search** w Obsidian:

```
# Pokaż tylko Core
path:core

# Pokaż tylko user profile
path:jakubc OR path:karinam

# Bez orphans
-tag:#orphan

# Tylko główne indexy
file:(INDEX OR eww OR core OR business)
```


### 3️⃣ **Local Graph zamiast Global**

- **Ctrl+Shift+G** w notatce = lokalny graph (1-2 poziomy)
- Szybszy, bardziej użyteczny
- Pokaże tylko powiązania danego pliku


### 4️⃣ **Grupy kolorów** (już skonfigurowane)

W `.obsidian/graph-optimization.json`:
- 🎀 **Różowy:** karinam (candy/pink)
- 🔵 **Cyan:** jakubc (owner)
- 🔴 **Czerwony:** core


## 🎯 Najlepsza strategia

**NIE używaj Global Graph dla całego repo!**

Zamiast tego:
1. **Local Graph** dla konkretnych plików
2. **Folder notes** jako mini-indexy
3. **Filtrowane wyszukiwania** w graph
4. **Dataview queries** dla przeglądu


## 📊 Statystyki

- Pliki: **481 MD**
- Średnio linków/plik: **~30**
- Całkowite połączenia: **~15000** 
- Limit graph: **~1200** ❌

**Waypoint działa OK** ✅  
**Graph wymaga filtrowania** ⚠️


## 🔗 Źródła

- [[GRAPH-SETUP]]
- [[GRAPH-READY]]
- [[install-waypoint]]
