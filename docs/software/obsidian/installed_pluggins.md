created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---
title: Zainstalowane wtyczki Obsidian — Kompletna dokumentacja
description: Dokumentacja wszystkich zainstalowanych wtyczek z konfiguracją i przykładami użycia
version: 2.1.0
updated: 2025-11-24
tags:
  - obsidian
  - plugins
  - documentation
  - configuration
created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---

# Zainstalowane wtyczki Obsidian — Kompletna dokumentacja

## 📚 Pełna dokumentacja Obsidian

Zobacz również:
- **[obsidian-plugins.md](./obsidian-plugins.md)** — 24 community plugins z przykładami
- **[obsidian-customization.md](./obsidian-customization.md)** — Motywy, CSS snippets, appearance ✨ NOWO
- **[plugins-status.md](./plugins-status.md)** — Audit pluginów (54% coverage)
- **[obsidian.md](./obsidian.md)** — Core funkcje Obsidian

created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---

## 📊 Podsumowanie

**Status:** 13 wtyczek zainstalowanych (8 core + 5 productivity)

| Kategoria | Liczba | Wtyczki |
|-----------|--------|---------|
| **Core Workflow** | 8 | Dataview, Tasks, Templater, QuickAdd, Kanban, Calendar, Periodic Notes, Obsidian Git |
| **Productivity** | 5 | Linter, Advanced Tables, Tag Wrangler, Note Refactor, Excalidraw |
| **RAZEM** | 13 | — |

created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---

## 🔧 Core Workflow Plugins (8)

### 1. Kanban — Tablice zarządzania zadaniami

**Status:** ✅ ZAINSTALOWANE  
**Repo:** https://github.com/mgmeyers/obsidian-kanban

#### Opis
Tablice Kanban w stylu Trello bezpośrednio w notatkach Markdown. Idealne do zarządzania projektami, zadaniami eBay, workflow.

#### Konfiguracja
```yaml
Settings → Kanban:
  - Date format: YYYY-MM-DD
  - Prepend / append new cards: Prepend
  - Link dates to daily notes: ✅ ON
  - Archive completed cards: ✅ ON
```

#### Użycie
**Tworzenie tablicy:**
```markdown
Ctrl+P → "Kanban: Create new board"
```

**Struktura (Markdown):**
```markdown
created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---
kanban-plugin: basic
created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---

## TODO

- [ ] Zadanie 1 @{2025-11-30}
- [ ] Zadanie 2 #priority/high

## In Progress

- [ ] Zadanie 3

## Done

- [x] Zadanie 4
```

**Praktyczne przykłady:**
- eBay sprzedaż: kolumny `TODO | Listed | Sold | Shipped`
- Projekty: `Backlog | In Progress | Review | Done`
- Daily notes: `Today | This Week | Later`

created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---

### 2. Dataview — Zapytania i raporty z notatek

**Status:** ✅ ZAINSTALOWANE  
**Repo:** https://github.com/blacksmithgu/obsidian-dataview

#### Opis
Przekształca vault w bazę danych. Zapytania SQL-like do generowania dynamicznych list, tabel i raportów.

#### Konfiguracja
```yaml
Settings → Dataview:
  - Enable JavaScript Queries: ✅ ON
  - Enable Inline Queries: ✅ ON
  - Enable Inline JavaScript: ✅ ON
  - Date Format: YYYY-MM-DD
```

#### Użycie

**Przykład 1: Lista zadań z priorytetem HIGH**
````markdown
```dataview
TABLE priority, due, status
FROM ""
WHERE contains(tags, "#eBay") AND priority = "high"
SORT due asc
```
````

**Przykład 2: Notatki z ostatniego tygodnia**
````markdown
```dataview
LIST
WHERE file.ctime >= date(today) - dur(7 days)
SORT file.ctime desc
LIMIT 10
```
````

**Przykład 3: Projekty z deadline**
````markdown
```dataview
TABLE deadline, status, owner
FROM "projects"
WHERE deadline <= date(today) + dur(30 days)
SORT deadline asc
```
````

**DataviewJS (zaawansowane):**
````markdown
```dataviewjs
dv.table(["Nazwa", "Status", "Progress"],
  dv.pages('"projects"')
    .where(p => p.status != "DONE")
    .map(p => [p.file.link, p.status, p.progress + "%"])
)
```
````

created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---

### 3. Templater — Skrypty i dynamiczne szablony

**Status:** ✅ ZAINSTALOWANE  
**Repo:** https://github.com/SilentVoid13/Templater

#### Opis
Potężny system szablonów z JavaScript, zmiennymi, funkcjami i automatyzacją.

#### Konfiguracja
```yaml
Settings → Templater:
  - Template folder location: "templates/"
  - Trigger on file creation: ✅ ON
  - Automatic jump to cursor: ✅ ON
  - Enable folder templates: ✅ ON
```

**Folder templates:**
- `usr/karinam/journal/` → `templates/daily-note.md`
- `projects/` → `templates/project.md`

#### Użycie

**Szablon daily note:**
```markdown
created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---
date: <% tp.date.now("YYYY-MM-DD") %>
day: <% tp.date.now("dddd") %>
tags: [daily]
created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---

# <% tp.date.now("YYYY-MM-DD dddd") %>

## 📋 Tasks
<% tp.file.cursor(1) %>

## 📝 Notes

## 🔗 Links
- [[<% tp.date.now("YYYY-MM-DD", -1) %>|← Yesterday]]
- [[<% tp.date.now("YYYY-MM-DD", 1) %>|Tomorrow →]]
```

**Szablon projektu:**
```markdown
created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---
title: <% tp.file.title %>
status: "TODO"
tags: [project]
created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---

# <% tp.file.title %>

## 🎯 Cel
<% tp.file.cursor(1) %>

## 📊 Status
- **Rozpoczęty:** <% tp.date.now("YYYY-MM-DD") %>
- **Deadline:** 
- **Owner:** 

## ✅ Tasks
- [ ] Task 1
- [ ] Task 2
```

**Komendy:**
- `Ctrl+P` → **Templater: Insert template**
- `Ctrl+P` → **Templater: Create new note from template**

created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---

### 4. Tasks — Zaawansowane filtrowanie zadań

**Status:** ✅ ZAINSTALOWANE  
**Repo:** https://github.com/obsidian-tasks-group/obsidian-tasks

#### Opis
Zaawansowane zarządzanie zadaniami: terminy, priorytety, powtarzające się zadania, filtrowanie.

#### Konfiguracja
```yaml
Settings → Tasks:
  - Global task filter: ""
  - Remove global filter from description: ✅ ON
  - Auto-suggest task formats: ✅ ON
  - Set done date on completion: ✅ ON
```

#### Użycie

**Format zadań:**
```markdown
- [ ] Zadanie podstawowe
- [ ] Zadanie z terminem 📅 2025-11-30
- [ ] Zadanie z priorytetem ⏫
- [ ] Zadanie powtarzające 🔁 every week
- [ ] Zadanie rozpoczęte 🛫 2025-11-24
- [ ] Zadanie z osobą przypisaną 👤 @karinam
```

**Priorytety:**
- `⏫` — Highest
- `⏬` — Lowest
- `🔼` — High
- `🔽` — Low

**Blok zapytania Tasks:**
````markdown
```tasks
not done
due before 2025-12-01
sort by priority
group by filename
```
````

**Przykłady:**
````markdown
# Zadania na dziś
```tasks
not done
due today
```

# Zadania HIGH priority
```tasks
not done
priority is highest
sort by due
```

# Zadania eBay
```tasks
path includes eBay
not done
```
````

created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---

### 5. QuickAdd — Szybkie akcje i makra

**Status:** ✅ ZAINSTALOWANE  
**Repo:** https://github.com/chhoumann/quickadd

#### Opis
Szybkie tworzenie notatek, kart Kanban, zadań przez hotkeys i makra.

#### Konfiguracja
```yaml
Settings → QuickAdd:
  - [Dodaj Choice] → Type: Template
    - Name: "Daily Note"
    - Template Path: "templates/daily-note.md"
    - File Name Format: "{{DATE:YYYY-MM-DD}}"
    - Folder: "usr/karinam/journal/"
```

**Przykładowe Choices:**
1. **Quick Task** (Capture)
   - Format: `- [ ] {{VALUE}} 📅 {{DATE:YYYY-MM-DD}}`
   - Append to: `usr/karinam/journal/{{DATE:YYYY-MM-DD}}.md`

2. **eBay Item** (Template)
   - Template: `templates/ebay-item.md`
   - Folder: `eBay/items/`

3. **Meeting Note** (Template)
   - Template: `templates/meeting.md`
   - Folder: `meetings/`

#### Użycie
- Assign hotkey: Settings → Hotkeys → search "QuickAdd"
- Ustaw `Ctrl+Shift+N` → QuickAdd: Daily Note
- Użyj: `Ctrl+Shift+N` → automatycznie utworzy daily note

created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---

### 6. Calendar — Wizualizacja czasowa notatek

**Status:** ✅ ZAINSTALOWANE  
**Repo:** https://github.com/liamcain/obsidian-calendar-plugin

#### Opis
Kalendarz w sidebarze pokazujący daily notes, integracja z Periodic Notes.

#### Konfiguracja
```yaml
Settings → Calendar:
  - Start week on: Monday
  - Show week number: ✅ ON
  - Confirm before creating new note: ❌ OFF
  - Weekly note format: YYYY-[W]WW
```

#### Użycie
- Otwórz prawy sidebar → ikona kalendarz
- Kliknij datę → otwórz/utwórz daily note
- Kropki pod datami = istniejące notatki
- Kolor kropki = liczba słów w notatce

created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---

### 7. Periodic Notes — Daily/Weekly/Monthly notes

**Status:** ✅ ZAINSTALOWANE  
**Repo:** https://github.com/liamcain/obsidian-periodic-notes

#### Opis
Rozszerzenie Calendar dla daily, weekly, monthly, yearly notes.

#### Konfiguracja
```yaml
Settings → Periodic Notes:

Daily Notes:
  - Format: YYYY-MM-DD
  - Template: templates/daily-note.md
  - Folder: usr/karinam/journal/

Weekly Notes:
  - Format: YYYY-[W]WW
  - Template: templates/weekly-note.md
  - Folder: usr/karinam/weekly/

Monthly Notes:
  - Format: YYYY-MM
  - Template: templates/monthly-note.md
  - Folder: usr/karinam/monthly/
```

#### Użycie
- `Ctrl+P` → **Periodic Notes: Open daily note**
- `Ctrl+P` → **Periodic Notes: Open weekly note**
- `Ctrl+P` → **Periodic Notes: Open monthly note**

created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---

### 8. Obsidian Git — Backup i automatyczne commity

**Status:** ✅ ZAINSTALOWANE (ale wyłączone)  
**Repo:** https://github.com/denolehov/obsidian-git

#### Opis
Automatyczne commity i push do Git repo. Backup, wersjonowanie, sync między urządzeniami.

#### Konfiguracja (gdy włączysz)
```yaml
Settings → Obsidian Git:
  - Vault backup interval: 10 (minutes)
  - Commit message: "vault backup: {{date}}"
  - Auto pull on startup: ✅ ON
  - Auto push on commit: ✅ ON
  - Pull updates on startup: ✅ ON
```

#### Użycie
- Automatyczny backup co 10 minut
- `Ctrl+P` → **Obsidian Git: Commit all changes**
- `Ctrl+P` → **Obsidian Git: Push**
- `Ctrl+P` → **Obsidian Git: Pull**

**⚠️ Uwaga:** Obecnie wyłączone — włącz w Settings → Community plugins

created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---

## ⚡ Productivity Plugins (5)

### 9. Obsidian Linter — Auto-formatowanie Markdown

**Status:** ✅ ZAINSTALOWANE  
**Repo:** https://github.com/platers/obsidian-linter

#### Opis
Automatyczne formatowanie Markdown przy zapisie: YAML, trailing spaces, headings, listy.

#### Konfiguracja
```yaml
Settings → Linter:
  - Lint on save: ✅ ON
  - Display changed files: ✅ ON
  - Format YAML array: ✅ ON
  - Remove trailing spaces: ✅ ON
  - Insert blank line after YAML: ✅ ON
```

#### Użycie
- Automatyczne formatowanie przy `Ctrl+S`
- Ręcznie: `Ctrl+P` → **Linter: Lint current file**
- Wiele plików: `Ctrl+P` → **Linter: Lint all files in folder**

created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---

### 10. Advanced Tables — Edytor tabel

**Status:** ✅ ZAINSTALOWANE  
**Repo:** https://github.com/tgrosinger/advanced-tables-obsidian

#### Opis
Edytor tabel w stylu Excel: Tab navigation, auto-formatowanie, sortowanie.

#### Konfiguracja
```yaml
Settings → Advanced Tables:
  - Pad cell width: ✅ ON
  - Format on tab: ✅ ON
  - Bind enter to navigation: ✅ ON
```

#### Użycie
**Skróty:**
- `Tab` — następna kolumna (auto-format)
- `Shift+Tab` — poprzednia kolumna
- `Enter` — następny wiersz
- `Ctrl+Shift+D` — menu tabel (insert/delete row/column, sort)

**Przykład:**
```markdown
| Projekt | Status | Priority |
|---------|--------|----------|
| eww     | TODO   | High     |
```
Kliknij w komórkę → `Tab` → auto-wyrównanie

created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---

### 11. Tag Wrangler — Zarządzanie tagami

**Status:** ✅ ZAINSTALOWANE  
**Repo:** https://github.com/pjeby/tag-wrangler

#### Opis
Rename, merge, delete tagów z context menu. Masowe operacje na tagach.

#### Konfiguracja
```yaml
Settings → Tag Wrangler:
  - Show tag counts: ✅ ON
  - Context menu integration: ✅ ON
```

#### Użycie
- Otwórz Tag Panel (prawy sidebar → `#`)
- Prawy klik na tag → **Rename tag** (zmieni we wszystkich notatkach)
- Prawy klik → **Merge tags** (scal dwa tagi)
- Prawy klik → **Delete tag**

created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---

### 12. Note Refactor — Ekstrakcja fragmentów

**Status:** ✅ ZAINSTALOWANE  
**Repo:** https://github.com/lynchjames/note-refactor-obsidian

#### Opis
Ekstrakcja zaznaczonego tekstu lub sekcji do nowej notatki z automatycznym linkiem.

#### Konfiguracja
```yaml
Settings → Note Refactor:
  - Default location: "notes/"
  - File name template: "{{date:YYYY-MM-DD}}-{{title}}"
  - Include heading: ✅ ON
  - Open in new pane: ✅ ON
```

#### Użycie
1. Zaznacz tekst
2. `Ctrl+P` → **Note Refactor: Extract selection to new note**
3. Podaj nazwę
4. Nowa notatka + link `![[nazwa]]` w oryginale

created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---

### 13. Excalidraw — Rysunki i diagramy

**Status:** ✅ ZAINSTALOWANE  
**Repo:** https://github.com/zsviczian/obsidian-excalidraw-plugin

#### Opis
Edytor rysunków wektorowych: flowcharts, diagramy, sketches.

#### Konfiguracja
```yaml
Settings → Excalidraw:
  - Folder for drawings: "drawings/"
  - Default filename: "Drawing {{date:YYYY-MM-DD}}"
  - Theme: "Match Obsidian"
  - Auto-export PNG: ✅ ON
```

#### Użycie
**Tworzenie:**
- `Ctrl+P` → **Excalidraw: Create new drawing**

**Skróty (w edytorze):**
- `R` — Rectangle
- `D` — Diamond
- `C` — Circle
- `A` — Arrow
- `T` — Text

**Osadzanie:**
```markdown
![[diagram.excalidraw]]
```

created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---

## 📚 Powiązane dokumenty

- [obsidian-plugins.md](./obsidian-plugins.md) — 24 zalecane pluginy
- [plugins-status.md](./plugins-status.md) — Audit instalacji
- [plugins-installation-guide.md](./plugins-installation-guide.md) — Przewodnik instalacji
- [obsidian.md](./obsidian.md) — Główna dokumentacja

created: 2025-11-21T19:00:00Z
modified: 2025-11-25T03:12:10Z
author: jakubc
---

## 🔄 Aktualizacje

**2025-11-18:** v1.0.0 — Lista 8 core plugins  
**2025-11-24:** v2.0.0 — Kompletna dokumentacja 13 wtyczek z konfiguracją i przykładami
