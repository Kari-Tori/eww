---
title: E-Waste Workshop README
description: Instrukcja uruchomienia i utrzymania środowiska E-Waste Workshop
tags:
  - docs
  - onboarding
updated: 2025-11-09
---

<!-- markdownlint-disable-next-line MD025 -->
# E-Waste Workshop — Centrum Recyklingu i Refabrykacji

> Repozytorium zawiera szablony i skrypty inicjalizujące środowisko
> E-Waste Workshop.

[🌐 Strona główna](http://www.e-wasteworkshop.co.uk)
[📦 Repozytorium GitHub](https://github.com/Nairecth/eww)
[⚡ Przejdź do „Jak uruchomić (TL;DR)”](#quick-start)

🔧 Skonfiguruj system Kubuntu do pracy z EWW w mniej niż 5 minut –
wystarczy pobrać i zsource’ować jeden skrypt.

<!-- Badge'y: maksymalnie 5, podmień URL-e na realne -->
![build-status](https://img.shields.io/badge/build-passing-brightgreen)
![release](https://img.shields.io/badge/release-v0.0.0.4-blue)
![license](https://img.shields.io/badge/license-MIT-green)
![bash](https://img.shields.io/badge/bash-5.1+-blue)
![platform](https://img.shields.io/badge/platform-Kubuntu%2024.04-orange)

**Wersja: 0.0.0.4** | [📋 CHANGELOG](CHANGELOG.md) | [🗂️ INDEX](INDEX.md) | [🤖 AI Context](AGENTS.md)

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

Skopiuj cały blok, wklej w interaktywną powłokę bash i zatwierdź
`Enter`:

```bash
# E-Waste Workshop — instalacja w jednym kroku
sudo mkdir -p /git && sudo chown "$USER":"$USER" /git
cd /git
now="$(date +%F)"
if ! command -v git >/dev/null 2>&1; then
  echo "[EWW] git nie znaleziony — instaluję..."
  sudo apt-get update -y && sudo apt-get install -y git
  if command -v lsb_release >/dev/null 2>&1; then
    echo "[EWW] System: $(lsb_release -ds)"
  else
    echo "[EWW] Kernel: $(uname -sr)"
  fi
  git --version
fi
if [ ! -d /git/eww/.git ]; then
  echo "[EWW] Klonuję repozytorium Nairecth/eww do /git/eww"
  git clone https://github.com/Nairecth/eww.git /git/eww
  echo "[EWW] Repozytorium E-Waste Workshop zapisane w /git/eww"
else
  echo "[EWW] Repozytorium już istnieje (${now}) — pobieram najnowsze"
  git -C /git/eww pull --ff-only
fi
cd /git/eww
echo "[EWW] Dodaję init-eww.sh do ~/.bashrc i uruchamiam inicjalizację"
grep -qxF 'source /git/eww/init-eww.sh' ~/.bashrc || \
  echo 'source /git/eww/init-eww.sh' >> ~/.bashrc
source /git/eww/init-eww.sh
echo "[EWW] Inicjalizacja zakończona (EWW_INIT_OK=${EWW_INIT_OK:-0})"
```

> [!TIP]
> Po zmianie `.bashrc` odpal `exec "$SHELL"`, aby natychmiast załadować
> nowe ustawienia.

**Co zrobi ten skrypt?**

- Upewni się, że katalog `/git` istnieje i należy do bieżącego użytkownika.
- Zainstaluje `git`, jeśli jeszcze go nie ma i przygotuje repozytorium w `/git/eww`.
- Dopisze `source /git/eww/init-eww.sh` do `~/.bashrc`, a następnie uruchomi inicjalizację.
- Na końcu pokaże stan `EWW_INIT_OK`; wartość `1` oznacza, że środowisko jest gotowe.

## Demo

> [!EXAMPLE]
> Poniżej przykładowa sesja po wklejeniu skryptu TL;DR do powłoki bash na
> świeżym Kubuntu.

```text
[EWW] git nie znaleziony — instaluję...
Hit:1 http://archive.ubuntu.com/ubuntu noble InRelease
...
[EWW] Klonuję repozytorium Nairecth/eww do /git/eww
Cloning into '/git/eww'...
remote: Enumerating objects: 420, done.
remote: Counting objects: 100% (420/420), done.
remote: Compressing objects: 100% (305/305), done.
Receiving objects: 100% (420/420), 512.00 KiB | 1.50 MiB/s, done.
[EWW] Dodaję init-eww.sh do ~/.bashrc i uruchamiam inicjalizację
╭─ Miłego dnia 09:11:2025 14:05 przez user@zalogowanynaHOST:/git/eww w folderze /git/eww
╰─ E-Waste Workshop www.E-WasteWorkshop.co.uk
[EWW] Inicjalizacja zakończona (EWW_INIT_OK=1)
```

## Wymagania

- Kubuntu 24.04 LTS (lub inna dystrybucja Ubuntu/Debian z `apt`)
- `bash` ≥ 5.1 uruchomiony w trybie interaktywnym
- `git`, `curl` oraz `sudo` z uprawnieniami do instalacji pakietów
- Dostęp do `systemd --user`, jeżeli chcesz korzystać z timerów z katalogu
  `systemd/`
- Opcjonalnie: `gh` (GitHub CLI) i skonfigurowane podpisy GPG dla
  skryptów release (`scripts/semver_auto.sh`)

## Instalacja

1. **Klon repozytorium**:

  ```bash
  sudo mkdir -p /git && sudo chown "$USER":"$USER" /git
  git clone https://github.com/Nairecth/eww.git /git/eww
  ```

1. **Dołączenie skryptu do powłoki**:

  ```bash
  echo 'source /git/eww/init-eww.sh' >> ~/.bashrc
  source /git/eww/init-eww.sh
  ```

  Weryfikacja:

  ```bash
  echo "$EWW_INIT_OK"   # oczekiwana wartość: 1
  pwd                    # /git/eww jeśli EWW_CD_ROOT=1
  ```

1. **Opcjonalne skrypty po instalacji**:

    > [!INFO]- Opcjonalne kroki
    > - `./scripts/eww-post-install.sh` – miejsce na dodatkowe czynności
    >   (obecnie placeholder).
    > - `./scripts/eww-init-idempotent-example.sh` – przykład użycia helperów z
    >   `lib/idempotent.sh`.
    > - `make install` – kopiuje wybrane skrypty do `/usr/local/bin` (upewnij
    >   się, że docelowe pliki istnieją).

## Konfiguracja

- Zachowanie initu kontrolują zmienne środowiskowe ustawione **przed**
  `source /git/eww/init-eww.sh`.
- Najważniejsze ustawienia:

| Zmienna | Co kontroluje | Domyślnie |
| --- | --- | --- |
| `EWW_ROOT` | Katalog repo załadowany do powłoki | `/git/eww` |
| `EWW_CD_ROOT` | Auto-`cd` do `EWW_ROOT` (`1`/`0`) | `1` |
| `EWW_BANNER_ENABLE` | Czy drukować baner przy starcie | `1` |
| `EWW_BANNER_TTY_ONLY` | Wymaganie TTY dla banera | `1` |
| `EWW_BANNER_PREFIX` | Tekst w górnej linii banera | `Miłego dnia` |
| `EWW_BANNER_BOTTOM_LEFT` | Dolny lewy podpis | `E-Waste Workshop` |
| `EWW_BANNER_BOTTOM_RIGHT` | Dolny prawy podpis | `www.E-WasteWorkshop.co.uk` |
| `EWW_ROTATE_ON_START` | Rotacja logów (`0`/`1`) przy starcie | `0` |

Przykład dopasowania w `.bashrc`:

```bash
export EWW_CD_ROOT=0
export EWW_BANNER_ENABLE=0
source /git/eww/init-eww.sh
```

## Użycie

- **Nowa sesja**: Po uruchomieniu terminala pojawia się baner i `EWW_INIT_OK=1`.
  Logi są dopisywane w `var/logs/` (jeśli dostępny `lib/log.sh`).
- **Helpery bash**: `init-eww.sh` ładuje m.in. `lib/log.sh` (`info`, `warn`),
  `lib/idempotent.sh` (`ensure_dir`, `ensure_pkg`, `ensure_file`) oraz
  `lib/sys.sh`.
- **Automatyzacja**:
  - `./scripts/check_readme.sh` – waliduje spójność README, `VERSION` i
    dokumentów release.
  - `./scripts/bump-version.sh`, `./scripts/semver_auto.sh` – obsługa wersji,
    changelogów i tagów.
  - `tests/*.bats` – testy BATS (`bats tests/test_init.bats`).
- **Systemd (opcjonalnie)**: Jednostki w `systemd/`. Aktywacja przykładowego timera:

  > [!NOTE]
  > Timery wymagają aktywnego `systemd --user`. Jeśli nie działa, sprawdź
  > `loginctl enable-linger $(whoami)`.

    ```bash
    systemctl --user enable --now eww-autocommit.timer
    systemctl --user status eww-autocommit.timer
    ```

## Struktura projektu

Projekt ma czystą organizację zgodną z MVP:

```
eww/
├── 📦 MVP (pliki główne)
│   ├── README.md           # Ten plik
│   ├── init-eww.sh         # Skrypt inicjalizacyjny
│   ├── VERSION             # Numer wersji (0.0.0.4)
│   ├── CHANGELOG.md        # Historia zmian
│   ├── Makefile            # Automatyzacja zadań
│   └── MVP.md              # Kryteria akceptacji
├── 📖 lib/                 # Biblioteki Bash
│   ├── banner.sh           # Generowanie banerów
│   ├── git.sh              # Helpery Git
│   ├── log.sh              # System logowania
│   ├── sys.sh              # Helpery systemowe
│   └── idempotent.sh       # Operacje idempotentne
├── 🛠️ dev/                 # Narzędzia deweloperskie
│   ├── bin/                # Narzędzia CLI (eww-*)
│   ├── scripts/            # Skrypty pomocnicze
│   ├── tests/              # Testy BATS
│   ├── systemd/            # Jednostki systemd
│   └── cfg/                # Konfiguracje
├── 📚 docs/                # Dokumentacja
│   ├── wiki/               # Wiki (Kubuntu, Neovim, Obsidian)
│   └── guide/              # Przewodniki
└── 🗄️ archive/             # Archiwum

93 plików, 29 katalogów
```

**Szczegółowy opis**: Zobacz [INDEX.md](INDEX.md) - automatycznie generowany indeks z opisami wszystkich plików i folderów.

## Narzędzia deweloperskie

Projekt zawiera zestaw narzędzi CLI w `dev/bin/`:

### Podstawowe narzędzia

```bash
# Drzewo katalogów z opisami plików
make tree
./dev/bin/eww-tree -L 3

# Indeks projektu
make index
make index-preview

# Changelog z commitów Git
make changelog
./dev/bin/eww-changelog --unreleased

# Status projektu
./dev/bin/eww-status

# Diagnostyka środowiska
./dev/bin/eww-doctor
```

### Automatyzacja

```bash
# Automatyczne komentarze w kodzie Bash
make comment-add FILE=lib/git.sh

# Wydanie nowej wersji
make release VERSION=0.0.0.5

# Wszystkie dostępne komendy
make help
```

### Testy

```bash
# Uruchom testy BATS
bats dev/tests/
bats dev/tests/test_init.bats

# Walidacja README
./dev/scripts/check_readme.sh
```

## Dokumentacja

- **[INDEX.md](INDEX.md)** - Kompletny indeks projektu z opisami (auto-generowany)
- **[CHANGELOG.md](CHANGELOG.md)** - Historia zmian (Keep a Changelog format)
- **[AGENTS.md](AGENTS.md)** - Kontekst dla AI coding agents
- **[MVP.md](MVP.md)** - Kryteria akceptacji MVP
- **[docs/](docs/)** - Wiki, przewodniki, dokumentacja MkDocs

### System opisów plików

Każdy plik ma opis w `.filedesc`:

```bash
# Znajdź plik po nazwie
grep "eww-tree" .filedesc

# Znajdź po opisie
grep -i "changelog" .filedesc

# Wygeneruj INDEX.md na nowo
make index
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
