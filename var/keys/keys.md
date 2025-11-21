---
title: "🔐 keys — Klucze kryptograficzne"
description: "Repozytorium publicznych kluczy GPG wykorzystywanych przy podpisywaniu commitów/artefaktów."
color: brown
author: "Jakub C. (Nairecth)"
created: 2025-11-21
updated: 2025-11-21
version: 0.1.0
status: "aktywny"
tags:
  - "[#FFB300]folder-note"
  - "[#3949AB]security"
  - "[#00897B]gpg"
  - "[#E53935]compliance"
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

# 🔐 keys — klucze publiczne

> [!TIP] Aktualizacja kluczy
> Nowe klucze należy dodawać w formacie ASCII-armor (`.asc`). Nazwa pliku powinna wskazywać fingerprint (`pubkey-<FPR>.asc`). W ten sposób można szybko zidentyfikować podpisy commitów.

## 🧭 Zakres folderu
- Przechowywanie kluczy publicznych GPG.
- Materiały referencyjne do konfiguracji `gitconfig.repo`.

## 🗂️ Zawartość

| Typ  | Nazwa | Opis |
| ---- | ----- | ---- |
| Plik | `pubkey-64350F8E46AB5B48.asc` | Klucz publiczny wykorzystywany do podpisywania commitów repo EWW. |

## ⚙️ Kluczowe funkcje
1. **Weryfikacja podpisów** – każdy może pobrać klucz i sprawdzić integralność commitów.
2. **Dokumentacja bezpieczeństwa** – folder łączy się z `config/gitconfig.repo`.
3. **Przygotowanie audytów** – szybkie udostępnienie kluczy dla partnerów/współpracowników.

## 🔁 Backlinki
- [INDEX.md](../INDEX.md)
- [FULL-INDEX.md](../FULL-INDEX.md)
- [README.md](../README.md)
- [eww.md](../eww.md)
- [config/config.md](../config/config.md)

## 📚 Źródła
- [AGENTS.md](../AGENTS.md)
- [README.md](../README.md)
- [config/gitconfig.repo](../config/gitconfig.repo)

