---
version: 0.0.1
title: "README"
created: 2025-11-25
modified: 2025-11-25
tags:
  - auto-versioned
---

# LEGO snippet

Ten folder przechowuje `lego-snippet.css` – wspólną stylizację status stripu i kart buildu dla całego katalogu `hobby/lego`.

Jak używać:

1. Skopiuj `lego-snippet.css` do swojego vaulta (`~/.config/obsidian/<vault>/.obsidian/snippets/lego-snippet.css`).
2. W Obsidianie otwórz `Settings → Appearance → CSS snippets`, znajdź `lego-snippet` i włącz go.
3. Każdy dokument w `usr/jakubc/hobby/lego/` powinien mieć `obsidian_snippet: lego-snippet` we front matter, żeby automatycznie ładować paletę LEGO (#FF0000, #FFD700, #0055A4, #00933B) oraz stylizowaną kartę buildu.
4. Jeśli chcesz rozszerzyć snippet, edytuj `lego-snippet.css` tutaj i ponownie skopiuj/odśwież w vaultach.

Zachowując plik we wspólnym folderze łatwo zachować spójność stylu dla kolejnych buildów w tej sekcji.

## 🔗 Backlinks

- [[usr/jakubc/hobby/lego/snippets/snippets]]
- [[usr/jakubc/jakubc]]
- [[EWW-MAP]]