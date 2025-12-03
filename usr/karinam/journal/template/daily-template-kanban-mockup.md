---
version: 0.0.6
modified: 2025-11-25
title: Szablon dzienny — Kanban (mockup)
date: "{{date}}"
template: daily-kanban
kanban-plugin: board
author: "karinam <kmirowska7@gmail.com>"
created: 2025-11-25
last_edit: "2025-11-18T22:27:56+00:00"
last_editor: "karinam <kmirowska7@gmail.com>"
description: "Szablon dzienny Kanban dla Obsidian (wtyczka Obsidian Kanban) — metadane przeniesione z nagłówka pliku"
plugin:
  name: Kanban
  author: mgmeyers
  repo: https://github.com/mgmeyers/obsidian-kanban
# Dodane: rekomendowane wtyczki i minimalne ustawienia (do informacji)
obsidian_plugins:
  - Kanban
  - Dataview
  - Templater
  - Tasks
  - QuickAdd
  - Calendar
  - Periodic Notes
  - Obsidian Git
---

## Przykłady kart z dodatkowymi informacjami (mockup)

%% kanban:settings
{"kanban-plugin":"board","list-collapse":"none","new-card-in":"Dziś 📅","show-checkboxes":true,"lane-width":320,"hide-tags-in-title":true,"tag-color-seeded":true}
%%

```kanban
## Dziś 📅
- [ ] Wydarzenia: sprawdź przypięte wydarzenia i kalendarz
- [ ] Zadania: przygotować agendę na spotkanie 10:00
- [ ] Płatności: zapłać abonament (termin: dzisiaj)  #płatności

## eBay 💸
- [ ] Sprawdź nowe wiadomości i oferty  #eBay
- [ ] Przygotować paczkę #455 — zdjęcia i opis  @karinam
- [ ] Zaktualizować opis produktu i cenę

## Ukończone ✅
- [x] Morning check-in z kalendarzem
- [x] Opłacono rachunek telefoniczny
- [x] Zgłoszono przesyłkę do DHL

## Jutro 🔜
- [ ] Zadania zaplanowane na jutro
- [ ] Przygotować materiały na spotkanie
- [ ] Śledzić przesyłki i status aukcji

## Nowa lista To-Do ➕
- [ ] (Utwórz nową listę, np. "Inne projekty" lub "Backlog")
```

> Sekcja dotycząca rekomendowanych wtyczek i przykładów konfiguracji została przeniesiona do dokumentacji projektu: /docs/software/obsidian/plugins/plugins.md

## 🔗 Backlinks

- [[usr/karinam/journal/template/template]]
- [[usr/karinam/karinam]]
- [[EWW-MAP]]
