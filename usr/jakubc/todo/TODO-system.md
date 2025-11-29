---
tags:
  - #todo
  - #eww
  - #system
  - #jakubc
created: 2025-11-22T00:00:00Z
modified: 2025-11-22T00:00:00Z
author: jakubc
title: "🧭 TODO: System zarządzania zadaniami"
status: active
owner: jakubc
---

# 🧭 TODO: System zarządzania zadaniami

## 🎯 Cel
- Jeden workflow zadań (repo = źródło prawdy) dostępny w VS Code, Obsidianie, Habitica (gamifikacja) i Vikunja (widok techniczny).

## 🖥️ Kontekst pracy
- **jakubc**: edycja lokalnie w VS Code na GERC (`/home/jakubc/git/eww`); podgląd/przegląd w Obsidianie.
- **Obsidian na GERC**: ten sam vault co VS Code, używany do czytania i szybkich edycji.
- **karinam**: praca lokalna przy sprzedaży eBay na ASUS Z77 (`/home/karinam/git/eww`); własne noty/zadania synchronizowane do repo.
- **Mobile**: iPhone (jakubc/karinam) – dostęp mobilny do zadań/notatek.
- **Stacje robocze**: Kubuntu 25.x + git na obu maszynach.
- **VS Code (jakubc)**: praca na obu komputerach; edycje idą do repo, status zadań musi być spójny z Obsidian/Habitica/Vikunja po sync.

## 📜 Ustalenia
- Ten plik opisuje system TODO i integracje; priorytet to spójność między VS Code/Obsidian a lokalną pracą karinam.
- Checklisty i karty zadań w repo; archiwum: `usr/jakubc/todo/archives/`.
- Repo główne: **github.com/nairecth/eww** (jakubc). Karinam pracuje na forku, push → jej GitHub → PR/merge do oryginału.

## 🗺️ Obszary zadań
- **Dom (house)**: `core/house/area/*/TODO.md` + dashboard `core/house/house_dashboard.md`.
- **E-Waste Workshop**: repo główne, karty techniczne, dokumentacja sprzętu/infra.
- **Jakub — development**: `usr/jakubc/` (karty `task_card: true`, backlog `usr/jakubc/todo/TODO.md`).
- **Karinam — sprzedaż**: eBay + lokalna praca na ASUS Z77 (`/home/karinam/git/eww`), sync do repo.
- **Personalne**: prywatne noty w `usr/` (jakubc/karinam), linkowane do wspólnych kart.

## 📦 Artefakty zadań
- **Lista główna**: `usr/jakubc/todo/TODO.md` — priorytety P1/P2/P3, źródło prawdy dla synchronizacji.
  ```md
  - [ ] (P1) [[TODO-gerc-boot|GERC Boot Autostart]]
  - [ ] (P2) Klient eBay `les.sara61`
  ```
- **Task cards**: pliki z `task_card: true` (np. `usr/jakubc/todo/TODO-gerc-boot.md`), z pełnym opisem, zakresem i kryteriami; linkowane z listy głównej.
  ```yaml
  ---
  title: "🗂️ Karta zadania · GERC Boot"
  task_card: true
  status: in-progress
  priority: P1
  owners: [jakubc]
  ---
  ```
- **Obsidian Tasks**: checkboxy w plikach markdown; plugin do widoków/filtrów.
  ```md
  - [ ] Deep clean kuchni 📅 2025-12-01 #cleaning
  ```
- **Habitica**: te same zadania w formie questów (fantasy, XP/Gold); stan spójny po sync.
  ```json
  { "text": "Quest: Oczyść kuchnię alchemika", "difficulty": "hard", "tags": ["house","cleaning"] }
  ```
- **Vikunja**: widok sprint/to-do; stan spójny po sync.
  ```json
  { "title": "Sprint: cleaning-kitchen", "priority": 1, "labels": ["house","cleaning"] }
  ```
- **Archiwum**: `usr/jakubc/todo/archives/` — stare listy/karty, trzymane dla historii.

## 🚀 MVP
- Źródło prawdy: `usr/jakubc/todo/TODO.md` + karty `task_card: true`.
- Obsidian + plugin Tasks: widoki/filtry checklist z repo.
- Habitica: automatycznie synchronizowane kluczowe zadania (fantasy opisy), odhaczanie mobile.
- Vikunja: automatycznie synchronizowane listy/sprinty (widok techniczny).
- Sync: automatyczny push/pull statusów (odhaczenie w jednej aplikacji odwzorowane w repo i pozostałych); proces w tle.
- Lokalizacja kart: folder `TODO/` obok edytowanego pliku, podkatalog `taskname/` (nazwa z `taskdesc` w YAML, może być auto-uzupełniona i sprawdzona ręcznie).

## ⚙️ Funkcjonalność (zakres)
- Repozytorium jako źródło prawdy: lista główna + karty (`task_card: true`) z priorytetami i właścicielem.
- Widoki: Obsidian + Tasks/Dataview do filtrowania checklist (bez własnych statusów).
- Gamifikacja: Habitica jako frontend fantasy; zadania mają odpowiadające wpisy (XP/Gold, questy).
- Listy techniczne: Vikunja jako widok sprint/to-do (tagi/priorytety), spójny stan z repo/Habitica po synchronizacji.
- Adnotacje w kodzie: krótkie `TODO:` z linkiem do listy/karty; pełen opis i status są w repo.

## 🤖 Automatyzacja (plan)
- Docelowo: skrypt/CLI, który parsuje markdown (YAML + checkboxy) i aktualizuje Habitica/Vikunja oraz odbiera stan ukończenia do repo.
- Mapowanie: P1/P2/P3 → Hard/Medium/Easy; obszary → tagi/emoji wspólne dla Habitica/Vikunja.
- Tryby: `push` (repo → fronty), `pull` (fronty → repo); tryb `dry-run` przed zmianami.
- Wywołanie: `make todo-sync` (manual) lub timer (np. co 2h, 08–22) po włączeniu automatyzacji.
- Sekrety: klucze Habitica/Vikunja poza repo (`.env`/`.config`), brak commitowania.
- Stan: na razie sync ręczny (MVP); kod i dokumentacja trafią do `dev/` gdy automatyzacja powstanie.

## Kanały i fronty
- **VS Code**: edycja plików źródłowych (jakubc).
- **Obsidian**: podgląd/edytor wspólny; statusy muszą być zgodne ze źródłem (repo).
- **Habitica**: warstwa gamifikacji (fantasy questy, XP/Gold, fun/motywacja); odhaczanie mobilne.
- **Vikunja**: główny widok listowy/to-do (web/mobile), miejsce do sprintów i zamknięcia innych frontów; stan wspólny z Habitica/Obsidian po sync.
- **Obsidian Tasks (plugin)**: prawdopodobnie używany do widoków/filtrów checkboxów w repo.

## 🏰 Gamifikacja
- Misje w Habitica: styl fantasy; zakres zgodny z opisem technicznym w Obsidianie.
- Opisy w Obsidianie: neutralne/operacyjne; status spójny z Habitica (odhaczenie w jednej = odhaczenie w drugiej po sync).
- Kategorie: Dom, EWW, Dev, Sprzedaż, Personalne → listy/tags/emoji w Habitica/Vikunja.
- Nagrody: progi XP/Gold (np. 50 XP = treat, 200 XP = wspólna nagroda); tabela tu lub w osobnym pliku.
- Mobile: iPhone (jakubc/karinam) do odhaczania zadań „w terenie”.

## 🔄 Sync i automatyzacja (draft)
- Źródło prawdy: `usr/jakubc/todo/TODO.md` + karty `task_card: true`; Habitica/Vikunja jako lustrzane fronty.
- Mapowanie: P1/P2/P3 → Habitica difficulty Hard/Medium/Easy; obszary → tagi/emoji.
- Kierunek:
  - Repo → Habitica/Vikunja: push nowych/zmienionych zadań (open).
  - Habitica/Vikunja → Repo: pull stanu ukończenia, aktualizacja checkboxów (commit później).
- Wejście: skrypt czytający markdown (YAML + checkboxy) → payload Habitica; log `sync-log`.
- Triggery: manual `make todo-sync` lub timer (np. co 2h, 08–22).
- Bezpieczeństwo: klucze Habitica w `.env`/`.config/habitica`; nie commitować tajemnic.
- Plan: mały CLI (Python/Node/Bash + curl) z dry-run; dokumentacja trafi do `dev/` gdy kod powstanie.

## ⏱️ Synchronizacja i serwer
- Automatyzacja w tle: wymagany stały proces/serwis (cron/systemd na GERC lub mały serwer/VPS) z kluczami API Habitica/Vikunja.
- Habitica: SaaS; używamy API do push/pull.
- Vikunja: własna instancja (Docker/docker-compose); CLI/worker aktualizuje stan.
- Tryb: near-real-time (np. co kilka minut) lub webhooki, tak by odhaczenie w dowolnym froncie pojawiło się w repo i pozostałych.
- Offline/konflikty: repo pozostaje nadrzędne; w razie rozbieżności wygrywa stan z `TODO.md`/kart po sync.

## 🔗 Źródła
- Habitica: https://habitica.com/ · `docs/software/habitica/README.md`
- Vikunja: https://vikunja.io/ · `docs/software/vikunja/README.md`
- Obsidian (plugin Tasks): https://github.com/obsidian-tasks-group/obsidian-tasks · `docs/software/obsidian/plugins/community/tasks.md`
- Obsidian (plugin Dataview): https://github.com/blacksmithgu/obsidian-dataview · `docs/software/obsidian/plugins/community/dataview.md`
- Obsidian ogólnie: https://obsidian.md/ · `docs/software/obsidian/README.md`
- Git: https://git-scm.com/doc · `docs/software/git/README.md`
- GitHub: https://docs.github.com/ · `docs/software/github/README.md`

## 🧾 Wymagania dot. TODO
- **Tworzenie w trakcie pracy**: jeśli pojawia się zadanie podczas edycji dowolnego pliku, zapisujemy je w `usr/jakubc/todo/TODO.md` (priorytet + link do pliku/sekcji) i/lub tworzymy kartę (`task_card: true`) gdy jest złożone.
- **Adnotacja w pliku źródłowym**: w kodzie/dokumentacji można zostawić krótki ślad `TODO:` z linkiem do karty/listy (np. `TODO: patrz usr/jakubc/todo/TODO.md (sekcja P1)`), ale źródłem statusu pozostaje lista/karta.
- **Karta zadania**: wymagane dla złożonych tematów (zakres, kryteria, właściciel); linkowana z listy głównej i ewentualnie z miejsca w kodzie, jeśli to zadanie techniczne.
- **Spójność statusu**: odhaczenie w Habitica/Vikunja musi być odzwierciedlone w repo (checkbox), repo wygrywa przy rozbieżnościach.
- **Jedno źródło prawdy**: statusy i priorytety w `TODO.md`/kartach; inne fronty są lustrami do odhaczania/planowania.
- **Lokalizacja kart**: karta trafia do folderu `TODO/` obok pliku, przy którym powstało zadanie; pierwszy TODO tworzy ten folder automatycznie.
- **Struktura kart**: wewnątrz `TODO/` każda karta ma własny katalog `taskname/`, gdzie `taskname` = `taskdesc` z YAML.
- **Opis karty**: `taskdesc` uzupełniany automatycznie przez AI (np. Ollama), a następnie weryfikowany ręcznie; trafia do YAML frontmatter i nadaje nazwę katalogowi.
