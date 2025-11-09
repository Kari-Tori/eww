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
![build-status](https://img.shields.io/badge/build-ci--status-lightgrey)
![release](https://img.shields.io/badge/release-v0.0.0-lightgrey)
![license](https://img.shields.io/badge/license-TBD-lightgrey)
![issues](https://img.shields.io/badge/issues-open-lightgrey)

Wersja: 0.0.0.2

## Spis treści

- [Quick start](#quick-start)
- [Demo](#demo)
- [Wymagania](#wymagania)
- [Instalacja](#instalacja)
- [Konfiguracja](#konfiguracja)
- [Użycie](#użycie)
- [Struktura repo](#struktura-repo)
- [Funkcje i lista weryfikacji](#funkcje-i-lista-weryfikacji)

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

## Struktura repo

- `lib/` – biblioteki bash: logowanie, idempotencja, baner, helpery systemowe.
- `scripts/` – narzędzia CLI, automatyzacja wersji, przykłady inicjalizacji.
- `tests/` – zestaw testów BATS dla initu i idempotencji.
- `systemd/` – jednostki i timery użytkownika (np. autocommit).
- `docs/` – dokumentacja, checklisty release, wiki projektu.

## Funkcje i lista weryfikacji

- `init-eww.sh` ustawia `EWW_ROOT` i (jeśli `EWW_CD_ROOT=1`) przenosi powłokę do
  repozytorium.
- Jeżeli dostępny jest `lib/bash/baner.sh`, baner drukuje się raz na sesję, a
  flaga `EWW_BANNER_SHOWN` zapobiega powtórkom.
- `lib/log.sh` (gdy obecny) zapewnia funkcje `info`, `warn`, `error` i
  opcjonalną rotację logów (`EWW_ROTATE_ON_START=1`).
- Ustawiana jest flaga `EWW_INIT_OK=1`, którą można łatwo sprawdzić (`echo
  "$EWW_INIT_OK"`).
- Helpery z `lib/idempotent.sh` są gotowe do tworzenia katalogów, plików i
  instalacji pakietów w skryptach automatyzujących.
