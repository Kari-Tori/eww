---
title: Status wtyczek Obsidian — Audit instalacji
description: Porównanie zalecanych wtyczek z zainstalowanymi w vault
version: 1.1.0
created: 2025-11-24
updated: 2025-11-24
tags:
  - obsidian
  - plugins
  - status
  - audit
---

# Status wtyczek Obsidian — Audit instalacji

## 📚 Pełna dokumentacja Obsidian

Zobacz również:
- **[obsidian-plugins.md](./obsidian-plugins.md)** — 24 community plugins z przykładami
- **[installed_pluggins.md](./installed_pluggins.md)** — 13 zainstalowanych z pełną konfiguracją
- **[obsidian-customization.md](./obsidian-customization.md)** — Motywy, CSS snippets, appearance ✨ NOWO
- **[plugins-installation-guide.md](./plugins-installation-guide.md)** — Przewodnik instalacji pluginów
- **[obsidian.md](./obsidian.md)** — Core funkcje Obsidian

---

## 📊 Podsumowanie

| Kategoria | Liczba |
|-----------|--------|
| **Zainstalowane** | 13 |
| **Zalecane (dokumentacja)** | 24 |
| **Zainstalowane + Zalecane** | 13 ✅ |
| **Do instalacji** | 11 ⚠️ |
| **Coverage** | 54% |

---

## ✅ Zainstalowane (13)

| # | Wtyczka | Kategoria | Status |
|---|---------|-----------|--------|
| 1 | **Dataview** | Core | ✅ |
| 2 | **Tasks** | Core | ✅ |
| 3 | **Templater** | Core | ✅ |
| 4 | **QuickAdd** | Core | ✅ |
| 5 | **Kanban** | Core | ✅ |
| 6 | **Calendar** | Core | ✅ |
| 7 | **Periodic Notes** | Core | ✅ |
| 8 | **Obsidian Git** | Core | ✅ (wyłączony) |
| 9 | **Obsidian Linter** | Productivity | ✅ NOWO |
| 10 | **Advanced Tables** | Productivity | ✅ NOWO |
| 11 | **Tag Wrangler** | Productivity | ✅ NOWO |
| 12 | **Note Refactor** | Productivity | ✅ NOWO |
| 13 | **Excalidraw** | Productivity | ✅ NOWO |

**Status:** ✅ Wszystkie HIGH priority zainstalowane!

---

## ⚠️ Zalecane ale NIE zainstalowane (11)

### 🟡 MEDIUM Priority — Nawigacja i wyszukiwanie (4)

| # | Wtyczka | Dlaczego ważne | Install Command |
|---|---------|----------------|-----------------|
| 14 | **Omnisearch** | Lepsze wyszukiwanie (fuzzy, OCR PDF) | Community Plugins → Search: "Omnisearch" |
| 15 | **Another Quick Switcher** | Szybsze przełączanie między notatkami | Community Plugins → Search: "Another Quick Switcher" |
| 16 | **Breadcrumbs** | Wizualizacja hierarchii, navigation | Community Plugins → Search: "Breadcrumbs" |
| 17 | **Graph Analysis** | Zaawansowana analiza grafu | Community Plugins → Search: "Graph Analysis" |

---

### 🟢 LOW Priority — Eksport i integracje (4)

| # | Wtyczka | Dlaczego ważne | Install Command |
|---|---------|----------------|-----------------|
| 18 | **Pandoc Plugin** | Export do PDF/DOCX/LaTeX (wymaga Pandoc) | Community Plugins → Search: "Pandoc" |
| 19 | **Better Export PDF** | Lepszy PDF export z CSS | Community Plugins → Search: "Better Export PDF" |
| 20 | **Webpage HTML Export** | Export notatek do HTML | Community Plugins → Search: "Webpage HTML Export" |
| 21 | **Kindle Highlights** | Import z Kindle | Community Plugins → Search: "Kindle Highlights" |

---

### 🟢 LOW Priority — Edytor i formatowanie (3)

| # | Wtyczka | Dlaczego ważne | Install Command |
|---|---------|----------------|-----------------|
| 22 | **Editor Syntax Highlight** | Syntax highlighting kodu | Community Plugins → Search: "Editor Syntax Highlight" |
| 23 | **Emoji Toolbar** | Szybki dostęp do emoji | Community Plugins → Search: "Emoji Toolbar" |
| 24 | **Paste URL into selection** | Auto-link przy wklejaniu URL | Community Plugins → Search: "Paste URL into selection" |

---

## 🎯 Zalecenia akcji

### 1. ✅ Zainstalowano HIGH priority (5 wtyczek)

**Ukończone:**
1. ✅ Obsidian Linter
2. ✅ Advanced Tables
3. ✅ Tag Wrangler
4. ✅ Note Refactor
5. ✅ Excalidraw

---

### 2. Rozważ MEDIUM priority (4 wtyczki)

Szczególnie polecane jeśli:
- **Omnisearch** — masz duży vault (1000+ notatek)
- **Another Quick Switcher** — często przełączasz się między notatkami
- **Breadcrumbs** — pracujesz z hierarchicznymi strukturami (MOCs)
- **Graph Analysis** — analizujesz powiązania między notatkami

---

### 3. LOW priority (7 wtyczek) — opcjonalne

Zainstaluj tylko jeśli potrzebujesz konkretnej funkcji:
- **Pandoc** — eksport do DOCX/PDF (wymaga instalacji Pandoc)
- **Excalidraw** — jeśli rysunki są ważne w workflow
- **Kindle Highlights** — jeśli importujesz z Kindle

---

## 📈 Metryki instalacji

### Coverage wtyczek

| Kategoria | Zainstalowane | Zalecane | % |
|-----------|---------------|----------|---|
| Core workflow | 8 | 8 | 100% ✅ |
| Produktywność | 5 | 5 | 100% ✅ |
| Nawigacja | 0 | 4 | 0% ⚠️ |
| Eksport | 0 | 4 | 0% ⚠️ |
| Edytor | 0 | 3 | 0% ⚠️ |

**Ogółem:** 13/24 (54%)

---

## 📦 Lista zainstalowanych (8)

### Core Workflow Plugins ✅

1. **Kanban** — tablice Kanban w notatkach
   - Status: ✅ ZAINSTALOWANE
   - Użycie: Zarządzanie zadaniami eBay, projekty

2. **Dataview** — zapytania i raporty z notatek
   - Status: ✅ ZAINSTALOWANE
   - Użycie: Dashboardy, listy zadań, raporty

3. **Templater** — skrypty i dynamiczne szablony
   - Status: ✅ ZAINSTALOWANE
   - Użycie: Daily notes, szablony projektów

4. **Tasks** — zaawansowane filtrowanie zadań
   - Status: ✅ ZAINSTALOWANE
   - Użycie: Terminy, priorytety, powtarzające się zadania

5. **QuickAdd** — szybkie akcje / makra
   - Status: ✅ ZAINSTALOWANE
   - Użycie: Szybkie tworzenie kart Kanban, notatek

6. **Calendar** — kalendarz
   - Status: ✅ ZAINSTALOWANE
   - Użycie: Integracja z daily notes

7. **Periodic Notes** — notatki periodyczne
   - Status: ✅ ZAINSTALOWANE
   - Użycie: Daily, weekly, monthly notes

8. **Obsidian Git** — backup i automatyczne commity
   - Status: ✅ ZAINSTALOWANE
   - Użycie: Wersjonowanie vaulta, backup do GitHub

---

## 🔄 Historia auditu

**2025-11-24:** Drugi audit
- 13 wtyczek zainstalowanych (8 core + 5 productivity)
- 11 wtyczek zalecanych do instalacji (MEDIUM/LOW priority)
- Coverage: 54% (13/24)
- ✅ Wszystkie HIGH priority zainstalowane
- Rekomendacja: rozważ 4 MEDIUM priority (Omnisearch, Quick Switcher, Breadcrumbs, Graph Analysis)

**2025-11-24:** Pierwszy audit
- 8 wtyczek zainstalowanych (core workflow)
- 16 wtyczek zalecanych do instalacji
- Coverage: 33% (8/24)
- Rekomendacja: zainstaluj 5 HIGH priority

---

## 📖 Powiązane dokumenty

- [obsidian-plugins.md](./obsidian-plugins.md) — Pełna lista 24 zalecanych pluginów
- [installed_pluggins.md](./installed_pluggins.md) — Lista 8 zainstalowanych
- [obsidian.md](./obsidian.md) — Główna dokumentacja Obsidian

---

## 🤝 Następne kroki

### Dzisiaj (HIGH priority):
1. ✅ Zainstaluj **Obsidian Linter** (auto-formatowanie)
2. ✅ Zainstaluj **Advanced Tables** (edytor tabel)
3. ✅ Zainstaluj **Excalidraw** (rysunki)

### Ten tydzień (MEDIUM priority):
4. ⚠️ Zainstaluj **Omnisearch** (lepsze wyszukiwanie)
5. ⚠️ Zainstaluj **Tag Wrangler** (zarządzanie tagami)

### Opcjonalnie (LOW priority):
- Pandoc Plugin (eksport DOCX/PDF)
- Kindle Highlights (import z Kindle)
- Editor Syntax Highlight

---

## 💡 Wskazówki

### Jak zainstalować plugin:
1. `Settings` (⚙️) → `Community plugins`
2. `Browse` → wpisz nazwę pluginu
3. `Install` → `Enable`

### Konfiguracja po instalacji:
- **Linter:** Settings → Linter → Enable "Lint on save"
- **Advanced Tables:** Działa automatycznie w trybie edycji
- **Excalidraw:** Utwórz nowy rysunek: `Ctrl+P` → "Create new Excalidraw drawing"

### Backup przed instalacją:
```bash
# Obsidian Git robi to automatycznie, ale ręcznie:
cd /path/to/vault
git add .
git commit -m "Pre-plugin installation backup"
git push
```
