---
title: "📁 Root Index — Przewodnik katalogu głównego"
description: "Profesjonalny spis zawartości katalogu głównego repozytorium E-Waste Workshop."
type: index
category: documentation
filepath: INDEX.md
color: green
author: "Jakub C. (Nairecth)"
created: 2025-11-21
updated: 2025-11-21
version: 1.0.0
language: pl
status: active
tags:
  - index
  - "[#1E88E5]index"
  - "[#43A047]root"
  - "[#8E24AA]docs"
  - "[#F4511E]structure"
  - "[#0079C1]kubuntu"
  - documentation
  - docs
  - knowledge
icon:
  set: lucide
  name: layout-grid
  color: "#1E88E5"
  emoji: "📁"

related:
  - docs/wiki/kubuntu.md
  - docs/ROOT-MINIMIZATION.md
  - docs/OBSIDIAN-SETUP.md
  - docs/ROOT-STRUCTURE.md
  - docs/placeholders/placeholders.md
sources:
  - path: "README.md"
    title: "README"
  - path: "docs/assets/icons.md"
    title: "ICON-SET"
backlinks:
  - path: "README.md"
    title: "README"
---

# 📁 Root Index — orientacja w katalogu głównym

> [!NOTE] Ikony i kolory
> Wszystkie odwołania do ikon Kubuntu/Code/Obsidian wykorzystują standard opisany w [docs/assets/icons.md](docs/assets/icons.md).

## 🗂️ Katalogi nadrzędne

| Folder | Folder note | Zakres |
| --- | --- | --- |
| `archive/` | [archive/archive.md](archive/archive.md) | Puste jeszcze archiwum na logi i wycofane pliki. |
| `bin/` | [bin/bin.md](bin/bin.md) | Skrypty CLI używane bezpośrednio przez użytkowników. |
| `business/` | [business/business.md](business/business.md) | Dokumentacja biznesowa (finanse, sprzedaż, operacje). |
| `config/` | [config/config.md](config/config.md) | Fragmenty konfiguracji bash/git/hooków. |
| `core/` | [core/core.md](core/core.md) | Rdzeń polityk, SOP oraz narzędzi kontroli. |
| `dev/` | [dev/dev.md](dev/dev.md) | Warsztat deweloperski, projekty PoC, playbooki. |
| `docs/` | [docs/docs.md](docs/docs.md) | Centralna dokumentacja projektu. |
| `GOVERNANCE/` | [GOVERNANCE/GOVERNANCE.md](GOVERNANCE/GOVERNANCE.md) | Kontrakty i zasady prowadzenia repo. |
| `hooks/` | [hooks/hooks.md](hooks/hooks.md) | Lokalnie instalowane hooki Git. |
| `infra/` | [infra/infra.md](infra/infra.md) | Automaty infrastrukturalne (Ansible, inventory). |
| `keys/` | [keys/keys.md](keys/keys.md) | Publiczne klucze GPG używane w repo. |
| `lib/` | [lib/lib.md](lib/lib.md) | Biblioteki Bash współdzielone między skryptami. |
| `logs/` | [logs/logs.md](logs/logs.md) | Bufor na logi runtime (ignorowane w Git). |
| `projects/` | [projects/projects.md](projects/projects.md) | Aktywne inicjatywy produktowe i init. |
| `scripts/` | [scripts/scripts.md](scripts/scripts.md) | Automaty i narzędzia wsadowe. |
| `site/` | [site/site.md](site/site.md) | Kod strony statycznej (assets, wiki). |
| `systemd/` | [systemd/systemd.md](systemd/systemd.md) | Jednostki systemd --user powiązane z repo. |
| `Tags/` | [Tags/Tags.md](Tags/Tags.md) | Rezerwacja pod taksonomię Obsidian. |
| `tests/` | [tests/tests.md](tests/tests.md) | Testy BATS walidujące init i narzędzia. |
| `tools/` | [tools/tools.md](tools/tools.md) | Skrypty analityczne i metryki repo. |
| `usr/` | [usr/usr.md](usr/usr.md) | Przestrzenie użytkowników (jakubc, karinam). |
| `var/` | [var/var.md](var/var.md) | Dane zmienne (heartbeat, statusy). |

## 📄 Dokumenty w katalogu głównym

- [README.md](README.md) — główne wprowadzenie do projektu.
- [CHANGELOG.md](CHANGELOG.md) — historia wersji (Keep a Changelog).
- [FRONTMATTER_REPORT.md](FRONTMATTER_REPORT.md) — status automatu front matter.
- [VERSION](VERSION) — aktualny numer wersji (`x.y.z`).
- [Makefile](Makefile) — codzienne zadania (TODO, sync, migracje).
- [init-eww.sh](init-eww.sh) — podstawowy skrypt inicjalizacyjny.

## 🔗 Przydatne skróty

- [docs/assets/icons.md](docs/assets/icons.md) — standard ikon Kubuntu/Code/Obsidian.
- [docs/wiki/kubuntu.md](docs/wiki/kubuntu.md) — przewodnik systemowy (`🟦 Kubuntu`).
- [docs/software/code/code.md](docs/software/code/code.md) — konfiguracja `🧰 VS Code`.
- [docs/software/obsidian/obsidian.md](docs/software/obsidian/obsidian.md) — notatki `💠 Obsidian`.

## ✅ Jak korzystać?

> [!TIP]
> Każdy wiersz w tabeli prowadzi do folder note'u opisującego zawartość katalogu. Dzięki temu można szybko znaleźć właściwy zakres bez ręcznego przeklikiwania struktury.

