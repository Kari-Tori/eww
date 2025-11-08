
# E-Waste Workshop

Wersja: 0.0.0.2

Krótki zestaw skryptów i narzędzi do szybkiego przygotowania środowiska warsztatowego.

Strona: https://e-wasteworkshop.co.uk — Repo: https://github.com/Nairecth/eww

---

Quick start (1 linia):

```bash
curl -fsSL https://raw.githubusercontent.com/Nairecth/eww/main/init-eww.sh -o ~/Downloads/init-eww.sh && less ~/Downloads/init-eww.sh && . ~/Downloads/init-eww.sh
```

Krótko: pobierz, sprawdź, sourcuj (ważne: source, nie uruchamiaj w podprocesie).

Najważniejsze zmienne (jedna linia opisu każda):
- `EWW_ROOT` — domyślnie `/git/eww`, możesz nadpisać przed sourcowaniem.
- `EWW_CD_ROOT` — `1` (domyślnie); ustaw `0` aby nie zmieniać katalogu.
- `EWW_LOG_FILE` — domyślnie `${XDG_STATE_HOME:-$HOME/.local/state}/eww/init-eww.log`.
- `EWW_NO_LOG=1` — wyłącza zapis do pliku; `EWW_DEBUG=1` włącza debug.

Co robi `init-eww.sh` (skrót): sprawdza interaktywność powłoki, ustawia `EWW_ROOT`, opcjonalnie `cd`, próbuje załadować baner raz na sesję i ustawia `EWW_INIT_OK`.

Logi: dopisujemy do pliku (append) — stare wpisy zostają. Rotacja: `eww_log_rotate` lub `logrotate`.

Development / wydania: wersja w `VERSION`, historia w `CHANGELOG.md`, helper `scripts/bump-version.sh` (branch/tag/push/PR).

Testy & linting: użyj `shellcheck` dla skryptów, `bats` dla testów, Vale / write-good dla dokumentacji (dodaj `.vale.ini` jeśli używasz Vale).

Pełne kryteria MVP i instrukcje testowe: `MVP.md`.

Kontakt: astriblast@gmail.com

<!-- Maintainers: keep README short; move long docs to docs/ -->
# E-Waste Workshop

<!--
	Komentarz dla utrzymujących: ten README ma być krótki i jednoznaczny.
	Zawiera jedynie link do strony, link do repo i minimalne instrukcje użycia
	- -->

	# E-Waste Workshop

	<!--
		README ma być krótki, przejrzysty i zawierać jedynie informacje potrzebne użytkownikowi
		i konserwatorom (quick start, co robi `init-eww.sh`, logging, kontakt). Nie usuwaj
		przykładowych poleceń pobrania — służą jako instrukcja.
	-->

	Krótki zestaw narzędzi i skryptów do szybkiego przygotowania środowiska warsztatowego.

	Strona projektu: https://e-wasteworkshop.co.uk

	Repozytorium: https://github.com/Nairecth/eww
	## Spis treści

	- Quick start
	- Wymagania
	- Instalacja / Pobranie
	- Użycie (sourcing)
	- Konfiguracja
	- Co robi skrypt
	- Logowanie
	- Development i wydania
	- Testy i linting
	- Zmiany (CHANGELOG)
	- Kontakt / Licencja

	## Quick start

	1. Pobierz skrypt:

	```bash
	curl -fsSL -o ~/Downloads/init-eww.sh \
		https://raw.githubusercontent.com/Nairecth/eww/main/init-eww.sh
	```

	2. Sprawdź plik przed uruchomieniem:

	```bash
	less ~/Downloads/init-eww.sh
	```

	3. Załaduj w bieżącej powłoce (ważne — source):

	```bash
	. ~/Downloads/init-eww.sh
	# lub
	source ~/Downloads/init-eww.sh
	```

	## Wymagania

	- Bash (interaktywna powłoka)
	- (opcjonalnie) curl, less
	- (opcjonalnie) narzędzia linterów: shellcheck, vale, npx write-good

	## Instalacja / Pobranie

	Możesz sklonować repozytorium lub pobrać tylko `init-eww.sh` z katalogu głównego.

	```bash
	git clone https://github.com/Nairecth/eww.git /path/to/eww
	```

	## Użycie (sourcing)

	Skrypt należy załadować do bieżącej powłoki, aby ustawić zmienne środowiskowe w sesji.

	Przykłady:

	```bash
	EWW_ROOT=/custom/path . ~/Downloads/init-eww.sh
	EWW_CD_ROOT=0 . ~/Downloads/init-eww.sh
	```

	## Konfiguracja (zmienne środowiskowe)

	- `EWW_ROOT` — domyślnie `/git/eww`
	- `EWW_CD_ROOT` — `1` (jeśli nie chcesz zmiany katalogu ustaw `0`)
	- `EWW_LOG_FILE` — lokalizacja pliku logu (domyślnie `${XDG_STATE_HOME:-$HOME/.local/state}/eww/init-eww.log`)
	- `EWW_NO_LOG=1` — wyłącza zapis do pliku logu
	- `EWW_DEBUG=1` — włącza dodatkowe logi debugujące
	 - `EWW_ROTATE_ON_START=1` — jeśli ustawione, obecny plik logu zostanie przeniesiony
		 do archiwum z timestampem przed rozpoczęciem nowego runu (domyślnie `0`).

	## Co robi skrypt

	- Sprawdza, czy powłoka jest interaktywna; jeśli nie, nic nie robi.
	- Ustawia `EWW_ROOT` (można nadpisać przed sourcowaniem).
	- Opcjonalnie przechodzi (`cd`) do `EWW_ROOT` gdy `EWW_CD_ROOT` ≠ 0.
	- Próbuję załadować baner (`$EWW_ROOT/lib/bash/baner.sh`) i wywołuję `eww_banner` raz na sesję.
	- Ustawia zmienne sesji: `EWW_BANNER_SHOWN`, `EWW_INIT_OK`.

	## Logowanie

	Domyślna lokalizacja logu:

	```
	${XDG_STATE_HOME:-$HOME/.local/state}/eww/init-eww.log
	```

	Ustawienia i zachowanie:

	- `EWW_LOG_FILE` — zmień miejsce zapisu (pusta wartość wyłącza zapis).
	- `EWW_NO_LOG=1` — wyłącza zapis do pliku (logi nadal trafiają na stderr).
	- Logi są dopisywane (append) — stare wpisy zostają zachowane.
	- Do rotacji można użyć `eww_log_rotate` lub standardowego `logrotate`.

	## Development i wydania

	- `VERSION` — plik z aktualną wersją.
	- `CHANGELOG.md` — notatki wydania.
	- `scripts/bump-version.sh` — pomocnik do tworzenia branchy, tagów i wpisów changelog.

	Przykład (suchy run):

	```bash
	./scripts/bump-version.sh 0.0.0.2 --dry-run --branch --tag
	```

	## Testy i linting

	- Uruchom `shellcheck` na skryptach bash.
	- Jeżeli dostępne, uruchom `bats tests/` dla sanity tests.
	- Vale / write-good dla dokumentacji — dodaj `.vale.ini` jeśli chcesz używać Vale.

	## Zmiany (CHANGELOG)

	Zobacz `CHANGELOG.md` w repozytorium dla historii wydań.

	## Kontakt / Licencja

	Kontakt: astriblast@gmail.com

	Licencja: (wstaw tutaj licencję projektu)

	<!-- Maintainers: keep README concise; place extended docs in `docs/` -->

	## Skompresowana wersja (quick)

	Krótko:

	- Pobierz -> sprawdź -> sourcuj (ważne: source, nie uruchom w podprocesie).
	- Po sourcowaniu: `EWW_ROOT`, opcjonalne `cd`, baner raz na sesję, `EWW_INIT_OK=1`.

	Najważniejsze polecenia:

	```bash
	curl -fsSL -o ~/Downloads/init-eww.sh https://raw.githubusercontent.com/Nairecth/eww/main/init-eww.sh
	less ~/Downloads/init-eww.sh
	. ~/Downloads/init-eww.sh
	```

	Kluczowe zmienne:
	- `EWW_ROOT` (domyślnie `/git/eww`)
	- `EWW_CD_ROOT` (`1` aby cd do root)
	- `EWW_LOG_FILE` (domyślnie `${XDG_STATE_HOME:-$HOME/.local/state}/eww/init-eww.log`)
	- `EWW_NO_LOG=1` (wyłącza zapis do pliku)

	Logi są dopisywane (append); stare wpisy zostają zachowane. Aby rotować: `eww_log_rotate` lub skonfiguruj `logrotate`.

	Pełna dokumentacja i kryteria MVP: `MVP.md`. Kontakt: astriblast@gmail.com


