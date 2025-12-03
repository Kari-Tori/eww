---
tags:
  - #automation
  - #development
  - #eww
  - #knowledge
  - #linux
  - #obsidian
  - #secondbrain
title: "Obsidian CSS Snippets"
description: "Custom CSS snippets for EWW vault"
category: obsidian
  - obsidian
  - css
  - customization
created: 2025-11-21
updated: 2025-11-21
author: jakubc






owner: jakubc
---

# 🎨 Obsidian CSS Snippets

Custom CSS snippets dla EWW Obsidian vault.

## 📁 Snippets

### graph-colors.css

Kolory dla Graph View - 8 kolorów dla głównych obszarów repo:

- 💖 **Pink** - `#karinam` `#pink` (usr/karinam/)
- 🔵 **Blue** - `#jakubc` `#blue` (usr/jakubc/)
- 📚 **Green** - `#docs` `#documentation` (docs/)
- 💻 **Yellow** - `#development` `#business` `#project` (dev/)
- 🏗️ **Purple** - `#infra` `#devops` (infra/)
- 🔧 **Orange** - `#tools` `#automation` (tools/)
- 📂 **Brown** - `#runtime` `#data` (var/)
- ⚙️ **Gray** - `#config` `#settings` (config/)

## 🔧 Jak używać

1. Otwórz Settings → Appearance → CSS Snippets
2. Włącz `graph-colors`
3. Otwórz Graph View (Ctrl+G)
4. Zobacz kolorowy graf! 🌈

## 📊 Grupy kolorów

Grupy są również skonfigurowane w `.obsidian/graph.json`:

```json
"colorGroups": [
  { "query": "tag:#karinam OR tag:#pink", "color": "pink" },
  { "query": "tag:#jakubc OR tag:#blue", "color": "blue" },
  ...
]
```

## 🎯 Filtry

W Graph View użyj filtrów:

- `tag:#pink` - tylko pliki karinam
- `tag:#blue` - tylko pliki jakubc
- `tag:#docs` - tylko dokumentacja
- `tag:#development` - tylko dev/business

## 🔗 Backlinks

- [[INDEX]]
- [[dev]]
- [[EWW-MAP]]
