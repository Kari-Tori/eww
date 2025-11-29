---
tags:
  - #todo
  - #plan
  - #eww
  - #system
  - #jakubc
created: 2025-11-22T00:00:00Z
modified: 2025-11-22T00:00:00Z
author: jakubc
title: "Plan wdrożenia: TODO System (Obsidian + Habitica + Vikunja + Git)"
status: draft
owner: jakubc
sources:
  - usr/jakubc/todo/TODO-system.md
  - docs/software/habitica/README.md
  - docs/software/vikunja/README.md
  - docs/software/obsidian/plugins/community/tasks.md
  - docs/software/obsidian/plugins/community/dataview.md
  - docs/software/git/README.md
  - docs/software/github/README.md
---

# Plan wdrożenia: TODO System

## 🎯 Cel
Zautomatyzowany obieg zadań: repo (źródło prawdy) ↔ Obsidian (widoki) ↔ Habitica (gamifikacja) ↔ Vikunja (widok sprint/to-do) z near-real-time synchronizacją i spójnością statusów.

## 📚 Zakres i założenia
- Repo nadrzędne: `usr/jakubc/todo/TODO.md` + karty `task_card: true`.
- Fronty: Habitica (fantasy), Vikunja (listy/sprinty), Obsidian (Tasks/Dataview).
- Priorytety: P1/P2/P3 → Hard/Medium/Easy; obszary → tagi/emoji spójne między frontami.
- Karty: w `TODO/<taskname>/` obok pliku źródłowego; `taskdesc` generowane (AI) i weryfikowane ręcznie.
- Git/GitHub: flow fork PR (karinam → nairecth/eww), repo jako jedyne źródło stanu.
- Reguła repo nadrzędnego: przy konflikcie stan z `TODO.md`/kart wygrywa; sync musi odzwierciedlać repo w Habitica/Vikunja.
- Tworzenie TODO: pierwszy TODO tworzy folder `TODO/` przy pliku; każde zadanie ma własny katalog `TODO/<taskname>/` (nazwa ze znormalizowanego `taskdesc` w YAML).
- Skalowanie liczby plików: zakładamy dużą liczbę folderów/plików `TODO/<taskname>/`; potrzebne konsekwentne slugowanie nazw, deduplikacja i okresowe porządki/archiwizacja, by zachować czytelność i wydajność widoków (Obsidian/Dataview).

## 🗺️ Etapy
1) **Inwentaryzacja i porządki**  
   - Uporządkować `TODO.md` i karty `task_card: true` (P1/P2/P3, właściciele, tagi obszarów).  
   - Ujednolicić nazewnictwo tagów/emoji dla obszarów (Dom/EWW/Dev/Sprzedaż/Personalne).  
   - Zweryfikować archiwum (`usr/jakubc/todo/archives/`) i usunąć duplikaty otwartych zadań.

2) **Definicje mappingu i filtrów**  
   - Spisać mapowanie priorytetów i obszarów → Habitica/Vikunja (tags, difficulty, labels).  
   - Ustalić filtr zadań do eksportu (np. tylko P1/P2, bez prywatnych/poufnych).  
   - Zdefiniować format slug `taskname` (lowercase, dash) i walidację duplikatów.

3) **Instancje i dostęp**  
   - Habitica: pozyskać USER_ID/API_TOKEN, zapisać w `~/.config/habitica/env`.  
   - Vikunja: postawić/uzyskać instancję (Docker/docker-compose), utworzyć token API, zapisać w `~/.config/vikunja/env`.  
   - Obsidian: potwierdzić Tasks/Dataview aktywne w vault repo.

4) **Projekt CLI sync (MVP auto)**  
   - Język: Python/Node/Bash (curl) – małe CLI z komendami `push`, `pull`, `sync`, `dry-run`.  
   - Wejście: parser markdown (YAML + checkboxy) z `usr/jakubc/todo/`.  
   - Wyjście:  
     - Habitica: tworzenie/aktualizacja To-Dos/Dailies (difficulty, tags).  
     - Vikunja: tworzenie/aktualizacja tasks (project/labels/priority).  
   - Kierunek:  
     - `push`: repo → fronty (tylko open/zmienione).  
     - `pull`: fronty → repo (status done/updated_at).  
     - Konflikt: repo wygrywa; pull tylko jeśli brak lokalnej zmiany lub nowszy timestamp.  
   - Logi: `var/log/todo-sync.log`; dry-run raportuje zmiany bez zapisu.

5) **Harmonogram i uruchamianie**  
   - Systemd timer lub cron na GERC (np. co 5–10 min, 08–22).  
   - Komenda: `make todo-sync` wywołuje CLI z `--pull --push` + log.  
   - Awaria API: retry z backoff; po 3 błędach wyłącz automatyczny push, loguj.

6) **Integracje frontów**  
   - Habitica: zachować fantasy `text`/`notes` z linkiem do pliku w repo.  
   - Vikunja: labels = obszary, priority = P1/P2/P3; `description` zawiera link do karty.  
   - Obsidian: widoki Tasks/Dataview (pull z repo po sync), bez własnego zapisu statusów.

7) **Testy i walidacja**  
   - Scenariusz: utwórz nowe P1 w `TODO.md` → push → sprawdź Habitica/Vikunja.  
   - Scenariusz: odhacz w Habitica → pull → checkbox w repo zmienia się na done.  
   - Scenariusz konfliktu: równoczesne zmiany → repo wygrywa, log konfliktu.  
   - Jednostkowe: parser markdown, mapowanie priorytetów/tagów, dry-run.

8) **Dokumentacja i rollout**  
   - Opisać CLI i env w `dev/` (np. `dev/tools/todo-sync.md`).  
   - Dodać sekcję „Operacje” w `TODO-system.md`: jak uruchomić sync, gdzie logi, jak wstrzymać.  
   - Krótki checklist operacyjny dla karinam (fork/PR + sync fronty).  
   - Ewentualne noty o prywatności (co NIE wychodzi do Habitica/Vikunja).

## 🧭 Podejście deweloperskie (repo nadrzędne, auto-sync)
- **Źródło prawdy + lustrzane fronty**: status tylko w repo (`TODO.md` + karty); Habitica/Vikunja to UI. Pull przed push; repo-wins przy konflikcie.
- **Warstwa sync (CLI/serwis)**: parser markdown (YAML + checkboxy) → model zadania (id, priorytet, obszar, ścieżka, mtime); komendy `push`, `pull`, `sync`, `dry-run`.
- **Mapowanie i idempotencja**: P1/P2/P3 → Hard/Medium/Easy; obszary → tagi/emoji; stabilne `task_id` (hash ścieżka+tytuł); zapis remote-id w YAML (`habitica_id`, `vikunja_id`) dla uniknięcia duplikatów.
- **Push/Pull**:  
  - `push`: repo → fronty (open/zmienione).  
  - `pull`: fronty → repo (done/updated_at); konflikt → log, repo-wins.  
  - Dry-run + log `var/log/todo-sync.log`; retry/backoff na API.
- **Slugowanie i skala**: `taskname` = znormalizowany `taskdesc` (lowercase, dash, limit znaków), deduplikacja; rotacja/archiwizacja zamkniętych >30 dni; cache indeksu zadań, by nie parsować wszystkiego przy każdym sync.
- **Sekrety i bezpieczeństwo**: klucze API w `~/.config/{habitica,vikunja}/env`; przy błędach API wyłącz tylko push, pull-read-only OK.
- **Uruchamianie**: systemd timer/cron (co 5–10 min) lub webhooki Vikunja; Habitica tylko API pull/push okresowy. Komenda użytkowa: `make todo-sync --pull --push --dry-run?`.
- **Integracje frontów**:  
  - Habitica: `text` fantasy, `notes` z linkiem do pliku, `difficulty` = P1→hard.  
  - Vikunja: `title` techniczny, `labels` = obszary, `priority` = P1/P2/P3, `description` z linkiem do karty.  
  - Obsidian Tasks/Dataview: wyłącznie widok na repo, bez własnych statusów.
- **Testy**: scenariusze (nowe P1 → push → fronty; odhacz w Habitica → pull → repo; konflikt repo-wins); jednostkowe dla parsera, mapowania, slugów, dry-run.
- **Operacyjnie (fork karinam)**: sync z upstream; sekrety tylko u właściciela instancji; PR flow bez przekazywania kluczy.

## 🧩 Otwarte decyzje
- Gdzie hostować Vikunja (GERC vs VPS) i jakich zasobów potrzebuje.  
- Częstotliwość sync (5 min vs 10 min) i obsługa webhooków.  
- Zakres eksportu (czy P3 też wysyłać, co z zadaniami prywatnymi/poufne).  
- Strategia konfliktów przy jednoczesnym odhaczaniu w wielu frontach (timestamp vs repo-wins).  
- Normalizacja nazw `taskname` i procedura, gdy AI wygeneruje duplikat.  
- Logi i monitoring (rotacja logów, alert przy błędach API).

## 🔍 Propozycje implementacyjne (wzorce bez szukania w sieci)
- **Stos narzędzi sync**: Python + `frontmatter` (parsowanie YAML/MD) + `requests` (API Habitica/Vikunja) + `click` (CLI) + `rich` (logi kolor). Alternatywa: Node + `gray-matter` + `axios` + `commander`.
- **Cache/index**: generuj `var/cache/todo-index.json` z polami: id (hash ścieżka+tytuł), path, mtime, priority, area, remote_ids. Używaj do szybkiego diff w kolejnych runach.
- **Remote IDs w YAML**: dodaj pola `habitica_id`, `vikunja_id` w kartach/listach po pierwszym pushu, żeby unikać duplikatów.
- **Rozwiązywanie konfliktów**: pull → porównanie `updated_at` frontu vs `mtime` pliku; jeśli konflikt, log + repo-wins (nie zmieniaj pliku). Push tylko, gdy repo nowsze lub brak konfliktu.
- **Filtr eksportu**: domyślnie P1/P2 i brak tagu `#private`; P3 opcjonalnie. Obszary jako wymagane tagi do mapowania (Dom/EWW/Dev/Sprzedaż/Personalne).
- **Slugowanie**: funkcja `slugify(taskdesc, max=60)` (lowercase, dash, usuń diakrytyki), sprawdź kolizje; przy kolizji dodaj sufiks `-2`.
- **Struktura logów**: `var/log/todo-sync.log` + rotacja (np. 5 plików po 5 MB); poziomy: INFO (push/pull), WARN (konflikt), ERROR (API).
- **Testy automatyczne**: fixture z przykładowymi MD + snapshot expect → test parsowania/mapowania; test dry-run (nie zmienia plików); test konfliktu (repo-wins).
- **Bezpieczeństwo**: `.env` z `HAB_USER/HAB_TOKEN`, `VIKUNJA_TOKEN/VIKUNJA_URL` w `~/.config/...`; CLI odmawia działania, jeśli brak sekretów lub niezaufany branch.
- **Operacje**: `make todo-sync` → `python tools/todo_sync.py --pull --push --log var/log/todo-sync.log`; `make todo-sync-dry` → `--dry-run`.
- **Vikunja deployment**: docker-compose w `dev/` z reverse proxy + TLS (opcjonalnie); namespace/project per obszar lub jedna przestrzeń z labelami.
- **Habitica mapping**: `text` = fantasy, `notes` = link do repo, `difficulty` = P1→hard, P2→medium, P3→easy; tagi = obszary.
## 🧱 Standard w kodzie (adnotacje)
- Format adnotacji: `TODO: <krótki opis> (link: usr/jakubc/todo/TODO.md#P1)` lub `TODO: patrz TODO/<taskname>/` dla kart.
- Czego nie robić: bez osobnych statusów w komentarzach; status w repo (checkbox/karta).
- Priorytet i obszar: dodaj w liście głównej/kartach (P1/P2/P3, tag obszaru), nie w komentarzu.

## ▶️ Kolejność wdrożeń integracji
1) Obsidian Tasks/Dataview: upewnić się, że widoki działają na repo (lista główna + karty), bez własnych statusów.  
2) Vikunja: uruchomić instancję, ustawić mapowanie tagów/priorytetów, przygotować CLI `push/pull`.  
3) Habitica: mapowanie na questy/difficulty, integracja API, dodanie linków do plików w `notes`.  
4) Automatyczny sync: timer/systemd z CLI (pull→merge→push), logi i dry-run.  

## ✅ Kryteria gotowości
- CLI push/pull z dry-run działa na 3 scenariuszach testowych.  
- Habitica i Vikunja odzwierciedlają P1/P2 z repo w obu kierunkach.  
- Timer/cron/systemd uruchamia sync bez błędów przez 24h.  
- Dokumentacja użytkowa (jak uruchomić, gdzie są logi, jak wyłączyć) dostępna w repo.  
- Konflikty rozstrzygane przewidywalnie (repo-wins lub timestamp), odnotowane w logu.
