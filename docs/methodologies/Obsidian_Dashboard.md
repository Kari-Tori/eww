---
title: Obsidian Dashboard
description: Obsidian Dashboard  
type: file
category: docs
filepath: docs/methodologies/Obsidian Dashboard.md
color: green
author: jakubc
owner: jakubc
created: 2025-11-21
updated: 2025-11-21
version: 1.0.0
language: pl
status: active
priority: normal
license: MIT
tags:
  - documentation
  - markdown
  - docs
  - knowledge
keywords:
aliases:

related:
  - docs/readme-checklist.md
  - docs/ENDPOINTS.md
  - docs/yaml-frontmatter-spec.md
  - docs/neovim-guide.md
  - docs/narzedzia-deweloperskie.md
dependencies:
sources:
  - docs/methodologies/Obsidian Dashboard.md
backlinks: []
context: "E-Waste Workshop - Bash toolkit for Kubuntu environment setup"
project: eww
repository: https://github.com/Kari-Tori/eww-1
---



# Obsidian Dashboard  
_E-Waste Workshop Vault | Użytkownik: jakubc_

---

## **Status systemu**
- **Vault hostowany na:** GERC (Kubuntu)
- **Synchronizacja:** Syncthing (iPhone jakubc, iPhone karinam)
- **Wersjonowanie:** [✓] (na GERC)
- **Automatyzacja:** [✗] Do wdrożenia
- **Użytkownicy:** jakubc, karinam

---

## **Główne foldery**
- `00_INBOX/` — Szybkie wrzuty, nowe notatki
- `01_PROJECTS/` — Aktywne projekty (YouTube, GERC, AI itd.)
- `02_RESOURCES/` — Tutoriale, wiedza, artykuły
- `03_OBSIDIAN/` — Dashboard, Changelog, Config
- `04_ASSETS/` — Inwentaryzacja sprzętu
- `05_TASKS/` — Zadania operacyjne
- `Team/` — Notatki osobiste, onboarding, role
- `Templates/` — Szablony Templatera

---

## **Główne pliki**
- [[03_OBSIDIAN/CHANGELOG.md]]
- [[03_OBSIDIAN/MVP.md]]
- [[05_TASKS/Tasks.md]]
- [[Team/AboutJakub.md]]
- [[Team/AboutKarina.md]]

---

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

---

## **Plan rozwoju Vaultu**
- [x] Stworzenie struktury folderów
- [x] Ustawienie Syncthing (2x iPhone)
- [x] Konfiguracja Dashboardu
- [ ] Wdrożenie automatyzacji i skrótów (iOS + Templater)
- [ ] Backlog zadań do `Tasks.md`
- [ ] Podpięcie AI (analiza zasobów, sprzętu itd.)
- [ ] Wersja mobilna Vaultu (Notebooks, MarkdownReader itd.)

---

## **Ostatnie zmiany**
Zobacz [[03_OBSIDIAN/CHANGELOG.md]]  
Aktualizuj ręcznie po każdej większej zmianie.

---

## **Notatka**
Ten dashboard możesz dostosować do potrzeb — dodając linki, sekcje projektowe i szybki dostęp do MOC.
