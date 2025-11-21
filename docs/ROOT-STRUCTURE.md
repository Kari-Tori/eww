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
title: "📁 Struktura Głównego Katalogu"






---

# 📁 Struktura Głównego Katalogu

> **Root directory** - tylko essentials, wszystko uporządkowane

## 📄 Pliki w Root (10 plików)

```
eww/
├── README.md              # Główna dokumentacja projektu
├── CHANGELOG.md           # Historia zmian
├── Makefile               # Automatyzacja zadań
├── VERSION                # Wersja projektu
├── init-eww.sh           # Główny skrypt inicjalizacyjny
├── package.json          # NPM dependencies
├── package-lock.json     # NPM lock
├── .gitignore            # Git ignore rules
├── .gitattributes        # Git attributes
└── .editorconfig         # Editor config
```

## 📂 Foldery w Root (organizacja)

### 🔧 Core & Development

| Folder | Opis | Zawartość |
|--------|------|-----------|
| **bin/** | Skrypty CLI | Wykonywalne komendy `eww-*` |
| **lib/** | Biblioteki | Funkcje współdzielone (`.sh`) |
| **core/** | Rdzeń systemu | Policies, SOP, templates |
| **scripts/** | Skrypty pomocnicze | Automation, utilities |
| **tests/** | Testy | BATS tests |

### 📚 Documentation & Content

| Folder | Opis | Zawartość |
|--------|------|-----------|
| **docs/** | Dokumentacja | MD files, guides, references |
| **business/** | Biznes | Operacje, finanse, sprzedaż |
| **dev/** | Development | Projekty, playbooks, ideas |
| **projects/** | Projekty | Init scripts, e-waste-workshop |

### 🔨 Infrastructure

| Folder | Opis | Zawartość |
|--------|------|-----------|
| **infra/** | Infrastruktura | Ansible, inventory, roles |
| **systemd/** | Systemd units | Service files |
| **config/** | Konfiguracje | Config files, settings |
| **hooks/** | Git hooks | Pre-commit, etc |

### 👥 Users & Data

| Folder | Opis | Zawartość |
|--------|------|-----------|
| **usr/** | Profile użytkowników | jakubc/, karinam/ |
| **var/** | Dane zmienne | Logs, status, runtime |
| **keys/** | Klucze | SSH keys, credentials |
| **archive/** | Archiwum | Stare pliki, backup |

### 🌐 Web & Publishing

| Folder | Opis | Zawartość |
|--------|------|-----------|
| **site/** | Strona WWW | Generated site (MkDocs) |

### 🛠️ Tools

| Folder | Opis | Zawartość |
|--------|------|-----------|
| **tools/** | Narzędzia | Dev tools, utilities |

### 📋 Governance

| Folder | Opis | Zawartość |
|--------|------|-----------|
| **GOVERNANCE/** | Zarządzanie | Policies, contracts |


## 🗂️ Hidden Directories (zostają w root)

```
.git/              # Git repository
.github/           # GitHub workflows, configs
.githooks/         # Git hooks (pre-commit)
.obsidian/         # Obsidian vault config
.continue/         # Continue.dev AI config
.vscode/           # VS Code workspace settings
```

**W .gitignore:**
```gitignore
.continue/
.vscode/
.obsidian/
```


## 📦 Przeniesione z Root

### Do docs/
- `AGENTS.md` → `docs/AGENTS.md`
- `INDEX.md` → `docs/INDEX.md`
- `FULL-INDEX.md` → `docs/FULL-INDEX.md`
- `Tags/` → `docs/tags/`

### Do config/
- `.copilotrc.yml` → `config/copilot.yml`
- `.markdownlint.json` → `config/.markdownlint.json`
- `.yamllint.yaml` → `config/.yamllint.yaml`
- `.vale.ini` → `config/.vale.ini`
- `.vale/` → `config/.vale/`
- `.filedesc` → `config/.filedesc`
- `eww.code-workspace` → `config/eww.code-workspace`

### Do .githooks/
- `.pre-commit-config.yaml` → `.githooks/.pre-commit-config.yaml`

### Do .obsidian/
- `eww.md` → `.obsidian/eww.md`

### Do archive/
- `.makemd/` → `archive/.makemd/`
- `.space/` → `archive/.space/`

### Usunięte
- `.write-test` - testowy plik
- `.yamllint.yml` - duplikat


## 🎯 Zasady Organizacji

### Root Directory Rules

1. **Tylko pliki kluczowe** - README, Makefile, VERSION, package.json
2. **Foldery główne** - max 20-25 folderów
3. **Hidden dirs** - tylko niezbędne (.git, .github, .obsidian, .continue, .vscode)
4. **Config files** - w `config/` nie w root
5. **Dokumentacja** - w `docs/` nie w root

### Naming Conventions

- **Foldery:** `lowercase-kebab-case/`
- **Pliki:** `lowercase-kebab-case.ext`
- **Skrypty:** `eww-nazwa` (bez .sh w bin/)
- **Biblioteki:** `nazwa.sh` (w lib/)
- **Hidden:** `.nazwa` tylko gdy wymagane

### Co gdzie

| Typ | Lokalizacja |
|-----|-------------|
| Dokumentacja MD | `docs/` |
| Config files | `config/` |
| Wykonywalne | `bin/` |
| Biblioteki | `lib/` |
| Skrypty pomocnicze | `scripts/` |
| Testy | `tests/` |
| Systemd units | `systemd/` |
| User data | `usr/` |
| Temp/logs | `var/` |


## 📊 Statystyki

```bash
# Pliki w root
ls -1 | grep -v "^\.git$" | wc -l
# Output: ~28

# Tylko pliki (nie foldery)
ls -1 *.md *.json *.sh 2>/dev/null | wc -l
# Output: 10

# Hidden directories
ls -1d .* | grep -v "^\.$" | wc -l
# Output: 6
```


## 🔧 Maintenance

### Sprawdź strukturę
```bash
tree -L 1 -a
```

### Znajdź misplaced files
```bash
# Config files w root
find . -maxdepth 1 -name ".*" -type f

# MD files w root (powinny być w docs/)
find . -maxdepth 1 -name "*.md"
```

### Cleanup
```bash
# Auto-cleanup
make clean

# Manual
mv *.md docs/              # MD files
mv .*.yml config/          # Config files
```


**Zaktualizowano:** 2025-11-21  
**Stan:** ✅ Uporządkowany  
**Plików w root:** 10  
**Folderów w root:** ~28
