---
version: 0.0.1
tags:
  - #automation
  - #development
  - #eww
  - #jakubc
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-12-01
modified: 2025-12-01
author: jakubc
title: "Makefile - notatki"





owner: jakubc
---

# Makefile - notatki

> [!abstract]+ 🌈 Po co (styl)
> - 🎯 Opisuje cele i zależności dla `make`.
> - ⚡ Przyspiesza powtarzalne zadania (build, test, release).
> - 🧩 Łączy różne narzędzia w jednym pliku (kompilacja, docker, docs).

> [!info]+ 🎨 Ikony i kolory
> - 🎯 cel / wynik
> - ⚡ szybkie wykonanie
> - 🧱 zależności
> - 🧭 nawigacja / porządek
> - 🧪 testy / dry run

## Czym jest Makefile?
- 📜 Plik konfiguracyjny dla `make` opisujący cele (targety) i ich zależności.
- 🧱 Pozwala uruchamiać tylko to, co trzeba (np. przebudować jeden moduł zamiast całego projektu).
- 🧩 Działa jak mini-system tasków: cele mogą wywoływać skrypty i inne cele.
- 🎯 Typowe zastosowania: kompilacja, testy, generowanie dokumentacji, pakowanie artefaktów, porządkowanie repo.

## Po co mi to?
- Żeby jednym słowem odpalać długie komendy (np. `make lint` zamiast całej linii z flaga-mi).
- Żeby każdy w zespole miał ten sam zestaw kroków (help, build, test, release) bez szukania w README.
- Żeby zmniejszyć liczbę błędów: `make` pilnuje zależności i nie robi niepotrzebnych kroków.
- Żeby łatwo dodać nowe automaty: dopisujesz cel i od razu masz go w workflow.

## Struktura i podstawy
- 🧱 Cel z zależnościami: `cel: zależność1 zależność2`.
- ⚡ Komendy pod celem muszą mieć TAB (nie spacje).
- 🎯 Deklaruj `.PHONY: cel1 cel2` dla celów nie tworzących plików.
- 🧭 Używaj zmiennych do powtórzeń (`CC := gcc`, `CFLAGS := -Wall`).

## Wzorce przydatne w EWW
- 🎯 Lista komend: `make help`.
- 🔍 Spójność wersji: `make check-versions`.
- 🔄 Podbicie wersji: `make bump-version BUMP=X.Y.Z` (potem tag `vX.Y.Z`).
- 🛠️ Szablon CI: `lint:` / `test:` / `build:` w zależności od projektu.

## Porady i debug
- ⚙️ Ustaw `SHELL := /bin/bash` gdy potrzebujesz funkcji Bashe.
- 🧪 Używaj `make -n` (dry run) i `@echo` do wglądu w polecenia.
- 🧭 Grupuj zmienne u góry, cele w sekcjach tematycznych.

## 🔗 Backlinks

- [[usr/jakubc/study/study]]
- [[usr/jakubc/jakubc]]
- [[EWW-MAP]]