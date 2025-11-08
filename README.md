# E-Waste Workshop

Strona: https://e-wasteworkshop.co.uk

Repozytorium: https://github.com/Nairecth/eww

Krok 1 — pobranie skryptu

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

Załaduj (source), żeby ustawienia działały w Twojej sesji terminala:

```bash
. ~/Downloads/init-eww.sh
```

Co robi `init-eww.sh` (krótko):

- sprawdza, czy powłoka jest interaktywna (jeśli nie — nie robi zmian),
- ustawia `EWW_ROOT` (domyślnie `/git/eww`) — można nadpisać przed źródłowaniem,
- jeżeli `EWW_CD_ROOT` ≠ 0 i katalog istnieje — przechodzi (`cd`) do `EWW_ROOT`,
- próbuje załadować `$EWW_ROOT/lib/bash/baner.sh` i wywołać `eww_banner` raz na sesję,
- ustawia flagi sesji: `EWW_BANNER_SHOWN`, `EWW_INIT_OK`.

Bezpieczeństwo: przed sourcowaniem sprawdź zawartość pobranego pliku.

Kontakt: astriblast@gmail.com
# E-Waste Workshop
Strona: https://e-wasteworkshop.co.uk

Repozytorium: https://github.com/Nairecth/eww

Krok 1 — pobranie skryptu

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

Załaduj (source), żeby ustawienia działały w Twojej sesji terminala:

```bash
. ~/Downloads/init-eww.sh
```

Co robi `init-eww.sh` (krótko):

- sprawdza, czy powłoka jest interaktywna (jeśli nie — nie robi zmian),
- ustawia `EWW_ROOT` (domyślnie `/git/eww`) — można nadpisać przed źródłowaniem,
- jeżeli `EWW_CD_ROOT` ≠ 0 i katalog istnieje — przechodzi (`cd`) do `EWW_ROOT`,
- próbuje załadować `$EWW_ROOT/lib/bash/baner.sh` i wywołać `eww_banner` raz na sesję,
- ustawia flagi sesji: `EWW_BANNER_SHOWN`, `EWW_INIT_OK`.

Bezpieczeństwo: przed sourcowaniem sprawdź zawartość pobranego pliku.

Kontakt: astriblast@gmail.com
