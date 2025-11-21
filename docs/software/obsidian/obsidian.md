---
tags:
  - #folder_note
  - #automation
  - #docs
  - #eww
  - #linux
  - #obsidian
  - #secondbrain
  - #star-wars
created: 2025-11-21T19:00:00Z
modified: 2025-11-21T19:00:00Z
author: jakubc
title: "## Cel"






---



> [!TIP] Standard ikony
> Dokument korzysta z definicji `simple-icons/obsidian` (kolor `#4C2A85`) opisanej w [docs/assets/icons.md](../../assets/icons.md).

> [!INFO] Automatyczny instalator Community Plugins
> Skrypt `scripts/install-ai-toolkit.sh obsidian ~/Obsidian/code` pobiera najnowsze wydania Kanban, Dataview, Tasks, Templater, QuickAdd, Advanced URI, Calendar, Periodic Notes, Obsidian Git oraz Lintera i umieszcza je w `vault/.obsidian/plugins/`.

## Cel
Krótki, praktyczny przewodnik po podstawowych funkcjach oryginalnej aplikacji Obsidian — opis pojęć, trybów pracy, pane'ów, core-pluginów i przydatnych skrótów. Materiał ma charakter autorski i uzupełniający (nie jest bezpośrednim cytatem z oficjalnej dokumentacji).

## Przegląd
Obsidian to lokalny edytor Markdown z możliwością tworzenia sieci powiązanych notatek (vault). Główne cechy:
- Przechowywanie plików jako zwykły Markdown w katalogu (vault).
- Linkowanie między notatkami ([[Notatka]]), backlinki i graph view.
- Rozszerzalność przez wtyczki (core i community).
- Tryby edytora: edycja (wysokoformatowany Markdown), podgląd, tryb live (zależnie od wersji).
- Obsługa frontmatter (YAML) i metadanych.

## Podstawowe pojęcia
- Vault — katalog zawierający wszystkie pliki Markdown i zasoby powiązane.
- Note / Notatka — pojedynczy plik .md.
- Link wewnętrzny — [[Nazwa notatki]] tworzy połączenie i (opcjonalnie) plik docelowy.
- Backlinks — panel pokazujący odwołania do bieżącej notatki (incoming links).
- Transclusion / embed — wstawienie innej notatki lub fragmentu jako zawartości (np. ![[Plik#Nagłówek]]).
- Frontmatter — blok YAML na początku pliku z metadanymi.

## Edytor i tryby
- Edit mode — tryb edycji surowego Markdown.
- Preview mode — renderowany podgląd Markdown (callouts, tabele, formatowanie).
- Live preview (jeśli dostępny) — połączenie edycji i podglądu (edytujesz i widzisz render).
- Split panes — możliwość otwarcia wielu paneli (edytor + podgląd) i zmiany układu.

## Linkowanie, referencje i organizacja
- Tworzenie linków: [[Nazwa notatki]]; automatyczne uzupełnianie.
- Alias i nagłówki w linkach: [[Plik|Alias]] lub [[Plik#Nagłówek]].
- Backlinks: panel pokazuje wszystkie miejsca, gdzie dana notatka jest cytowana.
- Outgoing links: listuje linki wychodzące z notatki.
- Unlinked mentions: podpowiedzi miejsc, gdzie tekst pasuje do tytułu notatki bez linku.

## Graph View
- Widok sieciowy zależności notatek.
- Filtry (tagi, foldery, zakres czasowy) i opcje wyświetlania.
- Przydatny do eksploracji powiązań i znajdowania kontekstów.

## Wyszukiwanie i filtry
- Globalne wyszukiwanie full-text.
- Zaawansowane query z użyciem operatorów (AND, OR, -).
- Filtry kontekstowe w panelach i core-pluginach (np. Search, Quick Switcher).

## Core Plugins (przykładowe, funkcje core)
- Files & Links — obsługa plików, tworzenie linków.
- Graph View — wizualizacja powiązań.
- Backlinks — panel odwrotnych odwołań.
- Starred — zakładki notatek.
- Templates — wstawianie szablonów (w core lub jako plugin).
- Daily Notes / Periodic Notes — dzienne notatki (core albo community).
- Tags — panel tagów i przeszukiwanie wg tagów.
- Command Palette — szybkie wywoływanie poleceń.
- Hotkeys — przypisanie skrótów klawiaturowych.
(Uwaga: lista core pluginów może się zmieniać; powyżej najczęściej występujące.)

## Community Plugins (w skrócie)
- Rozszerzają funkcjonalność: Dataview, Kanban, Tasks, Templater, QuickAdd itd.
- Instalowane z Community Plugins w aplikacji.
- Mogą dodawać nowe panele, polecenia, formaty i integracje.

## Sync, Publish i Mobile
- Obsidian Sync — opcjonalna usługa synchronizacji (szyfrowana) między urządzeniami.
- Obsidian Publish — publikacja notatek jako stronę WWW (usługa płatna).
- Aplikacje mobilne — obsługują większość funkcji core; różnice w UI i ograniczeniach wtyczek.

## Integracje i automatyzacja
- Advanced URI — sterowanie przez URI (otwieranie notatek, tworzenie linków).
- Hotkeys/Workspaces — zapis układów paneli, przypisanie skrótów.
- QuickAdd / Templater — automatyzacja tworzenia notatek i wstawiania treści.
- Community scripts i API wtyczek — możliwość pisania własnych wtyczek (TypeScript API; tu tylko wzmianka).

## Format notatek i składnia
- Standardowy Markdown + rozszerzenia: internal links, callouts, task checkboxes, footnotes, tables.
- YAML frontmatter — metadane (np. date, tags, aliases).
- Task listy: `- [ ] Zadanie` i `- [x] Wykonane`.
- Code blocks — bloków kodu z określonym językiem (```js ... ```).

## Command Palette i skróty
- Command Palette (Ctrl/Cmd+P) — szybkie wyszukiwanie i uruchamianie poleceń.
- Quick Switcher (Ctrl/Cmd+O) — szybkie przełączanie między notatkami.
- Hotkeys w ustawieniach — przypiszienie akcji do klawiszy.
- Workspaces — przywracanie układu paneli.

## Najlepsze praktyki
- Organizuj vault folderami i konwencją nazewnictwa.
- Używaj linków i backlinków zamiast duplikowania treści.
- Wykorzystuj frontmatter do strukturyzacji danych (Dataview).
- Regularnie commituj/backupuj vault (Obsidian Git lub inne rozwiązanie).
- Testuj community plugins w osobnym vault przed produkcyjnym użyciem.

## Zasoby i dalsza lektura
- Oficjalna dokumentacja Obsidian: https://help.obsidian.md/  
- Repozytoria popularnych wtyczek (Dataview, Tasks, Templater, QuickAdd) — linki w dokumentacji projektu plugins.md  
- Społeczność: r/ObsidianMD, oficjalny Discord, GitHub Discussions


Uwagi:
- Ten dokument to autorski przegląd funkcji core Obsidian i praktycznych wskazówek; oficjalne szczegóły oraz aktualizacje znajdziesz pod linkiem do dokumentacji Obsidian (help.obsidian.md).
- Jeśli chcesz, mogę rozwinąć każdą sekcję (np. pełna lista core pluginów z opisami i ustawieniami) i wygenerować przykładowe konfiguracje dla twojego workflow.

## 📑 Index plików

- [installed_pluggins](installed_pluggins.md)

## 📁 Podfoldery

- [plugins/](plugins/plugins.md)

## 🔗 Backlinks

- [[EWW-MAP]]
- [[GRAPH-MAP]]
- [[GRAPH-CORE]]
- [[GRAPH-BUSINESS]]
- [[GRAPH-CONFIG]]

