created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---
title: Visual Studio Code — Kompletny przewodnik
description: Pełna dokumentacja VS Code dla projektu eww — konfiguracja, rozszerzenia, workflow, integracja z AI i narzędziami deweloperskimi
version: 1.0.0
updated: 2025-11-24
tags:
  - vscode
  - editor
  - ide
  - development
  - tools
  - ai
  - copilot
created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

# Visual Studio Code — Kompletny przewodnik 🚀

## 🎯 Cel dokumentu

Kompleksowa dokumentacja Visual Studio Code jako głównego IDE dla projektu **E-Waste Workshop (eww)**. Dokument opisuje:
- Konfigurację edytora dla Bash/Shell scripting
- Integrację z AI (GitHub Copilot, Continue, Codex)
- Rozszerzenia dla Markdown/Obsidian workflow
- Narzędzia deweloperskie (linting, formatting, testing)
- Best practices i productivity tips

## 📚 Spis treści

1. [Podstawowa konfiguracja](#-podstawowa-konfiguracja)
2. [Rozszerzenia](#-rozszerzenia)
3. [HTML/CSS/Web Development](#-htmlcssweb-development)
4. [Workspace settings](#️-workspace-settings)
5. [Keybindings](#️-keybindings)
6. [Integracja z AI](#-integracja-z-ai)
7. [Bash/Shell development](#-bashshell-development)
8. [Markdown & Documentation](#-markdown--documentation)
9. [Git & Version Control](#-git--version-control)
10. [Debugging](#-debugging)
11. [Productivity & Automation](#-productivity--automation)

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🔧 Podstawowa konfiguracja

### Instalacja VS Code

**Kubuntu 24.04 LTS:**
```bash
# Metoda 1: Snap (zalecana dla Kubuntu)
sudo snap install code --classic

# Metoda 2: APT (oficjalne repo Microsoft)
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install code
```

### Pierwsza konfiguracja

```bash
# Synchronizacja ustawień przez GitHub
code --enable-features=UseOzonePlatform --ozone-platform=wayland

# Instalacja podstawowych rozszerzeń
code --install-extension ms-vscode.cpptools
code --install-extension ms-python.python
code --install-extension GitHub.copilot
code --install-extension GitHub.copilot-chat
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🧩 Rozszerzenia

### Must-Have Extensions

#### 1. **GitHub Copilot** + **Copilot Chat**
```vscode-extensions
GitHub.copilot,GitHub.copilot-chat
```
**Funkcje:**
- AI-powered code completion
- Chat w kontekście kodu
- Inline suggestions
- Dokumentacja automatyczna

**Konfiguracja:**
```json
{
  "github.copilot.enable": {
    "*": true,
    "yaml": true,
    "plaintext": false,
    "markdown": true
  },
  "github.copilot.editor.enableAutoCompletions": true
}
```

#### 2. **Python** (Microsoft)
```vscode-extensions
ms-python.python
```
**Funkcje:**
- IntelliSense (Pylance)
- Debugging
- Linting (pylint, flake8)
- Testing (pytest, unittest)

#### 3. **ShellCheck** + **shell-format**
```vscode-extensions
timonwong.shellcheck,foxundermoon.shell-format
```
**Funkcje:**
- Linting Bash/Shell scripts
- Auto-formatting z shfmt
- Best practices suggestions

### Pełna lista rozszerzeń

Zobacz szczegółowe dokumenty:
- **[code-plugins.md](./code-plugins.md)** — Rozszerzenia Markdown/Obsidian/AI (68 rozszerzeń)
- **[html-css-tools.md](./html-css-tools.md)** — Rozszerzenia HTML/CSS/Web Development (20+ rozszerzeń)
- **[extensions-status.md](./extensions-status.md)** — Audit zainstalowanych rozszerzeń

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🌐 HTML/CSS/Web Development

### Podstawowe narzędzia (10 rozszerzeń zainstalowanych):

1. **HTML CSS Support** — CSS IntelliSense w HTML
2. **Auto Rename Tag** — Synchronizacja par tagów
3. **Auto Close Tag** — Automatyczne zamykanie
4. **HTML Snippets** — HTML5 snippets
5. **CSS class completion** — Autocomplete CSS classes
6. **CSS Peek** — Peek definition
7. **Live Server** — Live reload (port 5500)
8. **Color Highlight** — Podświetlanie kolorów
9. **Color Picker** — GUI picker
10. **Image Preview** — Preview w gutter

### Quick Start HTML/CSS

#### Instalacja podstawowych narzędzi:
```bash
code --install-extension ecmel.vscode-html-css
code --install-extension formulahendry.auto-rename-tag
code --install-extension formulahendry.auto-close-tag
code --install-extension ritwickdey.liveserver
code --install-extension esbenp.prettier-vscode
```

#### Live Server workflow:
1. Otwórz plik HTML
2. Prawy klik → **Open with Live Server**
3. Browser otworzy się na `http://localhost:5500`
4. Edycje są automatycznie odświeżane

#### Emmet przykłady:
```
div.container>header+main>section.hero>h1+p
```
Rozwinie się do pełnej struktury HTML.

### Konfiguracja HTML/CSS:
```json
{
  "[html]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true,
    "editor.tabSize": 2
  },
  "[css]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  },
  "emmet.includeLanguages": {
    "javascript": "javascriptreact",
    "vue-html": "html"
  },
  "emmet.triggerExpansionOnTab": true,
  "liveServer.settings.port": 5500
}
```

### 📚 Pełna dokumentacja HTML/CSS

Zobacz: **[html-css-tools.md](./html-css-tools.md)** dla kompletnego przewodnika zawierającego:
- 20+ rozszerzeń HTML/CSS/JavaScript
- Tailwind CSS, SCSS, Stylelint
- Browser Preview, Accessibility tools
- Framework support (Vue, React)
- Pełne przykłady konfiguracji
- Workflow i best practices

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## ⚙️ Workspace settings

**Pełna lista rozszerzeń:** Zobacz [code-plugins.md](./code-plugins.md)

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## ⚙️ Workspace Settings

### `.vscode/settings.json` (projekt eww)

```json
{
  "// === EDITOR ===": "",
  "editor.fontSize": 14,
  "editor.fontFamily": "'JetBrains Mono', 'Fira Code', 'Cascadia Code', monospace",
  "editor.fontLigatures": true,
  "editor.lineHeight": 22,
  "editor.rulers": [80, 120],
  "editor.wordWrap": "on",
  "editor.minimap.enabled": false,
  "editor.bracketPairColorization.enabled": true,
  "editor.guides.bracketPairs": true,
  "editor.inlineSuggest.enabled": true,
  "editor.suggestSelection": "first",
  "editor.tabSize": 2,
  "editor.insertSpaces": true,
  "editor.detectIndentation": true,
  "editor.formatOnSave": true,
  "editor.formatOnPaste": false,
  "editor.codeActionsOnSave": {
    "source.fixAll": "explicit",
    "source.organizeImports": "explicit"
  },

  "// === FILES ===": "",
  "files.autoSave": "afterDelay",
  "files.autoSaveDelay": 1000,
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,
  "files.trimFinalNewlines": true,
  "files.encoding": "utf8",
  "files.eol": "\n",
  "files.associations": {
    "*.sh": "shellscript",
    "*.bash": "shellscript",
    "*.md": "markdown",
    "Makefile": "makefile",
    "*.bats": "shellscript",
    ".bashrc": "shellscript",
    ".bash_profile": "shellscript"
  },
  "files.exclude": {
    "**/.git": true,
    "**/.DS_Store": true,
    "**/node_modules": true,
    "**/__pycache__": true,
    "**/.pytest_cache": true,
    "**/*.pyc": true
  },

  "// === TERMINAL ===": "",
  "terminal.integrated.defaultProfile.linux": "bash",
  "terminal.integrated.fontSize": 13,
  "terminal.integrated.fontFamily": "'JetBrains Mono', monospace",
  "terminal.integrated.cursorBlinking": true,
  "terminal.integrated.cursorStyle": "line",
  "terminal.integrated.scrollback": 10000,

  "// === BASH/SHELL ===": "",
  "shellcheck.enable": true,
  "shellcheck.executablePath": "/usr/bin/shellcheck",
  "shellcheck.run": "onType",
  "shellformat.path": "/usr/bin/shfmt",
  "shellformat.flag": "-i 2 -ci -bn -sr",
  "[shellscript]": {
    "editor.defaultFormatter": "foxundermoon.shell-format",
    "editor.formatOnSave": true,
    "editor.tabSize": 2
  },

  "// === MARKDOWN ===": "",
  "markdown.preview.breaks": true,
  "markdown.preview.linkify": true,
  "markdown.extension.toc.githubCompatibility": true,
  "[markdown]": {
    "editor.defaultFormatter": "yzhang.markdown-all-in-one",
    "editor.wordWrap": "on",
    "editor.quickSuggestions": {
      "comments": "on",
      "strings": "on",
      "other": "on"
    }
  },
  "markdownlint.config": {
    "MD013": false,
    "MD033": false,
    "MD041": false
  },

  "// === YAML ===": "",
  "yaml.schemas": {
    "https://json.schemastore.org/github-workflow.json": ".github/workflows/*.yml",
    "https://json.schemastore.org/frontmatter.json": "**/*.md"
  },
  "[yaml]": {
    "editor.defaultFormatter": "redhat.vscode-yaml",
    "editor.tabSize": 2
  },

  "// === PYTHON ===": "",
  "python.linting.enabled": true,
  "python.linting.pylintEnabled": false,
  "python.linting.flake8Enabled": true,
  "python.formatting.provider": "black",
  "python.testing.pytestEnabled": true,
  "[python]": {
    "editor.defaultFormatter": "ms-python.python",
    "editor.tabSize": 4
  },

  "// === GIT ===": "",
  "git.autofetch": true,
  "git.confirmSync": false,
  "git.enableSmartCommit": true,
  "git.postCommitCommand": "none",
  "git.showPushSuccessNotification": true,

  "// === AI & COPILOT ===": "",
  "github.copilot.enable": {
    "*": true,
    "yaml": true,
    "markdown": true,
    "shellscript": true
  },
  "github.copilot.editor.enableAutoCompletions": true,
  
  "// === WORKSPACE ===": "",
  "workbench.colorTheme": "Monokai",
  "workbench.iconTheme": "material-icon-theme",
  "workbench.startupEditor": "welcomePage",
  "workbench.editor.enablePreview": false,

  "// === FOAM (Obsidian compatibility) ===": "",
  "foam.edit.linkReferenceDefinitions": "withExtensions",
  "foam.openDailyNote.directory": "usr/karinam/journal"
}
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## ⌨️ Keybindings

### Najważniejsze skróty (domyślne)

| Skrót | Akcja | Opis |
|-------|-------|------|
| `Ctrl+P` | Quick Open | Szybkie otwieranie plików |
| `Ctrl+Shift+P` | Command Palette | Wszystkie komendy |
| `Ctrl+B` | Toggle Sidebar | Pokaż/ukryj sidebar |
| `Ctrl+`` ` | Toggle Terminal | Pokaż/ukryj terminal |
| `Ctrl+Shift+E` | Explorer | Panel plików |
| `Ctrl+Shift+F` | Search | Wyszukiwanie w projekcie |
| `Ctrl+Shift+G` | Git | Panel Git |
| `Ctrl+Shift+X` | Extensions | Rozszerzenia |
| `F5` | Start Debugging | Debug |
| `Ctrl+Shift+B` | Run Build Task | Buduj projekt |
| `Ctrl+/` | Toggle Comment | Komentarz linii |
| `Alt+↑/↓` | Move Line | Przesuń linię |
| `Ctrl+D` | Add Selection | Multi-cursor |
| `F12` | Go to Definition | Idź do definicji |
| `Ctrl+Space` | Trigger Suggest | Autocomplete |

### Custom keybindings (`.vscode/keybindings.json`)

```json
[
  {
    "key": "ctrl+shift+t",
    "command": "workbench.action.tasks.test"
  },
  {
    "key": "ctrl+shift+`",
    "command": "workbench.action.terminal.new"
  },
  {
    "key": "ctrl+k ctrl+o",
    "command": "workbench.action.files.openFolder"
  }
]
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🤖 Integracja z AI

### GitHub Copilot

#### Użycie Copilot Chat

**Przykłady promptów:**
```
@workspace Jak skonfigurować shellcheck dla projektu?
@workspace Wygeneruj test BATS dla funkcji git::last_tag
@workspace Znajdź wszystkie funkcje w lib/git.sh
/explain Wyjaśnij ten skrypt Bash
/fix Napraw błędy w tym skrypcie
/doc Wygeneruj dokumentację dla tej funkcji
/tests Wygeneruj testy jednostkowe
```

#### Best practices
1. **Kontekst** — otwórz powiązane pliki przed zapytaniem
2. **Precyzyjne prompty** — opisz dokładnie czego potrzebujesz
3. **Review** — zawsze sprawdzaj wygenerowany kod
4. **Iteracja** — doprecyzowuj prompt jeśli wynik nie jest ok

### Continue (Custom AI Models)

#### Instalacja
```bash
code --install-extension Continue.continue
```

#### Konfiguracja `~/.continue/config.json`

```json
{
  "models": [
    {
      "title": "Ollama Codex",
      "provider": "ollama",
      "model": "codellama:13b",
      "apiBase": "http://localhost:11434"
    }
  ],
  "contextProviders": [
    {
      "name": "file",
      "params": {
        "glob": "**/*.{sh,bash,md,py}"
      }
    },
    {
      "name": "folder",
      "params": {
        "folder": "docs"
      }
    },
    {
      "name": "codebase"
    }
  ],
  "slashCommands": [
    {
      "name": "comment",
      "description": "Dodaj komentarze po polsku",
      "prompt": "Dodaj szczegółowe komentarze po polsku do poniższego kodu."
    },
    {
      "name": "test",
      "description": "Wygeneruj test BATS",
      "prompt": "Wygeneruj test BATS dla poniższej funkcji Bash."
    },
    {
      "name": "docs",
      "description": "Generuj dokumentację Markdown",
      "prompt": "Wygeneruj dokumentację Markdown z YAML frontmatter."
    }
  ],
  "tabAutocompleteModel": {
    "title": "Ollama Codex",
    "provider": "ollama",
    "model": "codellama:13b"
  }
}
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🐚 Bash/Shell Development

### Workflow deweloperski

#### 1. Nowy skrypt Bash

**Template (user snippet):**
```json
{
  "Bash Script Template": {
    "prefix": "bash-script",
    "body": [
      "#!/usr/bin/env bash",
      "# ${1:Nazwa skryptu} - ${2:Krótki opis}",
      "set -euo pipefail",
      "",
      "readonly SCRIPT_DIR=\"$(cd \"$(dirname \"${BASH_SOURCE[0]}\")\" && pwd)\"",
      "",
      "# Kolory",
      "readonly GREEN='\\033[0;32m'",
      "readonly RED='\\033[0;31m'",
      "readonly NC='\\033[0m'",
      "",
      "log_info() { printf \"[EWW] %s\\n\" \"$1\"; }",
      "log_error() { printf \"${RED}[ERROR]${NC} %s\\n\" \"$1\" >&2; }",
      "",
      "usage() {",
      "  cat <<EOF",
      "Użycie: \\$(basename \"$0\") [OPCJE]",
      "EOF",
      "}",
      "",
      "main() {",
      "  ${0:# kod}",
      "}",
      "",
      "main \"$@\""
    ]
  }
}
```

#### 2. Linting (ShellCheck)

**Konfiguracja `.shellcheckrc`:**
```bash
# /home/karinam/git/eww/.shellcheckrc
disable=SC2086
severity=style
source-path=SCRIPTDIR
```

**Uruchomienie:**
```bash
shellcheck bin/eww-*
shellcheck lib/*.sh

# Lub przez VS Code task
Ctrl+Shift+P → Tasks: Run Task → ShellCheck
```

#### 3. Formatowanie (shfmt)

```bash
# Format all scripts
shfmt -w -i 2 -ci -bn -sr bin/ lib/ scripts/

# Check only
shfmt -d -i 2 -ci -bn -sr bin/
```

#### 4. Testing (BATS)

**Przykład testu `tests/lib_git.bats`:**
```bash
#!/usr/bin/env bats

setup() {
  load '../lib/git.sh'
}

@test "git::last_tag zwraca tag" {
  run git::last_tag
  [ "$status" -eq 0 ]
  [[ "$output" =~ ^v[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
}
```

**Uruchomienie:**
```bash
bats tests/
# lub
Ctrl+Shift+P → Tasks: Run Task → Run BATS tests
```

### Tasks dla Bash (`.vscode/tasks.json`)

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "ShellCheck (lint)",
      "type": "shell",
      "command": "shellcheck",
      "args": ["${file}"],
      "problemMatcher": [],
      "group": {
        "kind": "test",
        "isDefault": true
      }
    },
    {
      "label": "Format Bash (shfmt)",
      "type": "shell",
      "command": "shfmt",
      "args": ["-w", "-i", "2", "-ci", "-bn", "-sr", "${file}"]
    },
    {
      "label": "Run BATS tests",
      "type": "shell",
      "command": "bats",
      "args": ["tests/"]
    },
    {
      "label": "Execute current script",
      "type": "shell",
      "command": "bash",
      "args": ["${file}"]
    }
  ]
}
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 📝 Markdown & Documentation

### Rozszerzenia Markdown

**Must-have:**
```vscode-extensions
yzhang.markdown-all-in-one,shd101wyy.markdown-preview-enhanced,bierner.markdown-mermaid
```

Pełna lista: [code-plugins.md](./code-plugins.md)

### Workflow dokumentacji

#### Snippet `md-doc`:

```json
{
  "Markdown Documentation": {
    "prefix": "md-doc",
    "body": [
      "---",
      "title: ${1:Tytuł}",
      "description: ${2:Opis}",
      "created: ${CURRENT_YEAR}-${CURRENT_MONTH}-${CURRENT_DATE}",
      "tags:",
      "  - ${3:tag1}",
      "---",
      "",
      "# ${1:Tytuł}",
      "",
      "## 🎯 Cel",
      "",
      "${0}",
      ""
    ]
  }
}
```

#### Diagramy Mermaid

````markdown
```mermaid
graph LR
    A[Start] --> B[Process]
    B --> C[End]
```
````

#### Callouts Obsidian

```markdown
> [!info] Informacja
> Treść callout.

> [!warning] Uwaga
> Ostrzeżenie!
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🔀 Git & Version Control

### Rozszerzenia Git

```vscode-extensions
eamodio.gitlens,mhutchie.git-graph
```

### GitLens — Konfiguracja

```json
{
  "gitlens.codeLens.enabled": true,
  "gitlens.currentLine.enabled": true,
  "gitlens.hovers.currentLine.over": "line",
  "gitlens.blame.format": "${author}, ${agoOrDate}"
}
```

### Workflow Git

1. **Source Control** (`Ctrl+Shift+G`)
   - Stage: `+` przy pliku
   - Commit: Message + `Ctrl+Enter`
   - Push: `...` → Push

2. **Command Palette:**
   ```
   Git: Commit
   Git: Push
   Git: Pull
   Git: Checkout to...
   Git: Create Branch
   ```

3. **GitLens features:**
   - Blame annotations
   - Git Graph
   - Compare branches/commits

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🐛 Debugging

### Bash Debugging

**Rozszerzenie:**
```bash
code --install-extension rogalmic.bash-debug
```

**`.vscode/launch.json`:**
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "bashdb",
      "request": "launch",
      "name": "Debug Bash Script",
      "program": "${file}",
      "cwd": "${workspaceFolder}"
    }
  ]
}
```

**Użycie:**
1. Ustaw breakpoint (klik na marginesie)
2. `F5` → Start Debugging
3. `F10` → Step Over
4. `F11` → Step Into

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## ⚡ Productivity & Automation

### Tasks automation (Makefile)

```makefile
.PHONY: lint format test

lint:
	shellcheck bin/* lib/*.sh scripts/*.sh

format:
	shfmt -w -i 2 -ci -bn -sr bin/ lib/ scripts/

test:
	bats tests/
```

**Integracja z VS Code:**
```json
{
  "label": "Make: lint",
  "type": "shell",
  "command": "make",
  "args": ["lint"]
}
```

### Multi-cursor editing

| Skrót | Akcja |
|-------|-------|
| `Alt+Click` | Dodaj cursor |
| `Ctrl+Alt+↑/↓` | Cursor góra/dół |
| `Ctrl+D` | Następne wystąpienie |
| `Ctrl+Shift+L` | Wszystkie wystąpienia |

### Snippets (User Snippets)

**File → Preferences → Configure User Snippets → shellscript.json:**

```json
{
  "EWW Function": {
    "prefix": "eww-func",
    "body": [
      "# ${1:nazwa_funkcji} (${2:opis})",
      "# Argumenty: \\$1 - ${3:arg1}",
      "# Zwraca: ${4:0 sukces}",
      "${1:nazwa}() {",
      "  local ${5:arg}=\"\\$1\"",
      "  ${0}",
      "}"
    ]
  }
}
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 📖 Dokumentacja i zasoby

### Oficjalne zasoby
- **VS Code Docs:** https://code.visualstudio.com/docs
- **VS Code API:** https://code.visualstudio.com/api
- **Marketplace:** https://marketplace.visualstudio.com/

### Tutorials
- **Bash in VS Code:** https://code.visualstudio.com/docs/languages/shellscript
- **Markdown:** https://code.visualstudio.com/docs/languages/markdown
- **Git:** https://code.visualstudio.com/docs/sourcecontrol/overview

### Community
- **VS Code GitHub:** https://github.com/microsoft/vscode
- **Reddit r/vscode:** https://reddit.com/r/vscode

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## ✅ Checklist konfiguracji

- [ ] VS Code zainstalowany
- [ ] Podstawowe rozszerzenia (Copilot, Python, ShellCheck)
- [ ] Workspace settings skonfigurowane
- [ ] Keybindings dostosowane
- [ ] ShellCheck + shfmt zainstalowane
- [ ] BATS zainstalowany
- [ ] GitLens skonfigurowany
- [ ] Tasks zdefiniowane
- [ ] Snippets utworzone
- [ ] Pre-commit hooks
- [ ] Rozszerzenia Markdown
- [ ] Continue/AI skonfigurowane

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🔄 Aktualizacje

**2025-11-24:** Wersja 1.0.0
- Utworzenie kompletnej dokumentacji VS Code
- Konfiguracje dla Bash, Markdown, Git
- Integracja z AI (Copilot, Continue)
- Tasks, snippets, keybindings
- Debugging, productivity tips

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🔗 Powiązane dokumenty

- [code-plugins.md](./code-plugins.md) — Rozszerzenia VS Code
- [AGENTS.md](../../AGENTS.md) — Kontekst dla AI
- [.github/copilot-instructions.md](../../.github/copilot-instructions.md) — Zasady dla Copilot

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🤝 Wkład

Zgłaszaj propozycje ulepszeń przez GitHub Issues lub Pull Requests.
