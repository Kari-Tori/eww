created: 2025-11-21T14:00:00Z
modified: 2025-11-24T22:31:13Z
author: jakubc
---
tags:
  - #automation
  - #development
  - #docs
  - #eww
  - #knowledge
  - #linux
  - #secondbrain
title: "Makefile Guide - E-Waste Workshop"






owner: jakubc
created: 2025-11-21T14:00:00Z
modified: 2025-11-24T22:31:13Z
author: jakubc
---

# Makefile Guide - E-Waste Workshop

Rozbudowany Makefile z **50+ targetami** do automatyzacji wszystkich operacji eww.

## Quick Start

```bash
make help           # Lista wszystkich targetów
make version        # Aktualna wersja projektu
make git-status     # Status Git + last 10 commits
make test           # Uruchom testy Bats
```

## Kategorie targetów

### 1. Plan dnia (TODO)

```bash
make todo           # Pełny plan dnia (usr/jakubc/todo.md)
make todo-paczki    # Instrukcja wysyłki GTX1060 + GTR1660
make todo-obiad     # Podgrzanie obiadu
make todo-ebay      # Przypomnienie klientka eBay
make todo-posciel   # Zadanie z pościelą
make todo-ssh       # Plan migracji SSH (TODO-SSH.md)
```

### 2. Migracja SSH (13 kroków)

```bash
make backup-gerc         # 1. Backup /git/eww do /jakubc/git
make prepare-target      # 2. Przygotuj /jakubc/git/eww
make ssh-remote-check    # 3. Sprawdź Asus_Z77
make ssh-remote-git      # 4. Status Git na Asus_Z77
make ssh-remote-config   # 5. Config VS Code/Obsidian
make sync-dry            # 6. Rsync dry-run Asus → /jakubc
make sync-run            # 6. Rsync właściwy
make sync-perms          # 7. Napraw uprawnienia
make sync-configs        # 8. Rsync configs
make diff-repos          # 9. Porównaj /git vs /jakubc
make sync-legacy-dry     # 10. Dry-run legacy sync
make sync-legacy         # 10. Sync legacy files
make set-alias           # 11. Alias proj + open VS Code
make git-verify          # 12. Git status/log
make project-check       # 13. npm install + test + dev
```

### 3. Podstawowe operacje

```bash
make install        # Instaluj binaria eww-* do ~/bin
make uninstall      # Usuń binaria eww-*
make test           # Uruchom testy Bats
make test-bats      # To samo co test
make lint           # ShellCheck wszystkich skryptów
make clean          # Usuń *.bak, *.tmp
```

### 4. Wersjonowanie

```bash
make version           # Wyświetl wersję (VERSION lub scripts/version.sh)
make bump-version      # Zwiększ wersję (BUMP=MAJOR|MINOR|PATCH)
make changelog         # Wygeneruj CHANGELOG.md
```

**Przykład:**
```bash
make bump-version BUMP=MINOR   # 0.0.0.5 → 0.1.0
make changelog                 # Generate CHANGELOG.md
git add VERSION CHANGELOG.md
git commit -m "chore: bump to v0.1.0"
```

### 5. Dokumentacja

```bash
make readme-check   # Sprawdź spójność README + VERSION + release docs
```

### 6. Frontmatter i tagging

```bash
make frontmatter        # Generuj YAML frontmatter we wszystkich plikach
make frontmatter-dry    # Podgląd (dry-run, first 100 lines)
make auto-tag           # Automatyczne tagowanie (eww-auto-tag.sh)
```

**Uwaga:** `make frontmatter` zaktualizuje **wszystkie pliki** .md i .sh w repo!

### 7. Git operacje

```bash
make tag           # Automatyczne tagowanie Git (eww-auto-tag.sh git-tag)
make git-status    # Status + last 10 commits
make git-push      # Push do origin + tags
make commit        # Interaktywny commit (eww-commit lub git commit)
```

### 8. Diagnostyka i naprawa

```bash
make obsidian-fix   # Napraw ścieżki Obsidian vaults
make vscode-fix     # Wyczyść cache VS Code (590MB Service Worker errors)
make doctor         # Diagnostyka środowiska (eww-doctor)
make banner         # Wyświetl banner eww
make status         # Status projektu (Git + environment)
```

### 9. GitHub & AI Tools

```bash
make github-setup    # Instaluj GitHub CLI, Copilot, Continue.dev
make github-auth     # Authenticate z GitHub
make github-status   # Status GitHub tools (gh, copilot, extensions)
```

## Workflow examples

### Typowy workflow developera

```bash
# 1. Sprawdź status
make git-status

# 2. Uruchom testy
make test

# 3. ShellCheck
make lint

# 4. Aktualizuj frontmatter
make frontmatter-dry   # Podgląd
make frontmatter       # Właściwe

# 5. Commit
make commit

# 6. Push
make git-push
```

### Release workflow

```bash
# 1. Bump version
make bump-version BUMP=MINOR

# 2. Generate changelog
make changelog

# 3. Check README
make readme-check

# 4. Commit release
git add VERSION CHANGELOG.md README.md
git commit -m "chore: release v0.1.0"

# 5. Tag
git tag -a v0.1.0 -m "Release 0.1.0"

# 6. Push
make git-push
```

### Diagnostyka problemów

```bash
# 1. Środowisko
make doctor

# 2. Obsidian vaults
make obsidian-fix

# 3. VS Code cache
make vscode-fix

# 4. Git status
make git-status

# 5. README consistency
make readme-check
```

## Zmienne środowiskowe

```bash
PREFIX=~/.local/bin make install    # Instaluj do custom dir
BUMP=MAJOR make bump-version        # Bump major version
```

## Tips & tricks

### 1. Dry-run before destructive operations

```bash
make frontmatter-dry   # Zamiast make frontmatter
make sync-dry          # Zamiast make sync-run
make sync-legacy-dry   # Zamiast make sync-legacy
```

### 2. Combine targets

```bash
make clean test lint   # Wyczyść, testuj, lint
```

### 3. Make w background

```bash
make test &            # Testy w tle (UWAGA: może nie działać z interactive)
```

### 4. Output do pliku

```bash
make git-status > status.log
make frontmatter-dry > frontmatter-preview.txt
```

## Troubleshooting

### Brak uprawnień wykonania skryptu

```bash
chmod +x scripts/nazwa-skryptu.sh
```

### Missing separator error

Sprawdź czy recipe lines zaczynają się od **TAB**, nie spacji:

```makefile
target:
"TAB here!"  # ✅ TAB
    @echo "SPACES!"    # ❌ SPACES
```

### Skrypt nie istnieje

```bash
# Sprawdź czy plik istnieje
ls -la scripts/nazwa-skryptu.sh

# Jeśli nie, utwórz lub sprawdź ścieżkę w Makefile
```

## Przydatne skróty

| Target | Skrócony opis |
|--------|---------------|
| `make help` | Lista wszystkich targetów |
| `make test` | Uruchom testy |
| `make lint` | ShellCheck |
| `make version` | Wersja projektu |
| `make git-status` | Git status + commits |
| `make frontmatter-dry` | Podgląd frontmatter |
| `make obsidian-fix` | Napraw Obsidian |
| `make vscode-fix` | Wyczyść VS Code cache |
| `make doctor` | Diagnostyka |
| `make banner` | Banner eww |

## Dokumentacja

- **Makefile** - `/home/jakubc/git/eww/Makefile`
- **Skrypty** - `scripts/`, `bin/`
- **Testy** - `tests/*.bats`
- **TODO** - `usr/jakubc/todo.md`, `usr/jakubc/TODO-SSH.md`

## Historia zmian

- **2025-11-21** - Rozbudowa z 13 do 50+ targetów
  - Dodano: install, test, lint, clean, version, changelog, readme-check
  - Dodano: frontmatter, auto-tag, git-status, commit, git-push
  - Dodano: obsidian-fix, vscode-fix, doctor, banner, status
  - Naprawiono: GitHub targets (TAB syntax)

- **2025-11-20** - Wersja podstawowa
  - Plan dnia TODO + 13 kroków migracji SSH
  - GitHub & AI Tools setup

## 🔗 Backlinks

- [[docs/infra/legacy/legacy]]
- [[docs/docs]]
- [[INDEX]]
