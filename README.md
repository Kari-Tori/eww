---
title: E-Waste Workshop README
description: Kompletna dokumentacja projektu - instalacja, konfiguracja, użycie
version: 0.0.0.4
author: Nairecth
repository: https://github.com/Nairecth/eww
website: http://www.e-wasteworkshop.co.uk
tags:
  - bash
  - kubuntu
  - automation
  - devtools
  - documentation
category: documentation
type: readme
audience: developers
language: pl
platform: Kubuntu 24.04 LTS
requires:
  - bash >= 5.1
  - git
  - make
created: 2024-11-08
updated: 2025-11-09
license: MIT
status: stable
---

<!-- markdownlint-disable-next-line MD025 -->
<!-- 
  README.md - Główna dokumentacja projektu E-Waste Workshop
  
  Plik stanowi centralny punkt dokumentacji dla projektu EWW (E-Waste Workshop).
  Zawiera kompletne informacje o instalacji, konfiguracji i użytkowaniu systemu.
  
  STRUKTURA DOKUMENTU:
  ====================
  1. Metadane YAML - informacje o dokumencie, wersji, autorze
  2. Quick Start - instalacja "one-liner" dla nowych użytkowników
  3. Demo - przykładowa sesja instalacji
  4. Wymagania - lista wymagań systemowych i zależności
  5. Instalacja - szczegółowe kroki instalacji krok po kroku
  6. Konfiguracja - zmienne środowiskowe i opcje konfiguracji
  7. Użycie - podstawowe operacje i przykłady użycia
  8. Struktura projektu - organizacja katalogów i plików
  9. Narzędzia deweloperskie - CLI tools i automatyzacja
  10. Dokumentacja - linki do dodatkowych zasobów
  11. Contributing - zasady współpracy i konwencje
  12. License - informacje o licencji
  
  AUTOMATYZACJA:
  ==============
  - Badżki shields.io z aktualnym statusem buildu, wersji, licencji
  - Statystyki projektu (liczba plików, katalogów, narzędzi)
  - Linki do CHANGELOG.md, INDEX.md, AGENTS.md
  - Automatyczna weryfikacja spójności przez ./dev/scripts/check_readme.sh
  
  KONWENCJE:
  ==========
  - Markdown z rozszerzeniami GitHub Flavored Markdown
  - Callout bloki (TIP, NOTE, WARNING, INFO, EXAMPLE)
  - Tabele dla strukturyzowanych danych
  - Code blocks z syntax highlighting
  - Emoji dla wizualnego wyróżnienia sekcji
  
  AKTUALIZACJA:
  =============
  - Ręczna edycja dla treści merytorycznej
  - Automatyczna weryfikacja przez check_readme.sh
  - Aktualizacja statystyk przez eww-status
  - Sync z VERSION, CHANGELOG.md po każdym release
  
  POWIĄZANE PLIKI:
  ================
  - INDEX.md - szczegółowy indeks projektu
  - CHANGELOG.md - historia zmian
  - AGENTS.md - kontekst dla AI agents
  - MVP.md - kryteria akceptacji
  - .filedesc - system opisów plików
  
  KONSERWACJA:
  ============
  - Weryfikuj spójność wersji: README, VERSION, CHANGELOG
  - Aktualizuj statystyki po dodaniu nowych plików/katalogów
  - Dodawaj nowe narzędzia do sekcji "Narzędzia deweloperskie"
  - Aktualizuj wymagania przy zmianach w zależnościach
  - Sprawdzaj poprawność linków (make check-links jeśli dostępne)
  
  AUTOR: Nairecth
  UTWORZONO: 2024-11-08
  OSTATNIA AKTUALIZACJA: 2025-11-09
  WERSJA: 0.0.0.4
-->

<!-- markdownlint-disable MD025 -->
# E-Waste Workshop — Centrum Recyklingu i Refabrykacji

> Repozytorium zawiera szablony i skrypty inicjalizujące środowisko
> E-Waste Workshop.

[🌐 Strona główna](http://www.e-wasteworkshop.co.uk)
[📦 Repozytorium GitHub](https://github.com/Nairecth/eww)
[⚡ Przejdź do Quick Start](#quick-start)

🔧 Skonfiguruj system Kubuntu do pracy z EWW w mniej niż 5 minut –
wystarczy pobrać i zsource'ować jeden skrypt.

<!-- Badżki -->
![build-status](https://img.shields.io/badge/build-passing-brightgreen)
![release](https://img.shields.io/badge/release-v0.0.0.4-blue)
![license](https://img.shields.io/badge/license-MIT-green)
![bash](https://img.shields.io/badge/bash-5.1+-blue)
![platform](https://img.shields.io/badge/platform-Kubuntu%2024.04-orange)

**Wersja: 0.0.0.4** | **Ostatni commit:** `ebe70c9` | **Aktualizacja:** 2025-11-09

[📋 CHANGELOG](CHANGELOG.md) | [🗂️ INDEX](INDEX.md) | [🤖 AI Context](AGENTS.md)

## 📊 Statystyki projektu

- 📁 **Katalogi:** 29
- 📄 **Pliki:** 93  
- 📜 **Opisanych:** 117 (system .filedesc)
- 🛠️ **Narzędzia dev:** 10 (dev/bin/)
- 📚 **Biblioteki:** 5 (lib/*.sh)

## Spis treści

- [Quick start](#quick-start)
- [Demo](#demo)
- [Wymagania](#wymagania)
- [Instalacja](#instalacja)
- [Konfiguracja](#konfiguracja)
- [Użycie](#użycie)
- [Struktura projektu](#struktura-projektu)
- [Narzędzia deweloperskie](#narzędzia-deweloperskie)
- [Dokumentacja](#dokumentacja)
- [Contributing](#contributing)
- [License](#license)

## Quick start

Jak uruchomić — TL;DR

Skopiuj cały blok, wklej w interaktywną powłokę bash i zatwierdź `Enter`:

```bash
# E-Waste Workshop — instalacja w jednym kroku
sudo mkdir -p /git && sudo chown "$USER":"$USER" /git
cd /git
now="$(date +%F)"

if ! command -v git >/dev/null 2>&1; then
    sudo apt-get update && sudo apt-get install -y git
fi

git clone https://github.com/Nairecth/eww.git
cd eww

# Backup poprzedniej konfiguracji (jeśli istnieje)
if grep -q "init-eww.sh" ~/.bashrc 2>/dev/null; then
    cp ~/.bashrc ~/.bashrc.bak."$now"
fi

# Dodaj source do .bashrc
echo "source /git/eww/init-eww.sh" >> ~/.bashrc
source ~/.bashrc
```

✅ **Gotowe!** Otwórz nowy terminal lub wykonaj `source ~/.bashrc`

## Demo

Przykładowa sesja instalacji:

```bash
$ cd /git
$ git clone https://github.com/Nairecth/eww.git
Cloning into 'eww'...
remote: Enumerating objects: 453, done.
remote: Counting objects: 100% (453/453), done.
Receiving objects: 100% (453/453), 2.14 MiB | 5.32 MiB/s, done.

$ cd eww
$ source init-eww.sh

[EWW] ✓ Inicjalizacja zakończona
[EWW] ROOT: /git/eww
[EWW] PATH zaktualizowany: dev/bin
[EWW] Dostępne komendy: eww-status, eww-changelog, eww-tree
[EWW] Wpisz: eww-status

$ eww-status
╔══════════════════════════════════════╗
║   E-Waste Workshop - Status v0.0.0.4 ║
╚══════════════════════════════════════╝

✓ Wersja: 0.0.0.4
✓ Git repo: /git/eww
✓ Branch: main
✓ Ostatni commit: ebe70c9
✓ Narzędzia: 10
✓ Biblioteki: 5
```

## Wymagania

### System

- **OS:** Kubuntu 24.04 LTS (lub kompatybilny Ubuntu/Debian)
- **Shell:** Bash 5.1+
- **Git:** 2.34+
- **Make:** GNU Make 4.3+

### Opcjonalne

- **BATS** - dla testów (instalacja: `sudo apt install bats`)
- **ShellCheck** - linting Bash (instalacja: `sudo apt install shellcheck`)
- **GitHub CLI (`gh`)** - integracja z GitHub

### Sprawdź wymagania

```bash
# Wersja Bash
bash --version | head -1

# Wersja Git
git --version

# Wersja Make
make --version | head -1
```

## Instalacja

### Automatyczna (zalecana)

Zobacz sekcję [Quick Start](#quick-start) powyżej.

### Manualna

```bash
# 1. Utwórz katalog /git
sudo mkdir -p /git
sudo chown "$USER":"$USER" /git

# 2. Sklonuj repo
cd /git
git clone https://github.com/Nairecth/eww.git
cd eww

# 3. Dodaj do .bashrc
echo "source /git/eww/init-eww.sh" >> ~/.bashrc

# 4. Załaduj konfigurację
source ~/.bashrc
```

## Konfiguracja

### Zmienne środowiskowe

Po inicjalizacji dostępne są:

```bash
EWW_ROOT="/git/eww"              # Katalog główny projektu
EWW_CD_ROOT=1                     # Auto-cd do EWW_ROOT przy starcie terminala
EWW_BANNER_ENABLE=1               # Pokazuj baner powitalny
EWW_INIT_OK=1                     # Flaga poprawnej inicjalizacji
```

### Konfiguracja repo Git

```bash
# Konfiguracja Git dla repo (opcjonalnie)
cp cfg/gitconfig.repo .git/config

# Pre-commit hooks (opcjonalnie)
cp cfg/pre-commit.yaml .pre-commit-config.yaml
```

### Dostosowanie

Edytuj `init-eww.sh` według potrzeb:

```bash
# Wyłącz baner
export EWW_BANNER_ENABLE=0

# Zmień katalog główny
export EWW_ROOT="/home/$USER/projekty/eww"

# Wyłącz auto-cd
export EWW_CD_ROOT=0
```

## Użycie

### Podstawowe komendy

```bash
# Status projektu
eww-status

# Wygeneruj changelog z commitów Git
eww-changelog
eww-changelog --unreleased

# Pokaż drzewo projektu z opisami
eww-tree
eww-tree docs/

# Wygeneruj INDEX.md
eww-index

# Dodaj YAML frontmatter do Markdown
eww-frontmatter --auto README.md
eww-frontmatter --dry-run docs/guide.md

# Diagnostyka środowiska
eww-doctor
```

### Makefile

```bash
# Pokaż wszystkie dostępne komendy
make help

# Changelog z commitów Git
make changelog

# Wygeneruj INDEX.md
make index

# Dodaj frontmatter
make frontmatter FILE=docs/guide.md
make frontmatter-dry FILE=README.md

# Drzewo projektu
make tree
make tree PATH=lib/

# Automatyczne komentarze w kodzie
make comment-add FILE=lib/git.sh

# Wydaj nową wersję
make release VERSION=0.0.0.5
```

### Testy

```bash
# Uruchom wszystkie testy
bats dev/tests/

# Konkretny test
bats dev/tests/test_init.bats

# Walidacja README
./dev/scripts/check_readme.sh
```bash
./dev/scripts/check_readme.sh
```

## Struktura projektu

```text
eww/
├── init-eww.sh           # Główny skrypt inicjalizacyjny
├── VERSION               # Numer wersji (0.0.0.4)
├── Makefile              # Automatyzacja zadań
├── .filedesc             # Opisy plików i katalogów
├── README.md             # Ten plik
├── INDEX.md              # Kompletny indeks (auto-generowany)
├── CHANGELOG.md          # Historia zmian
├── AGENTS.md             # Kontekst dla AI
├── MVP.md                # Kryteria MVP
│
├── lib/                  # Biblioteki współdzielone
│   ├── banner.sh         # Funkcje banerów
│   ├── git.sh            # Helpery Git
│   ├── log.sh            # System logowania
│   ├── idempotent.sh     # Operacje idempotentne
│   └── sys.sh            # Helpery systemowe
│
├── dev/                  # Narzędzia deweloperskie
│   ├── bin/              # Skrypty CLI
│   │   ├── eww-status    # Status projektu
│   │   ├── eww-changelog # Generator changelogu
│   │   ├── eww-tree      # Drzewo z opisami
│   │   ├── eww-index     # Generator INDEX.md
│   │   ├── eww-frontmatter # YAML metadata
│   │   ├── eww-banner    # Generator banerów
│   │   ├── eww-commit    # Helper commitów
│   │   └── eww-doctor    # Diagnostyka
│   ├── scripts/          # Pomocnicze skrypty
│   ├── tests/            # Testy BATS
│   ├── systemd/          # Jednostki systemd
│   └── cfg/              # Pliki konfiguracyjne
│
├── docs/                 # Dokumentacja
│   ├── README.md         # Indeks dokumentacji
│   ├── dokumentacja.md   # Przewodnik dokumentowania
│   ├── guide/            # Przewodniki użytkownika
│   └── wiki/             # Wiki projektu
│
└── archive/              # Archiwum starych plików
    ├── backups/          # Backupy
    ├── infra/            # Infrastruktura (Ansible)
    └── www/              # Strony WWW
```

## Narzędzia deweloperskie

### CLI Tools (dev/bin/)

| Narzędzie | Opis |
|-----------|------|
| `eww-status` | Pokazuje status projektu (wersja, Git, statystyki) |
| `eww-changelog` | Generuje changelog z commitów Git (Conventional Commits) |
| `eww-tree` | Wyświetla drzewo katalogów z opisami z .filedesc |
| `eww-index` | Generuje INDEX.md na podstawie .filedesc |
| `eww-frontmatter` | Dodaje/aktualizuje YAML frontmatter w Markdown |
| `eww-banner` | Generuje kolorowe banery ASCII |
| `eww-commit` | Helper do commitów z Conventional Commits |
| `eww-doctor` | Diagnostyka środowiska i zależności |

### Biblioteki (lib/)

| Plik | Funkcje |
|------|---------|
| `banner.sh` | `banner::show()`, `banner::simple()` |
| `git.sh` | `git::last_tag()`, `git::is_clean()`, `git::get_version()` |
| `log.sh` | `log_info()`, `log_warn()`, `log_error()`, `log_success()` |
| `idempotent.sh` | `idempotent::check()`, `idempotent::mark()` |
| `sys.sh` | `sys::detect_os()`, `sys::check_deps()` |

### System .filedesc

Centralna baza opisów plików i katalogów (117 wpisów):

```bash
# Format: ścieżka|Opis
lib/git.sh|Funkcje pomocnicze do operacji Git
dev/bin/eww-tree|Wyświetla drzewo katalogów z opisami
docs/dokumentacja.md|Przewodnik dokumentowania projektu
```



## Dokumentacja

- **[INDEX.md](INDEX.md)** - Kompletny indeks projektu z opisami (auto-generowany)
- **[CHANGELOG.md](CHANGELOG.md)** - Historia zmian (Keep a Changelog format)
- **[AGENTS.md](AGENTS.md)** - Kontekst dla AI coding agents
- **[MVP.md](MVP.md)** - Kryteria akceptacji MVP
- **[docs/](docs/)** - Wiki, przewodniki, dokumentacja MkDocs


**Użycie:**

```bash
# Znajdź plik po nazwie
grep "eww-tree" .filedesc

# Znajdź po opisie  
grep -i "changelog" .filedesc

# Wygeneruj INDEX.md na nowo
make index

# Wyświetl drzewo z opisami
eww-tree
```

### Automatyzacja

Wszystkie powtarzalne zadania dostępne przez `make`:

```bash
make help              # Lista wszystkich targetów
make changelog         # Changelog z Git
make index             # Regeneruj INDEX.md
make tree              # Drzewo projektu
make frontmatter FILE=x # Dodaj YAML metadata
make release VERSION=x  # Wydaj nową wersję
```


## Contributing

1. Fork projektu
2. Utwórz branch dla feature: `git checkout -b feat/nowa-funkcja`
3. Dodaj testy w `dev/tests/`
4. Commituj z Conventional Commits: `git commit -m "feat: opis"`
5. Wyślij PR

### Konwencje

- **Commity**: `feat:`, `fix:`, `chore:`, `docs:`, `refactor:`, `test:`
- **Kod Bash**:
  - Używaj `#!/usr/bin/env bash` i `set -euo pipefail`
  - Funkcje: `namespace::funkcja()` lub `funkcja_pomocnicza()`
  - Zmienne globalne: `EWW_NAZWA_ZMIENNEJ`
  - Zmienne lokalne: `local nazwa_zmiennej`
  - **Komentarze i komunikaty PO POLSKU**
- **Testowanie**: Każda nowa funkcja powinna mieć test w BATS
- **Dokumentacja**: Aktualizuj `.filedesc` i README

Zobacz [.github/copilot-instructions.md](.github/copilot-instructions.md) dla pełnych wytycznych.

## License

TBD - Do ustalenia

---

**Maintainer:** [Nairecth](https://github.com/Nairecth)  
**Repository:** [github.com/Nairecth/eww](https://github.com/Nairecth/eww)  
**Website:** [www.e-wasteworkshop.co.uk](http://www.e-wasteworkshop.co.uk)
