---
title: Struktura repozytorium
description: Organizacja katalogów i plików w projekcie E-Waste Workshop
tags:
  - structure
  - organization
  - documentation
language: pl
---

# 📁 Struktura repozytorium E-Waste Workshop

## 🗂️ Organizacja główna

```
eww/
├── business/          # Procesy biznesowe i governance
├── usr/              # Katalogi użytkowników projektu
├── core/             # Konfiguracje systemowe i workflow
├── dev/              # Narzędzia deweloperskie
├── lib/              # Biblioteki współdzielone
├── bin/              # Binaria wykonywalne
├── docs/             # Dokumentacja projektu
├── archive/          # Archiwum historyczne
└── Tags/             # System tagów Obsidian
```

## 📂 Szczegółowy opis katalogów

### `business/` - Biznes i governance

Procesy biznesowe, metodyki, governance projektu.

```
business/
├── governance/       # Struktura zarządzania, plany, strategie
├── methodologies/    # Metodyki pracy (PARA, Blitzscaling, DevOps)
├── processes/        # Procesy operacyjne
└── vendors/          # Dokumentacja wykonawców/vendorów
```

**Zawiera:**
- Plany biznesowe (MVP, cele)
- Metodyki pracy (PARA, Second Brain)
- Procesy operacyjne
- Governance i team structure

### `usr/` - Katalogi użytkowników

Osobiste workspace'y członków zespołu.

```
usr/
├── jakubc/          # Workspace Jakuba
├── karinam/         # Workspace Kariny
└── gary/            # Workspace Gary'ego
```

**Każdy katalog użytkownika zawiera:**
- Osobiste notatki i dokumenty
- TODOs i plany
- Study notes
- Projekty osobiste

### `core/` - Konfiguracje systemowe

Pliki konfiguracyjne, workflow, systemd, zmienne systemowe.

```
core/
├── bashrc.eww.snippet    # Snippet do ~/.bashrc
├── gitconfig.repo        # Git config dla repo
├── copilot.yml          # GitHub Copilot config
├── eww.code-workspace   # VSCode workspace
├── pre-commit.yaml      # Git hooks
├── pulseaudio-gerc.pa   # PulseAudio config
├── VERSION              # Numer wersji
├── systemd/             # Usługi systemd --user
├── workflow/            # Dokumentacja workflow
├── tasks/               # Zadania (jakubc/)
├── var/                 # Zmienne, logi, status
├── tags/                # System tagów
└── inbox/               # Importy vaultów (gitignore)
```

**Cel:**
- Centralna konfiguracja systemu
- Workflow i procesy
- Runtime data i logi

### `dev/` - Development tools

Narzędzia deweloperskie, skrypty, testy, projekty.

```
dev/
├── bin/              # Binaria deweloperskie
├── cfg/              # Konfiguracje dev
├── docs/             # Dokumentacja deweloperska
├── lib/              # Biblioteki dev
├── scripts/          # Skrypty pomocnicze
├── systemd/          # Usługi systemd dev
├── tests/            # Testy (BATS)
├── tests-tools/      # Narzędzia testowe
├── projects/         # Projekty deweloperskie (init)
├── Playbooks/        # Ansible playbooks
└── Projects/         # Projekty Obsidian
```

**Zawiera:**
- Skrypty automatyzacji
- Testy jednostkowe i integracyjne
- Narzędzia CI/CD
- Projekty pomocnicze

### `lib/` - Biblioteki Bash

Współdzielone funkcje i biblioteki Bash.

```
lib/
├── banner.sh         # Funkcje banerów
├── git.sh           # Helpery Git
├── log.sh           # System logowania
├── idempotent.sh    # Operacje idempotentne
├── sys.sh           # Helpery systemowe
└── bash/            # Dodatkowe moduły
```

**Zasady:**
- Funkcje w stylu `namespace::function_name`
- Komentarze po polsku
- Dokumentacja w nagłówkach plików

### `bin/` - Wykonywalne binaria

Główne skrypty CLI użytkownika.

```
bin/
└── eww-setup-plugins-monitor
```

**Konwencje:**
- Nazwa: `eww-nazwa-funkcji`
- Shebang: `#!/usr/bin/env bash`
- `set -euo pipefail`
- Bez rozszerzenia `.sh`

### `docs/` - Dokumentacja

Kompletna dokumentacja projektu.

```
docs/
├── README.md             # Główna dokumentacja
├── guide/               # Przewodniki
├── infra/               # Dokumentacja infrastruktury
├── software/            # Dokumentacja software
├── wiki/                # Wiki projektu
└── archive/             # Archiwalne docs
```

### `archive/` - Archiwum

Historyczne pliki, backupy, przestarzałe komponenty.

```
archive/
├── backups/            # Backupy plików
└── usr-karinam-add.patch
```

## 📜 Pliki główne katalogu

### Dokumentacja
- `README.md` - Landing page projektu
- `AGENTS.md` - Kontekst dla AI Coding Agents
- `CONTRIBUTING.md` - Jak kontrybuować
- `CODE_OF_CONDUCT.md` - Kodeks postępowania
- `SECURITY.md` - Polityka bezpieczeństwa
- `CHANGELOG.md` - Historia zmian
- `TODO.md` - Lista zadań projektu

### Konfiguracja
- `LICENSE` - Licencja MIT
- `Makefile` - Automatyzacja zadań
- `VERSION` - Numer wersji (x.y.z.b)

### Pliki ukryte
- `.gitignore` - Wykluczenia Git
- `.gitattributes` - Atrybuty Git
- `.github/` - GitHub Actions, templates
- `.obsidian/` - Konfiguracja Obsidian
- `.vscode/` - Konfiguracja VSCode

## 🎯 Zasady organizacji

### Naming conventions

**Katalogi:**
- Lowercase z myślnikami: `catalog-name/`
- Wyjątki: `Tags/`, `CHANGELOG.md`, `README.md`

**Pliki:**
- Markdown: `nazwa-pliku.md`
- Bash: `nazwa-skryptu.sh`
- Binaria: `eww-nazwa` (bez rozszerzenia)
- Konfiguracje: `.nazwa-config`

**Branches Git:**
- `feat/nazwa-funkcji`
- `fix/nazwa-bugfixa`
- `chore/nazwa-zadania`
- `docs/nazwa-dokumentacji`

### Co gdzie wrzucać?

**Biznes → `business/`:**
- Plany, strategie, governance
- Metodyki pracy
- Procesy operacyjne

**Osobiste → `usr/username/`:**
- Notatki osobiste
- Study notes
- TODOs osobiste

**Konfiguracja → `core/`:**
- Pliki config systemowe
- Workflow i procesy
- Systemd services

**Development → `dev/`:**
- Skrypty pomocnicze
- Testy
- Narzędzia CI/CD

**Kod współdzielony → `lib/`:**
- Funkcje Bash używane w wielu miejscach
- Helpery systemowe

**CLI tools → `bin/`:**
- Główne narzędzia użytkownika
- Skrypty wykopywalne

**Dokumentacja → `docs/`:**
- Przewodniki
- Specyfikacje
- Wiki

## 🚫 Co NIE trafia do Git

Skonfigurowane w `.gitignore`:

**Duże pliki:**
- `core/inbox/` - importy vaultów (2.7GB)
- `usr/karinam/devices/` - zdjęcia i media

**Cache i temp:**
- `.obsidian/cache/`, `.obsidian/workspace.json`
- `.makemd/thumbnails/`, `*.mdc`
- `tmp/`, `*.tmp`

**Generowane:**
- `core/reports/repo-stats.md`
- `node_modules/`
- `*.log`

**Osobiste:**
- `.obsidian/workspace.json` (lokalne)
- `.obsidian/hotkeys.json`
- `.vscode/settings.json` (częściowo)

## 📊 Statystyki (przykładowe)

```
Katalogi główne:     9
Pliki Markdown:      ~500
Skrypty Bash:        ~50
Pliki konfiguracji:  ~30
Całkowity rozmiar:   ~3GB (z inbox)
Bez cache/inbox:     ~200MB
```

## 🔄 Synchronizacja

**Git remotes:**
```bash
upstream  https://github.com/Nairecth/eww.git  # Główne repo (Jakub)
origin    git@github.com:Kari-Tori/eww.git     # Twój fork
```

**Workflow:**
```bash
git fetch upstream        # Pobierz zmiany Jakuba
git merge upstream/main   # Połącz lokalnie
git push origin main      # Wypchnij na fork
# GitHub PR: origin → upstream
```

## 📚 Zobacz też

- [README.md](README.md) - Landing page
- [AGENTS.md](AGENTS.md) - Kontekst dla AI
- [CONTRIBUTING.md](CONTRIBUTING.md) - Jak kontrybuować
- [docs/README.md](docs/README.md) - Główna dokumentacja

---

**Ostatnia aktualizacja:** 2025-11-26  
**Wersja:** 0.0.0.5
