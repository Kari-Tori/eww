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
title: "�� Graph Optimization Strategy"






owner: jakubc
---

# �� Graph Optimization Strategy

## 🎯 Problem
- **490 plików** markdown w repozytorium
- Graph engine się wykrzacza przy >1200 połączeniach
- Waypoint generuje zbyt wiele auto-linków

## ✅ Rozwiązania Zastosowane

### 1. Graph Configuration
**Lokalizacja**: `.obsidian/graph.json`

```json
{
  "maxNodes": 5000,          // Max dla Obsidian (hardcoded)
  "linkDistance": 250,       // Większy odstęp = mniej nakładania
  "repelStrength": 12,       // Węzły się odpychają
  "centerStrength": 0.5,     // Balans centrum
  "showArrow": true,         // Kierunek linków
  "textFadeMultiplier": 0    // Tekst zawsze widoczny
}
```

### 2. Waypoint Limits
**Lokalizacja**: `.obsidian/plugins/waypoint/data.json`

```json
{
  "maxFiles": 20,            // Max 20 plików na folder note
  "maxDepth": 2,             // Max 2 poziomy głębokości
  "stopScanAtFolderNotes": true
}
```

**Efekt**: 
- Było: 30 files × 3 depth × ~30 folders = ~2700 linków 
- Jest: 20 files × 2 depth × ~30 folders = ~1200 linków ✅

### 3. Local Graph View
**Lokalizacja**: `.obsidian/graph-local.json`

Optymalizowany widok dla **konkretnych ścieżek**:
```json
{
  "search": "path:jakubc OR path:karinam OR path:business",
  "maxNodes": 500,           // Mniejszy subset
  "linkDistance": 300        // Większa przestrzeń
}
```

### 4. Git Versioning
**Plugin**: Obsidian Git (już zainstalowany)

**Config**: Auto-commit co 10 minut
```json
{
  "autoSaveInterval": 10,
  "autoPushInterval": 10,
  "pullBeforePush": true
}
```

## 🚀 Użycie

### Full Graph (wolny, ale kompletny)
1. Otwórz **Graph View** (Ctrl+G)
2. Poczekaj ~30 sek na render
3. Użyj filtrów z `graph.json`

### Local Graph (szybki)
1. Kliknij prawym na notkę → **Open local graph**
2. Lub użyj custom view z `graph-local.json`

### Obsidian Git
- **Auto**: Commituje co 10 min automatycznie
- **Manual**: `Ctrl+P` → "Obsidian Git: Commit"
- **Status**: Pasek statusu pokazuje branch i zmiany

## 📈 Metryki

| Parametr | Przed | Po | Zmiana |
|----------|-------|----|----|
| Pliki MD | 490 | 490 | - |
| Auto-linki | ~2700 | ~1200 | -55% |
| Render time | timeout | ~30s | ✅ |
| Max nodes | 5000 | 5000 | - |
| Waypoint depth | 3 | 2 | -33% |

## 🔗 Źródła
- [[graph.json]] - główna konfiguracja
- [[graph-local.json]] - lokalny widok
- [[waypoint/data.json]] - limity Waypoint
- [[obsidian-git]] - wersjonowanie

## 📝 Notatki
- **5000 nodes** to hardcoded max w Obsidian (nie da się zwiększyć)
- **Local graph** zawsze szybszy niż full graph
- **Waypoint** można wyłączyć dla konkretnych folderów (`.nowaypoint`)
- **Git** działa lokalnie, nie wymaga chmury

**Status**: ✅ Zoptymalizowane
**Ostatnia aktualizacja**: 2025-11-21

## 🔗 Backlinks

- [[INDEX]]
- [[README]]
- [[docs]]