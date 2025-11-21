---
tags:
  - #automation
  - #development
  - #eww
  - #knowledge
  - #linux
  - #productivity
  - #secondbrain
created: 2025-11-01T09:00:00Z
modified: 2025-11-01T09:00:00Z
author: jakubc
title: "E-Waste Workshop — Centrum Recyklingu i Refabrykacji"






---
# E-Waste Workshop — Centrum Recyklingu i Refabrykacji

> Repozytorium zawiera szablony i skrypty inicjalizujące środowisko E-Waste Workshop.

🔧 Skonfiguruj system Ubuntu/Kubuntu do pracy z EWW w mniej niż 5 minut – wystarczy pobrać i zsource'ować jeden skrypt.

**About Us:** [🌐 E-Waste Workshop](http://www.e-wasteworkshop.co.uk) zajmuje się recyklingiem i refabrykacją sprzętu elektronicznego, promując zrównoważony rozwój i edukację w zakresie technologii.

[📦 Repozytorium GitHub](https://github.com/Nairecth/eww) | [⚡ Przejdź do Quick Start](#-quick-start)

> [!TIP] Skróty na start
> - [📁 Root Index](INDEX.md) — nawigacja po katalogu głównym
> - [🎨 Standard ikon Kubuntu/Code/Obsidian](docs/assets/icons.md)
> - [🟦 Kubuntu](docs/wiki/kubuntu.md) • [🧰 VS Code](docs/software/code/code.md) • [💠 Obsidian](docs/software/obsidian/obsidian.md)


<p align="center">
  <img src="https://img.shields.io/badge/status-pre--mvp-FFD700" alt="Status">
  <img src="https://img.shields.io/badge/version-0.0.0.5--pre--mvp-4169E1" alt="Version">
  <img src="https://img.shields.io/badge/license-MIT-00C853" alt="License">
  <br>
  <img src="https://img.shields.io/badge/bash-5.2+-00BCD4?logo=gnu-bash&logoColor=white" alt="Bash">
  <img src="https://img.shields.io/badge/ubuntu-25.04-E95420?logo=ubuntu&logoColor=white" alt="Ubuntu">
  <img src="https://img.shields.io/badge/git-2.48+-F05032?logo=git&logoColor=white" alt="Git">
  <img src="https://img.shields.io/badge/make-4.4+-4169E1" alt="Make">
  <br>
  <img src="https://img.shields.io/badge/📁_katalogi-305-9C27B0" alt="Katalogi">
  <img src="https://img.shields.io/badge/📄_pliki_md-664-8B5CF6" alt="Pliki MD">
  <img src="https://img.shields.io/badge/🛠️_cli_tools-10-FF6F00" alt="CLI Tools">
  <img src="https://img.shields.io/badge/📚_libs-5-00BCD4" alt="Libs">
  <img src="https://img.shields.io/badge/📝_docs-117-7CB342" alt="Docs">
  <br>
  <img src="https://img.shields.io/badge/język-polski-DC143C" alt="Język PL">
  <img src="https://img.shields.io/badge/maintained-yes-00C853" alt="Maintained">
  <img src="https://img.shields.io/badge/commit-ebe70c9-696969" alt="Last Commit">
  <img src="https://img.shields.io/badge/updated-2025--11--09-00ACC1" alt="Updated">
</p>

<p align="center">
  <a href="CHANGELOG.md">📋 Changelog</a> •
  <a href="INDEX.md">🗂️ Index</a> •
  <a href="docs/AGENTS.md">🤖 AI Context</a> •
  <a href="docs/MVP.md">🎯 MVP</a>
</p>


## ⚡ Quick Start

**Instalacja w jednym kroku** — skopiuj, wklej, zatwierdź `Enter`:

```bash
# E-Waste Workshop — instalacja
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

**Wymagania:** Bash 5.2+ | Git 2.34+ | Ubuntu 25.04


## 📖 Spis treści

- [⚡ Quick Start](#-quick-start)
- [📁 Root Index i ikonografia](#-root-index-i-ikonografia)
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

## 📁 Root Index i ikonografia

- [📁 Root Index](INDEX.md) — tabelaryczny spis katalogów i folder note'ów.
- [🎨 ICON-SET](docs/assets/icons.md) — standard ikon Kubuntu/Code/Obsidian stosowany w dokumentacji.
- [🟦 Kubuntu](docs/wiki/kubuntu.md), [🧰 Visual Studio Code](docs/software/code/code.md) i [💠 Obsidian](docs/software/obsidian/obsidian.md) — dedykowane przewodniki narzędziowe.
- [🤖 scripts/install-ai-toolkit.sh](scripts/install-ai-toolkit.sh) — instalator CLI + pluginów (VS Code, Obsidian) wykorzystywanych w projekcie.

> [!INFO]
> Linki z tej sekcji pomagają utrzymać spójny wygląd całego repozytorium oraz szybko odnaleźć opis dowolnego katalogu.

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
║   E-Waste Workshop - Status v0.0.0.5 ║
╚══════════════════════════════════════╝

✓ Wersja: 0.0.0.5
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

Zobacz sekcję [⚡ Quick Start](#-quick-start) powyżej.

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
```

## Struktura projektu

```text
eww/
├── init-eww.sh           # Główny skrypt inicjalizacyjny
├── VERSION               # Numer wersji (0.0.0.5)
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
make index             # Regeneruj INDEX.md
make check-folders     # Sprawdź folder notes
make update-indexes    # Zaktualizuj indeksy w folder notes
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


**Maintainer:** [Nairecth](https://github.com/Nairecth)
**Repository:** [github.com/Nairecth/eww](https://github.com/Nairecth/eww)
**Website:** [www.e-wasteworkshop.co.uk](http://www.e-wasteworkshop.co.uk)

````markdown
Host karina
  HostName IP_KARINY
  User karina
  IdentityFile ~/.ssh/karina-eww
````
