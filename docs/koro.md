# KoroFileHeader -> YAML frontmatter

Skrypt scripts/koro-to-frontmatter.sh konwertuje nagłówek KoroFileHeader (HTML comment na początku pliku)
na frontmatter YAML używany w notatkach (np. Obsidian).

Jak użyć:
- Nadaj skryptowi prawa wykonywania: chmod +x scripts/koro-to-frontmatter.sh
- Uruchom: ./scripts/koro-to-frontmatter.sh ścieżka/do/pliku.md

Zachowanie:
- Skrypt nie nadpisze pliku, jeśli już zaczyna się od `---` (frontmatter YAML).
- Wyciąga pola: @Author, @Date, @LastEditTime, @LastEditors, @FilePath, @Description
  i tworzy z nich blok YAML.
- Usuwa pierwszy blok HTML-komentarza z pliku i wstawia wygenerowany frontmatter.

Przykład:
  ./scripts/koro-to-frontmatter.sh usr/karinam/journal/template/daily-template-kanban-mockup.md

Uwaga:
- Wszystkie komunikaty po polsku.
- Skrypt jest prosty — możesz dodać mapowanie formatów dat lub integrację z Makefile.
