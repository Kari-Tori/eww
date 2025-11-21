---
title: "🗄️ logs — Artefakty dzienników"
description: "Miejsce na logi i raporty runtime generowane przez skrypty EWW."
color: brown
author: "Jakub C. (Nairecth)"
created: 2025-11-21
updated: 2025-11-21
version: 0.1.0
status: "aktywny"
tags:
  - "[#FFB300]folder-note"
  - "[#546E7A]observability"
  - "[#00897B]ops"
  - "[#F4511E]automation"
  - data
  - runtime
sources:
  - path: "../README.md"
    title: "Repo README"
  - path: "../AGENTS.md"
    title: "AGENTS"
backlinks:
  - path: "../INDEX.md"
    title: "Główny indeks"
  - path: "../FULL-INDEX.md"
    title: "Full Index"
  - path: "../eww.md"
    title: "Opis repo"
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

---
**Auto-linked:** 2025-11-21
