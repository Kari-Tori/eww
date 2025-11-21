---
tags:
  - graph
  - core
  - visualization
  - red
created: 2025-11-21
author: jakubc
cssclasses:
  - graph-view
---

# 🔴 GRAPH: Core Components

> **Graf wizualizujący komponenty core systemu EWW**

## 📊 Ustawienia grafu

```dataview
TABLE file.folder as Folder, length(file.outlinks) as "Outlinks", length(file.inlinks) as "Backlinks"
FROM "core"
WHERE file.name != "core"
SORT length(file.outlinks) DESC
LIMIT 50
```

## 🎯 Filtr Graph View

Kliknij **Open Graph View** i ustaw:

```
path:core -path:archive -path:var/log
```

**Kolor**: 🔴 Czerwony (`#core`)

## 📁 Zawartość core/

%% Begin Waypoint %%
- **[[core]]** - Folder note
- [[core-resources]]
- [[project-config]]
- [[system-setup]]

%% End Waypoint %%

## 🔗 Główne połączenia

- [[jakubc]] → właściciel core
- [[business]] → konsumuje core resources
- [[config]] → konfiguracja core

## 📈 Statystyki

- **Notatek**: ~50-80
- **Max depth**: 3 levels
- **Rendering**: < 1s

---

**Instrukcja**: Pin ten plik i otwórz Graph View → szybka nawigacja po core! 🚀
