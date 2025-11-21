---
title: "🎨 ICON-SET — Standard Kubuntu/Code/Obsidian"
description: "Zbiór referencyjnych ikon i kolorów wykorzystywanych w dokumentacji projektowej."
type: file
category: docs
filepath: docs/assets/icons.md
color: green
author: "Jakub C. (Nairecth)"
owner: jakubc
created: 2025-11-21
updated: 2025-11-21
version: 1.0.0
language: pl
status: active
priority: normal
license: MIT
tags:
  - "[#FFB300]style-guide"
  - "[#1E88E5]icons"
  - "[#8E24AA]brand"
  - "[#43A047]docs"
  - documentation
  - docs
  - knowledge
keywords:
  - icons
  - kubuntu
  - obsidian
  - vscode
icon:
  set: lucide
  name: palette
  color: "#FFB300"
  emoji: "🎨"
aliases: []
related:
  - ../README.md
  - ../wiki/kubuntu.md
  - ../software/code/code.md
  - ../software/obsidian/obsidian.md
dependencies: []
sources:
  - path: "../README.md"
    title: "Docs README"
  - path: "../../README.md"
    title: "Repo README"
  - path: "../../AGENTS.md"
    title: "AGENTS"
backlinks:
  - path: "../wiki/kubuntu.md"
    title: "Kubuntu wiki"
  - path: "../software/code/code.md"
    title: "VS Code guide"
  - path: "../software/obsidian/obsidian.md"
    title: "Obsidian guide"
context: "E-Waste Workshop — Bash toolkit dla środowiska Kubuntu"
project: eww
repository: https://github.com/Kari-Tori/eww-1
---


# 🎨 Standard ikon Kubuntu / Code / Obsidian

> [!NOTE] Cel dokumentu
> Ujednolicamy ikonografię dla najczęściej używanych narzędzi środowiska (system Kubuntu, edytor Visual Studio Code oraz Obsidian). Dzięki temu kolejne dokumenty korzystają z tych samych kolorów, emoji i identyfikatorów.

## 🟦 Kubuntu

| Element         | Wartość                                                     |
| -------------- | ----------------------------------------------------------- |
| **Emoji**      | `🟦`                                                        |
| **Zestaw**     | `simple-icons`                                              |
| **Nazwa**      | `kubuntu`                                                   |
| **Kolor HEX**  | `#0079C1`                                                   |
| **Zastosowanie** | Materiały nt. systemu/instalacji Kubuntu (wiki, guide, infra). |

> [!TIP] Wskazówka
> Używaj nagłówków w formie `🟦 Kubuntu — ...` i kolorowanych tagów `[#0079C1]kubuntu`.

## 🧰 Visual Studio Code

| Element         | Wartość                                                     |
| -------------- | ----------------------------------------------------------- |
| **Emoji**      | `🧰`                                                        |
| **Zestaw**     | `simple-icons`                                              |
| **Nazwa**      | `visualstudiocode`                                          |
| **Kolor HEX**  | `#007ACC`                                                   |
| **Zastosowanie** | Dokumenty opisujące VS Code, rozszerzenia i konfiguracje. |

> [!NOTE] Format
> Dla tagów stosuj zapis `[#007ACC]code` lub `[#007ACC]vscode`.

## 💠 Obsidian

| Element         | Wartość                                                     |
| -------------- | ----------------------------------------------------------- |
| **Emoji**      | `💠`                                                        |
| **Zestaw**     | `simple-icons`                                              |
| **Nazwa**      | `obsidian`                                                  |
| **Kolor HEX**  | `#4C2A85`                                                   |
| **Zastosowanie** | Wszystkie przewodniki dotyczące Obsidian (pluginy, vault). |

> [!IMPORTANT] Wdrażanie
> W sekcjach front matter dodaj blok `icon:` z polami `name`, `set`, `color`, `emoji` i dopisz źródło do niniejszego dokumentu.

## 🔁 Aktualizacje
- Dodanie nowego narzędzia do zestawu wymaga rozszerzenia tabeli powyżej i aktualizacji dokumentów korzystających z danej ikony.
- Kolory bazują na oficjalnych barwach marek (Simple Icons).
