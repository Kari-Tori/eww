---
tags:
  - #folder_note
  - #house
  - #home
  - #core
  - #shared
created: 2025-11-22T00:00:00Z
modified: 2025-11-22T16:56:44+00:00
author: jakubc
title: "Dom — folder note i indeks"
status: active
folder: core/house/
owner: jakubc
---

# 📁 core/house

## Cel i zakres

> Centralny hub operacyjny dla wspólnych zadań domowych (jakubc + karinam). Folder udostępnia backlog, SOP-y i checklisty, aby wszystkie działania związane z domem były zsynchronizowane między prywatnymi vaultami (`usr/`) i głównym repo.

## Zawartość

### Struktura katalogów

```
house/
├── area/                # 7 obszarów zarządczych
│   ├── maintenance/
│   │   ├── rules.md
│   │   ├── functions.md
│   │   ├── raci.md
│   │   └── TODO.md
│   ├── repairs/         # analogiczny zestaw plików
│   ├── features/
│   ├── cooking/
│   ├── shopping/
│   ├── cleaning/
│   └── other/
├── house.md             # Folder note + indeks (ten plik)
└── house_dashboard.md   # Dashboard operacyjny / widok tygodniowy
```

### Główne pliki

| Plik / katalog | Opis | Status |
|----------------|------|--------|
| `house.md` | Nota katalogowa + mapa Waypoint dla całego folderu. | ✅ |
| `house_dashboard.md` | Dashboard operacyjny (wskaźniki, ceremonie, linki). | ✅ |
| `area/` | 7 obszarów procesowych (Maintenance, Repairs, Features, Cooking, Shopping, Cleaning, Other). | 🚧 (szablony gotowe) |

### Obszary `area/`

| Obszar | Opis | TODO | Zasady / Funkcje / RACI |
|--------|------|------|-------------------------|
| Maintenance | Rutynowe przeglądy i serwisy instalacji. | [[core/house/area/maintenance/TODO]] | [[core/house/area/maintenance/rules]] · [[core/house/area/maintenance/functions]] · [[core/house/area/maintenance/raci]] |
| Repairs | Reaktywne naprawy awarii i usterek. | [[core/house/area/repairs/TODO]] | [[core/house/area/repairs/rules]] · [[core/house/area/repairs/functions]] · [[core/house/area/repairs/raci]] |
| Features & Improvements | Projekty usprawniające komfort i automatyzację. | [[core/house/area/features/TODO]] | [[core/house/area/features/rules]] · [[core/house/area/features/functions]] · [[core/house/area/features/raci]] |
| Cooking & Meals | Plan posiłków, meal-prep, eksperymenty kulinarne. | [[core/house/area/cooking/TODO]] | [[core/house/area/cooking/rules]] · [[core/house/area/cooking/functions]] · [[core/house/area/cooking/raci]] |
| Shopping & Supplies | Zakupy, zapasy i zamówienia online. | [[core/house/area/shopping/TODO]] | [[core/house/area/shopping/rules]] · [[core/house/area/shopping/functions]] · [[core/house/area/shopping/raci]] |
| Cleaning | Harmonogramy sprzątania i checklisty. | [[core/house/area/cleaning/TODO]] | [[core/house/area/cleaning/rules]] · [[core/house/area/cleaning/functions]] · [[core/house/area/cleaning/raci]] |
| Other / Misc | Tematy ad-hoc zanim zyskają dedykowany obszar. | [[core/house/area/other/TODO]] | [[core/house/area/other/rules]] · [[core/house/area/other/functions]] · [[core/house/area/other/raci]] |

**Legenda statusów:** ✅ gotowe · 🚧 w toku · 📝 zaplanowane · ⚠️ wymaga aktualizacji · ❌ przestarzałe

## Konwencje

### Nazewnictwo

- Pliki obszarowe: `area/{obszar}/TODO.md`, `rules.md`, `functions.md`, `raci.md`.
- Dokumenty mapujące: `house.md` (folder note) + `house_dashboard.md` (widok operacyjny).
- Tagi obowiązkowe: `#folder_note`, `#house`, `#shared` + tag obszaru (`#maintenance`, `#cooking`, `#cleaning`, ...).

### Standardy dokumentacji

- Każdy plik ma YAML front matter z właścicielem, statusem i tagami.
- Checklisty zgodne z pluginem Tasks (`- [ ]`, daty `📅 YYYY-MM-DD`, priorytety `⏫/⏬`).
- Linkowanie wzajemne: karty w `area/{obszar}/TODO.md` odsyłają do prywatnych not w `usr/`, a prywatne noty wracają do `core/house/`.

## Zależności

### Katalogi powiązane

- `../core.md` — nadrzędne standardy Core.
- `/usr/jakubc/` i `/usr/karinam/` — osobiste konteksty i wykonawcy zadań.
- `/Tags/#house/` — taksonomia tagów domowych używana w Obsidianie.

### Wymagania zewnętrzne

- Obsidian + pluginy Waypoint (mapa folderów) oraz Tasks (zadania).
- Git (synchronizacja zmian między współdzielonymi maszynami).

## Jak używać

### Podstawowe operacje

```bash
# Dodanie zadania w obszarze "cleaning"
cd /home/jakubc/git/eww/core/house/area/cleaning
$EDITOR TODO.md
```

### Typowe workflow

1. Zidentyfikuj zadanie/domowy temat i wybierz odpowiedni obszar (np. cleaning).
2. Dodaj wpis w `area/{obszar}/TODO.md` (nowa pozycja lub aktualizacja istniejącej).
3. Linkuj zadanie w prywatnych notach (`usr/`) oraz oznacz właściciela/termin w pluginie Tasks.
4. Po realizacji odhacz zadanie i przenieś notatki do sekcji archiwum w tym samym pliku.

### Przykłady użycia

```bash
# Szybki przegląd backlogu
cd /home/jakubc/git/eww
obsidian core/house/house.md

# Przeniesienie prywatnego zadania do wspólnego backlogu
rg -n "sprzątanie" usr/jakubc/TODO-home.md
code core/house/area/cleaning/TODO.md
```

## Uwagi specjalne

### Ograniczenia

- Nie przechowuj tu dokumentów z danymi wrażliwymi (faktury, numery kont) — zamiast tego linkuj do zaszyfrowanych lokalizacji.
- Załączniki binarne (zdjęcia usterek) lądują w `var/` lub systemie plików poza repo; w notach dodaj tylko odwołanie.

### Bezpieczeństwo

- Przed pushem sprawdź, czy pliki nie zawierają prywatnych adresów/telefonów.
- Synchronizacja repo (Git) powinna poprzedzać aktualizację prywatnych vaultów, aby uniknąć konfliktów.

## Maintenance

### Częste zadania

- **Przegląd tygodniowy (poniedziałek):** aktualizacja statusów w `area/*/TODO.md`.
- **Porządkowanie miesięczne:** archiwizacja zakończonych pozycji w odpowiednich plikach `area/{obszar}/TODO.md` (sekcja `## 🗄️ Archiwum`).
- **Backlink audit:** uruchom `scripts/check-folder-notes.sh`, aby upewnić się, że `house.md` jest oznaczony i linkowany.

### Kontakt

- **Właściciele:** jakubc & karinam.
- **Dokumentacja pomocnicza:** `usr/jakubc/TODO-home.md` (kontekst prywatny) oraz noty Kariny w `usr/karinam/`.

## Historia zmian

| Data | Autor | Zmiana |
|------|-------|--------|
| 2025-11-22 | jakubc | Refaktoryzacja struktury: `area/*/{rules,functions,raci,TODO}.md` + dashboard. |
| 2025-11-22 | jakubc | Inicjalizacja folder note wg szablonu `core/tmp/folder_note.md`. |

## Zobacz też

- [[core.md]]
- [[usr.md]]
- [[usr/jakubc/TODO-home]]
- [[core/house/house_dashboard]]

---

**Ostatnia aktualizacja**: 2025-11-22  
**Wersja**: 0.1
