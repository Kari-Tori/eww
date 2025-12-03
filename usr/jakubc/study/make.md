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
title: "make - narzędzie budujące"





owner: jakubc
---

# make - narzędzie budujące

> [!abstract]+ 🌈 Po co (styl)
> - ⚡ Automatyzuje sekwencje z `Makefile`.
> - 🎯 Uruchamia tylko potrzebne kroki (zależności + czasy modyfikacji).
> - 🧩 Neutralne technologicznie: komendy to zwykłe polecenia shellowe.
> - 🖍️ Ikony: ⚡ szybkie, 🎯 cel, 🧭 nawigacja, 🧩 integracja.

> [!info]+ 🎨 Legenda bloków i kolorów
> - ⚡ szybkie uruchomienie / energia
> - 🧭 nawigacja / katalogi
> - 🧪 testowanie / dry run
> - 🛠️ budowanie / kompilacja
> - 🧱 zależności / kolejność

## Czym jest `make`?
- Program wykonujący cele (targety) zdefiniowane w `Makefile` lub plikach `*.mk`.
- Analizuje zależności między plikami i celami, by uruchomić minimalny zestaw komend.
- Używa zmiennych automatycznych (`$@`, `$<`, `$^`) ułatwiających pisanie reguł.
- Może kompilować C, budować obrazy Dockera, generować dokumentację i więcej.

## Po co mi to?
- Do uruchamiania powtarzalnych zadań jednym poleceniem (`make test`, `make build`).
- Do sklejania różnych narzędzi w jeden spójny workflow (np. lint → test → release).
- Do szybkiego onboardingu: nowe osoby robią `make help` i wiedzą, jakie kroki są dostępne.
- Do skrócenia komend: zamiast długich skryptów shellowych masz krótkie cele w jednym miejscu.

## Kluczowe opcje
- ⚡ `make` – wykonuje pierwszy cel z `Makefile`.
- 🎯 `make <cel>` – uruchamia wskazany cel, np. `make test`.
- 🧪 `make -n <cel>` – dry run, pokazuje komendy bez ich wykonania.
- 🛠️ `make -j <N>` – równoległe wykonywanie celów (np. `make -j4`).
- 🧭 `make -C <dir>` – uruchamia `make` w innym katalogu.
- 🚧 `make -k` – kontynuuje mimo błędów, by zebrać więcej informacji.

## Podstawy korzystania
- 🧭 Najpierw sprawdź dostępne cele: wiele projektów ma `make help`.
- 🧱 Dodawaj `.PHONY` dla celów nie generujących plików (brak kolizji z artefaktami).
- ⚙️ Ustal zmienne konfiguracyjne na górze (np. `SHELL := /bin/bash`, `BUILD_DIR := build`).
- 🧪 Debuguj `make -n` lub `make --trace`; w razie potrzeby wstaw `@echo`.

## W kontekście EWW
- 🎯 Główne polecenia: `make help`, `make check-versions`, `make bump-version BUMP=X.Y.Z`.
- 🔄 Zachowaj spójność wersji (`VERSION`, frontmatter, tag `vX.Y.Z`) po `make bump-version`.

## 🔗 Backlinks

- [[usr/jakubc/study/study]]
- [[usr/jakubc/jakubc]]
- [[EWW-MAP]]