---
tags:
  - #automation
  - #development
  - #docs
  - #eww
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T18:00:00Z
modified: 2025-11-21T18:00:00Z
author: jakubc
title: "README — lista kontrolna przed wydaniem (do użycia w Obsidian)"






owner: jakubc
---



# README — lista kontrolna przed wydaniem (do użycia w Obsidian)

- [ ] Wersja w `VERSION` jest aktualna i spójna z `README` (linia `Wersja:`)
- [ ] Sekcja `Quick start` zawiera 1-liniowy przykład pobrania i sourcowania `projects/init/init-eww.sh`
- [ ] Sekcja `Funkcje i lista weryfikacji` zawiera checklistę funkcji i poleceń do testów manualnych
- [ ] Dokument wydania `docs/release-0.0.0.1.md` istnieje i opisuje MVP
- [ ] `CHANGELOG.md` zawiera wpis dla 0.0.0.1 (MVP)
- [ ] `scripts/check_readme.sh` wykonuje się bez błędów (uruchom: `./scripts/check_readme.sh`)
- [ ] README zawiera krótkie informacje o logowaniu i zmiennych (`EWW_ROOT`, `EWW_LOG_FILE`, `EWW_NO_LOG`)
- [ ] README jest krótki i czytelny — przenieść dłuższe instrukcje do `docs/`
- [ ] Zaktualizować kontakt/autora w README jeśli wymagane

## Obsidian: jak oznaczać starsze wersje jako "szare"

W Obsidianie prosty sposób to dodać tag `#archived` (lub `#old`) do notatek/plików, które chcesz zszarzyć.

1. W pliku notatki (np. `docs/release-0.0.0.1.md`) dodaj tag `#archived` na górze lub w treści.
2. Stwórz CSS snippet w `.obsidian/snippets/archived-grey.css` (przykład poniżej) i włącz go w Settings → Appearance → CSS snippets.

Przykładowy snippet (może wymagać nowszej wersji Obsidian):

```css
/* archived-grey.css — przyciemnia notatki zawierające tag #archived w widoku podglądu */
.markdown-preview-view:has(.tag[href="#archived"]) {
  opacity: 0.5;
}
```

Jeśli Twój Obsidian nie obsługuje `:has()`, użyj tagu i wyszukaj `tag:#archived` w panelu wyszukiwania, lub ręcznie dodaj `#archived` do linków, które chcesz ukryć.


Zaznacz elementy checklisty w Obsidianie, gdy będą potwierdzone.
