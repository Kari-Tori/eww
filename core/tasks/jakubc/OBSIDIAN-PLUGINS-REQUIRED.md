---
tags:
  - obsidian
  - plugins
  - todo
  - setup
created: 2025-11-22T21:10:00Z
author: jakubc
title: "Obsidian Plugins - Wymagane dla TODO"
owner: jakubc
---

# 🔌 Obsidian Plugins - Wymagane dla TODO

Pluginy potrzebne do pełnej funkcjonalności TODO Daily.

## 📦 CORE PLUGINS (wbudowane)

Włącz w: **Settings → Core plugins**

- [x] **Graph View** - wizualizacja połączeń
- [x] **Templates** - szablony zadań
- [x] **Daily Notes** - automatyczne TODO dzienne
- [x] **Quick Switcher** - szybka nawigacja (Ctrl+O)
- [x] **Command Palette** - komendy (Ctrl+P)
- [x] **Search** - wyszukiwanie (Ctrl+Shift+F)
- [x] **Backlinks** - odnośniki zwrotne
- [x] **Tags View** - przeglądanie tagów
- [x] **Properties View** - YAML frontmatter

## 🚀 COMMUNITY PLUGINS (zainstaluj)

### 1. **Dataview** ⭐ MUST HAVE

**ID:** `dataview`
**Zastosowanie:** Dynamiczne listy zadań, statystyki, queries

**Instalacja:**
```
Settings → Community plugins → Browse → "Dataview" → Install → Enable
```

**Konfiguracja:**
```yaml
Enable JavaScript Queries: ON
Enable Inline Queries: ON
```

**Używane w TODO:**
- Lista przeterminowanych zadań
- Zadania według priorytetu
- Statystyki dnia
- Quick links

---

### 2. **Tasks** ⭐ MUST HAVE

**ID:** `obsidian-tasks-plugin`
**Zastosowanie:** Zaawansowane zarządzanie zadaniami, deadline, priorytety

**Instalacja:**
```
Settings → Community plugins → "Tasks" → Install
```

**Syntax:**
```markdown
- [ ] Zadanie 📅 2025-11-22 🔼 ⏫
```

- `📅` - due date
- `🔼` - high priority
- `⏫` - highest priority
- `✅` - completed date

---

### 3. **Calendar** 🟡 Recommended

**ID:** `calendar`
**Zastosowanie:** Kalendarz TODO, szybka nawigacja po dniach

**Funkcje:**
- Wizualny kalendarz
- Kliknij datę → otwórz TODO
- Kropki pokazują dni z TODO

---

### 4. **Checklist** 🟡 Recommended

**ID:** `obsidian-checklist-plugin`
**Zastosowanie:** Widok wszystkich checkboxów w vault

**Funkcje:**
- Lista WSZYSTKICH checkboxów
- Filtrowanie po plikach
- Progress tracking

---

### 5. **Progress Bar** 🟢 Optional

**ID:** `obsidian-progress-bar`
**Zastosowanie:** Wizualny progress zadań

**Syntax:**
```markdown
> [!progress]
> value: 57
```

---

### 6. **Advanced Tables** 🟢 Optional

**ID:** `table-editor-obsidian`
**Zastosowanie:** Łatwa edycja tabel Markdown

**Funkcje:**
- Auto-formatowanie
- Sortowanie
- Dodawanie/usuwanie kolumn/wierów

---

### 7. **Templater** 🟡 Recommended

**ID:** `templater-obsidian`
**Zastosowanie:** Zaawansowane szablony z JavaScript

**Przykład template TODO:**
```javascript
---
date: <% tp.date.now("YYYY-MM-DD") %>
day: <% tp.date.now("dddd") %>
week: <% tp.date.now("WW") %>
---

# TODO Daily - <% tp.date.now("YYYY-MM-DD") %>
```

---

### 8. **Tag Wrangler** 🟢 Optional

**ID:** `tag-wrangler`
**Zastosowanie:** Zarządzanie tagami

**Funkcje:**
- Rename tags
- Merge tags
- Zobacz wszystkie pliki z tagiem

---

### 9. **Kanban** 🟢 Optional

**ID:** `obsidian-kanban`
**Zastosowanie:** Tablica Kanban dla zadań

**Use case:**
```
TODO Backlog | In Progress | Done
```

---

### 10. **Excalidraw** 🟢 Optional

**ID:** `obsidian-excalidraw-plugin`
**Zastosowanie:** Diagramy, flowcharty

**Use case:**
- Timeline wizualny
- Mind maps dla projektów
- Architektura systemu

---

## 🎨 CSS SNIPPETS

Dodaj do `.obsidian/snippets/`:

### `todo-dashboard.css`

```css
/* Kolory priorytetów */
.priority-10 { background: #ff0000; color: white; }
.priority-9 { background: #ff4500; color: white; }
.priority-8 { background: #ff8c00; }
.priority-7 { background: #ffd700; }
.priority-6 { background: #87ceeb; }
.priority-5 { background: #90ee90; }
.priority-4 { background: #dda0dd; }
.priority-3 { background: #f0f0f0; }
.priority-2 { background: #e0e0e0; }
.priority-1 { background: #d0d0d0; }

/* Callouts TODO */
.callout[data-callout="progress"] {
  background: linear-gradient(90deg, #4caf50 0%, #8bc34a 100%);
}
```

Włącz w: **Settings → Appearance → CSS snippets**

---

## ⚙️ KONFIGURACJA DATAVIEW

Dodaj do każdego pliku zadania (np. `garynet/task.md`):

```yaml
---
tags:
  - todo
  - task
type: task
status: pending
priority: 9
deadline: 2025-11-22
estimated: 2h
assignee: jakubc
---
```

### Query przykłady:

#### Wszystkie zadania P9-P10
```dataview
TABLE priority, deadline, status
FROM "usr/jakubc/TODO"
WHERE priority >= 9
WHERE status != "done"
SORT priority DESC, deadline ASC
```

#### Zadania na dzisiaj
```dataview
TASK
FROM "usr/jakubc/TODO/TODO-daily"
WHERE date = date(today)
WHERE !completed
SORT priority DESC
```

#### Przeterminowane (czerwone!)
```dataview
TABLE deadline as "⚠️ DEADLINE", priority as "P"
FROM "usr/jakubc/TODO"
WHERE deadline < date(today)
WHERE status != "done"
SORT deadline ASC
LIMIT 10
```

---

## 📋 CHECKLIST INSTALACJI

- [ ] Włącz Core Plugins (9 sztuk)
- [ ] Zainstaluj Dataview ⭐
- [ ] Zainstaluj Tasks ⭐
- [ ] Zainstaluj Calendar
- [ ] Zainstaluj Checklist
- [ ] Zainstaluj Templater
- [ ] (Optional) Progress Bar
- [ ] (Optional) Advanced Tables
- [ ] (Optional) Tag Wrangler
- [ ] (Optional) Kanban
- [ ] Dodaj CSS snippet todo-dashboard.css
- [ ] Włącz CSS snippet w Settings
- [ ] Test Dataview query na TODO-2025-11-22
- [ ] Sprawdź Calendar view

---

## 🔗 Powiązane

- [[TODO-2025-11-22/TODO-2025-11-22]] - Dzisiejsze TODO (przykład)
- [[../docs/infra/software/obsidian/plugins/]] - Dokumentacja pluginów

---

**Ostatnia aktualizacja:** 2025-11-22
**Status:** ✅ Gotowe do użycia
