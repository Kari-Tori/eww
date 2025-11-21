---
id: sb-vectorindex
title: Indeks wektorowy
type: spec/module
status: draft
owner: Jakub
tags:
  - vectorstore
  - wyszukiwanie
  - ai
  - secondbrain
  - personal
  - blue
  - jakubc
created: 2025-10-27
updated: 2025-11-21
aliases: [Indeks wektorowy]
linter-yaml-title-alias: Indeks wektorowy
date created: poniedziałek, październik 27. 2025, 1:46:36 pm
date modified: poniedziałek, październik 27. 2025, 1:51:07 pm
color: blue
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
