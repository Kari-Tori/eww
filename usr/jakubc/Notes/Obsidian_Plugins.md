---
title: "Obsidian — katalog wtyczek (2025)"
created: 2025-11-21
updated: 2025-11-21
modified: "2025-10-12"
type: "wiki"
area: "secondbrain"
status: "done"
priority: "M"
tags: ["#obsidian/plugins", "#secondbrain"]
  - personal
  - blue
  - jakubc
cssclass: ["sb-purple"]
aliases: [Obsidian — katalog wtyczek (2025)]
linter-yaml-title-alias: Obsidian — katalog wtyczek (2025)
date created: 2025-11-21
updated: 2025-11-21
date modified: czwartek, październik 30. 2025, 6:42:03 pm
color: blue
---

# Obsidian — katalog wtyczek (2025)

> **Legenda:** ★ = kluczowe do Secondbrain · (core) = wbudowane/utrzymywane przez Obsidian

## Nowości 2025 (warto sprawdzić)
- **Bases (core) ★** — natywne widoki jak w bazie danych: tabele/karty, filtry, formuły, relacje. Zastępuje wiele hacków na Dataview.
- **Make.md (Spaces/Contexts) ★** — „warstwa produktywności”: bazy z relacjami, rollupy, widoki, ulepszenia UI.
- **Omnisearch** — szybki, trafny search z indeksacją załączników.

---

## 1) Bazy i widoki danych
- **Bases (core) ★** — właściwości (properties) jako baza danych; widoki, filtry, formuły, relacje.
- **Dataview ★** — zapytania `table/list` oraz **DataviewJS** do dashboardów i raportów.
- **Make.md ★** — przestrzenie (Spaces), bazy powiązane, karty, boardy, rollupy.

## 2) Zadania i harmonogram
- **Tasks ★** — zadania w całym vaultcie, powtarzalność, zapytania i filtry.
- **Day Planner** — time‑boxing (plan dnia) i oś czasu.
- **Full Calendar** — kalendarz miesięczny/tygodniowy powiązany z notatkami.

## 3) Okresowe notatki i daty
- **Periodic Notes ★** — szablony not dziennych/tygodniowych/miesięcznych/rocznych.
- **Natural Language Dates** — daty „po ludzku” (np. *next Friday*, *in 2 weeks*).

## 4) Szablony i „capture”
- **Templater ★** — szablony + JavaScript (frontmatter, automaty treści, refaktoryzacje).
- **QuickAdd ★** — szybkie przechwytywanie (capture), wieloetapowe makra, integracja z Templaterem.

## 5) Wyszukiwanie i nawigacja
- **Omnisearch ★** — semantyczne i szybkie wyszukiwanie, indeksuje także PDF/załączniki.

## 6) Formatowanie i higiena treści
- **Linter ★** — porządkowanie YAML, tytułów, list, odstępów; standaryzacja properties.

## 7) Automatyczne porządkowanie plików
- **Auto Note Mover ★** — reguły przenoszenia not do folderów na podstawie frontmatter/tagów.

## 8) Projekty / Kanban
- **Kanban** — tablice projektowe oparte o markdown (kolumny, karty, metadane).

## 9) Tabele Markdown
- **Advanced Tables** — wygodne edytowanie, auto‑format, szybkie skróty, eksport CSV.

## 10) Rysunki i diagramy
- **Excalidraw** — szkice, diagramy, notatki wizualne bez wychodzenia z Obsidiana.

## 11) Interaktywne UI w notatkach
- **Meta Bind ★** — kontrolki (input, select, toggle) powiązane z frontmatter.
- **Note Toolbar** — własne paski narzędzi per nota/kontekst.
- **Buttons** — przyciski uruchamiające komendy, makra i linki.
- **Commander** — rozszerzanie i mapowanie komend w UI (menu, paski, skróty).

## 12) Git / wersjonowanie
- **Obsidian Git ★** — commit/pull/push z poziomu Obsidiana, historia zmian, backup.

## 13) AI / powiązania (opcjonalnie)
- **Smart Connections** — podpowiedzi podobnych notatek (embeddingi), linkowanie kontekstowe.
- **Make.md AI** — funkcje AI w ramach Spaces (jeśli używasz Make.md jako głównej warstwy).

---

## Minimalny zestaw startowy (12) — pod Secondbrain
**Bases (core), Dataview, Make.md, Tasks, Periodic Notes, Templater, QuickAdd, Omnisearch, Linter, Auto Note Mover, Meta Bind, Obsidian Git**.

> Instalacja: *Settings → Community Plugins → Browse* (wyszukaj po nazwie). Dla **Bases** włącz **Properties/Bases** w ustawieniach wersji 1.9+.

---

## Uwaga dot. properties (Obsidian 1.9+)
- Zmieniono nazwy pól: `tags/aliases/cssclasses` to **listy** (zamiast starych `tag/alias/cssclass`).
- Warto ujednolicić klucze YAML w całym vaultcie (Linter) i używać `properties` zamiast ad‑hoc frontmatterów.

---

### Notatki własne
- Dodaj tu swoje ulubione wtyczki i krótkie reguły użycia.
- Zapisuj decyzje architektoniczne: kiedy Bases vs Dataview, kiedy Make.md Spaces.
