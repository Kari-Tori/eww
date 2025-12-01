---
title: Rekomendowane rozszerzenia VS Code dla projektu eww
created: 2025-12-01
modified: 2025-12-01
author: AI Assistant
category: documentation
tags:
  - vscode
  - extensions
  - tools
  - development
version: 0.0.0.5
---

# Rekomendowane rozszerzenia VS Code dla projektu eww

## ✅ Zainstalowane rozszerzenia kluczowe (już masz!)

### AI & Productivity
- ✅ `github.copilot` - GitHub Copilot (główny AI assistant)
- ✅ `github.copilot-chat` - Copilot Chat
- ✅ `continue.continue` - Continue.dev (MCP support)
- ✅ `codeium.codeium` - Codeium (darmowy AI autocomplete)

### Bash/Shell Development
- ✅ `foxundermoon.shell-format` - formatowanie shell scripts
- ✅ `timonwong.shellcheck` - linting Bash
- ✅ `mads-hartmann.bash-ide-vscode` - Bash Language Server
- ✅ `rogalmic.bash-debug` - debugger Bash
- ✅ `shakram02.bash-beautify` - beautifier Bash
- ✅ `remisa.shellman` - snippety Bash

### Markdown & Documentation
- ✅ `yzhang.markdown-all-in-one` - wszystko dla Markdown
- ✅ `davidanson.vscode-markdownlint` - linting Markdown
- ✅ `shd101wyy.markdown-preview-enhanced` - enhanced preview
- ✅ `bierner.markdown-emoji` - emoji w Markdown
- ✅ `willasm.obsidian-md-vsc` - integracja z Obsidian

### Git & Version Control
- ✅ `eamodio.gitlens` - GitLens (zaawansowany Git)
- ✅ `donjayamanne.githistory` - historia Git
- ✅ `mhutchie.git-graph` - graf Git
- ✅ `github.vscode-pull-request-github` - GitHub PR
- ✅ `github.vscode-github-actions` - GitHub Actions

### Docker & Containers
- ✅ `ms-azuretools.vscode-docker` - Docker support

### Code Quality
- ✅ `sonarsource.sonarlint-vscode` - SonarLint
- ✅ `ryanluker.vscode-coverage-gutters` - Coverage Gutters

### Utilities
- ✅ `formulahendry.code-runner` - Code Runner
- ✅ `esbenp.prettier-vscode` - Prettier formatter
- ✅ `redhat.vscode-yaml` - YAML support

### Python (dla skryptów)
- ✅ `ms-python.python` - Python support

## 📦 Rekomendowane do zainstalowania (opcjonalne)

### Dodatkowe AI Assistants
- `saoudrizwan.claude-dev` - Cline (Claude-based coding agent)
- `rooveterinaryinc.roo-cline` - Roo Code (team of AI agents)
- `anthropic.claude-code` - Claude Code official
- `tabnine.tabnine-vscode` - Tabnine AI

### Kubernetes (jeśli planujesz)
- `ms-kubernetes-tools.vscode-kubernetes-tools` - Kubernetes support
- `ms-vscode-remote.remote-containers` - Dev Containers

### Dodatkowa jakość kodu
- `snyk-security.snyk-vulnerability-scanner` - Snyk Security
- `trunk.io` - Trunk Code Quality
- `markis.code-coverage` - Code Coverage dodatkowe

### REST API Testing
- `rangav.vscode-thunder-client` - Thunder Client (Postman alternative)
- `humao.rest-client` - REST Client

### Testy
- `hbenl.vscode-test-explorer` - Test Explorer UI

## 🎯 Najlepsze kombinacje dla eww

### Minimalna konfiguracja (już masz!)
```
github.copilot + github.copilot-chat + continue.continue
foxundermoon.shell-format + timonwong.shellcheck
eamodio.gitlens + mhutchie.git-graph
yzhang.markdown-all-in-one
```

### Full Stack (do rozważenia)
```
+ ms-azuretools.vscode-docker
+ ms-kubernetes-tools.vscode-kubernetes-tools  
+ sonarsource.sonarlint-vscode
+ rangav.vscode-thunder-client
```

### AI Powerhouse (max AI assistance)
```
+ codeium.codeium (już jest)
+ saoudrizwan.claude-dev
+ tabnine.tabnine-vscode
```

## 🛠️ Instalacja

### Pojedyncze rozszerzenie
```bash
code --install-extension <extension-id>
```

### Z pliku (recommended extensions)
1. Utwórz `.vscode/extensions.json`
2. Dodaj listę rekomendacji
3. VS Code automatycznie zaproponuje instalację

### Przykład `.vscode/extensions.json`:
```json
{
  "recommendations": [
    "github.copilot",
    "github.copilot-chat",
    "continue.continue",
    "foxundermoon.shell-format",
    "timonwong.shellcheck",
    "eamodio.gitlens",
    "ms-azuretools.vscode-docker",
    "sonarsource.sonarlint-vscode"
  ]
}
```

## 📊 Statystyki

**Łącznie zainstalowanych:** 91 rozszerzeń
**Kategorie:**
- AI & Chat: 4
- Bash/Shell: 6
- Markdown: 5
- Git: 5
- Quality: 2
- Docker: 1
- Python: 1
- Utilities: 67+ (pozostałe)

## �� Aktualizacja

```bash
# Aktualizuj wszystkie rozszerzenia
code --update-extensions

# Lista zainstalowanych
code --list-extensions

# Eksport do pliku
code --list-extensions > my-extensions.txt
```

---

**Ostatnia aktualizacja:** 2025-12-01
**Status:** ✅ Kluczowe narzędzia zainstalowane i skonfigurowane
