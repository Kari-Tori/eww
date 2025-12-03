---
version: 0.0.4
tags:
  - #automation
  - #development
  - #eww
  - #jakubc
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21
modified: 2025-12-01
author: jakubc
title: "Indexowanie wiedzy"






owner: jakubc
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

## 🔗 Backlinks

- [[jakubc]]
- [[INDEX]]
- [[core]]

---
*Auto-generated backlinks for cluster connectivity*