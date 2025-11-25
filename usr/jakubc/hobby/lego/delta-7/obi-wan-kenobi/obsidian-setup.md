---
title: Obsidian – konfiguracja Delta-7 buildów
description: Spis kroków i snippetów potrzebnych, by `obi-wan-kenobi.md` działał poprawnie w Obsidianie.
type: documentation
status: draft
audience: contributors
language: pl
---

# Konfiguracja Obsidian dla Delta-7

Ta karta zbiera potrzebne wtyczki, snippet CSS i zasady struktury, dzięki którym `Obi-Wan's Jedi Starfighter` wyświetla się jak planowano.

## Wtyczki (Community + core)

1. **Dataview** – zainstaluj i włącz, a następnie w `Settings → Dataview`:
   - włącz `Enable JavaScript API`, aby `dataviewjs` mogły korzystać z `dv.container.innerHTML`.
   - potwierdź, że layout notatki nie ukrywa pluginów (blok `Obi-Wan Delta 7` musi mieć odgórny `dataviewjs`).
2. **Metadata Menu** – zdefiniuj nowe `field group` z nazwą `build` albo `delta-7` i dodaj pola: `type`, `status`, `parts`, `link`, `notes`, `includes`. Po zapisaniu w panelu edyta możesz klikać w listę buildów i zmieniać dane bez ręcznego edytowania YAML.
3. **Obsidian Style Settings** – dzięki niemu możesz zapisać palety i teksty (np. `status-strip.color-active`) oraz przekierować je na CSS snippet, gdybyś w przyszłości chciał rozbudować gradienty.
4. **Obsidian Kanban** – opcjonalnie, żeby przypisać bloki 1‑6 jako karty i śledzić ich status (`done` = zielony, `in progress` = żółty, `todo` = szary).
5. **Obsidian Projects** – do dashboardu całej sekcji Delta-7. Jeśli zrobisz `project` z typem `lego`, plugin automatycznie złapie notatki z `category: lego` i blocki `build`.

Wszystkie wtyczki instalujemy z `Settings → Community plugins`. Po każdej instalacji włącz przełącznik „Enable” i uruchom ponownie vault, jeśli pojawi się alert.

## LEGO snippet (status strip + build card)

1. Skopiuj `usr/jakubc/hobby/lego/snippets/lego-snippet.css` do katalogu vaulta, np. `~/.config/obsidian/<vault>/.obsidian/snippets/lego-snippet.css`.
2. W Obsidianie otwórz `Settings → Appearance → CSS snippets`, odnajdź `lego-snippet` i włącz go.
3. Snippet zestawia:
   - `.status-strip` z `display:inline-flex` i `gap:4px`, by timeline był rozkładem minifig buildów.
   - `.status-strip span` – kwadraty (14×14 px) z cieniem i obramowaniem w oficjalnych barwach LEGO: czerwony (#FF0000), żółty (#FFD700), niebieski (#0055A4) oraz zielony (#00933B).
   - `.build-card`, `.build-card__meta` i `.build-card__notes` — gradientowy panel, który sygnalizuje Block 1 jako „złotą” kartę, wykorzystując paletę LEGO (żółty gradient z niebieską ramką).
4. Używaj tego elementu w notatce (np. w `dataviewjs`) jako:
   ```md
   <span class="status-strip">
     <span class="active"></span>
     <span class="pending"></span>
     <span class="future"></span>
     <span class="future"></span>
     <span class="future"></span>
     <span class="goal"></span>
   </span>
   ```
   dzięki temu „Delta-7 build timeline” zaprezentuje Block 1‑6 w kolorach i odstępach opisanych wcześniej.

## Struktura danych buildów

- Dane do Visualizacji trzymamy w `usr/jakubc/hobby/lego/delta-7/obi-wan-kenobi/assets/*`. Każdy plik to osobny build (typ `build` w front matter).
- Pola wymagane przez `dataviewjs`: `build_id`, `title`, `date`, `duration_hours`, `cost`, `currency`, `shop`, `status`, `parts`, `base`, `notes`, `includes`, `link`.
- Pola pomocnicze: `project`, `category`, `tags` (pozostań przy tych nazwach, żeby inne widoki typu Delta-7 dashboard mogły cię automatycznie podpiąć).
- Aby dodać nowy build, skopiuj istniejący szablon, zaktualizuj status (np. `completed`, `pending`, `planned`) i uzupełnij `notes/includes` poprzez Metadata Menu.

## Weryfikacja w notatce

1. Po każdej zmianie w assetach otwórz `obi-wan-kenobi.md`, przewiń do sekcji `## Obi-Wan Delta 7` i upewnij się, że Dataview renderuje od nowa.
2. Jeśli pojawiają się surowe błędy (np. `dataviewjs` pokazuje wiersz z backtickami), sprawdź, czy w kodzie nie zostały przypadkowe ` ``` ` lub brakujący znak `${`.
3. Na potrzeby Kanbana/Projects utwórz osobne karty (`Block 1` itp.) i ustaw status `done`/`in progress`/`to do` zgodny ze snippetem.

 Dokumentacja w tym pliku powinna pomóc w powtarzalnym odtwarzaniu środowiska Obsidiana dla tego builda. Jeśli chcesz siedzieć w innym vault, skopiuj snippet i metadata menu tam, gdzie pracujesz.

## Zastosowanie LEGO snippetu w całym folderze

- W katalogu `usr/jakubc/hobby/lego/` każda notatka powinna mieć w front matter `obsidian_snippet: lego-snippet`. Możesz użyć skryptu na bazie `rg -l 'obsidian_snippet'` / `perl -0pi -e 's/obsidian_snippet: .*/obsidian_snippet: lego-snippet/'` (w razie potrzeby) albo edytować ręcznie najważniejsze pliki (Delta-7, eksponaty, bazy).
- Jeśli pracujesz w innych vaultach lub zakładkach, skopiuj `lego-snippet.css` do `.obsidian/snippets/lego-snippet.css`, potem otwórz `Settings → Appearance → CSS snippets` i włącz `lego-snippet`. To aktywuje paletę LEGO dla wszystkich notatek z odpowiednim front matterem.
- Przygotuj plik `usr/jakubc/hobby/lego/snippets/README.md` (opcjonalnie) z linkiem do `lego-snippet` i krótkim opisem, żeby inni użytkownicy wiedzieli, że całe LEGO repo korzysta z tej stylizacji.
