---
created: <% tp.date.now("YYYY-MM-DD") %>
date: <% tp.date.now("YYYY-MM-DD") %>
day: <% tp.date.now("dddd") %>
start_time: <% tp.date.now("HH:mm") %>
template: daily
tags: [#journal/daily, #personal]
---

# <% tp.date.now("dddd") %> — <% tp.date.now("YYYY-MM-DD") %> ✨

> [!tip] Krótkie streszczenie
- MIT (najważniejsze zadanie dziś): _wpisz najważniejsze zadanie_
- 3 cele dnia:
  - [ ] Cel 1
  - [ ] Cel 2
  - [ ] Cel 3

**Start time:** `<% tp.date.now("HH:mm") %>`

---

## Szybkie nastroje i energia
- Mood: 😌 / 😐 / 😞 / 🙂  (krótki opis)
- Energy: 1-5
- Focus: (np. "deep work: 2h")

## Rano — plan działania
- 07:00 — Krótka rutyna: kawa, rozciąganie, 10 min planowania

## Time log (opcjonalne)
- `09:00–10:00` — Zadanie A

## Zadania / Action items
- [ ] Zadanie z priorytetem ⭐ — krótki opis

### Tracker nawyków
- [ ] Medytacja
- [ ] Ruch 30m
- [ ] Woda 2L

---

## Drobne zwycięstwa / Wins

## Wdzięczność (1–3)

## Notatki / Refleksje

## Zdjęcia / Załączniki

`![[Attachments/nazwa_zdjecia.jpg]]`

---

_Wariant przeznaczony dla pluginu Templater — wstawia datę i godzinę automatycznie._
---
Date: <% tp.date.now("YYYY-MM-DD") %>
Day: <% tp.date.now("dddd") %>
StartTime: <% tp.date.now("HH:mm") %> # wpisz godzinę uruchomienia komputera
Tags: [#journal/daily, #personal]
Template: daily-templater
---

# <% tp.date.now("dddd") %> — <% tp.date.now("YYYY-MM-DD") %> ✨

> [!tip] Krótkie streszczenie
- MIT (najważniejsze zadanie dziś): _wpisz najważniejsze zadanie_
- 3 cele dnia:
  - [ ] Cel 1
  - [ ] Cel 2
  - [ ] Cel 3

**Start time:** `<% tp.date.now("HH:mm") %>`  
*(Wpisz godzinę, o której włączyłaś komputer lub rozpoczęłaś dzień)*

---

## Szybkie nastroje i energii
- Mood: 😌 / 😐 / 😞 / 🙂  (krótki opis)
- Energy: 1-5
- Focus: (np. "deep work: 2h")

## Rano — plan działania
- 07:00 — Krótka rutyna: kawa, rozciąganie, 10 min planowania
- 08:00 — Pierwszy blok pracy — MIT

## Time log (opcjonalne)
- `09:00–10:00` — Zadanie A
- `10:00–10:30` — Przerwa / spacer

## Zadania / Action items
- [ ] Zadanie z priorytetem ⭐ — krótki opis
- [ ] Inne zadanie — tagi: #work #home

### Tracker nawyków
- [ ] Medytacja
- [ ] Ruch 30m
- [ ] Woda 2L

---

## Drobne zwycięstwa / Wins
- Małe osiągnięcie: _np. wysprzątane biurko_

## Wdzięczność (1–3)
- Za: _np. dobrą kawę_

## Notatki / Refleksje

Miejsce na bardziej rozbudowane przemyślenia, linki, fragmenty kodu, pomysły.

## Zdjęcia / Załączniki

Dodaj pliki graficzne do `usr/karinam/journal/Attachments/` i osadź je w treści:

- Obsidian (wstawianie plików z vault):
  - `![[Attachments/nazwa_zdjecia.jpg]]`
- Markdown (relatywna ścieżka):
  - `![opis](Attachments/nazwa_zdjecia.jpg)`

---

## Jak używać tego szablonu (Templater)

- W Obsidian zainstaluj plugin Templater.
- Użyj "Insert template" -> `Templates/daily-templater.md` lub QuickAdd.
- Szablon automatycznie wypełni datę i godzinę przy wstawieniu.
