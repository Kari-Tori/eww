---
modified: 2025-11-28
created: 2025-11-09
version: 0.0.3
title: lib/ - Biblioteki współdzielone
description: TODO - uzupełnij opis.
---

# lib/ - Biblioteki współdzielone

Biblioteki Bash używane przez projekt eww.

## Główne pliki

### `projects/init/init-eww.sh` - Główny skrypt inicjalizacyjny
Punkt wejścia dla użytkowników. Ustawia środowisko eww.

**Użycie:**
```bash
source /git/eww/projects/init/init-eww.sh
```

**Co robi:**
- Ustawia `EWW_ROOT`
- Opcjonalnie przechodzi do katalogu projektu (`EWW_CD_ROOT`)
- Ładuje baner jeśli dostępny
- Ustawia flagę `EWW_INIT_OK=1`

### `banner.sh` - System banerów
Funkcje do wyświetlania banerów powitalnych.

### `git.sh` - Helpery Git
Funkcje pomocnicze do pracy z Git:
- `git::last_tag()` - ostatni tag
- `git::is_clean()` - czy repo jest czyste
- `git::current_branch()` - aktualna gałąź
- `git::commits_between()` - commity między tagami

### `log.sh` - System logowania
Funkcje do logowania z kolorami:
- `log_info()` - informacje (niebieski)
- `log_warn()` - ostrzeżenia (żółty)
- `log_error()` - błędy (czerwony)
- `log_success()` - sukcesy (zielony)

### `idempotent.sh` - Operacje idempotentne
Helpery zapewniające idempotencję operacji:
- `ensure_dir()` - upewnij się że katalog istnieje
- `ensure_file()` - upewnij się że plik istnieje
- `ensure_pkg()` - upewnij się że pakiet jest zainstalowany

### `sys.sh` - Helpery systemowe
Funkcje systemowe i utilities.

## Konwencje

- Wszystkie funkcje z prefiksem namespace (np. `git::`, `log::`)
- Zmienne lokalne zawsze z `local`
- Wszystkie zmienne cytowane: `"$var"`
- Obsługa błędów z komunikatami po polsku

## Sourcowanie

Biblioteki można sourcować w skryptach:

```bash
#!/usr/bin/env bash
set -euo pipefail

# Source biblioteki
source "$(dirname "$0")/../lib/log.sh"
source "$(dirname "$0")/../lib/git.sh"

# Użycie
log_info "Sprawdzam ostatni tag..."
last_tag=$(git::last_tag)
log_success "Znaleziono: $last_tag"
```

## 🔗 Backlinks

- [[dev/lib/lib/lib]]
- [[dev/dev]]
- [[dev/Development]]