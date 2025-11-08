# eww — krótkie wprowadzenie

Krótko: zbiór prostych skryptów i helperów do konfiguracji oraz uruchamiania środowiska eww.

Wersja: zobacz plik `VERSION`

## Quick start

1. Sklonuj repo:

   git clone "https://github.com/Nairecth/eww.git"

2. Jeśli chcesz aby skrypt ustawił zmienne i funkcje w Twojej aktualnej powłoce, załaduj go (sourcing):

   source ./init-eww.sh

3. Jeśli chcesz tylko uruchomić skrypt jednorazowo (nie zmienia on Twojej powłoki):

   ./init-eww.sh

4. Przed wysłaniem PR uruchom podstawowe checki:

   ./scripts/check_readme.sh
   pre-commit run --all-files

## Sourcing vs executing — krótko

- source ./init-eww.sh  — wykonuje skrypt w bieżącej powłoce; używaj gdy chcesz, by zmienne środowiskowe i funkcje zostały ustawione w tej samej sesji (np. `EWW_ROOT`).
- ./init-eww.sh        — uruchamia w nowej powłoce; zmiany nie wpłyną na Twoją aktualną sesję.

Przykład: jeśli chcesz mieć dostęp do funkcji/aliasów zdefiniowanych w skrypcie, użyj `source`.

## Ważne zmienne środowiskowe

- EWW_ROOT — katalog główny repo (ustawiany przez `init-eww.sh`).
- EWW_NO_LOG — jeśli ustawione, logger nie będzie zapisywać plików log.
- EWW_DEBUG — włącza bardziej szczegółowe logowanie (jeśli zaimplementowane).

## Release / bump version (quick)

1. Uruchom `./scripts/bump-version.sh X.Y.Z --dry-run --branch --tag` by sprawdzić zmiany.
2. Po zielonych checkach: zrób commit, stwórz branch release i otwórz PR / lub zrób tag.

## Testy i lint

- Bats — testy: `bats tests`
- ShellCheck & shfmt — skonfigurowane przez `.pre-commit-config.yaml` (uruchom `pre-commit run --all-files`).
- Vale — prose lint dla dokumentów (lokalna konfiguracja w `.vale/`).

## Contributing

- Utrzymuj krótkie, czytelne commity. Taguj wydania semverem.
- Uruchom pre-commit i testy lokalnie przed PR.

## Gdzie szukać więcej

- `CHANGELOG.md` — historia wydań
- `docs/` — dalsza dokumentacja i przewodniki
- `scripts/` — helpery i narzędzia pomocnicze

---
Plik ten jest szablonem gotowego README; skopiuj zawartość do `README.md`, dopasuj URL repo i drobne szczegóły przed zatwierdzeniem.
