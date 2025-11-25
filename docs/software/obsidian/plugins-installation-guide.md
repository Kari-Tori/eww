---
title: Instalacja i konfiguracja wtyczek Obsidian — Przewodnik
description: Krok po kroku instalacja 5 HIGH priority wtyczek z konfiguracją
version: 1.0.0
created: 2025-11-24
updated: 2025-11-24
tags:
  - obsidian
  - plugins
  - installation
  - configuration
  - guide
---

# Instalacja i konfiguracja wtyczek Obsidian — Przewodnik

## 🎯 Cel

Zainstalować i skonfigurować **5 HIGH priority wtyczek** dla Obsidian:
1. **Obsidian Linter** — auto-formatowanie Markdown
2. **Advanced Tables** — edytor tabel
3. **Tag Wrangler** — zarządzanie tagami
4. **Note Refactor** — ekstrakcja fragmentów
5. **Excalidraw** — rysunki i diagramy

---

## ⚠️ Uwaga: Git NOT enabled

**Status:** Obsidian Git jest zainstalowany ale **NIE włączony**.

**Backup przed instalacją (ręczny):**
```bash
# Przejdź do vault
cd /home/karinam/.local/share/obsidian/vaults/YourVaultName  # Zmień na swoją ścieżkę

# Lub jeśli vault jest w ~/Documents/Obsidian
cd ~/Documents/Obsidian

# Utwórz backup
tar -czf ~/obsidian-backup-$(date +%Y%m%d-%H%M%S).tar.gz .

# Opcjonalnie: commit ręczny (jeśli vault jest repo Git)
git add .
git commit -m "Pre-plugin installation backup (Linter, Advanced Tables, Tag Wrangler, Note Refactor, Excalidraw)"
git push
```

---

## 📦 Instalacja wtyczek (GUI)

### Krok 1: Otwórz Community Plugins

1. Uruchom **Obsidian**
2. Otwórz **Settings** (`Ctrl+,` lub ikona ⚙️)
3. Lewy panel → **Community plugins**
4. Jeśli pierwszy raz: kliknij **Turn on community plugins**
5. Kliknij **Browse**

---

## 1️⃣ Obsidian Linter

### Instalacja

1. W oknie **Browse community plugins** wpisz: `Linter`
2. Kliknij plugin **Linter** (autor: platers)
3. Kliknij **Install**
4. Kliknij **Enable**

### Konfiguracja

**Settings → Linter:**

```yaml
# General
Lint on save: ✅ ON
Display message on lint: ✅ ON
Folders to ignore: ""

# YAML
Format YAML array: ✅ ON
Insert blank line after YAML: ✅ ON
YAML timestamp format: "YYYY-MM-DD"

# Heading
Heading blank lines: ✅ ON
Remove trailing punctuation in heading: ✅ ON

# Footnote
Re-Index footnotes: ✅ ON

# Content
Remove trailing spaces: ✅ ON
Remove multiple blank lines: ✅ ON
Remove empty lines around list markers: ✅ ON

# Spacing
Space after list markers: ✅ ON
Two spaces between lines with content: ❌ OFF (conflict z Obsidian)

# Paste
Format tags in YAML: ✅ ON
```

**Kluczowe ustawienia:**
- ✅ **Lint on save** — auto-format przy zapisie
- ✅ **Format YAML array** — formatowanie frontmatter
- ✅ **Remove trailing spaces** — usuń spacje na końcu linii

### Test

Utwórz nową notatkę:
```markdown
---
title:   Test Linter  
tags: [test,obsidian]
---

# Test   

To jest test.   
```

Zapisz (`Ctrl+S`) — Linter automatycznie powinien:
- Usunąć podwójne spacje w `title`
- Sformatować `tags` jako array YAML
- Usunąć trailing spaces

---

## 2️⃣ Advanced Tables

### Instalacja

1. Browse → wpisz: `Advanced Tables`
2. Kliknij **Advanced Tables** (autor: tgrosinger)
3. Install → Enable

### Konfiguracja

**Settings → Advanced Tables:**

```yaml
# Formatting
Pad cell width using spaces: ✅ ON
Format on tab: ✅ ON

# Navigation
Bind enter to table navigation: ✅ ON
Bind tab to table navigation: ✅ ON
Bind arrow keys to table navigation: ✅ ON

# Commands
Enable ctrl+shift+D for table menu: ✅ ON
```

**Kluczowe skróty:**
- `Tab` — następna kolumna (auto-formatuje tabelę)
- `Shift+Tab` — poprzednia kolumna
- `Enter` — następny wiersz
- `Ctrl+Shift+D` — menu tabel (insert row/column, sort)

### Test

Utwórz tabelę (tryb edycji):
```markdown
| Nazwa | Status | Priorytet |
|---|---|---|
```

Kliknij w komórkę i naciśnij `Tab` — Advanced Tables automatycznie:
- Wyrówna kolumny
- Doda separatory `|`
- Pozwoli nawigować Tab/Enter

Wypróbuj:
```markdown
| Nazwa | Status | Priorytet |
|-------|--------|-----------|
| Task1 | TODO   | High      |
| Task2 | DONE   | Low       |
```

Naciśnij `Ctrl+Shift+D` → **Sort by column** → wybierz kolumnę

---

## 3️⃣ Tag Wrangler

### Instalacja

1. Browse → wpisz: `Tag Wrangler`
2. Kliknij **Tag Wrangler** (autor: pjeby)
3. Install → Enable

### Konfiguracja

**Settings → Tag Wrangler:**

```yaml
# General
Show tag counts: ✅ ON
Context menu integration: ✅ ON

# Tag panel
Show tag tree: ✅ ON
Collapse subtags: ❌ OFF
```

**Kluczowe funkcje:**
- Prawy klik na tag w Tag Panel → **Rename tag**
- Prawy klik → **Merge tags**
- Prawy klik → **Delete tag**

### Test

1. Otwórz **Tag panel** (prawy sidebar → ikona `#`)
2. Utwórz notatkę z tagami:
```markdown
---
tags:
  - projekty/eww
  - ebay/sprzedaz
---
```
3. Prawy klik na `projekty/eww` → **Rename tag** → zmień na `projekt/eww-toolkit`
4. Tag zostanie zmieniony **we wszystkich notatkach** automatycznie

---

## 4️⃣ Note Refactor

### Instalacja

1. Browse → wpisz: `Note Refactor`
2. Kliknij **Note Refactor** (autor: lynchjames)
3. Install → Enable

### Konfiguracja

**Settings → Note Refactor:**

```yaml
# Default location
Default location for new notes: "notes/"
Include first line as note heading: ✅ ON

# Templates
New note template: ""  # Opcjonalnie: ścieżka do szablonu
File name template: "{{date:YYYY-MM-DD}}-{{title}}"

# Behavior
Open new note in new pane: ✅ ON
Transclude by default: ❌ OFF
```

**Kluczowe komendy:**
- `Ctrl+P` → **Note Refactor: Extract selection to new note**
- `Ctrl+P` → **Note Refactor: Split note by headings**

### Test

Utwórz notatkę:
```markdown
# Projekt eww

## Backend
Opis backendu...

## Frontend
Opis frontendu...

## DevOps
Opis DevOps...
```

1. Zaznacz sekcję **## Backend** (cały fragment)
2. `Ctrl+P` → **Note Refactor: Extract selection to new note**
3. Podaj nazwę: `eww-backend`
4. Nowa notatka zostanie utworzona w `notes/2025-11-24-eww-backend.md`
5. W oryginalnej notatce zostanie link: `![[eww-backend]]`

---

## 5️⃣ Excalidraw

### Instalacja

1. Browse → wpisz: `Excalidraw`
2. Kliknij **Excalidraw** (autor: zsviczian)
3. Install → Enable
4. **Uwaga:** Excalidraw może chwilę pobierać dodatkowe zasoby

### Konfiguracja

**Settings → Excalidraw:**

```yaml
# General
Folder for new drawings: "drawings/"
Default file name: "Drawing {{date:YYYY-MM-DD}}"

# Display
Theme: "Match Obsidian theme"
Grid mode: ✅ ON
Snap to grid: ✅ ON

# Export
Auto-export PNG: ✅ ON
PNG export folder: "drawings/exports/"

# Embed settings
Embed width: "100%"
```

**Kluczowe skróty (w edytorze Excalidraw):**
- `R` — Rectangle
- `D` — Diamond
- `C` — Circle
- `A` — Arrow
- `T` — Text
- `Ctrl+Z` — Undo
- `Ctrl+D` — Duplicate

### Test

1. `Ctrl+P` → **Excalidraw: Create new drawing**
2. Podaj nazwę: `test-diagram`
3. Edytor Excalidraw się otworzy
4. Narysuj prosty flowchart:
   - Kliknij `R` → narysuj prostokąt
   - Kliknij `A` → narysuj strzałkę
   - Kliknij `T` → dodaj tekst
5. Zamknij edytor — rysunek zostanie zapisany jako `drawings/test-diagram.excalidraw.md`

**Osadzanie w notatce:**
```markdown
# Moja notatka

![[test-diagram]]
```

---

## ✅ Checklist po instalacji

### Sprawdź czy wszystko działa:

- [ ] **Linter:** Utwórz notatkę z trailing spaces → Zapisz → Sprawdź czy usunięte
- [ ] **Advanced Tables:** Utwórz tabelę → Naciśnij Tab → Sprawdź auto-format
- [ ] **Tag Wrangler:** Prawy klik na tag → Sprawdź menu (Rename, Merge, Delete)
- [ ] **Note Refactor:** Zaznacz tekst → Extract to new note → Sprawdź link
- [ ] **Excalidraw:** Utwórz nowy rysunek → Sprawdź czy zapisuje w `drawings/`

---

## 🔧 Konfiguracja zaawansowana

### Integracja Linter + Templater

Jeśli używasz **Templater**, możesz dodać auto-lint do szablonów:

**Szablon daily note:**
```markdown
---
date: <% tp.date.now("YYYY-MM-DD") %>
tags: [daily]
---

# <% tp.date.now("YYYY-MM-DD dddd") %>

## Tasks
<% tp.web.daily_quote() %>

<!-- Linter auto-format on save -->
```

### Integracja Advanced Tables + Dataview

Możesz używać Advanced Tables do edycji wyników Dataview:

```markdown
## Zadania (Dataview)

```dataview
TABLE priority, due, status
FROM "projects"
WHERE status != "DONE"
SORT due asc
\```

## Zadania (Manual - Advanced Tables)

| Projekt | Priorytet | Termin | Status |
|---------|-----------|--------|--------|
| eww     | High      | 2025-12 | TODO   |
```

Kliknij w drugą tabelę → Tab → edytuj ręcznie

---

## 🐛 Troubleshooting

### Linter nie formatuje automatycznie
- Sprawdź: Settings → Linter → **Lint on save** (musi być ✅)
- Restart Obsidian

### Advanced Tables nie wyrównuje kolumn
- Sprawdź: Settings → Advanced Tables → **Pad cell width using spaces** (✅)
- Upewnij się że kursor jest **wewnątrz tabeli**
- Naciśnij `Tab` (nie `Space`)

### Tag Wrangler nie pokazuje menu
- Sprawdź: Settings → Tag Wrangler → **Context menu integration** (✅)
- Prawy klik **dokładnie na tagu** (nie obok)

### Note Refactor tworzy pliki w złym miejscu
- Sprawdź: Settings → Note Refactor → **Default location for new notes**
- Zmień na `notes/` lub preferowany katalog

### Excalidraw nie ładuje edytora
- Sprawdź połączenie internetowe (Excalidraw pobiera zasoby przy pierwszym uruchomieniu)
- Disable → Enable plugin
- Restart Obsidian

---

## 📚 Dodatkowe zasoby

### Dokumentacja wtyczek:
- **Linter:** https://github.com/platers/obsidian-linter
- **Advanced Tables:** https://github.com/tgrosinger/advanced-tables-obsidian
- **Tag Wrangler:** https://github.com/pjeby/tag-wrangler
- **Note Refactor:** https://github.com/lynchjames/note-refactor-obsidian
- **Excalidraw:** https://github.com/zsviczian/obsidian-excalidraw-plugin

### Community:
- r/ObsidianMD (Reddit)
- Obsidian Discord
- Obsidian Forum: https://forum.obsidian.md/

---

## 🔄 Następne kroki

Po zainstalowaniu 5 HIGH priority:

### 1. Przetestuj workflow:
- Utwórz daily note z Templater
- Dodaj zadania z Advanced Tables
- Użyj Linter do formatowania
- Wyekstrahuj fragment z Note Refactor
- Narysuj diagram z Excalidraw

### 2. Zainstaluj MEDIUM priority (opcjonalnie):
- **Omnisearch** — lepsze wyszukiwanie
- **Another Quick Switcher** — szybsze przełączanie
- **Breadcrumbs** — hierarchia MOCs

### 3. Włącz Obsidian Git (backup):
```
Settings → Obsidian Git → Enable
Commit interval: 10 minutes
Auto-pull on startup: ✅
```

---

## ✨ Podsumowanie

**Zainstalowano:**
1. ✅ Obsidian Linter — auto-formatowanie
2. ✅ Advanced Tables — edytor tabel
3. ✅ Tag Wrangler — zarządzanie tagami
4. ✅ Note Refactor — ekstrakcja fragmentów
5. ✅ Excalidraw — rysunki i diagramy

**Status:** 13/24 wtyczek (54% coverage)

**Czas instalacji:** ~10-15 minut
**Poziom trudności:** 🟢 Łatwy (GUI)

Gotowe! 🚀
