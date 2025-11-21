---
title: "🧰 Visual Studio Code — standard pracy"
description: "Wytyczne konfiguracji VS Code, rozszerzeń i workflow dla projektu EWW."
type: file
category: docs
filepath: docs/software/code/code.md
color: green
author: "Jakub C. (Nairecth)"
owner: jakubc
created: 2025-11-21
updated: 2025-11-21
version: 1.1.0
language: pl
status: active
priority: normal
license: MIT
tags:
  - "[#007ACC]code"
  - "[#1E88E5]ide"
  - "[#43A047]workflow"
  - "[#8E24AA]docs"
  - documentation
  - docs
  - knowledge
keywords:
  - visual-studio-code
  - ide
  - vscode
icon:
  set: simple-icons
  name: visualstudiocode
  color: "#007ACC"
  emoji: "🧰"
aliases: []
related:
  - docs/FULL-INDEX.md
  - ../../wiki/kubuntu.md
  - ../obsidian/obsidian.md
dependencies: []
sources:
  - path: "../../assets/icons.md"
    title: "ICON-SET"
  - path: "../../../README.md"
    title: "Repo README"
  - path: "../../README.md"
    title: "Docs README"
backlinks:
  - path: "../obsidian/obsidian.md"
    title: "Obsidian guide"
  - path: "../../wiki/kubuntu.md"
    title: "Kubuntu wiki"
context: "E-Waste Workshop — Bash toolkit dla środowiska Kubuntu"
project: eww
repository: https://github.com/Kari-Tori/eww-1
---


# 🧰 Visual Studio Code — ikona i styl

> [!NOTE] Standard ikony
> Zastosowano `simple-icons/visualstudiocode` (kolor `#007ACC`) zgodnie z [docs/assets/icons.md](../../assets/icons.md).

> [!TIP] Automatyczna instalacja rozszerzeń
> Uruchom `scripts/install-ai-toolkit.sh vscode`, aby zainstalować rekomendowane rozszerzenia AI/Git/Docs w VS Code (skrypt instaluje również Copilota, Continue i narzędzia lintujące).

Cel
- Zdefiniować szybkie wytyczne dla kodu przechowywanego w katalogu docs/software/code.
- Wskazać rekomendowane narzędzia, linting, formatowanie i workflow.

Podstawowe założenia
- Język dokumentacji i komentarzy: polski.
- Stosuj konwencje projektowe z AGENTS.md i .github/copilot-instructions.md.
- Zachowuj czytelność, testowalność i idempotentność skryptów.

Rekomendowane narzędzia
- Lintery:
  - Bash: shellcheck
  - POSIX / sh: shellcheck --shell=sh
- Formatowanie:
  - shfmt dla skryptów Bash
- Testy:
  - BATS dla skryptów Bash (tests/*.bats)
- CI:
  - GitHub Actions: uruchamiaj shellcheck, shfmt --check, bats
- Pre-commit:
  - instalacja hooków (pre-commit lub custom scripts) uruchamiających shellcheck i shfmt

Konwencje kodu (skrót)
- Shebang: #!/usr/bin/env bash
- set -euo pipefail w każdym skrypcie
- Wszystkie zmienne cytowane: "$zmienna"
- Lokalne zmienne: local nazwa
- Globalne stałe: EWW_NAZWA_STALEJ (UPPER_SNAKE)
- Nazwy funkcji: eww::nazwa_funkcji lub nazwa_funkcji (snake_case)
- Komentarze i komunikaty: po polsku

Struktura repo (przypomnienie)
- bin/ — skrypty wykonywalne
- lib/ — biblioteki pomocnicze
- scripts/ — skrypty pomocnicze
- tests/ — testy BATS

Przykładowy pipeline (GitHub Actions)
- checkout
- uruchom shellcheck dla .sh
- uruchom shfmt --check
- uruchom bats tests/

Snippet — minimalny skrypt zgodny ze standardem
```bash
#!/usr/bin/env bash
# filepath: /home/karinam/git/eww/bin/eww-przyklad
# Krótki opis: przykład zgodnego skryptu
set -euo pipefail

log_info() { printf '[EWW] %s\n' "$1"; }

main() {
  log_info "Uruchomiono skrypt przykładowy"
}

main "$@"
```

Gdzie szukać więcej
- AGENTS.md — kontekst dla AI i konwencje projektu
- .github/copilot-instructions.md — zasady dotyczące generowania kodu przez Copilot/AI
- docs/software/obsidian/plugins.md oraz docs/software/code/plugins/ — przykłady integracji i konfiguracji

Uwagi końcowe
- Ten plik jest syntetycznym przewodnikiem; szczegóły techniczne i pełne konfiguracje (workflow, hooki) umieszczaj w katalogu .github/ i docs/ zgodnie z potrzebą.
