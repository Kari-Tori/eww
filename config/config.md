---
title: ⚙️ Configuration
type: folder-note
status: active
tags:
  - hub
  - config
  - settings
  - eww
  - infra
author: jakubc
created: 2025-11-21
updated: 2025-11-21
---

# ⚙️ Configuration

> **Pliki konfiguracyjne i ustawienia projektu EWW**

## 📋 Przeznaczenie Folderu

Centralny folder dla wszystkich plików konfiguracyjnych projektu.

## 📑 Zawartość Folderu

### 🔧 Pliki Konfiguracyjne (Root)
- [[.gitignore|📝 .gitignore]] - Ignorowane pliki Git
- [[.editorconfig|✏️ .editorconfig]] - Ustawienia edytora
- [[.gitattributes|🔖 .gitattributes]] - Atrybuty Git

### 💎 Obsidian Config
- [[.obsidian/graph.json|🎨 Graph Config]] - Konfiguracja grafu
- [[.obsidian/appearance.json|🎨 Appearance]] - Wygląd Obsidian
- [[.obsidian/workspace.json|🪟 Workspace]] - Layout workspace

### 🐙 GitHub Config
- [[.github/copilot-instructions.md|🤖 Copilot]] - Instrukcje dla Copilot
- [[.github/workflows/|⚙️ Workflows]] - GitHub Actions

### 🔨 Narzędzia Dev
- [[.vscode/|📝 VSCode]] - Ustawienia VSCode
- [[.makemd/|📋 MakeMD]] - Konfiguracja MakeMD

## 🔗 Powiązania

**Z główną mapą**: [[EWW-MAP|🗺️ Repository Map]]  
**Z dokumentacją**: [[docs/docs|📚 Docs]]  
**Z infrastrukturą**: [[infra/infra|🏗️ Infra]]

## 📊 Struktura

```
config/
├── .gitignore          # Git ignore rules
├── .editorconfig       # Editor settings
├── .gitattributes      # Git attributes
├── .obsidian/          # Obsidian vault config
│   ├── graph.json      # Graph colors & settings
│   ├── appearance.json # Theme & appearance
│   └── workspace.json  # Layout configuration
├── .github/            # GitHub specific
│   ├── copilot-instructions.md
│   └── workflows/
└── .vscode/            # VSCode settings
```

## 🎨 Oznaczenie Grafu

**Tag**: `#config`  
**Kolor**: 🟠 Pomarańczowy  
**Widoczność**: Średnia (konfiguracja)

---

**Lokalizacja**: `/config/`  
**Ostatnia aktualizacja**: 2025-11-21  
**Autor**: [[usr/jakubc/jakubc|Jakub C]]

#config #settings #eww #infra
