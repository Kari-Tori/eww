---
version: 0.0.1
modified: 2025-11-24
tags:
  - obsidian
  - guide
  - setup
created: 2025-11-24
author: jakubc
title: "RESTART OBSIDIAN - Instrukcja"
owner: jakubc
---

# 🔄 RESTART OBSIDIAN - Instrukcja aktywacji TODO

## ✅ CO ZOSTAŁO ZAINSTALOWANE

### 🔌 Pluginy (53 total!)

**MUST HAVE dla TODO:**
- ⭐ **Dataview** (0.5.68) - dynamiczne listy
- ⭐ **Tasks** (7.22.0) - zarządzanie zadaniami

**Recommended:**
- 🟡 **Calendar** (1.5.10) - kalendarz TODO
- 🟡 **Templater** (2.16.2) - szablony
- 🟡 **Kanban** (2.0.51) - tablica zadań

**Bonus (już masz!):**
- Checklist, ProgressBar, Advanced Tables, Tag Wrangler, Git, i 45 innych!

### 🎨 CSS Snippets

- ✅ **todo-dashboard.css** - kolory priorytetów P1-P10
- ✅ Włączony w appearance.json

### ⚙️ Core Plugins

- ✅ Wszystkie 24 core plugins włączone
- ✅ Daily Notes, Templates, Graph, Search, etc.

---

## 🔄 RESTART OBSIDIAN - KROK PO KROKU

### Opcja 1: Restart z GUI (ZALECANE)

1. **Otwórz Obsidian**
2. Naciśnij: **`Ctrl + P`** (Command Palette)
3. Wpisz: **`reload`**
4. Wybierz: **"Reload app without saving"**
5. Poczekaj 5 sekund...
6. ✅ **Gotowe!**

### Opcja 2: Zamknij i otwórz ponownie

1. Zamknij Obsidian (Alt+F4 lub X)
2. Otwórz ponownie
3. ✅ Gotowe!

### Opcja 3: Kill process (jeśli się zawiesił)

```bash
# Znajdź proces
ps aux | grep obsidian

# Kill
killall obsidian

# Otwórz ponownie
obsidian &
```

---

## ✅ SPRAWDZENIE PO RESTARCIE

### 1. Włącz pluginy (jeśli nie włączone automatycznie)

**Settings → Community plugins → Installed plugins**

Włącz (toggle ON):
- [x] Dataview ⭐
- [x] Tasks ⭐
- [x] Calendar
- [x] Templater
- [x] Kanban
- [x] Checklist
- [x] ProgressBar

### 2. Sprawdź Dataview

1. Otwórz: **Settings → Dataview**
2. Włącz:
   - ✅ **Enable JavaScript Queries**
   - ✅ **Enable Inline Queries**
   - ✅ **Enable Inline JavaScript Queries**

### 3. Sprawdź CSS snippet

1. Otwórz: **Settings → Appearance → CSS snippets**
2. Znajdź: **todo-dashboard**
3. Upewnij się że jest: **✅ włączony** (toggle ON)

### 4. TEST - Otwórz TODO dzisiejsze

```
Ctrl+O (Quick Switcher)
Wpisz: TODO-2025-11-22
Enter
```

**Co powinieneś zobaczyć:**
- ✅ Dataview queries działają (listy zadań)
- ✅ Kolory priorytetów (P10=czerwony, P1=szary)
- ✅ Callouts (info, danger, success)
- ✅ Mermaid timeline (Gantt chart)

---

## 🚨 JEŚLI COŚ NIE DZIAŁA

### Problem: Dataview nie generuje list

**Rozwiązanie:**
1. Settings → Dataview
2. Włącz **Enable JavaScript Queries**
3. Restart Obsidian
4. Poczekaj 5 sekund na przetworzenie vault

### Problem: Brak kolorów priorytetów

**Rozwiązanie:**
1. Settings → Appearance → CSS snippets
2. Włącz **todo-dashboard**
3. Restart (Ctrl+P → "Reload")

### Problem: Plugin nie włącza się

**Rozwiązanie:**
1. Settings → Community plugins
2. Turn OFF "Restricted Mode" (jeśli włączony)
3. Refresh plugin list
4. Włącz plugin ręcznie

### Problem: Błędy Dataview

**Debug:**
```
Ctrl+Shift+I (Developer Tools)
→ Console tab
→ Sprawdź błędy
```

---

## 📊 KIEDY RESTARTOWAĆ?

### ✅ RESTART TERAZ (po instalacji):
- Po zainstalowaniu pluginów ← **TERAZ!**
- Po zmianie CSS snippets
- Po aktualizacji pluginów
- Gdy plugin się zawiesił

### ❌ NIE TRZEBA RESTARTOWAĆ:
- Przy tworzeniu/edycji notatek
- Przy zmianie settings (większość)
- Przy dodawaniu plików

---

## 🎯 CO DALEJ (po restarcie)

1. **Otwórz TODO:**
   ```
   usr/jakubc/TODO/TODO-daily/TODO-2025-11-22/TODO-2025-11-22.md
   ```

2. **Sprawdź czy działa:**
   - Dataview queries (automatyczne listy)
   - Kolory priorytetów
   - Mermaid timeline

3. **Zacznij pracę:**
   - Zaznaczaj checkboxy (✅)
   - Statystyki aktualizują się live!
   - Wieczorem wypełnij "Podsumowanie"

4. **Customizuj (opcjonalnie):**
   - Settings → Dataview → dostosuj format dat
   - Settings → Tasks → customizacja emoji
   - CSS snippet → zmień kolory priorytetów

---

## 📝 NOTATKI

**Aktualny stan (21:16):**
- ✅ Wszystkie pluginy zainstalowane (53!)
- ✅ CSS snippet utworzony i włączony
- ✅ Core plugins włączone (24)
- ✅ Dataview skonfigurowany (JS enabled)
- ✅ Community plugins list zaktualizowana
- ⏳ **CZEKA NA RESTART OBSIDIAN**

---

## 🔗 Dokumentacja

- [[OBSIDIAN-PLUGINS-REQUIRED]] - Pełna lista pluginów
- [[TODO-2025-11-22/TODO-2025-11-22]] - Dzisiejsze TODO
- [[../../docs/infra/software/obsidian/]] - Dokumentacja Obsidian

---

> [!success] Gotowe!
> **RESTART OBSIDIAN TERAZ** aby aktywować wszystkie zmiany!
> 
> **Metoda:** Ctrl+P → "reload" → Enter

**Status:** ⏳ Czeka na restart
**Czas instalacji:** ~5 minut
**Następny krok:** RESTART OBSIDIAN ⬆️

## 🔗 Backlinks

- [[core/tasks/jakubc/jakubc]]
- [[core/core]]
- [[core/config]]