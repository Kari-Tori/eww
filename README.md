
# E-Waste Workshop

Wersja: 0.0.0.2

Krótki zestaw skryptów i narzędzi do szybkiego przygotowania środowiska warsztatowego.

<!-- README for E-Waste Workshop (lokalnie: /git/eww) -->

# E-Waste Workshop

Wersja: 0.0.0.2 (ver.pre-mvp)

Krótki zestaw skryptów i narzędzi do szybkiego przygotowania środowiska warsztatowego.

Strona: https://e-wasteworkshop.co.uk — Repo: https://github.com/Nairecth/eww

Lokalizacja na dysku (zalecana dla developera/testera): `/git/eww`

---

## Quick start (1 linia)

Pobierz, sprawdź i załaduj skrypt w bieżącej powłoce (ważne: source, nie uruchamiaj w podprocesie):

```bash
curl -fsSL https://raw.githubusercontent.com/Nairecth/eww/main/init-eww.sh -o ~/Downloads/init-eww.sh && less ~/Downloads/init-eww.sh && . ~/Downloads/init-eww.sh
<!-- README for E-Waste Workshop (lokalnie: /git/eww) -->

# E-Waste Workshop

Wersja: 0.0.0.2 (ver.pre-mvp)

Krótki zestaw skryptów i narzędzi do szybkiego przygotowania środowiska warsztatowego.

Strona: https://e-wasteworkshop.co.uk — Repo: https://github.com/Nairecth/eww

Lokalizacja na dysku (zalecana dla developera/testera): `/git/eww`

---

## Quick start (1 linia)

Pobierz, sprawdź i załaduj skrypt w bieżącej powłoce (ważne: source, nie uruchamiaj w podprocesie):

```bash
curl -fsSL https://raw.githubusercontent.com/Nairecth/eww/main/init-eww.sh -o ~/Downloads/init-eww.sh && less ~/Downloads/init-eww.sh && . ~/Downloads/init-eww.sh
```

## Najważniejsze (krótkie)

- Co robi `init-eww.sh`: sprawdza interaktywność powłoki, ustawia `EWW_ROOT`, opcjonalnie wykonuje `cd` do root, ładuje baner raz na sesję i ustawia `EWW_INIT_OK`.
- Użycie: zawsze sourcuj (`. ~/Downloads/init-eww.sh` lub `source ...`) aby zmienne trafiły do bieżącej sesji.

## Kluczowe zmienne środowiskowe

- `EWW_ROOT` — domyślnie `/git/eww` (możesz nadpisać przed sourcowaniem).
- `EWW_CD_ROOT` — `1` (domyślnie); ustaw `0` aby nie zmieniać katalogu.
- `EWW_LOG_FILE` — domyślnie `${XDG_STATE_HOME:-$HOME/.local/state}/eww/init-eww.log`.
- `EWW_NO_LOG=1` — wyłącza zapis do pliku.
- `EWW_DEBUG=1` — włącza debug.
- `EWW_ROTATE_ON_START=1` — (opcjonalnie) przenosi obecny log do archiwum przed startem.

## Logowanie

- Logi są dopisywane (append) do `EWW_LOG_FILE` — stare wpisy zostają zachowane.
- Rotację można wykonać manualnie przez `eww_log_rotate` lub skonfigurować `logrotate`.

## Development i wydania

- `VERSION` — plik zawierający numer semver (`0.0.0.2`).
- Etykieta wydania/stan: `ver.pre-mvp` (opisowy tag stanu przed MVP).
- `CHANGELOG.md` — historia zmian.
- `scripts/bump-version.sh` — pomocnik do bump/branch/tag/push/PR (ma tryb `--dry-run`).

Przykład suchy run:

```bash
./scripts/bump-version.sh 0.0.0.2 --dry-run --branch --tag
```

## Testy i linting

- `shellcheck` dla skryptów bash.
- `bats` (jeśli dostępne) dla testów w `tests/`.
- Vale / write-good dla dokumentacji (dodaj `.vale.ini` jeśli chcesz używać Vale).

## Pełna dokumentacja i kryteria MVP

Zobacz `MVP.md`.

Wydanie 0.0.0.1 (MVP): szczegółowe instrukcje pobrania i uruchomienia znajdziesz w `docs/release-0.0.0.1.md`.

## Funkcje i lista weryfikacji (checklist)

Poniżej znajduje się lista głównych funkcji skryptu/repo i krótkie polecenia do ich ręcznego potwierdzenia przed wypuszczeniem wydania.

- Interaktywny tryb inicjacji — potwierdź, że skrypt nie wykonuje inicjacji w nieinteraktywnej powłoce.
	- Sprawdź: uruchom `bash -c ". ~/Downloads/init-eww.sh"` — skrypt nie powinien ustawić `EWW_INIT_OK`.

- Ustawianie i nadpisywanie `EWW_ROOT` — potwierdź, że zmienna może być nadpisana przed sourcowaniem.
	- Sprawdź:
		```bash
		EWW_ROOT=/tmp/eww . ~/Downloads/init-eww.sh
		echo "$EWW_ROOT"
		```

- Automatyczne `cd` do `EWW_ROOT` (zależne od `EWW_CD_ROOT`) — sprawdź zachowanie dla `1` i `0`.
	- Sprawdź:
		```bash
		EWW_CD_ROOT=1 EWW_ROOT=/tmp/eww . ~/Downloads/init-eww.sh; pwd
		EWW_CD_ROOT=0 EWW_ROOT=/tmp/eww . ~/Downloads/init-eww.sh; pwd
		```

- Baner (banner) ładowany raz na sesję — potwierdź, że skrypt próbuje załadować `lib/bash/baner.sh` i ustawia `EWW_BANNER_SHOWN`.
	- Sprawdź (jeśli baner dostępny):
		```bash
		. ~/Downloads/init-eww.sh
		echo "$EWW_BANNER_SHOWN"
		```

- Ustawianie flagi `EWW_INIT_OK` po udanej inicjacji — potwierdź obecność tej zmiennej.
	- Sprawdź:
		```bash
		. ~/Downloads/init-eww.sh
		echo "$EWW_INIT_OK"
		```

- Logowanie do `EWW_LOG_FILE` — plik powinien zawierać dopisane wpisy (append).
	- Sprawdź:
		```bash
		. ~/Downloads/init-eww.sh
		tail -n 50 "${EWW_LOG_FILE:-${XDG_STATE_HOME:-$HOME/.local/state}/eww/init-eww.log" || true
		```

- Rotacja logów (`EWW_ROTATE_ON_START`) — jeśli funkcja dostępna, powinna przenieść stary log.
	- Sprawdź:
		```bash
		touch "${EWW_LOG_FILE:-${XDG_STATE_HOME:-$HOME/.local/state}/eww/init-eww.log";
		EWW_ROTATE_ON_START=1 . ~/Downloads/init-eww.sh
		ls -l "${XDG_STATE_HOME:-$HOME/.local/state}/eww/" | grep init-eww || true
		```

- Plik `VERSION` i konsystencja w `README` — warto sprawdzić, czy `README` wyświetla tę samą wartość.
	- Sprawdź:
		```bash
		cat VERSION
		grep -m1 "Wersja:" README.md || true
		```

- `scripts/bump-version.sh` (tryb `--dry-run`) — potwierdź, że przygotowuje zmiany bez pushowania.
	- Sprawdź:
		```bash
		./scripts/bump-version.sh 0.0.0.1 --dry-run --branch --tag
		```

- CHANGELOG — potwierdź, że wpis dla 0.0.0.1 (MVP) istnieje i opisuje kluczowe zmiany.
	- Sprawdź:
		```bash
		grep -n "0.0.0.1" CHANGELOG.md || true
		```

- Testy i lintery — uruchom `shellcheck` oraz `bats` (jeśli dostępne) i popraw krytyczne błędy.
	- Sprawdź:
		```bash
		shellcheck init-eww.sh || true
		bats tests/ || true
		```

Oznacz w komentarzu na PR/issue które z powyższych zostały ręcznie potwierdzone — to ułatwi decyzję o promocji do wydania (MVP).


## Kontakt

astriblast@gmail.com

<!-- Maintainers: README ma być krótki; dłuższe przewodniki umieszczaj w /docs lub w osobnych plikach. -->

