# `yaml_example.yaml` · Przewodnik linia po linii

Ten dokument objaśnia referencyjny szablon YAML dla kart zadań na Kubuntu 25.04. Każda sekcja nawiązuje do odpowiednich fragmentów pliku `yaml_example.yaml`.

## 1. Nagłówek (linie 1–9)

- Komentarze wprowadzają nazwę szablonu i tłumaczą, co zawiera każdy główny blok (`document`, `environment`, `structure`, `tasks`, `references`, `guidance`).
- Dzięki temu plik YAML jest samodokumentujący się bez potrzeby dodatkowych notatek.

## 2. `document` (linie 11–24)

- Trzyma identyfikator karty (`TODO-2025-11-22`), tytuł, opis i właściciela.
- `created_at`/`updated_at` używają ISO 8601 z offsetem `+00:00`, zgodnie ze stylem Kubuntu.
- `classification`, `priority`, `workflow_state` oraz lista tagów odpowiadają wartościom w frontmatterze Markdown.

## 3. `environment` (linie 26–31)

- Zawiera statyczne informacje o platformie (`kubuntu-25.04`, `plasma-6.4`), ścieżce repo i charakterystyce pliku (UTF‑8, zakończenia UNIX).
- Ma służyć jako kontekst przy tworzeniu nowych kart lub debugowaniu integracji.

## 4. `structure` (linie 33–55)

- `frontmatter` opisuje, które pola muszą istnieć w dokumencie Markdown (`status`, `priority`, `task_card`).
- `sections` wymienia wszystkie nagłówki, co upraszcza przygotowanie widoków VS Code/Obsidian.
- `admonitions` i `embedded_queries` dokumentują standardowe bloki (info/tip, zapytanie Dataview).

## 5. `tasks` (linie 56–65)

- `priority_buckets` grupują zadania według priorytetu; tylko kubełek P1 ma element (`[[TODO-gerc-boot]]`).
- `in_progress` i `completed` pomagają synchronizować statusy między YAML-em, Markdownem i `tasks.json`.

## 6. `references` (linie 67–73)

- Lista wikilinków utrzymywana ręcznie, by wiedzieć, które notatki zależą od tej karty.
- Flaga `backlinks_section: enabled` przypomina, że w Markdownie znajduje się sekcja z automatycznymi backlinkami.

## 7. `guidance` (linie 75–81)

- `open_questions`, `decisions` i `follow_up_actions` pełnią rolę meta-dziennika: zapisują wątpliwości, ustalenia i kolejne kroki.
- Przykład: decyzja o trzymaniu frontmattera w ISO ze względów systemowych oraz zadanie wdrożenia szablonu w VS Code.

---

**Użycie**  
1. Otwórz `yaml_example.yaml` jako bazę dla nowej karty zadania.  
2. W `yaml_example.md` sprawdź opis sekcji, jeśli potrzebujesz przypomnienia, co wypełniać.  
3. Skopiuj relevantne pola do docelowej notatki i dostosuj wartości, zachowując strukturę.  
