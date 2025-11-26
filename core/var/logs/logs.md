---
tags:
  - #folder_note
  - #automation
  - #development
  - #eww
  - #knowledge
  - #linux
  - #productivity
  - #secondbrain
created: 2025-11-21T20:00:00Z
modified: 2025-11-21T20:00:00Z
author: jakubc
title: "🗄️ logs — katalog dzienników"






owner: jakubc
---

# 🗄️ logs — katalog dzienników

> [!INFO] Retencja
> Folder domyślnie pozostaje pusty; `.gitignore` pilnuje, żeby wygenerowane logi nie trafiały do repo. Utrzymujemy tylko strukturę.

## 🧭 Zakres folderu
- Przechowywanie logów lokalnych (np. `logs/eww-sync-<data>.log`).
- Buforowanie raportów stanu (wykorzystywane przez `systemd`/`scripts`).

## 🗂️ Zawartość

| Typ  | Nazwa | Opis |
| ---- | ----- | ---- |
| Plik | `.gitignore` | Ignoruje wszystkie dynamicznie tworzone logi zachowując katalog w repo. |

## ⚙️ Kluczowe funkcje
1. **Bezpieczne logowanie** – skrypty mogą pisać do `logs/` bez ryzyka przypadkowego commitu.
2. **Łatwe sprzątanie** – logi są odseparowane, można je hurtowo usuwać lub kopiować do `archive/`.
3. **Integracja z `var/`** – folder współpracuje z `var/logs/` w środowisku runtime.

## 🔁 Backlinki
- [INDEX.md](../INDEX.md)
- [FULL-INDEX.md](../FULL-INDEX.md)
- [README.md](../README.md)
- [eww.md](../eww.md)
- [var/var.md](../var/var.md)

## 📚 Źródła
- [AGENTS.md](../AGENTS.md)
- [README.md](../README.md)



## 🔗 Powiązane dokumenty

- [[logs/logs|logs]]
- [[docs/INDEX|INDEX]]

**Auto-linked:** 2025-11-21

## 📑 Index plików

*Brak plików markdown.*

## 📁 Podfoldery

*Brak podfolderów.*

## 🔗 Backlinks

- [[EWW-MAP]]
- [[GRAPH-MAP]]
- [[GRAPH-CORE]]
- [[GRAPH-BUSINESS]]
- [[GRAPH-CONFIG]]

