# E-Waste Workshop

Strona projektu: https://e-wasteworkshop.co.uk

Repozytorium na GitHub: https://github.com/Nairecth/eww

Krótki opis
-------------
To repozytorium zawiera skrypty pomocnicze i zasoby używane na warsztatach E-Waste Workshop.

Prosty README z instrukcją uruchomienia `init-eww.sh` i opisem jego działania.

Krok 1 — pobierz skrypt z GitHub
--------------------------------
Pobierz plik `init-eww.sh` bezpośrednio z repozytorium (polecane):

```bash
# curl
curl -fsSL -o ~/Downloads/init-eww.sh \
  https://raw.githubusercontent.com/Nairecth/eww/main/init-eww.sh

# lub wget
wget -O ~/Downloads/init-eww.sh \
  https://raw.githubusercontent.com/Nairecth/eww/main/init-eww.sh
```

Sprawdź pobrany plik przed uruchomieniem:

```bash
less ~/Downloads/init-eww.sh
```

Krok 2 — załaduj skrypt w bieżącej powłoce (sourcowanie)
-------------------------------------------------------
Aby ustawienia zadziałały w Twojej sesji terminala, załaduj skrypt w bieżącej powłoce:

```bash
. ~/Downloads/init-eww.sh
```

Możesz też dodać `source` do `~/.bashrc`, aby ładowało się przy starcie sesji:

```bash
echo ". /absolute/path/to/init-eww.sh" >> ~/.bashrc
```

Co robi `init-eww.sh` — opis działania
--------------------------------------
- Sprawdza, czy powłoka jest interaktywna; jeśli nie jest — nic nie zmienia.
- Ustawia zmienną środowiskową `EWW_ROOT` (domyślnie `/git/eww`). Możesz nadpisać ją przed źródłowaniem, np.:
  ```bash
  export EWW_ROOT=/moj/katalog && . ~/Downloads/init-eww.sh
  ```
- Jeśli `EWW_CD_ROOT` nie jest ustawione na `0`, a katalog `EWW_ROOT` istnieje, skrypt przechodzi (`cd`) do tego katalogu.
- Próbuje załadować lokalną bibliotekę banera `$EWW_ROOT/lib/bash/baner.sh` (jeśli istnieje) i wywoła funkcję `eww_banner` raz na sesję.
- Ustawia/eksportuje flagi sesji: `EWW_BANNER_SHOWN` i `EWW_INIT_OK`, aby uniknąć wielokrotnego wyświetlania banera.

Uwaga bezpieczeństwa
---------------------
Nigdy nie sourcuj skryptów pobranych z internetu bez ich sprawdzenia. Przejrzyj zawartość (`less`, `cat`) przed wykonaniem.

Kontakt
-------
Owner / Contact: astriblast@gmail.com

# E-Waste Workshop – `/git/eww`

**Lokalizacja (lokalny dysk):** `/git/eww`  
**Repo (GitHub):** https://github.com/Nairecth/eww  
**Owner/Contact:** astriblast@gmail.com

## Struktura plików
```
/git/eww
├─ README.md
├─ init-eww.sh
├─ bin/
│  ├─ eww-status
│  ├─ eww-commit
│  └─ eww-banner
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
