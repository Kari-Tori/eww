---
version: 0.0.4
tags:
  - #automation
  - #development
  - #docs
  - #eww
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-10
modified: 2025-11-24
author: jakubc
title: "Narzędzia deweloperskie - przewodnik"






owner: jakubc
---



# Narzędzia deweloperskie - przewodnik

## Spis treści

- [Rozszerzenia VS Code](#rozszerzenia-vs-code)
- [Narzędzia CLI](#narzędzia-cli)
- [Konfiguracja](#konfiguracja)
- [Przykłady użycia](#przykłady-użycia)
- [Integracja z projektem](#integracja-z-projektem)

## Rozszerzenia VS Code

### 🐚 Bash/Shell Development

| Rozszerzenie | ID | Funkcja |
|--------------|-----|---------|
| **Bash IDE** | `mads-hartmann.bash-ide-vscode` | Language Server Protocol dla Bash |
| **ShellCheck** | `timonwong.shellcheck` | Linter dla skryptów Shell |
| **shell-format** | `foxundermoon.shell-format` | Formatter (shfmt) |
| **Bash Debug** | `rogalmic.bash-debug` | Debugger dla Bash (bashdb) |
| **shellman** | `remisa.shellman` | Snippety dla Shell |

### 📝 Dokumentacja i komentarze

| Rozszerzenie | ID | Funkcja |
|--------------|-----|---------|
| **Better Comments** | `aaron-bond.better-comments` | Kolorowe komentarze (TODO, FIXME, NOTE) |
| **Todo Tree** | `gruntfuggly.todo-tree` | Widok drzewa TODO/FIXME |
| **koroFileHeader** | `obkoro1.korofileheader` | Auto-nagłówki plików i funkcji |

### 📖 Markdown

| Rozszerzenie | ID | Funkcja |
|--------------|-----|---------|
| **Markdown All in One** | `yzhang.markdown-all-in-one` | TOC, shortcuts, preview |
| **markdownlint** | `davidanson.vscode-markdownlint` | Linter Markdown |
| **Markdown Preview Enhanced** | `shd101wyy.markdown-preview-enhanced` | Zaawansowany preview |
| **Mermaid Support** | `bierner.markdown-mermaid` | Diagramy Mermaid |
| **GitHub Styling** | `bierner.markdown-preview-github-styles` | GitHub style preview |

### 🎨 Formatowanie

| Rozszerzenie | ID | Funkcja |
|--------------|-----|---------|
| **Prettier** | `esbenp.prettier-vscode` | Uniwersalny formatter |
| **EditorConfig** | `editorconfig.editorconfig` | Wsparcie .editorconfig |
| **YAML** | `redhat.vscode-yaml` | YAML schema validation |

### 🔧 Git i kontrola wersji

| Rozszerzenie | ID | Funkcja |
|--------------|-----|---------|
| **GitLens** | `eamodio.gitlens` | Zaawansowane funkcje Git |
| **Git History** | `donjayamanne.githistory` | Historia commitów |
| **Conventional Commits** | `vivaxy.vscode-conventional-commits` | Helper Conventional Commits |

### 🤖 AI i produktywność

| Rozszerzenie | ID | Funkcja |
|--------------|-----|---------|
| **GitHub Copilot** | `github.copilot` | AI code completion |
| **GitHub Copilot Chat** | `github.copilot-chat` | AI chat assistant |
| **Continue** | `continue.continue` | AI coding assistant |

### 🎯 Produktywność

| Rozszerzenie | ID | Funkcja |
|--------------|-----|---------|
| **Error Lens** | `usernamehw.errorlens` | Inline error display |
| **Path Intellisense** | `christian-kohler.path-intellisense` | Auto-uzupełnianie ścieżek |
| **Material Icon Theme** | `pkief.material-icon-theme` | Ikony plików |
| **Indent Rainbow** | `oderwat.indent-rainbow` | Kolorowe wcięcia |

## Narzędzia CLI

### Linting i analiza

```bash
# ShellCheck - linter dla Bash
shellcheck --version  # 0.10.0
shellcheck lib/*.sh dev/bin/eww-*

# shfmt - formatter dla Shell
shfmt --version  # 3.8.0
shfmt -i 4 -w lib/*.sh

# markdownlint - linter Markdown
markdownlint --version  # 0.45.0
markdownlint README.md docs/*.md

# yamllint - linter YAML
yamllint --version  # 1.35.1
yamllint .github/workflows/*.yml
```

### Testowanie

```bash
# BATS - Bash Automated Testing System
bats --version  # 1.11.1
bats dev/tests/
bats projects/init/tests/

# Uruchom konkretny test
bats projects/init/tests/test_init.bats
```

### Dokumentacja

```bash
# pandoc - konwerter dokumentów
pandoc --version  # 3.1.11.1

# Markdown → HTML
pandoc README.md -o README.html

# Markdown → PDF (wymaga LaTeX)
pandoc README.md -o README.pdf

# Markdown → DOCX
pandoc README.md -o README.docx

# Z YAML frontmatter
pandoc --metadata-file=metadata.yaml README.md -o output.html
```

### Git i wersjonowanie

```bash
# GitHub CLI
gh --version  # 2.83.0

# Tworzenie PR
gh pr create --title "feat: nowa funkcja" --body "Opis"

# Lista PR
gh pr list

# Status issues
gh issue list --assignee @me
```

### Eksploratory plików CLI

Repozytorium dostarcza skrypt `bin/eww-cli-filemanagers`, który opakowuje najpopularniejsze menedżery plików działające w terminalu (`ranger`, `nnn`, `lf`, `mc`, `broot`).

```bash
# Lista dostępnych narzędzi i status instalacji
./bin/eww-cli-filemanagers list

# Instalacja lekkiego eksploratora nnn (apt-get install)
./bin/eww-cli-filemanagers install nnn

# Opis skrótów i szybkie wskazówki
./bin/eww-cli-filemanagers info ranger

# Uruchomienie wybranego narzędzia w tym samym terminalu
./bin/eww-cli-filemanagers launch broot
```

Skrypt weryfikuje obecność `apt-get` oraz wymusza użycie `sudo`, więc można bezpiecznie instalować pakiety na świeżych systemach Kubuntu (24.04+) bez ręcznego wyszukiwania nazw pakietów.

## Konfiguracja

### Better Comments

Rozszerzenie rozpoznaje automatycznie:

```bash
# TODO: Do zrobienia
# FIXME: Do naprawy
# NOTE: Ważna uwaga
# WARNING: Ostrzeżenie
# * Wyróżniony komentarz
# ! Deprecated
# ? Pytanie/wątpliwość
```

### Todo Tree

Konfiguracja w `.vscode/settings.json`:

```json
{
  "todo-tree.general.tags": [
    "TODO",
    "FIXME",
    "NOTE",
    "WARNING",
    "XXX",
    "HACK",
    "BUG"
  ],
  "todo-tree.highlights.defaultHighlight": {
    "icon": "alert",
    "type": "text-and-comment",
    "foreground": "#ffffff",
    "opacity": 80
  },
  "todo-tree.highlights.customHighlight": {
    "TODO": {
      "icon": "check",
      "foreground": "#00ff00"
    },
    "FIXME": {
      "icon": "bug",
      "foreground": "#ff0000"
    },
    "NOTE": {
      "icon": "note",
      "foreground": "#00ffff"
    }
  }
}
```

### koroFileHeader

Konfiguracja nagłówków plików:

```json
{
  "fileheader.customMade": {
    "Description": "",
    "Autor": "Nairecth",
    "Date": "Do not edit",
    "LastEditTime": "Do not edit",
    "FilePath": "Do not edit"
  },
  "fileheader.configObj": {
    "language": {
      "shellscript": {
        "head": "#!/usr/bin/env bash",
        "beforeAnnotation": "",
        "middle": "# ",
        "end": "",
        "functionSymbol": {
          "head": "",
          "middle": "# ",
          "end": ""
        }
      }
    }
  }
}
```

### ShellCheck

Ignorowanie reguł w `.shellcheckrc`:

```bash
# Ignoruj SC2034 - unused variables (często używane w sourced files)
disable=SC2034

# Ignoruj SC1090 - can't follow non-constant source
disable=SC1090

# Ignoruj SC2155 - declare and assign separately
# disable=SC2155  # Opcjonalnie
```

## Przykłady użycia

### 1. Automatyczne nagłówki plików

W VS Code:
- `Ctrl+Alt+I` - wstaw nagłówek pliku
- `Ctrl+Alt+T` - wstaw komentarz funkcji
- `Ctrl+Alt+U` - aktualizuj nagłówek

Przykład dla Bash:

```bash
#!/usr/bin/env bash
###
# @Description: Skrypt pomocniczy do operacji Git
# @Autor: Nairecth
# @Date: 2025-11-09 15:30:00
# @LastEditTime: 2025-11-09 16:45:00
# @FilePath: /home/karinam/git/eww/lib/git.sh
###

# Pobierz ostatni tag Git
# Argumenty: brak
# Zwraca: tag lub pusty string
git::last_tag() {
    git describe --tags --abbrev=0 2>/dev/null || echo ""
}
```

### 2. Todo Tree w akcji

Dodaj komentarze:

```bash
# TODO: Dodać obsługę wielu repozytoriów
# FIXME: Bug przy pustym output Git
# NOTE: Ta funkcja jest wywoływana przez `projects/init/init-eww.sh`
# WARNING: Wymaga Git 2.34+
```

Widok w VS Code:
- Aktywność **Todo Tree** w pasku bocznym
- Lista wszystkich TODO/FIXME w projekcie
- Kliknięcie przenosi do pliku

### 3. Bash Debug

Debug skryptu:

1. Ustaw breakpoint (kliknij na marginesie linii)
2. `F5` - uruchom debugger
3. Przeglądaj zmienne w panelu
4. Step over (`F10`), Step into (`F11`)

Launch configuration (`.vscode/launch.json`):

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "bashdb",
      "request": "launch",
      "name": "Debug projects/init/init-eww.sh",
      "program": "${workspaceFolder}/projects/init/init-eww.sh",
      "cwd": "${workspaceFolder}",
      "args": []
    }
  ]
}
```

### 4. Formatowanie automatyczne

Save → Auto-format:

```json
{
  "[shellscript]": {
    "editor.defaultFormatter": "foxundermoon.shell-format",
    "editor.formatOnSave": true
  },
  "[markdown]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  },
  "[yaml]": {
    "editor.defaultFormatter": "redhat.vscode-yaml",
    "editor.formatOnSave": true
  }
}
```

### 5. Generowanie dokumentacji

#### Pandoc - różne formaty

```bash
# HTML z TOC i CSS
pandoc README.md \
  --standalone \
  --toc \
  --toc-depth=3 \
  --css=style.css \
  -o README.html

# PDF z niestandardowymi marginami
pandoc README.md \
  --pdf-engine=xelatex \
  -V geometry:margin=2cm \
  -o README.pdf

# DOCX z szablonem
pandoc README.md \
  --reference-doc=template.docx \
  -o README.docx

# Prezentacja reveal.js
pandoc guide.md \
  -t revealjs \
  --standalone \
  -o presentation.html
```

#### Skrypt do dokumentacji

`dev/scripts/generate-docs.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail

readonly DOCS_DIR="docs"
readonly OUTPUT_DIR="docs/generated"

mkdir -p "$OUTPUT_DIR"

# Konwertuj wszystkie MD → HTML
find "$DOCS_DIR" -name "*.md" -type f | while read -r md_file; do
    base=$(basename "$md_file" .md)
    html_file="$OUTPUT_DIR/${base}.html"
    
    echo "Generuję: $html_file"
    pandoc "$md_file" \
        --standalone \
        --toc \
        --css=github.css \
        -o "$html_file"
done

echo "✓ Dokumentacja wygenerowana w $OUTPUT_DIR"
```

## Integracja z projektem

### Makefile targets

Dodaj do `Makefile`:

```makefile
.PHONY: lint format test docs

# Linting
lint:
	shellcheck lib/*.sh dev/bin/eww-*
	markdownlint README.md docs/*.md
	yamllint .github/workflows/*.yml

# Formatowanie
format:
	shfmt -i 4 -w lib/*.sh dev/bin/eww-*
	prettier --write "**/*.{json,yaml,yml,md}"

# Testy
test:
	bats dev/tests/ projects/init/tests/

# Generowanie dokumentacji
docs:
	./dev/scripts/generate-docs.sh

# Wszystko
check: lint test
```

### GitHub Actions

`.github/workflows/quality.yml`:

```yaml
name: Code Quality

on: [push, pull_request]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: ShellCheck
        run: shellcheck lib/*.sh dev/bin/eww-*
      
      - name: markdownlint
        uses: nosborn/github-action-markdown-cli@v3
        with:
          files: .
          config_file: .markdownlint.json
  
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup BATS
        uses: mig4/setup-bats@v1
      
      - name: Run tests
        run: bats dev/tests/ projects/init/tests/
```

### Pre-commit hooks

`.pre-commit-config.yaml`:

```yaml
repos:
  - repo: https://github.com/koalaman/shellcheck-precommit
    rev: v0.10.0
    hooks:
      - id: shellcheck
  
  - repo: https://github.com/igorshubovych/markdownlint-cli
    rev: v0.45.0
    hooks:
      - id: markdownlint
  
  - repo: https://github.com/adrienverge/yamllint
    rev: v1.35.1
    hooks:
      - id: yamllint
```

## Podsumowanie

✅ **37 rozszerzeń VS Code** zainstalowanych  
✅ **6 narzędzi CLI** skonfigurowanych  
✅ **Automatyzacja** przez Makefile  
✅ **CI/CD ready** z GitHub Actions  
✅ **Pre-commit hooks** dla jakości kodu

### Quick reference

```bash
# Linting
make lint

# Formatowanie
make format

# Testy
make test

# Dokumentacja
make docs

# Wszystko naraz
make check
```


**Autor:** Nairecth  
**Wersja:** 0.0.0.5  
**Data:** 2025-11-09

## 🔗 Backlinks

- [[dev/docs/docs]]
- [[docs/docs]]
- [[INDEX]]