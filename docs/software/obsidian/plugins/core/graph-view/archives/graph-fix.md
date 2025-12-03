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
created: 2025-11-21






owner: jakubc
---

# 🔧 FIX GRAFU - Too Many Notes

## Problem
- Obsidian widzi: **15,322 notatki** (limit: 20)
- Rzeczywiste pliki MD: **465**
- Powód: Pluginy generują wirtualne notatki

## Rozwiązanie

### 1. Wyłącz problematyczne pluginy (Settings → Community plugins):
- ❌ **Periodic Notes** (generuje tysiące dat)
- ❌ **Calendar** (tysiące dni)
- ❌ **DataView** (cache queries)
- ❌ **Projects** (wirtualne views)
- ❌ **Living Graph** (duplikuje nodes)

### 2. Zmień filtr grafu:
```
path:core OR path:business OR path:docs OR path:config OR path:infra
```

### 3. Zostaw tylko:
✅ Graph Analysis, Extended Graph, Waypoint, Folder Notes, Icon Folder, File Color

## Test
Po wyłączeniu → Ctrl+G (graf) → sprawdź licznik

## 🔗 Backlinks

- [[INDEX]]
- [[README]]
- [[docs]]