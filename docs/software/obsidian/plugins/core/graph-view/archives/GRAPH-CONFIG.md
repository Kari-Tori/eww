---
version: 0.0.4
tags:
  - #automation
  - #config
  - #eww
  - #graph
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21
modified: 2025-11-28
author: jakubc
title: "🟢 GRAPH: Configuration & Infrastructure"






owner: jakubc
---

# 🟢 GRAPH: Configuration & Infrastructure

> **Graf wizualizujący konfigurację i infrastrukturę systemu**

## 📊 Ustawienia grafu

```dataview
TABLE file.folder as Folder, length(file.outlinks) as "Outlinks", length(file.inlinks) as "Backlinks"
FROM "config" OR "infra"
WHERE file.name != "config" AND file.name != "infra"
SORT length(file.outlinks) DESC
LIMIT 50
```

## 🎯 Filtr Graph View

Kliknij **Open Graph View** i ustaw:

```
path:config OR path:infra -path:archive -path:var/log
```

**Kolor**: 🟢 Zielony (`#config #infra`)

## 📁 Zawartość config/ & infra/

%% Begin Waypoint %%
### config/
- **[[config]]** - Folder note
- [[env-setup]]
- [[system-config]]

### infra/
- **[[infra]]** - Folder note
- [[deployment]]
- [[infrastructure]]

%% End Waypoint %%

## 🔗 Główne połączenia

- [[core]] → core configuration
- [[jakubc]] → infrastructure owner
- [[docs]] → infrastructure docs

## 📈 Statystyki

- **Notatek**: ~30-50
- **Max depth**: 2 levels
- **Rendering**: < 0.5s


**Instrukcja**: Pin i otwórz Graph View → przegląd konfiguracji! ⚙️

## 🔗 Backlinks

- [[INDEX]]
- [[README]]
- [[docs]]