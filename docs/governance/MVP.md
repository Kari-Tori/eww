---
version: 0.0.4
title: "MVP"
created: 2025-11-21
modified: 2025-11-28
tags:
  - auto-versioned
---

created: 2025-11-21T15:00:00Z
modified: 2025-11-24T22:31:02Z
author: jakubc
---
tags:
  - #automation
  - #development
  - #docs
  - #eww
  - #knowledge
  - #linux
  - #secondbrain
title: "MVP — cel i kryteria akceptacji"






owner: jakubc
created: 2025-11-21T15:00:00Z
modified: 2025-11-24T22:31:02Z
author: jakubc
---



# MVP — cel i kryteria akceptacji

Wersja docelowa: 0.0.0.1 (MVP)

Cel
Zapewnić minimalny zestaw funkcjonalności, który pozwala na szybkie przygotowanie maszyny (najnowsze Kubuntu) do pracy z repozytorium E-Waste Workshop.

Kryteria akceptacji (definition of done)
1. `init-eww.sh` działa poprawnie po załadowaniu (sourcowaniu) w interaktywnej powłoce bash:
   - zmienna `EWW_ROOT` ustawiona (domyślnie `/git/eww`),
   - jeśli `EWW_CD_ROOT` nie jest `0` i katalog istnieje — powłoka przechodzi do `EWW_ROOT`,
   - jeśli `$EWW_ROOT/lib/bash/baner.sh` jest dostępny, zostaje załadowany i wywoływana jest funkcja `eww_banner` raz na sesję,
   - po inicjalizacji eksportowana jest flaga `EWW_INIT_OK=1`.

2. `README.md` zawiera jasne instrukcje:
   - jak pobrać `init-eww.sh` z GitHub (raw),
   - dlaczego należy `source` skrypt (a nie uruchamiać w subprocess),
   - jak sprawdzić, że inicjalizacja powiodła się (np. `echo "$EWW_INIT_OK"`).

3. Repozytorium zawiera plik `VERSION` ustawiony na `0.0.0.1` oraz wpis w `CHANGELOG.md` opisujący MVP.

4. Skrypt `scripts/bump-version.sh` pozwala na łatwe podbicie wersji i utworzenie brancha/komitu/taga (testowane z `--dry-run`).

5. Wydanie (release) można przeprowadzić lokalnie: wykonanie poleceń z `scripts/bump-version.sh` prowadzi do powstania branch/tag i (opcjonalnie) PR.

Testy manualne (jak zweryfikować na maszynie testowej Kubuntu)
1. Przygotowanie testowej maszyny:

```bash
# na świeżym Kubuntu
sudo apt update && sudo apt install -y git curl bash
git clone https://github.com/Nairecth/eww.git /git/eww
```

2. Pobranie i sourcowanie skryptu:

```bash
curl -fsSL -o ~/Downloads/init-eww.sh https://raw.githubusercontent.com/Nairecth/eww/main/init-eww.sh
. ~/Downloads/init-eww.sh

# Sprawdź status
echo "EWW_ROOT=$EWW_ROOT"
echo "EWW_INIT_OK=${EWW_INIT_OK-}"
```

3. Sprawdzenie banera (jeśli istnieje):

```bash
[ -r "$EWW_ROOT/lib/bash/baner.sh" ] && grep -n "function eww_banner" "$EWW_ROOT/lib/bash/baner.sh" || echo "brak banera"
```

4. Weryfikacja wersji i changeloga:

```bash
cat VERSION
head -n 20 CHANGELOG.md
```

Wydanie MVP (kroki)
1. Upewnij się, że wszystkie zmiany są w `main` i że `init-eww.sh` i `README.md` są poprawne.
2. Na maszynie deweloperskiej uruchom:

```bash
./scripts/bump-version.sh 0.0.0.1 -m "MVP: initial release" --branch --tag --push --pr
```

3. Jeśli PR zostanie utworzony, zrób review i zmerguj do `main` — to kończy wydanie.

Dodatkowe notatki
- Zalecam wykonanie testów na maszynie wirtualnej z najnowszym Kubuntu.
- Jeżeli chcesz, mogę automatycznie utworzyć wersję `0.0.0.1` i PR, ale potrzebuję potwierdzenia, że chcesz wypchnąć zmiany do origin i ewentualnie nadpisać tagi jeśli to konieczne.

## 🔗 Backlinks

- [[docs/governance/governance]]
- [[docs/docs]]
- [[INDEX]]