---
id: sb-index
title: Indexowanie wiedzy
type: spec/module
status: draft
owner: Jakub
tags:
  - index
  - wyszukiwanie
  - secondbrain
created: 2025-10-27
updated: 2025-10-27
aliases: [Indexowanie wiedzy]
linter-yaml-title-alias: Indexowanie wiedzy
date created: poniedziałek, październik 27. 2025, 1:46:36 pm
date modified: poniedziałek, październik 27. 2025, 1:52:33 pm
---

# Indexowanie wiedzy

## Cel
Szybkie wyszukiwanie po całej bazie notatek i zasobów.

## Rodzaje indeksów
1. Indeks metadanych
   - Klucze z YAML. status. owner. serial. location. priority. type.
   - Zapytania typu pokaż wszystkie intake z ostatnich 48 h Karina owner.

2. Indeks pełnotekstowy
   - Cały text_body po parsowaniu.
   - Zapytania typu karta graficzna brzęczenie VRM GTX 1080 Ti.

## Wejście
- Obiekt danych z parsera.

## Wyjście
- Zapis do bazy wyszukiwania. Minimum SQLite. Docelowo dedykowany silnik.

Przykład schematu SQLite:

```text
table notes_index (
  id text primary key,
  title text,
  owner text,
  status text,
  type text,
  location text,
  created text,
  updated text,
  tags text,
  text_body text,
  path text
)
```

Pole tags można przechowywać jako CSV albo JSON.

## Aktualizacja
- Każda zmiana w pliku md aktualizuje rekord.
- Id jest stałe. Reszta może się zmieniać.

## Integracja
- Indeks metadanych jest wykorzystywany do raportów operacyjnych.
- Indeks pełnotekstowy jest wykorzystywany do szybkiego szukania po tekście bez AI.
- Wektorowy indeks działa osobno i nie zastępuje tego indeksu.
