---
title: Workspace: Hybrydowe miejsce pracy (README)
created: 2025-11-21
updated: 2025-11-21
description: TODO - uzupełnij opis.
color: blue
---

# Workspace: Hybrydowe miejsce pracy (README)

Ta strona to index całego katalogu `usr/jakubc/workspace/`. Każdy temat opisujemy w oddzielnym pliku, aby łatwiej było go aktualizować i linkować. Celem katalogu jest opis i utrzymanie hybrydowego środowiska pracy (lokalnie + chmura), niezależnie od konkretnego narzędzia.

## Szybka nawigacja
- [tools_status.md](tools_status.md) – bieżący status Code/Copilot/Codex wraz z listą działań.
- [resarch/resarch_topics.md](resarch/resarch_topics.md) – pełna lista badań i kosztów narzędzi wykorzystywanych w hybrydowym workspace.
- [resarch/resarch.md](resarch/resarch.md) – instrukcja pracy w katalogu R&D oraz gdzie odkładać nowe eksperymenty.
- [archive/README.md](archive/README.md) – co trafiło do archiwum (stare konfiguracje i materiały referencyjne).

## Struktura katalogu
```text
usr/jakubc/workspace/
├── workspace.md     # ten README
├── tools_status.md  # status Code/Copilot/Codex i backlog działań
├── resarch/         # katalog R&D i eksperymenty
└── archive/         # starsze konfiguracje/eksperymenty
```
Na ten moment tylko powyższe elementy istnieją fizycznie w repo. Katalogi opisane wcześniej (`notes/`, `config/`, `diffs/`, `models/`, `scripts/`, `run-logs/`) wymagają odtworzenia lub przywrócenia z archiwum/kopii.

### Foldery operacyjne – gdzie co odkładać (stan bieżący)
- **`resarch/`** – jedyne aktywne miejsce na eksperymenty i dokumentację operacyjną. Każdy eksperyment dopisujemy jako osobny plik, a wyniki streszczamy w `resarch/resarch_topics.md`.
- **`archive/`** – tutaj wrzucamy odzyskane pliki (np. stare konfiguracje, usunięte notatki), dopóki nie odtworzymy docelowych katalogów roboczych.
- **`tools_status.md`** – źródło prawdy o agentach Code/Copilot/Codex; aktualizujemy callouty i listę działań po każdej sesji.

## Jak korzystać
1. Zacznij od [tools_status.md](tools_status.md), żeby sprawdzić kondycję agentów (Code/Copilot/Codex) i bieżący backlog.
2. Wszystkie nowe eksperymenty opisuj w `resarch/` (np. kopiując format z `resarch/resarch_topics.md`) i linkuj je z `resarch/resarch.md`.
3. Jeżeli odzyskujesz stare notatki lub konfiguracje, wrzuć je tymczasowo do `archive/` i dopisz komentarz, skąd pochodzą i co trzeba z nimi zrobić.
4. Po większej zmianie aktualizuj `tools_status.md` (callout + lista działań) i – jeśli dotyczy badań – streszczaj wynik w `resarch/resarch_topics.md`.
5. Odtworzenie katalogów takich jak `notes/`, `config/`, `diffs/`, `models/` traktuj jako osobne zadania i dokumentuj ich status właśnie w `tools_status.md`.

## Zasoby R&D
- Folder `resarch/` zawiera listę badanych narzędzi z opisem funkcji, kosztów (w GBP) i glosariuszem skrótów – patrz [resarch/resarch_topics.md](resarch/resarch_topics.md).
- Bieżące eksperymenty i analizy (np. log rozmów) dokumentujemy w plikach podkatalogu `resarch/` i dopisujemy do tabeli nawigacyjnej.
- Rekomendacje po eksperymentach zapisujemy w `resarch/resarch_topics.md`. Gdy katalog `notes/` zostanie odbudowany, przeniesiemy tam skróconą dokumentację.

### Migawka tematów badawczych (na bazie `resarch/resarch_topics.md`)
- **Platformy i interfejsy AI:** OpenAI/ChatGPT, Google AI Studio i Claude Code budują chmurową warstwę reasoningową z kosztami ~£0–£16/mies. lub usage-based.
- **IDE i edytory:** Cursor, Windsurf, VS Code/VSCodium, JetBrains (PyCharm, Fleet, Rider), Neovim oraz Zed stanowią przekrój środowisk od darmowych po płatne licencje ~£85+/rok.
- **Notatniki i organizacja:** Obsidian (sync 8 USD/mies.) i AppFlowy (open-source) są rekomendowane do lokalnego zarządzania wiedzą.
- **Platformy systemowe/biznesowe:** Kubuntu 24.04 to obowiązkowa baza, a integracje Odoo i eBay opisują proces sprzedażowy oraz ERP.
- **Agenci i frameworki:** Codex, Copilot, Continue, OpenRouter, Ollama, AG2 i LangGraph definiują miks agentów lokalnych/chmurowych wraz z kosztami i rolami.

## Stan narzędzi (szczegóły w [tools_status.md](tools_status.md))
- **Code / VS Code:** główne IDE zintegrowane z Copilotem, Continue i Codexem; służy jako stałe centrum dowodzenia zgodnie z opisem calloutu `success`.
- **GitHub Copilot Pro:** aktywny asystent terminala oraz pair-programming dla szybkich iteracji, zgodnie z calloutem `info`.
- **Codex CLI (OpenAI Business):** agent zadaniowy opisywany jako element `warning`, przejmuje większe patchowanie, aktualizacje dokumentacji i operacje na całym repo.

### Priorytety wynikające z `tools_status.md`
1. **Odtworzyć katalog `notes/`** – potrzebny jest co najmniej `notes/mvp-workflow.md`, aby potwierdzić MVP duetem Copilot + Codex.
2. **Przywrócić dokument ról (`notes/team-and-env.md`)** lub równoważny plik z podziałem zadań Copilot vs Codex; bez tego callout `info` nie ma pokrycia.
3. **Stworzyć `scripts/workspace-agent.sh`** – obecnie nie istnieje nawet katalog `scripts/`, więc trzeba go odtworzyć lub tymczasowo trzymać plik w `archive/`.
4. **Zorganizować logi sesji** – dopóki nie ma `run-logs/`, można prowadzić `archive/run-logs.md`, ale wpisy `Copilot`/`Codex` muszą się pojawić, by mierzyć skuteczność narzędzi.

## Status i dalsze prace
Obecnie źródłem prawdy są `tools_status.md` (stan agentów) oraz `resarch/` (badania). Ten README pozostaje lekką stroną startową z linkami i strukturą. Gdy odtworzymy brakujące katalogi (np. `notes/`, `config/`), dopiszemy nowe pliki do sekcji „Szybka nawigacja” i zaktualizujemy opis struktury.
