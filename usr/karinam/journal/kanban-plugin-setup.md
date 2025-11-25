---
title: Konfiguracja pluginu Kanban
description: Instrukcja instalacji i konfiguracji pluginu mgmeyers/obsidian-kanban w vaultcie journal.
---

# Plugin Kanban — instalacja i konfiguracja

## 1. Dlaczego ten plugin
- Obsługuje tablice Kanban bezpośrednio w Markdownie (link: https://github.com/mgmeyers/obsidian-kanban).
- Pozwala używać kolumn Dziś / eBay / Ukończone / Jutro / Zamknięte zgodnie z mockupem `daily-template-kanban-mockup.md`.

## 2. Instalacja (manualna z GitHuba)
1. Przejdź do strony wydań: https://github.com/mgmeyers/obsidian-kanban/releases.
2. Pobierz najnowsze archiwum `obsidian-kanban.zip`.
3. Rozpakuj zawartość do katalogu vaulta: `/git/eww/usr/karinam/journal/.obsidian/plugins/obsidian-kanban/` (zastąpi istniejące `manifest.json`, `main.js`, `styles.css`).
4. Upewnij się, że w `.obsidian/community-plugins.json` znajduje się wpis `"obsidian-kanban"` — został dodany w repo i będzie aktywował plugin po restarcie Obsidiana.

## 3. Konfiguracja w Obsidianie
1. Settings → Community Plugins → Confirm `Safe mode` = OFF.
2. Kliknij `Installed plugins` i włącz **Kanban**.
3. W konfiguracji pluginu ustaw:
   - `Show new card button` = ON.
   - `Show position handles` = OFF (czyściej wygląda tablica dzienna).
   - `New card insertion` = `Plan na dziś 📅` (zgodne z mockupem).
   - (Opcjonalnie) `Archive file` wskaż na `usr/karinam/journal/archives/kanban-archive.md` jeśli chcesz mieć osobny log.

## 4. Aktualizacja mockupów
- `template/daily-template-kanban-mockup.md` zawiera jedynie tablicę Kanban (5 kolumn).
- `template/daily-template-mockup.md` to pełny układ dziennej notatki z transkluzją tablicy.
- Fragment tablicy źródłowej znajduje się w `archives/daily-template-mockup-template.md` — możesz go edytować, aby zmienić domyślne karty lub ustawienia `%% kanban:settings`.

## 5. Synchronizacja eBay
- Kolumna „eBay” oznaczona jest jako `TODO jakubc` i wymaga integracji z zewnętrznym konektorem (brak w repo).
- Do czasu implementacji wpisy twórz ręcznie lub za pomocą Tasks/Dataview.

Po wykonaniu tych kroków Obsidian po uruchomieniu vaulta automatycznie włączy Kanban i tablice w dziennych notatkach zaczną renderować się zgodnie z mockupem.
