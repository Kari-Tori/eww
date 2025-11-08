# E-Waste Workshop
Strona projektu: https://www.e-wwasteworkshop.co.uk
Repozytorium na GitHub: https://github.com/Nairecth/eww

Krótki opis
-------------
To repozytorium zawiera skrypty pomocnicze i zasoby używane na warsztatach E-Waste Workshop.

Prosty README z instrukcją uruchomienia `init-eww.sh` i opisem jego działania.

Krok 1 — pobierz skrypt z GitHub
--------------------------------
Pobierz plik `init-eww.sh` bezpośrednio z repozytorium (polecane):

# E-Waste Workshop — krótkie README

Strona: https://e-wasteworkshop.co.uk

Repozytorium: https://github.com/Nairecth/eww

Krok 1 — pobierz

Pobierz plik `init-eww.sh` z GitHub (raw):

```bash
curl -fsSL -o ~/Downloads/init-eww.sh \
  https://raw.githubusercontent.com/Nairecth/eww/main/init-eww.sh
```

Sprawdź plik przed wykonaniem:

```bash
less ~/Downloads/init-eww.sh
```

Krok 2 — załaduj w bieżącej powłoce

Załaduj (source), żeby zmienne środowiskowe i przejście katalogu działały w Twojej sesji:

```bash
. ~/Downloads/init-eww.sh
```

Co robi `init-eww.sh` (krótko)

- Sprawdza, czy powłoka jest interaktywna; jeśli nie — nic nie zmienia.
- Ustawia `EWW_ROOT` (domyślnie `/git/eww`) — można nadpisać przed sourcowaniem.
- Jeśli `EWW_CD_ROOT` ≠ 0 i katalog istnieje — przechodzi (`cd`) do `EWW_ROOT`.
- Próbuje załadować `$EWW_ROOT/lib/bash/baner.sh` i wywołać `eww_banner` raz na sesję.
- Eksportuje flagi: `EWW_BANNER_SHOWN`, `EWW_INIT_OK`.

Bezpieczeństwo

Nigdy nie sourcuj niesprawdzonego skryptu — sprawdź zawartość przed wykonaniem.

Kontakt: astriblast@gmail.com
├─ scripts/
│  ├─ eww-setup-git.sh
│  ├─ eww-git-gpg-fix.sh
│  └─ eww-logging.sh
├─ logs/
│  └─ .gitkeep
└─ docs/
   └─ .gitkeep
```

## `init-eww.sh` — co robi
- Ustawia `EWW_ROOT=/git/eww`.
- Tworzy niezbędne katalogi (`bin/`, `scripts/`, `logs/`, `docs/`).
- Nadaje prawa wykonania plikom w `bin/` i `scripts/` (jeśli istnieją).
- Opcjonalnie inicjuje repo Git w `/git/eww` (jeśli brak `.git`).
- Wyświetla baner startowy i status.

## Jak uruchomić
Pobierz do katalogu „Pobrane/Downloads” i uruchom:

```bash
DL="$(xdg-user-dir DOWNLOAD 2>/dev/null || echo "$HOME/Downloads")"
mkdir -p "$DL" && cd "$DL"
curl -fsSL -o init-eww.sh https://raw.githubusercontent.com/Nairecth/eww/main/init-eww.sh
chmod +x init-eww.sh
./init-eww.sh
```
- touch: 2025-11-08 16:21:08 UTC
- signed: 2025-11-08 16:31:33 UTC
- signed: 2025-11-08 16:32:45 UTC
- signed: 2025-11-08 16:34:48 UTC
- signed: 2025-11-08 16:36:08 UTC
