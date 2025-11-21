---
tags:
  - #automation
  - #development
  - #docs
  - #eww
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T15:00:00Z
modified: 2025-11-21T15:00:00Z
author: jakubc
title: "🔌 Pluginy i Rozszerzenia"






---


# 🔌 Pluginy i Rozszerzenia

> **Must-have tools** dla produktywnego developmentu

## 🎨 VS Code Extensions

### 🤖 AI & Code Assistance

| Extension | Opis | Instalacja |
|-----------|------|------------|
| **GitHub Copilot** | AI autocomplete | `code --install-extension GitHub.copilot` |
| **GitHub Copilot Chat** | AI chat w edytorze | `code --install-extension GitHub.copilot-chat` |
| **Continue.dev** | Multi-model AI assistant | `code --install-extension Continue.continue` |
| **TabNine** | AI completion (alternatywa) | `code --install-extension tabnine.tabnine-vscode` |
| **IntelliCode** | Microsoft AI | `code --install-extension visualstudioexptteam.vscodeintellicode` |

### 📝 Markdown & Documentation

| Extension | Opis | Instalacja |
|-----------|------|------------|
| **Markdown All in One** | Wszystko dla MD | `code --install-extension yzhang.markdown-all-in-one` |
| **Markdown Lint** | Linting MD | `code --install-extension davidanson.vscode-markdownlint` |
| **Markdown Mermaid** | Diagramy Mermaid | `code --install-extension bierner.markdown-mermaid` |
| **Markdown PDF** | Export do PDF | `code --install-extension yzane.markdown-pdf` |
| **Obsidian Tools** | Wsparcie Obsidian | `code --install-extension zephraph.vscode-obsidian` |

### 🔧 Git & GitHub

| Extension | Opis | Instalacja |
|-----------|------|------------|
| **GitLens** | Supercharged Git | `code --install-extension eamodio.gitlens` |
| **GitHub Pull Requests** | PR w VS Code | `code --install-extension github.vscode-pull-request-github` |
| **Git History** | Historia commitów | `code --install-extension donjayamanne.githistory` |
| **Git Graph** | Wizualizacja | `code --install-extension mhutchie.git-graph` |
| **Git Blame** | Kto napisał kod | Built-in w GitLens |

### 🎯 Code Quality

| Extension | Opis | Instalacja |
|-----------|------|------------|
| **ESLint** | JavaScript linter | `code --install-extension dbaeumer.vscode-eslint` |
| **Prettier** | Code formatter | `code --install-extension esbenp.prettier-vscode` |
| **ShellCheck** | Bash linter | `code --install-extension timonwong.shellcheck` |
| **Error Lens** | Błędy inline | `code --install-extension usernamehw.errorlens` |
| **SonarLint** | Quality scanner | `code --install-extension sonarsource.sonarlint-vscode` |

### 🐳 DevOps & Infrastructure

| Extension | Opis | Instalacja |
|-----------|------|------------|
| **Docker** | Docker support | `code --install-extension ms-azuretools.vscode-docker` |
| **Kubernetes** | K8s tools | `code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools` |
| **YAML** | YAML support | `code --install-extension redhat.vscode-yaml` |
| **Remote SSH** | Remote dev | `code --install-extension ms-vscode-remote.remote-ssh` |
| **Dev Containers** | Container dev | `code --install-extension ms-vscode-remote.remote-containers` |

### ⚡ Productivity

| Extension | Opis | Instalacja |
|-----------|------|------------|
| **Code Spell Checker** | Sprawdzanie pisowni | `code --install-extension streetsidesoftware.code-spell-checker` |
| **Indent Rainbow** | Kolorowe wcięcia | `code --install-extension oderwat.indent-rainbow` |
| **Bracket Pair Colorizer** | Kolorowe nawiasy | Built-in w VS Code 1.60+ |
| **Material Icon Theme** | Lepsze ikony | `code --install-extension pkief.material-icon-theme` |
| **TODO Highlight** | Highlight TODO | `code --install-extension wayou.vscode-todo-highlight` |

### 📊 Data & Visualization

| Extension | Opis | Instalacja |
|-----------|------|------------|
| **Rainbow CSV** | CSV z kolorami | `code --install-extension mechatroner.rainbow-csv` |
| **Excel Viewer** | Preview Excel | `code --install-extension grapecity.gc-excelviewer` |
| **JSON Tools** | JSON formatter | `code --install-extension eriklynd.json-tools` |
| **REST Client** | HTTP client | `code --install-extension humao.rest-client` |


## 🚀 GitHub CLI Extensions

### Oficjalne

```bash
# GitHub Copilot CLI
gh extension install github/gh-copilot

# GitHub Dash (Dashboard)
gh extension install dlvhdr/gh-dash

# Branch management
gh extension install mislav/gh-branch

# Cleanup merged branches
gh extension install seachicken/gh-poi

# PR checkout
gh extension install github/gh-net  # Networking tools
```

### Community Extensions

```bash
# Tree view
gh extension install dlvhdr/gh-tree

# Repo stats
gh extension install github/gh-stats

# Issue templates
gh extension install mislav/gh-issue-template

# Release helper
gh extension install chelnak/gh-changelog
```

**Lista dostępnych:**
```bash
gh extension list
gh extension search
gh extension upgrade --all
```


## 💻 Terminal Tools

### Oh My Zsh Plugins (jeśli używasz zsh)

```bash
# W ~/.zshrc dodaj do plugins:
plugins=(
  git
  gh
  docker
  kubectl
  vscode
  npm
  yarn
  node
  python
  pip
  sudo
  command-not-found
  zsh-autosuggestions
  zsh-syntax-highlighting
)
```

### Bash Plugins

```bash
# Bash-it framework
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh

# Lub użyj starship prompt
curl -sS https://starship.rs/install.sh | sh
```

### CLI Tools

```bash
# bat - lepszy cat
sudo apt install bat

# fzf - fuzzy finder
sudo apt install fzf

# ripgrep - lepszy grep
sudo apt install ripgrep

# exa - lepszy ls
cargo install exa

# tldr - uproszczone man pages
sudo apt install tldr

# jq - JSON processor
sudo apt install jq

# httpie - lepszy curl
sudo apt install httpie
```


## 📦 Instalacja wszyskiego naraz

### Skrypt dla VS Code

> [!TIP] Automatyka w repo
> Zamiast ręcznie kopiować poniższy blok możesz uruchomić `scripts/install-ai-toolkit.sh vscode`, który wykonuje te same kroki i doinstalowuje brakujące rozszerzenia.

```bash
#!/bin/bash
# install-vscode-extensions.sh

# AI & Productivity
code --install-extension GitHub.copilot
code --install-extension GitHub.copilot-chat
code --install-extension Continue.continue
code --install-extension tabnine.tabnine-vscode
code --install-extension visualstudioexptteam.vscodeintellicode

# Git & GitHub
code --install-extension eamodio.gitlens
code --install-extension github.vscode-pull-request-github
code --install-extension donjayamanne.githistory
code --install-extension mhutchie.git-graph

# Markdown
code --install-extension yzhang.markdown-all-in-one
code --install-extension davidanson.vscode-markdownlint
code --install-extension bierner.markdown-mermaid

# Code Quality
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension timonwong.shellcheck
code --install-extension usernamehw.errorlens

# DevOps
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
code --install-extension redhat.vscode-yaml

# Productivity
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension oderwat.indent-rainbow
code --install-extension pkief.material-icon-theme

echo "✅ Wszystkie extensions zainstalowane!"
```

### EWW Automated Setup

**Już masz w skrypcie:**
```bash
./bin/eww-github-setup
```


## 🎯 Rekomendowane Kombinacje

### Dla Bash Developera
- ShellCheck
- GitLens
- GitHub Copilot
- Error Lens
- Spell Checker

### Dla Full-Stack Developera
- ESLint + Prettier
- GitHub Copilot + Copilot Chat
- GitLens
- Docker + Kubernetes
- REST Client

### Dla DevOps
- Docker + Kubernetes
- YAML + JSON Tools
- Remote SSH + Dev Containers
- GitLens
- ShellCheck

### Dla Technical Writer
- Markdown All in One
- Markdown Lint
- Spell Checker
- Obsidian Tools
- Copilot Chat (do generowania docs)


## ⚙️ Konfiguracja

### VS Code Settings

```json
// settings.json
{
  // Copilot
  "github.copilot.enable": {
    "*": true,
    "yaml": true,
    "plaintext": false,
    "markdown": true
  },
  
  // GitLens
  "gitlens.codeLens.enabled": true,
  "gitlens.currentLine.enabled": true,
  
  // Markdown
  "markdown.preview.mermaid.enabled": true,
  
  // Formatter
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": true,
  
  // Error Lens
  "errorLens.enabledDiagnosticLevels": [
    "error",
    "warning"
  ]
}
```

### GitHub CLI Config

```yaml
# ~/.config/gh/config.yml
git_protocol: ssh
editor: code --wait
prompt: enabled
pager: less
```


## 🔧 Troubleshooting

### VS Code extension nie działa

```bash
# Sprawdź status
code --list-extensions

# Reinstall
code --uninstall-extension publisher.extension
code --install-extension publisher.extension

# Restart VS Code
```

### GitHub CLI extension error

```bash
# Update
gh extension upgrade --all

# Reinstall
gh extension remove extension-name
gh extension install owner/extension-name
```


## 📚 Zasoby

- [VS Code Marketplace](https://marketplace.visualstudio.com/vscode)
- [GitHub CLI Extensions](https://github.com/topics/gh-extension)
- [Awesome VS Code](https://github.com/viatsko/awesome-vscode)


**Zaktualizowano:** 2025-11-21  
**Autor:** EWW Team
