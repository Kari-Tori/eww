---
version: 0.0.4
modified: 2025-11-28
tags:
  - #automation
  - #eww
  - #graph
  - #knowledge
  - #linux
  - #obsidian
  - #secondbrain
title: Graph Render Engine - Fix Performance
created: 2025-11-21
author: jakubc






owner: jakubc
---

# 🎨 Graph Render Engine - Optymalizacja

## ❌ Problem
**"Too many to handle"** - Graph nie renderuje się z 482 plikami MD

## 🔍 Diagnoza
1. **18 pluginów aktywnych** (limit ~20)
2. **5 graph plugins konfliktują:**
   - `graph-analysis`
   - `obsidian-living-graph`
   - `extended-graph`
   - `graph-nested-tags`
   - `graph-banner`
   - `juggl` (alternatywny engine!)

3. **Problemy wydajnościowe:**
   - Za dużo węzłów (482 pliki)
   - Wszystkie tagi widoczne
   - Orphans pokazywane
   - Attachments w grafie

## ✅ Rozwiązanie

### 1. **Wyłącz konfliktujące pluginy**
Zostaw tylko JEDEN graph plugin:
```bash
# Wyłącz w community-plugins.json:
- obsidian-living-graph (redundant)
- graph-banner (kosmetyczny)
- graph-nested-tags (powolny)

# ZOSTAW:
- extended-graph (najlepszy)
- juggl (dla 3D view - opcjonalnie)
```

### 2. **Optymalizuj graph.json**
```json
{
  "search": "-path:archive -path:Tags -path:.obsidian",
  "showTags": false,
  "showAttachments": false,
  "hideUnresolved": true,
  "showOrphans": false,
  "showArrow": false,
  "textFadeMultiplier": -1,
  "nodeSizeMultiplier": 0.8,
  "repelStrength": 15,
  "linkStrength": 0.5
}
```

### 3. **Użyj Local Graph zamiast Global**
- Ctrl+Click na notce → Open Local Graph
- Depth: 1-2 (nie więcej)
- Szybsze, czytelniejsze

### 4. **Alternatywa: Juggl 3D**
- Lepszy rendering dla dużych vault
- WebGL acceleration
- Command: "Open Juggl view"

## 📊 Oczekiwane rezultaty
- ✅ Graph renderuje <2 sek
- ✅ Smooth navigation
- ✅ 200-300 nodes widocznych (z filtrami)
- ✅ Kolory według tagów/folderów

## 🔗 Źródła
- [[graph-optimization]]
- [[graph.json]]
- [[community-plugins]]

## 🔗 Backlinks

- [[INDEX]]
- [[README]]
- [[docs]]