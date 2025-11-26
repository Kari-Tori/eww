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
title: "🎨 Graph Setup Guide - Kompleksowa Konfiguracja"






owner: jakubc
---

# 🎨 Graph Setup Guide - Kompleksowa Konfiguracja

## 🚀 Quick Start (3 kroki)

### 1️⃣ Zainstaluj pluginy
```bash
cd /home/jakubc/git/eww
./tools/install-graph-plugins.sh
```

### 2️⃣ Skopiuj konfigurację
```bash
# Kolory grafu już są w:
# .obsidian/graph-colors.json

# Importuj w Obsidian:
# Settings → Graph view → Import
```

### 3️⃣ Włącz pluginy
- **Ctrl+,** (Settings)
- **Community plugins** → Włącz:
  - ✅ Graph Analysis
  - ✅ Extended Graph
  - ✅ Breadcrumbs
  - ✅ Journey
  - ✅ Strange New Worlds
  - ✅ Excalidraw


## 🎯 Mapowanie kolorów (kolory tagów)

| Tag | Kolor | RGB | Znaczenie |
|-----|-------|-----|-----------|
| `#jakubc` | 🔵 Niebieski | `#3498db` | Notatki jakubc |
| `#karinam` / `#candy` | 💗 Różowy | `#f472b6` | Notatki Kariny |
| `#business` | 🟣 Fioletowy | `#8b5cf6` | Business/finanse |
| `#technical` / `#tools` | 🟦 Cyan | `#06b6d4` | Techniczne/narzędzia |
| `#documentation` | 🟢 Zielony | `#10b981` | Dokumentacja |
| `#ai` / `#automation` | 🟠 Pomarańczowy | `#f59e0b` | AI i automatyzacja |
| `#obsidian` / `#graph` | 🟪 Purpurowy | `#7c3aed` | Meta-obsidian |


## 🔧 Konfiguracja zaawansowana

### Graph Analysis

**Settings → Graph Analysis:**
- ✅ Enable clustering
- ✅ Show communities
- ✅ Calculate centrality
- Hub threshold: `5` (ważne node'y z 5+ linkami)

### Extended Graph

**Filtry:**
```
# Pokaż tylko notatki z tagiem business
tag:#business

# Ukryj folder Templates
-path:Templates/

# Pokaż tylko karinam
tag:#karinam OR tag:#candy

# Techniczne bez drafts
tag:#technical -tag:#draft
```

### Breadcrumbs

**Settings → Breadcrumbs:**
- ✅ Show in graph
- ✅ Implied relationships
- Parent field: `parent`
- Child field: `child`

**Przykład hierarchii w YAML:**
```yaml
parent: [[Business Overview]]
child:
  - [[Project A]]
  - [[Project B]]
```

### Journey

**Skróty klawiaturowe:**
- `Ctrl+Shift+J` - Find path between notes
- Automatycznie podświetla ścieżkę w grafie


## 📊 Best Practices - Wizualizacja

### 1. Używaj spójnych tagów
```yaml
  - jakubc          # autor
  - business        # kategoria
  - technical       # typ
  - active          # status
```

### 2. Twórz MOC (Maps of Content)
```markdown
# Business MOC

## Główne obszary
- [[Finance]]
- [[Projects]]
- [[Clients]]

## Aktywne projekty
![[Active Projects]]
```

### 3. Linkuj kontekstowo
```markdown
# ❌ ZŁE
Zobacz [[Project A]]

# ✅ DOBRE  
Projekt [[Project A|A]] wykorzystuje [[Technology Stack|stos]] z [[2024 Q1]].
```

### 4. Folder notes z Waypoint
Waypoint **automatycznie** tworzy:
```markdown
# 📁 business

## Zawartość
%% Begin Waypoint %%
- [[Finance Report 2024]]
- [[Client Meetings]]
- [[Budget Q1]]
%% End Waypoint %%
```


## 🎨 Customizacja wyglądu

### CSS Snippets (`.obsidian/snippets/graph-style.css`)
```css
/* Większe node'y dla MOC */
.graph-view.color-fill[data-tag*="moc"] {
  r: 8 !important;
}

/* Pogrubione linki dla parent-child */
.graph-view.color-line[data-link-type="parent"],
.graph-view.color-line[data-link-type="child"] {
  stroke-width: 2 !important;
}

/* Pulsujące aktywne projekty */
.graph-view.color-fill[data-tag*="active"] {
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.6; }
}
```


## 🐛 Troubleshooting

### Graf jest wolny
1. **Settings → Graph** → Decrease particles
2. Ogranicz depth: `2-3 levels`
3. Użyj filtrów: `-tag:#archive`

### Pluginy nie działają
```bash
# Sprawdź instalację
ls -la .obsidian/plugins/

# Przeładuj Obsidian
Ctrl+R
```

### Brak kolorów
1. **Settings → Graph** → Color groups
2. Import: `.obsidian/graph-colors.json`
3. Sprawdź tagi w YAML frontmatter


## 📚 Źródła

- [[Obsidian Graph Plugins]]
- [[tools/install-graph-plugins.sh]]
- [Graph Analysis Docs](https://github.com/SkepticMystic/graph-analysis)
- [Breadcrumbs Wiki](https://github.com/SkepticMystic/breadcrumbs)

## 🔗 Backlinki

```dataview
LIST 
FROM [[]]
WHERE file.name != this.file.name
SORT file.mtime DESC
```


**Ostatnia aktualizacja:** 2025-11-21  
**Autor:** jakubc  
**Status:** ✅ Production ready
