# dev/ - Narzędzia deweloperskie

Katalog zawiera narzędzia pomocnicze do rozwoju projektu eww.

## Zawartość

### `bin/` - Narzędzia CLI
Skrypty wykonywalne dostępne dla deweloperów:
- `eww-auto-comment` - automatyczne dodawanie komentarzy do kodu
- `eww-changelog` - generator changelogu z commitów Git
- `eww-banner` - generator banerów
- `eww-commit` - helper do commitów
- `eww-doctor` - diagnoza problemów
- `eww-status` - status projektu

### `scripts/` - Skrypty pomocnicze
Narzędzia do automatyzacji zadań:
- `bump-version.sh` - zarządzanie wersjami
- `release.sh` - proces wydania wersji
- `check_readme.sh` - walidacja dokumentacji
- `semver_auto.sh` - automatyczne wersjonowanie

### `tests/` - Testy
Testy BATS dla projektu:
- `test_init.bats` - testy inicjalizacji
- `test_idempotency.bats` - testy idempotencji
- `test_init_behavior.bats` - testy zachowania

### `systemd/` - Jednostki systemd
Timery i usługi systemd --user:
- `eww-autocommit.{service,timer}` - automatyczne commity
- `eww-status.{service,timer}` - monitoring statusu

### `cfg/` - Konfiguracje przykładowe
Pliki konfiguracyjne do kopiowania:
- `bashrc.eww.snippet` - fragment do ~/.bashrc
- `gitconfig.repo` - konfiguracja Git
- `pre-commit.yaml` - pre-commit hooks

## Użycie

Narzędzia w `bin/` można wywołać bezpośrednio:

```bash
# Z katalogu głównego eww
./dev/bin/eww-changelog --help
./dev/bin/eww-auto-comment lib/git.sh

# Lub dodać do PATH
export PATH="$PATH:/git/eww/dev/bin"
eww-changelog --help
```

## Makefile

Większość narzędzi ma aliasy w głównym Makefile:

```bash
make changelog          # używa dev/bin/eww-changelog
make comment-add        # używa dev/bin/eww-auto-comment
make help               # pokaż wszystkie komendy
```
