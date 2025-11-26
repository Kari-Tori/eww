---
tags:
  - #automation
  - #development
  - #eww
  - #jakubc
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T17:00:00Z
modified: 2025-11-21T17:00:00Z
author: jakubc
title: "Indeks wektorowy"






owner: jakubc
---

# Indeks wektorowy

## Cel
Dostarczenie szybkiego wyszukiwania podobieństwa semantycznego.

## Wejście
- Wektor embeddingu.
- Metadane minimalne
  - id
  - path
  - title
  - status
  - owner

## Wyjście
- Rekord wektorowy w bazie.
- Przykładowe pole
  - vector: [0.12, -0.04, 0.88, ...]
  - ref_id: sb-note-123
  - summary: "Diagnoza zasilacza Dell SFF i tabela pinoutu"
  - status: diagnostic
  - owner: Jakub

## Backend
- Preferowany lokalny silnik wektorowy
  - faiss
  - qdrant
  - milvus
  - chroma db
- Wymóg: możliwość zapytań nearest neighbors po cosine similarity.

## Zapytanie użytkownika
1. Użytkownik lub agent AI formułuje pytanie w języku naturalnym.
2. Pytanie też jest konwertowane do embeddingu.
3. Szukamy najbliższych wektorów.
4. Zwracamy listę notatek które mają największe podobieństwo semantyczne.
5. Te notatki można potem pokazać albo użyć do kontekstu odpowiedzi AI.

## Relacja do klasycznego indeksu
- Indeks klasyczny: szybkie filtry po statusie i polach YAML.
- Indeks wektorowy: rozumienie znaczenia i kontekstu.
- Oba indeksy są potrzebne.

## 🔗 Backlinks

- [[jakubc]]
- [[INDEX]]
- [[core]]

---
*Auto-generated backlinks for cluster connectivity*
