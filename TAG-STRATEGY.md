---
tags: [meta, strategy, graph, index,main]
author: jakubc
created: 2025-11-21
---

# 🏷️ STRATEGIA TAGOWANIA DLA GRAFU

## Problem: 499 plików → graf nieczytelny

## Rozwiązanie: HIERARCHIA TAGÓW

### Tier 1: HUB (max 10-15 notatek)
```
#hub - główne indexy folderów
#main - kluczowe dokumenty root
```

**Powinny mieć:** INDEX.md, README.md, folder notes głównych katalogów

### Tier 2: INDEX (20-30 notatek)
```
#index - folder notes podfolderów
#core - core workflow files
```

### Tier 3: CONTENT (reszta)
```
#docs, #business, #tools, #config
```
**NIE pokazywane** na głównym grafie (filter)

### Tier 4: EXCLUDED
```
#archive, #log, #temp, #candy (karinam vault)
```
**ZAWSZE filtrowane**

## Graf Filter
```
-path:archive/ -path:var/log/ -path:karinam/ -path:.obsidian/
tag:#hub OR tag:#main OR tag:#index
```

## TODO
1. Oznaczyć 12 plików root jako #main
2. Oznaczyć folder notes jako #hub lub #index
3. Przetagować resztę (tier 3/4)
