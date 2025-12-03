---
version: 0.0.1
title: "dataview"
created: 2025-11-29
modified: 2025-11-29
tags:
  - auto-versioned
---

# Obsidian — plugin Dataview

- Repo/plugin: https://github.com/blacksmithgu/obsidian-dataview
- Dokumentacja: https://blacksmithgu.github.io/obsidian-dataview/
- Cel: zapytania nad notatkami (YAML + treść) w tabelach/listach/kartach; używane do dashboardów TODO.

### Przykład tabeli TODO
```dataview
TABLE priority, status, deadline
FROM "usr/jakubc/todo"
WHERE !completed AND priority = "P1"
SORT deadline ASC
```

## 🔗 Backlinks

- [[INDEX]]
- [[docs]]
- [[README]]