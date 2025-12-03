---
modified: 2025-11-25
created: 2025-11-25
version: 0.0.6
title: Journal MVP — autostart notatek
description: Minimalny zestaw wymagań, żeby dziennik zawsze otwierał nowe wpisy przy starcie Obsidiana.
tags:
  - journal
  - mvp
---

# Journal MVP — szybkie cele

> [!goal] Goals
> 1. Każde uruchomienie Obsidiana 1.9 tworzy i otwiera notatkę `daily-YYYY-MM-DD.md` w `usr/karinam/journal/daily/`.
> 2. Notatka wyświetla nagłówek dnia w formacie `Czwartek 15.07.2024` (nazwa po polsku + data), generowany automatycznie z Templatera.
> 3. Codziennie powstający plik korzysta z układu jak w `usr/karinam/journal/template/daily-template-kanban-mockup.md`, dzięki czemu zawartość odpowiada ustalonemu mockupowi.

## Jak to osiągnąć (skrót)
1. W Obsidianie 1.9 włącz core-plugin **Daily Notes** (lub zamiennie **Periodic Notes**) i ustaw:
   - folder `usr/karinam/journal/daily`,
   - szablon `usr/karinam/journal/template/daily-template/daily-template.md` (folder szablonu zawiera też `daily-data/` dla danych dnia),
   - nazwę `daily-YYYY-MM-DD`,
   - opcję `Open/Create daily note on startup`.
2. Włącz **Templater**, wskaż folder `usr/karinam/journal/template` i zaznacz `Trigger Templater on new file creation`, żeby frontmatter z datą i godziną pojawiał się automatycznie.
3. (Opcjonalnie) upewnij się, że Tasks/Dataview i snippet `journal.css` są aktywne, ale MVP wymaga jedynie autostartu notatki z Templatera.

> [!done] Definition of Done
> - Po zamknięciu i ponownym otwarciu vaulta pojawia się nowy plik z aktualną datą.
> - Frontmatter (`date`, `day`, `pretty_date`, `start_time`, `tags`) wypełnia się Templaterem bez ręcznej edycji.
> - Dziennik jest gotowy do codziennego użycia od pierwszej sekundy po starcie Obsidiana.

## 🔗 Backlinks

- [[usr/karinam/journal/journal]]
- [[usr/karinam/karinam]]
- [[EWW-MAP]]
