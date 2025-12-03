---
version: 0.0.4
tags:
  - #automation
  - #development
  - #eww
  - #graph
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21
modified: 2025-11-28
author: jakubc
title: "🟡 GRAPH: Business Layer"






owner: jakubc
---

# 🟡 GRAPH: Business Layer

> **Graf wizualizujący warstwę biznesową projektu**

## 📊 Ustawienia grafu

```dataview
TABLE file.folder as Folder, length(file.outlinks) as "Outlinks", length(file.inlinks) as "Backlinks"
FROM "business"
WHERE file.name != "business"
SORT length(file.outlinks) DESC
LIMIT 50
```

## 🎯 Filtr Graph View

Kliknij **Open Graph View** i ustaw:

```
path:business -path:archive -path:var/log
```

**Kolor**: 🟡 Żółty (`#business`)

## 📁 Zawartość business/

%% Begin Waypoint %%
- **[[business]]** - Folder note
- [[business-logic]]
- [[workflows]]
- [[processes]]

%% End Waypoint %%

## 🔗 Główne połączenia

- [[core]] → wykorzystuje core components
- [[jakubc]] → business owner
- [[docs]] → dokumentacja procesów

## 📈 Statystyki

- **Notatek**: ~40-60
- **Max depth**: 2 levels
- **Rendering**: < 1s


**Instrukcja**: Pin i otwórz Graph View → przegląd logiki biznesowej! 💼

## 🔗 Backlinks

- [[INDEX]]
- [[README]]
- [[docs]]