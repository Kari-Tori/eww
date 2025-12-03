---
version: 0.0.3
tags:
  - #automation
  - #development
  - #docs
  - #eww
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21
modified: 2025-11-24
author: jakubc
title: "AGENTS.md - Kontekst dla AI Coding Agents"






owner: jakubc
---


# AGENTS.md - Kontekst dla AI Coding Agents

## Informacje o projekcie

**Nazwa:** E-Waste Workshop (eww)  
**Typ:** Bash scripting toolkit  
**Język:** Bash, dokumentacja po polsku  
**Cel:** Automatyzacja konfiguracji środowiska deweloperskiego na Kubuntu

## Architektura

### Główne komponenty
```
eww/
├── bin/               # Skrypty CLI użytkownika
│   ├── eww-banner    # Generator banerów
│   ├── eww-changelog # Generator changelogu z Git
│   ├── eww-auto-comment # Auto-komentarze do kodu
│   ├── eww-commit    # Helper do commitów
│   └── eww-status    # Status projektu
├── lib/              # Biblioteki współdzielone
│   ├── banner.sh     # Funkcje banerów
│   ├── git.sh        # Helpery Git
│   ├── log.sh        # System logowania
│   ├── idempotent.sh # Operacje idempotentne
│   └── sys.sh        # Helpery systemowe
├── scripts/          # Skrypty pomocnicze/wewnętrzne
├── tests/            # Testy BATS
├── docs/             # Dokumentacja Markdown
└── systemd/          # Jednostki systemd --user
```

## Stack technologiczny

- **Shell:** Bash 5.1+
- **OS:** Kubuntu 24.04 LTS
- **Testing:** BATS (Bash Automated Testing System)
- **CI/CD:** Potencjalnie GitHub Actions
- **Versionowanie:** Semantic Versioning (x.y.z.b)
- **Commit style:** Conventional Commits

## Wzorce i praktyki

### Struktura funkcji
```bash
# Nazwa funkcji (krótki opis)
# Argumenty:
#   $1 - opis pierwszego argumentu
# Zwraca: 0 sukces, 1+ błąd
nazwa_funkcji() {
    local arg1="$1"
    # implementacja
}
```

### Obsługa błędów
```bash
set -euo pipefail  # Zawsze na początku

if [[ ! -f $plik ]]; then
    log_error "Brak pliku: $plik"
    return 1
fi
```

### Konwencje nazewnictwa
- Globalne: `EWW_NAZWA_ZMIENNEJ`
- Lokalne: `local nazwa_zmiennej`
- Funkcje: `namespace::funkcja` lub `funkcja_pomocnicza`
- Readonly: `readonly STALA_WARTOSC`

## Workflow

### Typowy proces rozwoju
1. Stwórz gałąź: `git checkout -b feat/nowa-funkcja`
2. Implementuj z testami
3. `make comment-add FILE=...` - dodaj komentarze
4. `make changelog` - sprawdź zmiany
5. Commit z Conventional Commits
6. `make release VERSION=x.y.z.b` - wydanie

### Używane narzędzia
- `make` - automatyzacja zadań
- `git` - kontrola wersji
- `bats` - testy
- `shellcheck` - linting (zalecane)
- `gh` - GitHub CLI

## Zasady dla AI

### Gdy generujesz kod:
1. **Język:** Komentarze i komunikaty PO POLSKU
2. **Bezpieczeństwo:** Zawsze `set -euo pipefail`, cytuj zmienne
3. **Struktura:** Używaj wzorców z istniejącego kodu
4. **Testy:** Sugeruj testy BATS dla nowych funkcji
5. **Dokumentacja:** Aktualizuj README.md przy większych zmianach

### Gdy pomagasz z bugami:
1. Sprawdź najpierw `lib/` dla podobnego kodu
2. Użyj funkcji logowania z `lib/log.sh`
3. Pamiętaj o obsłudze błędów
4. Testuj edge cases

### Gdy refaktoryzujesz:
1. Zachowaj kompatybilność wsteczną
2. Dodaj deprecated warnings jeśli potrzeba
3. Zaktualizuj testy
4. Zaktualizuj CHANGELOG.md

## Kontekst techniczny

### Zmienne środowiskowe
```bash
EWW_ROOT="/git/eww"              # Katalog główny
EWW_CD_ROOT=1                     # Auto-cd do EWW_ROOT
EWW_BANNER_ENABLE=1               # Pokazuj baner
EWW_INIT_OK=1                     # Flaga inicjalizacji
```

### Kluczowe pliki
- `VERSION` - aktualny numer wersji (x.y.z.b)
- `CHANGELOG.md` - historia zmian (Keep a Changelog)
- `Makefile` - automatyzacja (make help)
- `projects/init/init-eww.sh` - główny skrypt inicjalizacyjny

## Cel projektu

Umożliwić szybką konfigurację środowiska deweloperskiego na świeżej instalacji Kubuntu poprzez:
1. Sklonowanie repo do `/git/eww`
2. Source'owanie `projects/init/init-eww.sh` w `~/.bashrc`
3. Automatyczne ustawienie środowiska, ścieżek, aliasów
4. Dostarczenie narzędzi CLI do codziennej pracy

## Planowane rozszerzenia
- [ ] Integracja z GitHub Actions
- [ ] Więcej testów coverage
- [ ] Dokumentacja MkDocs
- [ ] Plugin system dla rozszerzeń
- [ ] Support dla innych dystrybucji

## 🔗 Backlinks

- [[dev/docs/docs]]
- [[docs/docs]]
- [[INDEX]]