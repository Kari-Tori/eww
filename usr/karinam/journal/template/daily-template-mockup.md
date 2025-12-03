---
modified: 2025-11-25
created: 2025-11-25
version: 0.0.6
title: Daily Template Mockup
date: 2024-07-15
requires:
  - templater
  - tasks
  - dataview
  - kanban
---

# Czwartek — 15-07-2024

## 🗂️ Sekcja informacyjna — tablica Kanban
![[../archives/daily-template-mockup-template#Kanban]]

## 🗓️ Wydarzenia / Święta
> [!info] Plan dnia i święta
> - 08:00 • Spotkanie zespołu (Teams)
> - 12:00 • Święto państwowe — „Dzień Wolności”
> - 18:30 • Kolacja z przyjaciółką

## ✅ Zadania przypisane na ten dzień
> [!todo] Widok z Dataview
> ```dataview
> TASK
> WHERE !completed
> AND contains(lower(text), "todo")
> AND due = date(2024-07-15)
> SORT due desc
> ```
> - [ ] TODO: przepisać notatki z warsztatów `due:: 2024-07-15`
> - [ ] TODO: zarezerwować wizytę u dentysty `due:: 2024-07-15`

## 📸 Zdjęcia / Materiały
> [!photo] Lokalne + Nextcloud
> - Docelowo zdjęcia trafiają na serwer Nextcloud (ścieżki zachowują nazewnictwo dnia).
> - Tymczasowo wrzucaj je jako `![[daily-2024-07-15/photo-01.jpg]]` z katalogu `/git/eww/usr/karinam/journal/daily/` (folder odpowiadający danemu dniu).
> - Szablon tworzy podfolder `daily-data/`; można tam dodać dowiązanie `Downloads -> ~/Downloads`, żeby mieć stały dostęp do pobranych plików.

## 📝 Opis dnia
> [!quote] Rejestr
> - Komputer uruchomiony o **{{START_TIME}}** (wartość ma być pobrana na żywo w chwili włączenia).
> - Główne wydarzenia, refleksje, cytaty.
> - Notuj krótkie punkty albo mini akapity utrzymane w klimacie photoblogu.

## ✅ Podsumowanie dnia
> [!success] Ukończone zadania
> ```dataview
> TASK
> WHERE completed
> AND completion = date(2024-07-15)
> SORT completion desc
> ```
> W tym bloku pojawiają się wszystkie zadania zamknięte tego dnia, dzięki czemu widzisz faktyczny postęp.

## 🔗 Backlinks

- [[usr/karinam/journal/template/template]]
- [[usr/karinam/karinam]]
- [[EWW-MAP]]
