## E-Waste Workshop — repozytorium

To repozytorium zawiera skrypty i zasoby używane przy warsztatach E-Waste Workshop (e-wasteworkshop.co.uk). Zawiera narzędzia pomocnicze (`bin/`, `scripts/`), biblioteki powłoki (`lib/`) oraz pliki konfiguracyjne i dokumentację.

Ten plik README wyjaśnia, jak bezpiecznie i poprawnie użyć skryptu inicjalizującego `init-eww.sh` i co się stanie po jego załadowaniu.

## Szybkie użycie (najważniejsze)

- Zalecane: "sourcować" skrypt w swojej powłoce (czyli uruchomić go w bieżącym procesie powłoki). Dzięki temu ustawienia środowiska (zmienne, automatyczne przejście do katalogu) będą miały wpływ na Twoją sesję.
- Niezalecane: uruchamianie `./init-eww.sh` w oddzielnym procesie — wtedy skrypt wykona się w subprocess i nie ustawi zmiennych ani nie zmieni katalogu w Twojej powłoce.

Przykładowe polecenia (pobranie i źródłowanie):

```bash
# Pobierz plik do katalogu tymczasowego
curl -fsSL -o ~/Downloads/init-eww.sh \
  https://raw.githubusercontent.com/Nairecth/eww/main/init-eww.sh

# Załaduj (source) w bieżącej powłoce
. ~/Downloads/init-eww.sh

# Alternatywnie: dodaj do ~/.bashrc, żeby ładowało się przy starcie sesji interaktywnej
echo ". /absolute/path/to/init-eww.sh" >> ~/.bashrc
```

Uwaga: skrypt wykrywa, czy powłoka jest interaktywna. Jeśli nie (np. uruchomisz go w skrypcie non-interactive), większość ustawień nie zostanie zastosowana.

## Co dokładnie robi `init-eww.sh` (technicznie)

Na podstawie aktualnej treści skryptu, po załadowaniu (sourcing lub uruchomieniu w powłoce interaktywnej) wykonuje się funkcja `eww::init` i następujące działania:

- Sprawdza, czy powłoka jest interaktywna: jeżeli nie, kończy działanie (nie robi zmian).
- Ustala zmienną środowiskową `EWW_ROOT` (domyślnie `/git/eww`) — możesz ją nadpisać przed załadowaniem skryptu, np. `export EWW_ROOT=/moj/katalog && . init-eww.sh`.
- Opcjonalnie przechodzi (`cd`) do katalogu `EWW_ROOT`, jeżeli `EWW_CD_ROOT` nie jest ustawione na `0`, katalog istnieje, i bieżący katalog różni się od `EWW_ROOT`.
- Ustawia kilka zmiennych konfiguracyjnych banera (np. `EWW_BANNER_PREFIX`, `EWW_BANNER_BOTTOM_LEFT`, `EWW_BANNER_BOTTOM_RIGHT`).
- Jeśli dostępny jest plik biblioteki banera (`$EWW_ROOT/lib/bash/baner.sh`), skrypt go załaduje (`source`) i, jeżeli funkcja `eww_banner` istnieje, wywoła ją raz na sesję. To pokazuje baner informacyjny w terminalu.
- Eksportuje znaczniki sesji (`EWW_BANNER_SHOWN`, `EWW_INIT_OK`) — pozwala to uniknąć wielokrotnego wyświetlania banera w tej samej sesji.

Krótko: skrypt inicjalizuje środowisko warsztatowe (zmienne i opcjonalny baner) i ewentualnie przenosi Cię do katalogu projektu.

## Przykłady użycia i uwagi

- Jeżeli chcesz, aby ustawienia działały w każdej nowej sesji, dodaj linię `source /ścieżka/do/init-eww.sh` do `~/.bashrc` lub `~/.profile` (dla bash interactive).
- Jeśli zależy Ci na globalnym dostępie do narzędzi z `bin/`, rozważ dodanie `$EWW_ROOT/bin` do `PATH` w Twoim pliku `~/.bashrc`:

```bash
export EWW_ROOT="/git/eww"
export PATH="$EWW_ROOT/bin:$PATH"
```

- Skrypt sam w sobie NIE robi operacji sieciowych ani nie modyfikuje systemu bezpośrednio — główna funkcja to konfiguracja środowiska i wywołanie lokalnego banera, jeśli jest dostępny.

## Diagnostyka

- Jeżeli baner się nie pokazuje, sprawdź, czy:
  - plik `$EWW_ROOT/lib/bash/baner.sh` istnieje i jest czytelny,
  - funkcja `eww_banner` jest zdefiniowana po załadowaniu biblioteki,
  - Twoja powłoka jest interaktywna (np. uruchom `bash -i` lub otwórz nowy terminal).

- Aby ręcznie sprawdzić, czy inicjalizacja powiodła się, po załadowaniu uruchom:

```bash
echo "EWW_ROOT=$EWW_ROOT"
echo "EWW_INIT_OK=${EWW_INIT_OK-}"
```

## Kontakt i licencja

Owner / Contact: astriblast@gmail.com

Plik ten ma charakter dokumentacyjny dla warsztatów — dopasuj go do swoich potrzeb przed wdrożeniem na systemy produkcyjne.
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
