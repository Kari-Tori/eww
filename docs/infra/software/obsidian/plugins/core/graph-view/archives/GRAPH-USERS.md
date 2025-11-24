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
title: "🔵🩷 GRAPH: User Profiles"









owner: jakubc
---

# 🔵🩷 GRAPH: User Profiles

> **Graf wizualizujący profile użytkowników i ich aktywności**

## 📊 Ustawienia grafu

```dataview
TABLE file.folder as Folder, length(file.outlinks) as "Outlinks", length(file.inlinks) as "Backlinks"
FROM "usr"
WHERE file.name != "usr"
SORT length(file.outlinks) DESC
```

## 🎯 Filtr Graph View

Kliknij **Open Graph View** i ustaw:

```
path:usr/jakubc OR path:usr/karinam -path:var/log
```

**Kolory**:
- 🔵 Cyan (`#owner #eww`) - jakubc
- 🩷 Pink (`#candy #pink`) - karinam

## 👥 Profile użytkowników

%% Begin Waypoint %%
- **[[usr/jakubc/jakubc]]** - 🔵 Owner & Developer
- **[[usr/karinam/karinam]]** - 🩷 Candy Developer

%% End Waypoint %%

## 🔗 Główne połączenia

### jakubc 🔵
- [[core]] → owns core components
- [[business]] → business logic
- [[config]] → system configuration

### karinam 🩷
- [[usr/karinam/projects]] → personal projects
- [[usr/karinam/notes]] → development notes

## 📈 Statystyki

- **Użytkowników**: 2
- **Notatek**: ~100-150
- **Max depth**: 3 levels
- **Rendering**: < 1s


**Instrukcja**: Pin i otwórz Graph View → zobacz aktywności użytkowników! 👥
