---
title: GitHub Copilot Instructions dla projektu eww
description: TODO - uzupełnij opis.
---

# GitHub Copilot Instructions dla projektu eww

## O projekcie
Projekt **E-Waste Workshop** to zestaw narzędzi Bash do konfiguracji środowiska deweloperskiego na Kubuntu.

## Zasady programowania

### Styl kodu Bash
- Używaj `#!/usr/bin/env bash` jako shebang
- Zawsze dodawaj `set -euo pipefail` dla bezpieczeństwa
- Stosuj Conventional Commits (feat:, fix:, chore:, docs:)
- Nazwy funkcji w stylu: `eww::nazwa_funkcji` lub `nazwa_funkcji`
- Komentarze po polsku w kodzie
- Dokumentacja w języku polskim

### Struktura projektu
```
eww/
├── bin/          # Główne skrypty wykonywalne
├── lib/          # Biblioteki pomocnicze (*.sh)
├── scripts/      # Skrypty pomocnicze
├── docs/         # Dokumentacja
├── tests/        # Testy BATS
└── systemd/      # Jednostki systemd
```

### Konwencje nazewnictwa
- Pliki bibliotek: `lib/nazwa.sh` (małe litery, snake_case)
- Skrypty wykonywalne: `bin/eww-nazwa` (bez rozszerzenia)
- Funkcje pomocnicze: `nazwa_pomocnicza()` z komentarzem
- Zmienne globalne: `EWW_NAZWA_ZMIENNEJ` (uppercase)
- Zmienne lokalne: `local nazwa_zmiennej` (lowercase)

### Bezpieczeństwo
- Zawsze cytuj zmienne: `"$zmienna"`
- Używaj `local` dla zmiennych lokalnych
- Waliduj argumenty funkcji
- Obsługuj błędy z odpowiednimi komunikatami

### Logowanie i output
- Używaj funkcji z `lib/log.sh`: `log_info`, `log_warn`, `log_error`
- Koloruj output (GREEN, BLUE, YELLOW, RED, NC)
- Prefiks `[EWW]` w komunikatach
- `>&2` dla błędów i ostrzeżeń

### Testowanie
- Testy w BATS (`tests/*.bats`)
- Każda nowa funkcja powinna mieć test
- Uruchamiaj: `bats tests/`

### Makefile
- Dodawaj nowe targety z komentarzami
- Grupuj logicznie (podstawowe, changelog, readme, AI)
- Aktualizuj `.PHONY`
- Dodawaj opisy do `make help`

## Przykłady

### Nowa funkcja w bibliotece
```bash
# Pobierz ostatni tag Git
git::last_tag() {
    git describe --tags --abbrev=0 2>/dev/null || echo ""
}
```

### Nowy skrypt wykonywalny
```bash
#!/usr/bin/env bash
# eww-nazwa - Krótki opis
set -euo pipefail

readonly GREEN='\033[0;32m'
readonly NC='\033[0m'

usage() {
    cat <<EOF
Użycie: eww-nazwa [OPCJE]
Opis skryptu.
EOF
}

main() {
    # kod główny
}

main "$@"
```

### Commit message
```
feat(core): dodaj funkcję do parsowania wersji

Dodano git::get_version() do lib/git.sh
```

## Preferencje AI

### WAŻNE: Język polski ZAWSZE
- **WSZYSTKIE komentarze po polsku** - nigdy po angielsku
- **WSZYSTKIE komunikaty błędów po polsku**
- **WSZYSTKIE opisy funkcji po polsku**
- **WSZYSTKIE zmienne opisowe po polsku** (lub snake_case)

### Przykład DOBRY ✅
```bash
# Pobierz listę plików w katalogu
# Argumenty:
#   $1 - ścieżka do katalogu
# Zwraca: lista plików, jeden na linię
pobierz_pliki() {
    local katalog="$1"
    
    if [[ ! -d "$katalog" ]]; then
        log_error "Katalog nie istnieje: $katalog"
        return 1
    fi
    
    ls -1 "$katalog"
}
```

### Przykład ZŁY ❌
```bash
# Get list of files in directory  <- NIE! Po polsku!
# Args:  <- NIE! "Argumenty:"
get_files() {  <- NIE! "pobierz_pliki()"
    dir="$1"  <- NIE! Brak "local"
    ls -1 $dir  <- NIE! Brak cytowania zmiennej
}
```

### Zawsze dodawaj
- `set -euo pipefail` na początku skryptu
- Walidację argumentów funkcji
- Obsługę błędów z polskimi komunikatami
- `local` dla zmiennych lokalnych
- Cytowanie wszystkich zmiennych: `"$zmienna"`
- Testy dla nowych funkcji
- Aktualizację dokumentacji
