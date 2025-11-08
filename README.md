
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

## Kontakt

astriblast@gmail.com

<!-- Maintainers: README ma być krótki; dłuższe przewodniki umieszczaj w /docs lub w osobnych plikach. -->

