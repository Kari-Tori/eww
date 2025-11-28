created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---
title: Status rozszerzeń VS Code
description: Porównanie zalecanych rozszerzeń z zainstalowanymi lokalnie
version: 1.0.0
updated: 2025-11-24
tags:
  - vscode
  - extensions
  - status
  - audit
created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

# Status rozszerzeń VS Code — Audit instalacji

## 📊 Podsumowanie

| Kategoria | Liczba |
|-----------|--------|
| **Zainstalowane** | 58 |
| **Zalecane** | 23 |
| **Zainstalowane + Zalecane** | 13 ✅ |
| **Do zainstalowania** | 10 ⚠️ |
| **Nadmiarowe** | 45 |

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## ✅ Zainstalowane I zalecane (13)

| Rozszerzenie | Kategoria | Opis |
|--------------|-----------|------|
| `aaron-bond.better-comments` | 📝 Markdown | Semantyczne komentarze |
| `bierner.markdown-emoji` | 😀 Emoji | Emoji w Markdown |
| `bierner.markdown-mermaid` | 📊 Diagramy | Mermaid preview |
| `bierner.markdown-yaml-preamble` | 🏷️ YAML | Frontmatter w preview |
| `bpruitt-goddard.mermaid-markdown-syntax-highlighting` | 📊 Diagramy | Syntax highlighting Mermaid |
| `foam.foam-vscode` | 🔗 Obsidian | Wiki-links, backlinks, graph |
| `github.copilot-chat` | 🤖 AI | GitHub Copilot Chat |
| `kortina.vscode-markdown-notes` | 🔗 Obsidian | Wiki-links navigation |
| `redhat.vscode-yaml` | 🏷️ YAML | YAML validation |
| `shd101wyy.markdown-preview-enhanced` | 📝 Markdown | Advanced preview |
| `yzhang.markdown-all-in-one` | 📝 Markdown | Markdown essentials |
| `github.copilot` | 🤖 AI | (domyślnie z copilot-chat) |
| `timonwong.shellcheck` | 🐚 Bash | (bonus: Bash linting) |

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## ⚠️ Zalecane ale NIE zainstalowane (10)

### Must-Have do instalacji

| Rozszerzenie | Kategoria | Priorytet | Dlaczego ważne |
|--------------|-----------|-----------|----------------|
| `eliostruyf.vscode-front-matter` | 🏷️ YAML | 🔴 HIGH | CMS w VS Code, AI integration frontmatter |
| `jebbs.plantuml` | 📊 Diagramy | 🔴 HIGH | UML diagramy (architektura) |
| `hediet.vscode-drawio` | 📊 Diagramy | 🟡 MEDIUM | Draw.io integration |
| `tendoualice.markdown-obsidian-callout` | 📝 Obsidian | 🟡 MEDIUM | Callouts w preview |
| `willasm.obsidian-md-vsc` | 🔗 Obsidian | 🟡 MEDIUM | Direct Obsidian sync |
| `tintinweb.graphviz-interactive-preview` | 📊 Diagramy | 🟢 LOW | Graphviz DOT |
| `vstirbu.vscode-mermaid-preview` | 📊 Diagramy | 🟢 LOW | Dedykowany Mermaid preview |
| `perkovec.emoji` | 😀 Emoji | 🟢 LOW | Emoji picker |
| `yzane.markdown-pdf` | 📝 Markdown | 🟢 LOW | Export do PDF |
| `tomasdahlqvist.markdown-admonitions` | 📝 Markdown | 🟢 LOW | Admonitions (callouts alternatywne) |

### Skrypt instalacyjny

```bash
#!/usr/bin/env bash
# Instalacja zalecanych rozszerzeń VS Code (brakujące)

set -euo pipefail

readonly EXTENSIONS=(
  # HIGH priority
  "eliostruyf.vscode-front-matter"
  "jebbs.plantuml"
  
  # MEDIUM priority
  "hediet.vscode-drawio"
  "tendoualice.markdown-obsidian-callout"
  "willasm.obsidian-md-vsc"
  
  # LOW priority (opcjonalne)
  "tintinweb.graphviz-interactive-preview"
  "vstirbu.vscode-mermaid-preview"
  "perkovec.emoji"
  "yzane.markdown-pdf"
  "tomasdahlqvist.markdown-admonitions"
)

for ext in "${EXTENSIONS[@]}"; do
  echo "Installing $ext..."
  code --install-extension "$ext" || true
done

echo "✅ Instalacja zakończona!"
```

**Uruchomienie:**
```bash
bash scripts/install-missing-vscode-extensions.sh
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 📦 Zainstalowane ale NIE zalecane (45)

### Kategoria: Bash/Shell (6) ✅ KEEP
- `foxundermoon.shell-format` — shfmt formatter
- `mads-hartmann.bash-ide-vscode` — Bash IDE features
- `remisa.shellman` — Bash snippets
- `rogalmic.bash-debug` — Debugging Bash
- `shakram02.bash-beautify` — Beautify scripts
- `timonwong.shellcheck` — Linting ✅

**Rekomendacja:** Zachować — projekt bazuje na Bash

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### Kategoria: Git (3) ✅ KEEP
- `donjayamanne.githistory` — Git history view
- `github.vscode-pull-request-github` — GitHub PR integration
- `vivaxy.vscode-conventional-commits` — Conventional commits helper

**Rekomendacja:** Zachować — workflow Git

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### Kategoria: Python (4) ✅ KEEP
- `ms-python.debugpy` — Python debugger
- `ms-python.python` — Python extension
- `ms-python.vscode-pylance` — Python language server
- `ms-python.vscode-python-envs` — Python environments

**Rekomendacja:** Zachować — używane w projekcie

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### Kategoria: Remote/SSH (3) ✅ KEEP
- `ms-vscode-remote.remote-ssh` — SSH remote development
- `ms-vscode-remote.remote-ssh-edit` — SSH config editing
- `ms-vscode.remote-explorer` — Remote explorer

**Rekomendacja:** Zachować — praca zdalna

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### Kategoria: C/C++ (4) ⚠️ OPTIONAL
- `ms-vscode.cmake-tools` — CMake support
- `ms-vscode.cpptools` — C/C++ IntelliSense
- `ms-vscode.cpptools-extension-pack` — C/C++ pack
- `ms-vscode.cpptools-themes` — C/C++ themes

**Rekomendacja:** Zachować jeśli pracujesz z C/C++, usuń jeśli nie

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### Kategoria: Markdown — Duplikaty (8) ⚠️ REVIEW
- `bierner.github-markdown-preview` — GitHub preview
- `bierner.markdown-checkbox` — Checkbox support
- `bierner.markdown-footnotes` — Przypisy
- `bierner.markdown-shiki` — Syntax highlighting
- `bierner.markdown-preview-github-styles` — GitHub styles
- `davidanson.vscode-markdownlint` — Markdownlint
- `github.github-vscode-theme` — GitHub theme
- `ms-vscode.theme-markdownkit` — Markdown theme

**Rekomendacja:** 
- **KEEP:** `davidanson.vscode-markdownlint` (linting)
- **KEEP:** `bierner.github-markdown-preview` (GitHub compatibility)
- **REVIEW:** Reszta — duplikaty funkcji z `markdown-all-in-one`

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### Kategoria: Productivity (7) ✅ KEEP/REVIEW
- `christian-kohler.path-intellisense` — Path autocomplete ✅
- `editorconfig.editorconfig` — EditorConfig support ✅
- `esbenp.prettier-vscode` — Prettier formatter ✅
- `gruntfuggly.todo-tree` — TODO highlighting ✅
- `mechatroner.rainbow-csv` — CSV colors ✅
- `oderwat.indent-rainbow` — Indent visualization ⚠️
- `usernamehw.errorlens` — Error lens ✅

**Rekomendacja:** Zachować większość, `indent-rainbow` opcjonalny

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### Kategoria: AI (2) ✅ KEEP
- `mintlify.document` — AI documentation generator
- `openai.chatgpt` — ChatGPT integration

**Rekomendacja:** Zachować — AI workflow

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### Kategoria: Inne (8) ✅ KEEP/REVIEW
- `github.vscode-github-actions` — GitHub Actions support ✅
- `ms-ceintl.vscode-language-pack-pl` — Polski language pack ✅
- `ms-vscode.makefile-tools` — Makefile support ✅
- `obkoro1.korofileheader` — File header generator ⚠️
- `pkief.material-icon-theme` — Material icons ✅
- `streetsidesoftware.code-spell-checker` — Spell checker ✅
- `streetsidesoftware.code-spell-checker-polish` — Polski słownik ✅
- `vscodevim.vim` — Vim emulation ⚠️ (jeśli używasz)

**Rekomendacja:** Zachować większość

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🎯 Zalecenia akcji

### 1. Zainstaluj brakujące (HIGH priority)
```bash
code --install-extension eliostruyf.vscode-front-matter
code --install-extension jebbs.plantuml
code --install-extension hediet.vscode-drawio
code --install-extension tendoualice.markdown-obsidian-callout
code --install-extension willasm.obsidian-md-vsc
```

### 2. Review duplikatów Markdown
Rozważ usunięcie:
- `bierner.markdown-checkbox` (funkcja w `markdown-all-in-one`)
- `bierner.markdown-footnotes` (rzadko używane)
- `bierner.markdown-shiki` (duplikat syntax highlighting)

### 3. Usuń nieużywane C/C++ (jeśli nie pracujesz z C++)
```bash
code --uninstall-extension ms-vscode.cmake-tools
code --uninstall-extension ms-vscode.cpptools
code --uninstall-extension ms-vscode.cpptools-extension-pack
code --uninstall-extension ms-vscode.cpptools-themes
```

### 4. Zachowaj projekt-specific
- Bash/Shell (6 rozszerzeń) ✅
- Git (3 rozszerzenia) ✅
- Python (4 rozszerzenia) ✅
- Remote SSH (3 rozszerzenia) ✅

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 📈 Metryki

### Kategorie zainstalowanych rozszerzeń

| Kategoria | Liczba | % |
|-----------|--------|---|
| Markdown/Obsidian | 14 | 24% |
| Bash/Shell | 6 | 10% |
| Git | 3 | 5% |
| Python | 4 | 7% |
| AI | 4 | 7% |
| Remote/SSH | 3 | 5% |
| C/C++ | 4 | 7% |
| Productivity | 7 | 12% |
| Themes | 3 | 5% |
| Inne | 10 | 17% |

### Top 5 "must-have" brakujących

1. **Front Matter CMS** — AI-powered frontmatter management
2. **PlantUML** — UML diagrams (architektura)
3. **Obsidian Callout** — Callouts w preview
4. **Draw.io** — Diagramy wizualne
5. **Obsidian MD VSC** — Direct sync z Obsidian

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🔄 Historia auditu

**2025-11-24:** Pierwszy audit
- 58 zainstalowanych rozszerzeń
- 23 zalecane w dokumentacji
- 13 wspólnych (overlap 56%)
- 10 do zainstalowania
- Identyfikacja duplikatów i nieużywanych

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 📖 Powiązane dokumenty

- [code-plugins.md](./code-plugins.md) — Pełna lista zalecanych
- [README.md](./README.md) — Główna dokumentacja VS Code

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🤝 Następne kroki

1. ✅ Przejrzyj listę brakujących
2. ⚠️ Zainstaluj HIGH priority (Front Matter, PlantUML)
3. 🔍 Review duplikatów Markdown
4. 🗑️ Usuń nieużywane C/C++ (jeśli nie pracujesz z C++)
5. 📝 Aktualizuj ten dokument po zmianach
