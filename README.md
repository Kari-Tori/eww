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
```

## Najważniejsze (krótkie)

- Co robi `init-eww.sh`: sprawdza interaktywność powłoki, ustawia `EWW_ROOT`, opcjonalnie wykonuje `cd` do root, ładuje baner raz na sesję i ustawia `EWW_INIT_OK`.
- Użycie: zawsze sourcuj (`. ~/Downloads/init-eww.sh` lub `source ...`) aby zmienne trafiły do bieżącej sesji.

## Kluczowe zmienne środowiskowe

- `EWW_ROOT` — domyślnie `/git/eww` (możesz nadpisać przed sourcowaniem).
- `EWW_CD_ROOT` — `1` (domyślnie); ustaw `0` aby nie zmieniać katalogu.
- `EWW_LOG_FILE` — domyślnie `${XDG_STATE_HOME:-$HOME/.local/state}/eww/init-eww.log`.
- `EWW_NO_LOG=1` — wyłącza zapis do pliku logu.
- `EWW_DEBUG=1` — włącza tryb debug.
- `EWW_ROTATE_ON_START=1` — (opcjonalnie) rotacja logu przy starcie.

## Logowanie

- Loger dopisuje wpisy do `EWW_LOG_FILE` (append).
- Rotację można wykonać ręcznie funkcją `eww_log_rotate` (jeśli dostępna) lub skonfigurować `logrotate`.

## Development i wydania

- Numer wersji znajduje się w pliku `VERSION` (np. `0.0.0.2`).
- `CHANGELOG.md` zawiera historię wydań.
- `scripts/bump-version.sh` pomaga w bump/branch/tag/push (ma tryb `--dry-run`).

Przykład suchy run:

```bash
./scripts/bump-version.sh 0.0.0.3 --dry-run --branch --tag
```

## Sprawdzenia przed wydaniem

- Czy `README` zgadza się z `VERSION`? (`cat VERSION` i `grep -m1 "Wersja:" README.md`)
- Uruchom `./scripts/check_readme.sh` — zweryfikuje podstawowe reguły.
- Opcjonalnie: `shellcheck init-eww.sh lib/log.sh` i `bats tests/`.

## Funkcje i lista weryfikacji

- Interaktywny tryb inicjacji — skrypt nie powinien uruchamiać inicjacji w nieinteraktywnym shellu.
- Możliwość nadpisania `EWW_ROOT` przed sourcowaniem.
- Automatyczne `cd` zależne od `EWW_CD_ROOT` (1/0).
- Logger zapisuje do `EWW_LOG_FILE`; `EWW_NO_LOG=1` wyłącza zapis.

## Gdzie szukać więcej

Pełna dokumentacja i kryteria MVP w `MVP.md` i `docs/release-0.0.0.1.md`.

## Kontakt

astriblast@gmail.com

<!-- Maintainers: README ma być krótki; dłuższe przewodniki umieszczaj w /docs. -->

repos:
  - repo: https://github.com/koalaman/shellcheck
    rev: stable
    hooks:
      - id: shellcheck
        args: [--severity=warning]
  - repo: https://github.com/mvdan/sh
    rev: v3.7.0
    hooks:
      - id: shfmt
        args: [-i, 2, -ci]


