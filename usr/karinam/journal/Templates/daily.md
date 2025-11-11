---
Date: {{date:YYYY-MM-DD}}
Day: {{date:dddd}}
StartTime: {{time:HH:mm}} # wpisz godzinę uruchomienia komputera
Tags: [#journal/daily, #personal]
Template: daily
---

# {{Day}} — {{Date}} ✨

> [!tip] Krótkie streszczenie
- MIT (najważniejsze zadanie dziś): _wpisz najważniejsze zadanie_
- 3 cele dnia:
  - [ ] Cel 1
  - [ ] Cel 2
  - [ ] Cel 3

**Start time:** `{{StartTime}}`  
*(Wpisz godzinę, o której włączyłaś komputer lub rozpoczęłaś dzień)*

---

## Szybkie nastroje i energii
- Mood: 😌 / 😐 / 😞 / 🙂  (krótki opis)
- Energy: 1-5
- Focus: (np. "deep work: 2h" lub krótkie hasło)

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

## Jak używać tego szablonu

- Skopiuj ten plik do `Daily/daily-{{date:YYYY-MM-DD}}.md` lub użyj skryptu, który tworzy dziennik z tego szablonu.
- Sugestie: dodaj aliasy w górnym frontmatter, użyj tagów `#journal/daily` i `#personal`.
- Opcjonalnie: dodaj prosty CSS lub community plugin w Obsidian, aby wyróżnić sekcje (callouts, task styling).

---

_Szablon: nowoczesny, prosty i przyjazny dla Obsidian — zawiera pola na nastrój, tracker nawyków, MIT i szybki time-log. Wszystkie komentarze i pola po polsku._
---

---
Date: {{date:YYYY-MM-DD}}
Day: {{date:dddd}}
StartTime: {{time:HH:mm}} # wpisz godzinę uruchomienia komputera
Tags: #journal/personal
---

# {{Day}} — {{Date}}

**Start time:** `HH:MM`  
*(Wpisz godzinę, o której włączyłaś komputer)*

## Opis dnia

Miejsce na osobisty opis dnia — refleksje, najważniejsze zadania, co zostało zrobione.

## Zdjęcia / Załączniki

Dodaj pliki graficzne do `usr/karinam/journal/Attachments/` i osadź je w treści:

- Obsidian (wstawianie plików z vault):
	- `![[Attachments/nazwa_zdjecia.jpg]]`
- Markdown (relatywna ścieżka):
	- `![opis](Attachments/nazwa_zdjecia.jpg)`

## Action items

- [ ] Przykładowe zadanie — status: todo

---

Instrukcja szybkiego użycia:

- Skopiuj ten szablon do nowego pliku `Daily/daily-YYYY-MM-DD.md` i uzupełnij pola `StartTime`, `Opis` i dodaj zdjęcia do `Attachments/`.

