---
tags:
  - #automation
  - #docs
  - #eww
  - #knowledge
  - #linux
  - #obsidian
  - #secondbrain
created: 2025-11-21T10:00:00Z
modified: 2025-11-21T16:00:00Z
author: jakubc
title: "Obsidian Dashboard  "






---



# Obsidian Dashboard  
_E-Waste Workshop Vault | Użytkownik: jakubc_


## **Status systemu**
- **Vault hostowany na:** GERC (Kubuntu)
- **Synchronizacja:** Syncthing (iPhone jakubc, iPhone karinam)
- **Wersjonowanie:** [✓] (na GERC)
- **Automatyzacja:** [✗] Do wdrożenia
- **Użytkownicy:** jakubc, karinam


## **Główne foldery**
- `00_INBOX/` — Szybkie wrzuty, nowe notatki
- `01_PROJECTS/` — Aktywne projekty (YouTube, GERC, AI itd.)
- `02_RESOURCES/` — Tutoriale, wiedza, artykuły
- `03_OBSIDIAN/` — Dashboard, Changelog, Config
- `04_ASSETS/` — Inwentaryzacja sprzętu
- `05_TASKS/` — Zadania operacyjne
- `Team/` — Notatki osobiste, onboarding, role
- `Templates/` — Szablony Templatera


## **Główne pliki**
- [[03_OBSIDIAN/CHANGELOG.md]]
- [[03_OBSIDIAN/MVP.md]]
- [[05_TASKS/Tasks.md]]
- [[Team/AboutJakub.md]]
- [[Team/AboutKarina.md]]


## **Widoki Dataview**
### Zadania Kariny
```dataview
table status as "Status", file.link as "Zadanie", due as "Termin"
from "05_TASKS"
where contains(tags, "#karina")
sort due asc
```

### Zadania Jakuba
```dataview
table status as "Status", file.link as "Zadanie", due as "Termin"
from "05_TASKS"
where contains(tags, "#jakub")
sort due asc
```


## **Plan rozwoju Vaultu**
- [x] Stworzenie struktury folderów
- [x] Ustawienie Syncthing (2x iPhone)
- [x] Konfiguracja Dashboardu
- [ ] Wdrożenie automatyzacji i skrótów (iOS + Templater)
- [ ] Backlog zadań do `Tasks.md`
- [ ] Podpięcie AI (analiza zasobów, sprzętu itd.)
- [ ] Wersja mobilna Vaultu (Notebooks, MarkdownReader itd.)


## **Ostatnie zmiany**
Zobacz [[03_OBSIDIAN/CHANGELOG.md]]  
Aktualizuj ręcznie po każdej większej zmianie.


## **Notatka**
Ten dashboard możesz dostosować do potrzeb — dodając linki, sekcje projektowe i szybki dostęp do MOC.
