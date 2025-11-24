---
tags:
  - #infrastructure
  - #workflow
  - #todo
created: 2025-11-22T19:25:00Z
modified: 2025-11-22T19:25:00Z
author: jakubc
title: "TODO structure — policy"
owner: jakubc
---

# TODO structure — policy

## Zasada folder_note ↔ TODO
- Każdy folder note (np. `usr/jakubc/jakubc.md`, `docs/infra/hardware/workstations/gerc/gerc.md`) ma przypisany zewnętrzny folder `TODO/`.
- Folder `TODO/` zawiera:
  - `TODO.md` — indeks z linkami do podzadań/dzienników.
  - Podfoldery kategorii (np. `TODO-daily/`, `TODO-projects/`).
- W podfolderach datowanych (`TODO-daily/TODO-YYYY-MM-DD/`):
  - Każde zadanie = pojedynczy plik Markdown.
  - Nazwa folderu to data (ISO), nazwa pliku = skrócony opis zadania.
  - `README.md` (opcjonalny) opisuje kontekst dnia.

## Przykład (jakubc)
```
usr/jakubc/
├── jakubc.md          # folder note
└── TODO/
    ├── TODO.md        # indeks
    └── TODO-daily/
        └── TODO-2025-11-22/
            ├── README.md
            ├── internet.md
            ├── tablet.md
            └── … (1 zadanie = 1 plik)
```

## Proces
1. Tworząc nowy folder note → od razu dodaj `TODO/` obok.
2. Wszystkie checklisty/tickety przenosimy do pojedynczych plików w odpowiednich subfolderach.
3. `TODO.md` pełni rolę indeksu: linkuje do bieżących dat/projektów.
4. Linki zwrotne: w folder note dodaj sekcję `## ✅ Zadania` i link do `TODO/TODO.md`.

## Status
- [x] wdrożono dla `usr/jakubc/`
- [ ] wdrożyć dla innych folder notes (asus_z77, gerc, …)
