---
title: 📝 Journal — folder note
description: TODO - uzupełnij opis.
---

# 📝 Journal — folder note

> [!note] Photoblog + tekst
> Centralna notatka katalogu `usr/karinam/journal/`. Dziennik bazuje na układzie photoblogowym (opis + opcjonalne zdjęcia). Nowy wpis powstaje codziennie po otwarciu vaulta przez Obsidiana — bez dodatkowych skryptów systemowych i bez folderu `Attachments/`.

## ⚙️ Jak działa dziennik
1. W Obsidianie aktywuj core-plugin **Daily Notes** lub community **Periodic Notes** + **Templater**. Folder docelowy ustaw na `usr/karinam/journal/daily/`, a szablon na `template/daily-template/daily-template.md` (folder `daily-template/` tworzy też podfolder `daily-data/` na dane dnia).
2. Opcja „Create new note on startup” (Periodic Notes) lub „Open daily note on startup” (Daily Notes) sprawia, że przy pierwszym uruchomieniu Obsidiana każdego dnia notatka `daily-YYYY-MM-DD.md` powstaje automatycznie i natychmiast się otwiera.
3. W Templater zaznacz „Trigger Templater on new file creation”, aby frontmatter (`date`, `day`, `pretty_date`, `start_time`, `tags`) został uzupełniony natychmiast przez makra `<% tp.date.now(...) %>`. Nazwą i lokalizacją pliku zarządza plugin Daily/Periodic Notes zgodnie z Twoją konfiguracją (`daily/daily-YYYY-MM-DD.md`).
4. Cały układ pozostaje photoblogowy: sekcje na godzinę uruchomienia komputera, plan/cele, refleksje oraz blok „Zdjęcia / Galerie”. Zdjęcia są opcjonalne — sekcję można zostawić pustą.
5. Zdjęcia dodawaj standardowo w Obsidianie (drag & drop, `Attach new file`). Miejsce zapisu załączników kontrolujesz w Settings → Files & Links → Default location.

## 🗂️ Index katalogu
> [!summary] Najważniejsze elementy
> - `daily/` – dzienne wpisy `daily-YYYY-MM-DD.md`, tworzone automatycznie przez Obsidiana.  
> - `template/` – główny szablon `daily-template.md` (10 ⭐ Mood/Energy, callouty na opis/zdjęcia, blok Tasks).  
> - `template/daily-template-kanban-mockup.md` – tablica Kanban (Dziś/eBay/Ukończone/Jutro/Zamknięte) zgodna z pluginem mgmeyers/obsidian-kanban.  
> - `journal.css` – snippet z kolorami calloutów i gradientowymi nagłówkami.  
> - `kanban-plugin-setup.md` – instrukcja instalacji pluginu Kanban z GitHuba.  
> - `journal.md` – ta folder note / indeks.

## 🧱 Co zawiera dzienna notatka
```yaml
---
date: 2025-11-12
day: Wednesday
pretty_date: 12 listopada
start_time: 07:34   # automatycznie ustawiane przy tworzeniu
tags:
  - journal/daily
  - personal
template: daily-template
cssclass: journal-sheet
requires:
  - templater
  - periodic-notes
  - tasks
  - dataview
  - kanban
---
```

> [!info] Elementy wpisu
> - **Start dnia** – pojedynczy nagłówek `## Start dnia: DATA • DZIEŃ • HH:MM`.  
> - **Mood / Energy** – nagłówek + blok `[!abstract]` z opisem i interaktywnymi gwiazdkami `⭐/⚡`.  
> - **Tasks view** – blok `[!todo]` z zapytaniem pluginu Tasks (`due on YYYY-MM-DD`).  
> - **Opis / Zdjęcia** – callouty `[!quote]` i `[!photo]` stylizowane jak kartki albumu.  
> - **Podsumowanie** – `[!success]` do uzupełnienia po zakończeniu dnia.  
> - **Dataview skrót** – tabela ostatnich wpisów (`pretty_date`, `start_time`) z filtrem `date <= date(now)` gotowa do eksportu.

## 📏 Zasady dziennika
1. Jeden dzień = jeden plik `daily/daily-YYYY-MM-DD.md` (ew. dopisek `-1`, `-2` przy ekstra wpisach).
2. Automatyczne tworzenie i otwieranie obsługuje wyłącznie Obsidian (Daily Notes / Periodic Notes + Templater).
3. Zdjęcia dodawaj w Obsidianie zgodnie z ustawionym katalogiem załączników (np. globalny `Attachments`, `Same folder as current file` itp.).
4. Przy imporcie starszych wpisów pamiętaj o spójnym frontmatterze (klucze `date`, `day`, `pretty_date`, `start_time`, `tags`).
5. Snippety CSS trzymaj w repo; w Obsidianie aktywuj je w `/.obsidian/snippets/`.

## 🎨 Snippet stylów
> [!note] `usr/karinam/journal/journal.css`
> - Pastelowe kolory calloutów (`tip`, `info`, `todo`).  
> - Gradientowe nagłówki H2/H3 z lekkim glow.  
> - Zaokrąglone obrazy w sekcji `📸 Zdjęcia`.  
> Skopiuj plik do `VAULT/.obsidian/snippets/` i włącz w ustawieniach Appearance → CSS snippets.

## 📊 Widoki pluginów
> [!info] Tasks + Dataview
> - **Tasks** – blok w szablonie:
>   ```tasks
>   not done
>   due today
>   ```
>   wyświetla wszystkie niezakończone zadania z terminem „today”; możesz dopisać kolejne warunki (np. `path includes journal`).  
> - **Dataview** – przykładowa tabela w szablonie filtruje wpisy `date <= date(now)` i pokazuje ostatnie starty dnia (`pretty_date`, `start_time`). Możesz też dodać dashboard globalny, np.:
>   ```dataview
>   table pretty_date, start_time, mood := choice(contains(file.tasks.text, "⭐10"), "🔥", "")
>   from "usr/karinam/journal/daily"
>   sort date desc
>   limit 14
>   ```
>   aby mieć szybki podgląd nastroju i energii w ciągu ostatnich dwóch tygodni.

## 🔌 Wymagane pluginy / integracje
```yaml
requires:
  - templater
  - periodic-notes
  - tasks
  - dataview
```
> [!info] Konfiguracja
> - **Templater** – generuje frontmatter, gwiazdki Mood/Energy i dynamiczne daty.  
> - **Periodic/Daily Notes** – automatyczne tworzenie i otwieranie nowej kartki (wystarczy jeden z nich).  
> - **Tasks** – blok `tasks` w szablonie renderuje bieżące zadania i wspiera zaawansowane filtry (status, priorytet, ścieżka).  
> - **Dataview** – generuje tabelę poprzednich wpisów w sekcji „📊” oraz dodatkowe dashboardy, jeśli je dodasz.  
> - **Kanban (mgmeyers/obsidian-kanban)** – renderuje pięciokolumnową tablicę w dziennym mockupie; aktywuj plugin według instrukcji w `kanban-plugin-setup.md`.
> Opcjonalnie możesz dodać QuickAdd dla szybkiego wstawiania zdjęć lub highlightów.

## 📖 Jak uzyskać efekt „kartki z dziennika”
> [!note] Styl książkowy
> 1. Upewnij się, że snippet `journal.css` jest aktywowany (Appearance → CSS snippets). Dodaje tło papieru z liniami, ciepłą kolorystykę i „polaroidowe” zdjęcia.  
> 2. W preferencjach systemu zainstaluj klasyczne fonty (np. „EB Garamond”, „Playfair Display”). Obsidian użyje ich automatycznie do nagłówków i tekstu.  
> 3. Przy eksportowaniu do PDF/Markdown na potrzeby książki, włącz tryb „Print preview” — zachowa marginesy i cienie kartki.  
> 4. Zdjęcia dodawaj do calloutu `[!photo]`, dzięki czemu każdy wpis wygląda jak strona albumu.  
> 5. Mood/Energy w formie 10-gwiazdkowych suwaków przypomina analogowe oceny; po zaznaczeniu checkboxów będzie łatwo zobaczyć, jak zmieniało się samopoczucie w kolejnych dniach.

## 🔁 Workflow skrócony
> [!todo] Codzienna pętla
> 1. Otwórz Obsidiana → plugin Daily/Periodic Notes tworzy i otwiera wpis.  
> 2. Uzupełnij `StartTime`, plan dnia i checklisty (Templater już wpisał wartości startowe).  
> 3. Notuj refleksje / lekcje w ciągu dnia.  
> 4. Dodawaj zdjęcia za pomocą mechanizmu wbudowanego w Obsidiana (np. drag & drop, Attach new file) i wstaw `![[...]]`.  
> 5. Zakończ dzień krótkim podsumowaniem i lekcją.

_Notatka aktualna dla Kubuntu 24.04 + Obsidian (lokalny vault)._ 
