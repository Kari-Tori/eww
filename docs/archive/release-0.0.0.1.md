---
version: 0.0.6
title: "release-0.0.0.1"
created: 2025-11-08
modified: 2025-11-28
tags:
  - auto-versioned
---

created: 2025-11-08T20:52:07Z
modified: 2025-11-24T22:34:18Z
author: Jakub Celmer
---
tags:
  - #automation
  - #development
  - #docs
  - #eww
  - #knowledge
  - #linux
  - #secondbrain
title: "Release 0.0.0.1 — MVP"






owner: jakubc
created: 2025-11-08T20:52:07Z
modified: 2025-11-24T22:34:18Z
author: Jakub Celmer
---



# Release 0.0.0.1 — MVP

Ten dokument opisuje minimalne, pobieralne wydanie **0.0.0.1 (MVP)** dla projektu E-Waste Workshop.

Uwaga: README projektu jest wersjonowane w Git — każda zmiana README trafia do historii commitów i jest możliwa do prześledzenia.

## Pobranie pojedynczego pliku (`projects/init/init-eww.sh`)

Pobierz plik `projects/init/init-eww.sh` z repozytorium (raw) do katalogu `~/Downloads` i sprawdź go przed załadowaniem:

```bash
curl -fsSL https://raw.githubusercontent.com/Nairecth/eww/main/projects/init/init-eww.sh -o ~/Downloads/init-eww.sh
less ~/Downloads/init-eww.sh
```

## Uruchomienie (z katalogu Pobrania)

WAŻNE: załaduj skrypt do bieżącej powłoki (sourcing). Nie uruchamiaj go w podprocesie (`sh init-eww.sh` lub `bash init-eww.sh`), bo wtedy zmienne środowiskowe nie trafią do Twojej sesji.

Przykład (w katalogu domowym, gdzie plik trafił do `~/Downloads`):

```bash
#. (sourcing) z katalogu domowego
. ~/Downloads/init-eww.sh
# albo pełna ścieżka
source ~/Downloads/init-eww.sh
```

## Co robi `init-eww.sh` (skrót)

- Sprawdza, czy powłoka jest interaktywna — jeśli nie, nie wykonuje inicjacji.
- Ustawia zmienną `EWW_ROOT` (domyślnie `/git/eww`) — można ją nadpisać przed sourcowaniem.
- Opcjonalnie wykonuje `cd` do katalogu `EWW_ROOT` (gdy `EWW_CD_ROOT` ≠ 0).
- Próbuje załadować baner z `lib/bash/baner.sh` (jeśli dostępny) i wyświetli go raz na sesję.
- Ustawia flagi sesyjne: `EWW_BANNER_SHOWN`, `EWW_INIT_OK`.
- Inicjuje prosty system logowania (jeśli `lib/log.sh` jest obecny) i dopisuje wpisy do `EWW_LOG_FILE`.

## Gdzie sprawdzić wynik

- Aby potwierdzić, że inicjacja zakończyła się sukcesem:

```bash
echo "$EWW_INIT_OK"   # powinno zwrócić '1' lub podobne oznaczenie sukcesu
echo "$EWW_ROOT"      # sprawdź ustawioną ścieżkę projektu
```

- Sprawdź log (domyślnie):

```bash
tail -n 80 "${EWW_LOG_FILE:-${XDG_STATE_HOME:-$HOME/.local/state}/eww/init-eww.log" || true
```

## Konfiguracja i zmienne przydatne

- `EWW_ROOT` — nadpisz przed sourcowaniem, np. `EWW_ROOT=/tmp/eww . ~/Downloads/init-eww.sh`.
- `EWW_CD_ROOT=0` — nie wykonuj automatycznego `cd` po załadowaniu.
- `EWW_NO_LOG=1` — wyłącza zapis do pliku logu.
- `EWW_DEBUG=1` — włącza dodatkowe logi debugujące (jeśli skrypt je obsługuje).
- `EWW_ROTATE_ON_START=1` — przenosi istniejący log do archiwum przed nowym uruchomieniem (jeśli funkcja rotacji jest dostępna).

## Czego się spodziewać (bezpieczne oczekiwania)

- Skrypt nie powinien instalować systemowo nowych pakietów ani nadpisywać plików systemowych — jego zakres to konfiguracja sesji i przygotowanie środowiska warsztatowego.
- Możliwe działania: ustawienie zmiennych środowiskowych, zmiana katalogu roboczego, wyświetlenie banera, dopisanie do lokalnego pliku logu.
- Jeśli coś pójdzie nie tak: możesz zamknąć sesję powłoki (exit) — efekty są lokalne do tej sesji (poza logami na dysku).

## Bezpieczeństwo

- Zawsze sprawdź pobrany skrypt przed sourcowaniem (`less` lub edytor). Nie sourcuj plików z niezaufanych źródeł.

## Dalsze kroki po MVP

- Po osiągnięciu MVP (oznaczeniu jako `0.0.0.1`) stworzymy oficjalny tag i GitHub Release — wtedy pliki będą udostępnione jako stabilny artefakt do pobrania przez użytkowników.


Dokument utworzony jako część wydania 0.0.0.1 (MVP) — plik `README.md` głównego katalogu repo jest wersjonowany i każda jego zmiana pojawia się w historii commitów.