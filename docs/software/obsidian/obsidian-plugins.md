created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---
title: Community Plugins dla Obsidian — polecane i zaawansowane
description: Kompletny przewodnik po najlepszych community plugins dla Obsidian, z przykładami użycia, konfiguracją i integracją z workflow
version: 1.1.0
updated: 2025-11-24
tags:
  - obsidian
  - plugins
  - community
  - pkm
  - productivity
created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

# Community Plugins dla Obsidian — polecane i zaawansowane

## 🎯 Cel dokumentu

Zestawienie najczęściej polecanych community plugins dla Obsidian, opartych na:
- Forach r/ObsidianMD (Reddit)
- Oficjalnym Discord Obsidian
- GitHub Discussions popularnych pluginów
- Ankietach społeczności PKM

## 📚 Pełna dokumentacja Obsidian

Zobacz również:
- **[installed_pluggins.md](./installed_pluggins.md)** — 13 zainstalowanych pluginów z pełną konfiguracją
- **[obsidian-customization.md](./obsidian-customization.md)** — Motywy, CSS snippets, appearance ✨ NOWO
- **[plugins-status.md](./plugins-status.md)** — Audit pluginów (54% coverage)
- **[plugins-installation-guide.md](./plugins-installation-guide.md)** — Przewodnik instalacji
- **[obsidian.md](./obsidian.md)** — Core funkcje Obsidian

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 📦 Core plugins już zainstalowane

Lista w: `/docs/software/obsidian/installed_pluggins.md`

1. **Kanban** — tablice Kanban
2. **Dataview** — zapytania i raporty
3. **Templater** — dynamiczne szablony
4. **Tasks** — zaawansowane zadania
5. **QuickAdd** — szybkie akcje
6. **Calendar** — kalendarz
7. **Periodic Notes** — notatki periodyczne
8. **Obsidian Git** — backup i wersjonowanie

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🌟 Top Community Plugins (ranked by usage)

### 1️⃣ Dataview — Zapytania i raporty z notatek

**Repo:** https://github.com/blacksmithgu/obsidian-dataview  
**Instalacje:** 1.5M+  
**Rating:** ⭐⭐⭐⭐⭐

#### Opis
Dataview przekształca vault w bazę danych — umożliwia zapytania SQL-like, generowanie dynamicznych tabel, list i widoków.

#### Przykłady użycia

**Przykład 1: Lista zadań #eBay z priorytetem**
```dataview
TABLE priority as "Priorytet", due as "Termin", assignee as "Przypisany"
FROM ""
WHERE contains(tags, "#eBay") AND type = "task"
SORT due asc
```

**Przykład 2: Wszystkie notatki z ostatniego tygodnia**
```dataview
LIST
FROM ""
WHERE file.ctime >= date(today) - dur(7 days)
SORT file.ctime desc
```

**Przykład 3: Tabela projektów z statusem**
```dataview
TABLE status, started, deadline
FROM "projects"
WHERE type = "project"
SORT deadline asc
```

#### Konfiguracja
Settings → Dataview:
- Enable JavaScript Queries: ✅ (dla DataviewJS)
- Enable Inline Queries: ✅
- Enable Inline JavaScript Queries: ✅

#### Integracja z Kanban
Dataview może pobierać zadania z tablic Kanban:
```dataview
TASK
FROM "kanban"
WHERE !completed
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### 2️⃣ Tasks — Zaawansowane filtrowanie zadań

**Repo:** https://github.com/obsidian-tasks-group/obsidian-tasks  
**Instalacje:** 800K+  
**Rating:** ⭐⭐⭐⭐⭐

#### Opis
Tasks dodaje potężne filtry dla checkbox'ów `- [ ]`, terminy, priorytety, powtarzające się zadania.

#### Składnia zadania
```markdown
- [ ] Zadanie do wykonania 📅 2025-11-30 ⏫ #projekt
```
- `📅` — due date
- `⏫` — priorytet (high)
- `🔁` — powtarzające się
- `✅` — data zakończenia

#### Przykłady zapytań

**Przykład 1: Zadania na dziś**
````markdown
```tasks
not done
due today
sort by priority
```
````

**Przykład 2: Przeterminowane zadania**
````markdown
```tasks
not done
due before today
sort by due
```
````

**Przykład 3: Wszystkie zadania #eBay**
````markdown
```tasks
not done
tag includes #eBay
path includes "journal"
sort by priority, due
```
````

#### Konfiguracja
Settings → Tasks:
- Global Task Filter: (pozostaw puste dla wszystkich)
- Auto-suggest task format: ✅
- Set done date on every completed task: ✅

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### 3️⃣ Templater — Skrypty i dynamiczne szablony

**Repo:** https://github.com/SilentVoid13/Templater  
**Instalacje:** 1M+  
**Rating:** ⭐⭐⭐⭐⭐

#### Opis
Templater to rozszerzenie systemu szablonów Obsidian o JavaScript, zmienne, funkcje i logikę.

#### Przykłady szablonów

**Przykład 1: Szablon dzienny z datą**
```tpl
created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---
date: <% tp.date.now("YYYY-MM-DD") %>
title: Dzień — <% tp.date.now("YYYY-MM-DD") %>
day: <% tp.date.now("dddd") %>
week: <% tp.date.now("w") %>
created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

# <% tp.date.now("dddd, D MMMM YYYY") %>

## 📋 Zadania
- [ ] 

## 📝 Notatki


## 🎯 Cel dnia


## 📊 Podsumowanie

```

**Przykład 2: Nowy projekt z UUID**
```tpl
created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---
id: <% tp.date.now("YYYYMMDDHHmmss") %>
project: <% tp.file.title %>
status: planowanie
created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

# <% tp.file.title %>

## Opis


## Cele


## Zadania
- [ ] Rozpoczęcie projektu

```

**Przykład 3: Karta Kanban z metadanymi**
```tpl
- [ ] <% tp.system.prompt("Tytuł zadania") %>
	- 📅: <% tp.date.now("YYYY-MM-DD") %>
	- ⚑: <% tp.system.suggester(["P1", "P2", "P3", "P4"], ["P1", "P2", "P3", "P4"]) %>
	- 👤: @<% tp.system.prompt("Przypisany") %>
	- 🏷️: #<% tp.system.prompt("Tag") %>
```

#### Konfiguracja
Settings → Templater:
- Template folder location: `templates/`
- Trigger Templater on new file creation: ✅
- Enable Folder Templates: ✅
- Enable System Commands: ✅

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### 4️⃣ QuickAdd — Szybkie akcje i makra

**Repo:** https://github.com/chhoumann/quickadd  
**Instalacje:** 400K+  
**Rating:** ⭐⭐⭐⭐⭐

#### Opis
QuickAdd automatyzuje tworzenie notatek, wstawianie szablonów, uruchamianie skryptów.

#### Przykłady akcji

**Przykład 1: Szybkie dodanie karty do Kanban "Dziś"**
```json
{
  "name": "➕ Dodaj kartę Dziś",
  "type": "Template",
  "command": true,
  "templatePath": "templates/quick-card.md"
}
```

Template `templates/quick-card.md`:
```markdown
- [ ] {{VALUE:Tytuł}}
	- 📅: {{DATE:YYYY-MM-DD}}
	- ⚑: P3
	- 👤: @karinam
```

**Przykład 2: Nowa notatka daily**
```json
{
  "name": "📅 Nowa dzienna",
  "type": "Capture",
  "command": true,
  "captureTo": "usr/karinam/journal/{{DATE:YYYY/MM}}/{{DATE:YYYY-MM-DD}}.md",
  "createFileIfItDoesntExist": {
    "enabled": true,
    "createWithTemplate": true,
    "template": "templates/daily-template.md"
  }
}
```

**Przykład 3: Makro "Zaplanuj projekt"**
```json
{
  "name": "🚀 Zaplanuj projekt",
  "type": "Macro",
  "commands": [
    {
      "type": "NestedChoice",
      "name": "Wybierz typ projektu"
    },
    {
      "type": "Template",
      "templatePath": "templates/project-{{MACRO:ProjectType}}.md"
    },
    {
      "type": "Capture",
      "captureTo": "projects/{{VALUE:NazwaProjektu}}/README.md"
    }
  ]
}
```

#### Konfiguracja
Settings → QuickAdd:
- Folder: wybierz gdzie mają być tworzone notatki
- File name format: `{{DATE:YYYY-MM-DD}}-{{VALUE}}`

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### 5️⃣ Kanban — Tablice zarządzania zadaniami

**Repo:** https://github.com/mgmeyers/obsidian-kanban  
**Instalacje:** 600K+  
**Rating:** ⭐⭐⭐⭐⭐

#### Opis
Kanban tworzy tablice w stylu Trello/Jira wewnątrz notatek Markdown.

#### Struktura tablicy

```markdown
created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

kanban-plugin: basic

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## Dziś 📅

- [ ] Zadanie 1
	- 📅: 2025-11-24
	- ⚑: P1
- [ ] Zadanie 2


## W trakcie 🔄

- [ ] Zadanie 3


## Zrobione ✅

- [x] Zadanie 4

```

#### Integracja z Dataview/Tasks

**Dataview query w Kanban:**
````markdown
```dataview
TASK
FROM "projects"
WHERE !completed AND priority = "P1"
```
````

**Tasks query:**
````markdown
```tasks
not done
tag includes #eBay
path includes "kanban"
```
````

#### Konfiguracja
Settings → Kanban:
- Date format: `YYYY-MM-DD`
- Prepend / append new cards: Prepend (góra kolumny)
- Link dates to daily notes: ✅

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### 6️⃣ Calendar — Wizualizacja czasowa notatek

**Repo:** https://github.com/liamcain/obsidian-calendar-plugin  
**Instalacje:** 900K+  
**Rating:** ⭐⭐⭐⭐⭐

#### Opis
Calendar wyświetla kalendarz w sidebarz, integruje się z daily/periodic notes.

#### Funkcje
- Kliknięcie dnia → otwiera/tworzy daily note
- Kropki na datach = notatki
- Integracja z Periodic Notes

#### Konfiguracja
Settings → Calendar:
- Show week number: ✅
- Start week on Monday: ✅ (lub Sunday)
- Words per dot: 250 (ilość słów = kropka)

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### 7️⃣ Periodic Notes — Daily/Weekly/Monthly notes

**Repo:** https://github.com/liamcain/obsidian-periodic-notes  
**Instalacje:** 500K+  
**Rating:** ⭐⭐⭐⭐⭐

#### Opis
Rozszerzenie Daily Notes o weekly, monthly, quarterly, yearly notes.

#### Konfiguracja przykładowa

**Daily Notes:**
- Format: `YYYY-MM-DD`
- Folder: `usr/karinam/journal/{{date:YYYY/MM}}/`
- Template: `templates/daily-template.md`

**Weekly Notes:**
- Format: `YYYY-[W]WW`
- Folder: `usr/karinam/journal/weekly/`
- Template: `templates/weekly-template.md`

**Monthly Notes:**
- Format: `YYYY-MM`
- Folder: `usr/karinam/journal/monthly/`
- Template: `templates/monthly-template.md`

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### 8️⃣ Obsidian Git — Automatyczne commity i backup

**Repo:** https://github.com/denolehov/obsidian-git  
**Instalacje:** 400K+  
**Rating:** ⭐⭐⭐⭐⭐

#### Opis
Obsidian Git automatyzuje Git workflow bezpośrednio z vaultu.

#### Konfiguracja zalecana

Settings → Obsidian Git:
- Vault backup interval: `30` (co 30 min auto-commit)
- Commit message: `Auto-backup: {{date}}` 
- Pull updates on startup: ✅
- Push on backup: ❌ (ręczne push lub scheduled)
- Auto pull interval: `10` (pull co 10 min)

#### Workflow
1. **Auto-commit co 30 min** → lokalne zapisy
2. **Ręczny push** (Command Palette → Obsidian Git: Push)
3. **Pull przy starcie** → synchronizacja z repo

#### Integracja z .gitignore
```gitignore
.obsidian/workspace.json
.obsidian/workspace-mobile.json
.trash/
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### 9️⃣ Obsidian Linter — Utrzymanie stylu Markdown

**Repo:** https://github.com/platers/obsidian-linter  
**Instalacje:** 200K+  
**Rating:** ⭐⭐⭐⭐⭐

#### Opis
Linter automatycznie formatuje notatki zgodnie z regułami Markdown.

#### Przykładowe reguły
- Usuwanie trailing spaces
- Formatowanie headings (spacja po `#`)
- Sortowanie YAML frontmatter
- Automatyczne daty w `updated:`
- Usuwanie pustych linii

#### Konfiguracja
Settings → Linter:
- Lint on save: ✅
- Format YAML frontmatter: ✅
- Remove trailing whitespace: ✅
- Heading blank lines: ✅

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### 🔟 Advanced URI — Linki akcyjne i integracje

**Repo:** https://github.com/Vinzent03/obsidian-advanced-uri  
**Instalacje:** 150K+  
**Rating:** ⭐⭐⭐⭐⭐

#### Opis
Advanced URI umożliwia tworzenie linków, które wykonują akcje w Obsidian.

#### Przykłady URI

**Otwórz notatkę:**
```
obsidian://open?vault=eww&file=docs/software/obsidian/obsidian.md
```

**Dołącz tekst do notatki:**
```
obsidian://advanced-uri?vault=eww&filepath=journal/2025-11-24.md&data=Nowa notatka&mode=append
```

**Uruchom QuickAdd action:**
```
obsidian://advanced-uri?vault=eww&commandid=quickadd:choice:AddCard
```

**Wyszukaj w vault:**
```
obsidian://search?vault=eww&query=tag:#eBay
```

#### Integracja z zewnętrznymi skryptami
```bash
#!/usr/bin/env bash
# Dodaj zadanie z terminala
task="$1"
obsidian_uri="obsidian://advanced-uri?vault=eww&filepath=kanban/today.md&data=- [ ] ${task}&mode=append"
xdg-open "$obsidian_uri"
```

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🎨 Dodatkowe polecane pluginy

### Editing & Formatting

#### 11. **Admonition** — Callouts zaawansowane
Repo: https://github.com/javalent/admonitions  
Funkcje: Custom callouts z ikonami, kolorami, folding

#### 12. **Outliner** — Lepsze listy
Repo: https://github.com/vslinko/obsidian-outliner  
Funkcje: Vim-like navigation w listach, folding, drag & drop

#### 13. **Editor Syntax Highlight** — Syntax highlighting w edytorze
Repo: https://github.com/deathau/cm-editor-syntax-highlight-obsidian  
Funkcje: Kolorowanie składni w trybie edycji

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### Navigation & Organization

#### 14. **Tag Wrangler** — Zarządzanie tagami
Repo: https://github.com/pjeby/tag-wrangler  
Funkcje: Rename, merge, search tags

#### 15. **Waypoint** — Auto-generowanie MOC
Repo: https://github.com/IdreesInc/Waypoint  
Funkcje: Automatyczne tworzenie Map of Content

#### 16. **File Tree Alternative** — Alternatywny file explorer
Repo: https://github.com/ozntel/file-tree-alternative  
Funkcje: Zaawansowany explorer z custom sortowaniem

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### Visualization & Media

#### 17. **Excalidraw** — Rysowanie diagramów
Repo: https://github.com/zsviczian/obsidian-excalidraw-plugin  
Funkcje: Hand-drawn diagrams, integracja z notatkami

#### 18. **Charts** — Wykresy i grafy
Repo: https://github.com/phibr0/obsidian-charts  
Funkcje: Chart.js integration, wykresy z Dataview

#### 19. **Media Extended** — Odtwarzacz mediów
Repo: https://github.com/aidenlx/media-extended  
Funkcje: Timestamps, loop, speed control

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### Productivity & Automation

#### 20. **Text Expander** — Skróty tekstowe
Repo: https://github.com/konodyuk/obsidian-text-expander  
Funkcje: Auto-expand skrótów (`;;date` → data)

#### 21. **Buttons** — Przyciski w notatkach
Repo: https://github.com/shabegom/buttons  
Funkcje: Executable buttons w Markdown

#### 22. **MetaEdit** — Edycja frontmatter
Repo: https://github.com/chhoumann/MetaEdit  
Funkcje: Szybka edycja YAML inline

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

### Search & Discovery

#### 23. **Omnisearch** — Zaawansowane wyszukiwanie
Repo: https://github.com/scambier/obsidian-omnisearch  
Funkcje: Full-text search, OCR, PDF indexing

#### 24. **Strange New Worlds** — Graf lokalny w sidebarz
Repo: https://github.com/TfTHacker/obsidian42-strange-new-worlds  
Funkcje: Stały local graph dla aktywnej notatki

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🔗 Integracje między pluginami

### Workflow 1: Dataview + Tasks + Kanban
```markdown
## Dashboard zadań

### Zadania high priority
```dataview
TASK
FROM ""
WHERE !completed AND priority = "P1"
SORT due asc
```

### Zadania na dziś (Tasks)
```tasks
not done
due today
sort by priority
```

### Tablica Kanban
![[kanban/today]]
```

### Workflow 2: Templater + QuickAdd + Periodic Notes
1. **QuickAdd** tworzy notatkę daily
2. **Templater** wypełnia szablon z datą, tytułem
3. **Periodic Notes** zarządza strukturą folderów

### Workflow 3: Obsidian Git + Linter + Auto-backup
1. **Linter** formatuje na zapisie
2. **Obsidian Git** commituje co 30 min
3. **Pre-commit hook** (zewnętrzny) uruchamia shellcheck

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## ⚙️ Konfiguracja globalna — Rekomendacje

### Settings → Editor
- Vim mode: ❌ (lub ✅ jeśli lubisz Vim)
- Spell check: ✅
- Strict line breaks: ❌
- Auto pair brackets: ✅
- Auto pair Markdown syntax: ✅

### Settings → Files & Links
- Default location for new notes: `Same folder as current file`
- New link format: `Relative path to file`
- Use `[[Wikilinks]]`: ✅
- Detect all file extensions: ✅

### Settings → Appearance
- Theme: Wybierz ciemny/jasny
- CSS snippets: Włącz custom callouts (patrz docs/software/code/code-plugins.md)

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🚀 Skrypt instalacyjny pluginów (manual)

Obsidian nie ma CLI do instalacji pluginów, ale można:

### Opcja 1: Przez UI
1. Settings → Community Plugins → Browse
2. Wyszukaj plugin
3. Install → Enable

### Opcja 2: Przez .obsidian/plugins/
```bash
cd /path/to/vault/.obsidian/plugins
git clone https://github.com/blacksmithgu/obsidian-dataview.git
# Restart Obsidian → Enable plugin
```

### Opcja 3: BRAT (Beta Reviewers Auto-update Tester)
Plugin do instalacji beta-wersji pluginów z GitHub URL.

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 📊 Porównanie funkcji

| Plugin | Dataview | Tasks | Templater | QuickAdd | Kanban |
|--------|----------|-------|-----------|----------|--------|
| **Zapytania** | ✅ SQL-like | ✅ Filtry | ❌ | ❌ | ❌ |
| **Szablony** | ❌ | ❌ | ✅ JS | ✅ Proste | ❌ |
| **Tablice** | ❌ | ❌ | ❌ | ❌ | ✅ |
| **Zadania** | ✅ TASK | ✅ Tasks | ❌ | ❌ | ✅ Karty |
| **Automatyzacja** | ❌ | ❌ | ✅ Skrypty | ✅ Makra | ❌ |
| **API** | ✅ DataviewJS | ❌ | ✅ Templater | ✅ Scripts | ❌ |

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🔍 Debugging i troubleshooting

### Problem: Dataview nie renderuje zapytań
**Rozwiązanie:**
1. Settings → Dataview → Enable Inline Queries: ✅
2. Sprawdź składnię backticks (` ``` `)
3. Developer Console (Ctrl+Shift+I) → sprawdź błędy

### Problem: Tasks nie wykrywa zadań
**Rozwiązanie:**
1. Upewnij się, że checkbox zaczyna się od `- [ ]`
2. Settings → Tasks → Global Task Filter (usuń filtry)
3. Przeładuj vault (Command Palette → Reload without saving)

### Problem: Templater nie wstawia daty
**Rozwiązanie:**
1. Sprawdź składnię: `<% tp.date.now("YYYY-MM-DD") %>`
2. Settings → Templater → Enable System Commands: ✅
3. Test w nowej notatce

### Problem: Obsidian Git nie commituje
**Rozwiązanie:**
1. Terminal: `cd /path/to/vault && git status`
2. Skonfiguruj Git: `git config user.name "..."` i `git config user.email "..."`
3. Settings → Obsidian Git → Disable push: ❌ (włącz)

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 📚 Źródła i zasoby

### Oficjalne repozytoria
- **Dataview:** https://blacksmithgu.github.io/obsidian-dataview/
- **Tasks:** https://publish.obsidian.md/tasks/
- **Templater:** https://silentvoid13.github.io/Templater/
- **QuickAdd:** https://github.com/chhoumann/quickadd

### Społeczności
- **r/ObsidianMD** — Reddit community
- **Obsidian Discord** — https://discord.gg/obsidianmd
- **Obsidian Forum** — https://forum.obsidian.md/
- **GitHub Discussions** — poszczególne repo pluginów

### Tutoriale i guides
- **Dataview Tutorial:** https://www.youtube.com/watch?v=... (polecane na forum)
- **Tasks Quickstart:** https://publish.obsidian.md/tasks/Quick%20Start
- **Templater Examples:** Community showcase w repo

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## ✅ Checklist dla zaawansowanych użytkowników

- [x] Dataview queries dla dashboardów
- [x] Tasks filters z priorytetami i terminami
- [x] Templater templates z JavaScript
- [x] QuickAdd macros dla workflow
- [x] Kanban boards z integracją Dataview
- [x] Obsidian Git z auto-commit
- [x] Linter dla spójności formatowania
- [x] Advanced URI dla automatyzacji
- [ ] Custom plugins (TypeScript development)
- [ ] Dataview plugins/addons
- [ ] BRAT dla beta-testingu pluginów

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🔄 Aktualizacje

**2025-11-24:** Wersja 1.0.0
- Utworzenie dokumentu
- 24 pluginy opisane
- Przykłady użycia
- Integracje i workflow

created: 2025-11-25T03:13:57Z
modified: 2025-11-25T03:13:57Z
author: karinam
---

## 🤝 Wkład

Zgłaszaj sugestie nowych pluginów przez:
- GitHub Issues
- Pull Requests
- Discord #plugins-showcase
