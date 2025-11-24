---
tags:
  - #folder_note
  - #automation
  - #development
  - #eww
  - #infrastructure
  - #knowledge
  - #linux
  - #secondbrain
created: 
modified: 
author: jakubc
title: "🧠 core — serce repozytorium"






owner: jakubc
---


# 🧠 core — serce repozytorium

> [!IMPORTANT] Zależności
> Folder `core/` przechowuje polityki, definicje SOP i szablony wymagane przez zespoły. Zmiany tutaj wpływają na wszystkie pozostałe moduły, więc przed refaktorem należy sprawdzić `requirements.md` oraz powiązane projekty.

## 🧭 Zakres folderu
- Walidacja środowiska (`eww-check.sh`, `Makefile`).
- Standardy operacyjne i polityki (`SOP/`, `POLICIES/`).
- Szablony (m.in. `TEMPLATES/`, `installers/`).
- Konfiguracje CI/CD (`.forgejo/`), repo narzędziowe (`.git/` submodule).

## 🗂️ Zawartość

| Typ  | Nazwa | Opis |
| ---- | ----- | ---- |
| Skrypt | `eww-check.sh` | Diagnostyka środowiska i podstawowych zmiennych `.env`. |
| Folder | `.forgejo/` | Konfiguracje pipeline (workflows dla Forgejo/Gitea). |
| Folder | `.git/` | Wbudowany submodule (materiały core importowane do innych repo). |
| Plik | `.gitignore` | Specjalne ignorowanie plików wygenerowanych przez core. |
| Folder | `installers/` | Szablony instalacyjne (np. generatory `.deb` / bootstrap script). |
| Plik | `Makefile` | Zadania dedykowane core, niezależne od głównego `Makefile` repo. |
| Folder | `POLICIES/` | Sformalizowane polityki bezpieczeństwa/procesowe. |
| Plik | `requirements.md` | Wymagania sprzętowe i procesowe dla korzystania z core. |
| Folder | `SOP/` | Standard Operating Procedures. |
| Folder | `TEMPLATES/` | Uniwersalne szablony (systemd, docs, runbooki). |

## ⚙️ Kluczowe funkcje
1. **Definiowanie standardów** – folder jest źródłem prawdy dla polityk i SOP.
2. **Wsparcie instalatorów** – `installers/` oraz `eww-check.sh` zapewniają spójne onboarding środowisk.
3. **Automatyzacja CI/CD** – `.forgejo/` i `Makefile` umożliwiają uruchamianie pipeline'ów bezpośrednio z repo.

## 🔁 Backlinki
- [INDEX.md](../INDEX.md)
- [FULL-INDEX.md](../FULL-INDEX.md)
- [README.md](../README.md)
- [eww.md](../eww.md)
- [docs/index.md](../docs/index.md)

## 📚 Źródła
- [AGENTS.md](../AGENTS.md)
- [core/requirements.md](requirements.md)
- [core/TEMPLATES/TEMPLATES.md](TEMPLATES/TEMPLATES.md)
- [README.md](../README.md)

## 📑 Index plików

- [requirements](requirements.md)

## 📁 Podfoldery

- [installers/](installers/installers.md)
- [POLICIES/](POLICIES/POLICIES.md)
- [SOP/](SOP/SOP.md)
- [TEMPLATES/](TEMPLATES/TEMPLATES.md)

## 🔗 Backlinks

- [[EWW-MAP]]
- [[GRAPH-MAP]]
- [[GRAPH-CORE]]
- [[GRAPH-BUSINESS]]
- [[GRAPH-CONFIG]]

