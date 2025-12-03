---
version: 0.0.5
title: "ROOT-MINIMIZATION"
created: 2025-11-21
modified: 2025-11-29
tags:
  - auto-versioned
---

created: 2025-11-21T15:00:00Z
modified: 2025-11-24T22:31:02Z
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
title: "🧹 Root Directory Minimalization"






owner: jakubc
created: 2025-11-21T15:00:00Z
modified: 2025-11-24T22:31:02Z
author: jakubc
---

# 🧹 Root Directory Minimalization

> **Ultra-profesjonalna minimalizacja** - tylko essentials w root

## 📊 Statystyki

### Przed → Po

```
POCZĄTEK SESJI:   20+ plików w root
PO PIERWSZYM:     10 plików
TERAZ:            8 plików ✨
```

### Redukcja

- **Plików:** -60% (20 → 8)
- **Status:** Ultra-profesjonalne
- **Czas trwania:** 2 fazy czyszczenia


## 📄 Pliki w Root (8 essentials)

| # | Plik | Opis | Rozmiar |
|---|------|------|---------|
| 1 | `README.md` | Główna dokumentacja | ~13 KB |
| 2 | `CHANGELOG.md` | Historia zmian | ~2 KB |
| 3 | `Makefile` | Automatyzacja zadań | ~7 KB |
| 4 | `VERSION` | Wersja projektu | <1 KB |
| 5 | `init-eww.sh` | Init script | ~2 KB |
| 6 | `package.json` | NPM dependencies | ~200 B |
| 7 | `package-lock.json` | NPM lock | ~344 KB |
| 8 | `.editorconfig` | Editor config | ~1 KB |

**Hidden files:**
- `.gitignore`
- `.gitattributes`


## 📦 Historia Przeniesień

### Faza 1: Pierwsze czyszczenie

**Do docs/:**
- `AGENTS.md` → `docs/AGENTS.md`
- `INDEX.md` → `docs/INDEX.md` (faza 1)
- `FULL-INDEX.md` → `docs/FULL-INDEX.md`
- `Tags/` → `dev/obsidian/tags/` (symlink: `docs/infra/tags/`)

**Do config/:**
- `.copilotrc.yml` → `config/copilot.yml`
- `.markdownlint.json` → `config/.markdownlint.json`
- `.yamllint.yaml` → `config/.yamllint.yaml`
- `.vale.ini` → `config/.vale.ini`
- `.vale/` → `config/.vale/`
- `.filedesc` → `config/.filedesc`
- `eww.code-workspace` → `config/eww.code-workspace`

**Do .githooks/:**
- `.pre-commit-config.yaml` → `.githooks/.pre-commit-config.yaml`

**Do .obsidian/:**
- `eww.md` → `.obsidian/eww.md`

**Do archive/:**
- `.makemd/` → `archive/.makemd/`
- `.space/` → `archive/.space/`

**Usunięte:**
- `.write-test`
- `.yamllint.yml` (duplikat)

### Faza 2: Ultra-minimalizacja

**Do docs/:**
- `INDEX.md` → `docs/INDEX.md` (przeniesiony ponownie)
- `FRONTMATTER_REPORT.md` → `docs/FRONTMATTER_REPORT.md`

**Do .obsidian/:**
- `.obsidian-ignore` → `.obsidian/.obsidian-ignore`

**Do archive/:**
- `03_DEVELOPMENT/` → `archive/03_DEVELOPMENT/` (stary folder)
- `04_TEAM/` → `archive/04_TEAM/` (stary folder)
- `avocado/` → `archive/avocado/` (stary projekt)
- `obsidian/` → `archive/obsidian/` (stary vault)


## 📁 Struktura Folderów (28 głównych)

### Core & Development (5)
- `bin/` - CLI commands
- `lib/` - Biblioteki
- `core/` - Rdzeń (SOP, templates, policies)
- `scripts/` - Skrypty pomocnicze
- `tests/` - Testy BATS

### Content (4)
- `docs/` - Dokumentacja
- `business/` - Biznes
- `dev/` - Development
- `projects/` - Projekty

### Infrastructure (4)
- `infra/` - Ansible, deployment
- `systemd/` - Service units
- `config/` - Konfiguracje
- `hooks/` - Git hooks

### Users & Data (4)
- `usr/` - Profile (jakubc, karinam)
- `var/` - Logs, status
- `keys/` - SSH keys
- `archive/` - Archiwum

### Other (4)
- `site/` - MkDocs site
- `tools/` - Dev tools
- `GOVERNANCE/` - Policies
- `Tags` - Symlink → `dev/obsidian/tags/` (legacy: `docs/infra/tags/`)

### Hidden (6)
- `.git/` - Repository
- `.github/` - GitHub Actions
- `.githooks/` - Git hooks
- `.obsidian/` - Obsidian vault config
- `.continue/` - Continue.dev AI
- `.vscode/` - VS Code settings


## 🎯 Zasady Root Directory

### Do zachowania

✅ **Essentials tylko:**
- README, CHANGELOG
- Makefile, VERSION
- Init scripts
- Package files
- Editor config

### Do przeniesienia

📦 **Dokumentacja** → `docs/`  
📦 **Config files** → `config/`  
📦 **Hidden folders** → odpowiednie lokalizacje  
📦 **Stare projekty** → `archive/`  

### Do usunięcia

🗑️ Duplikaty  
🗑️ Temporary files  
🗑️ Nieużywane configs  


## 📈 Porównanie z Innymi Repo

| Typ Repo | Plików w Root | Status |
|----------|--------------|--------|
| Typowe | 15-20 | Bałagan |
| Dobre | 10-15 | OK |
| Profesjonalne | 6-10 | Świetne |
| **EWW** | **8** | **Ultra!** ✨ |


## 🔧 Maintenance

### Sprawdzanie czystości

```bash
# Policz pliki w root
ls -1 | grep -v "^\.git$" | wc -l

# Powinno być: 8 plików + foldery
```

### Auto-cleanup

```bash
# Użyj Makefile
make clean

# Lub skrypt
./scripts/bash/cleanup-root.sh
```

### Zasady

1. **Nowe pliki MD** → `docs/`
2. **Nowe config** → `config/`
3. **Nowe skrypty** → `scripts/` lub `bin/`
4. **Nie dodawaj** plików do root bez powodu!


## 📚 Dokumenty Powiązane

- [[docs/ROOT-STRUCTURE|ROOT-STRUCTURE]] - Pełna struktura
- [[docs/OBSIDIAN-SETUP|OBSIDIAN-SETUP]] - Obsidian config
- [[docs/INDEX|INDEX]] - Główny index


**Status:** Ultra-profesjonalne ✨  
**Plików w root:** 8  
**Ostatnia minimalizacja:** 2025-11-21  
**Rezultat:** Najczystsze repo ever! 🎉

## 🔗 Backlinks

- [[docs/governance/governance]]
- [[docs/docs]]
- [[INDEX]]