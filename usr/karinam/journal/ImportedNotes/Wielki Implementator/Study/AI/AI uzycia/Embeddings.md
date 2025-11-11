---
id: sb-embeddings
title: Embeddings semantyczne
type: spec/module
status: draft
owner: Jakub
tags:
  - embeddings
  - ai
  - wektory
  - secondbrain
created: 2025-10-27
updated: 2025-10-27
aliases: [Embeddings semantyczne]
linter-yaml-title-alias: Embeddings semantyczne
date created: poniedziałek, październik 27. 2025, 1:46:36 pm
date modified: poniedziałek, październik 27. 2025, 1:52:23 pm
---

# Embeddings semantyczne

## Cel
Przedstawienie znaczenia notatki jako wektora liczbowego. Dzięki temu wyszukiwanie rozumie sens a nie tylko słowa.

## Wejście
- text_body z parsera.
- Opcjonalnie streszczenie wygenerowane przez AI. Jeśli tekst jest bardzo długi można uśrednić kilka embeddingów.

## Wyjście
- Wektor liczb stałej długości.
- Przykład teoretyczny
  - 768 elementów typu float32.
  - To jest sygnatura znaczeniowa notatki.

## Wymagania
- Model embeddingów działa lokalnie na maszynie Secondbrain. Brak wycieku treści na zewnątrz.
- Ta sama wersja modelu dla całego klastra żeby wyniki były porównywalne.

## Dalsze użycie
- Wektor idzie do bazy wektorowej razem z metadanymi notatki.
- Ten wektor jest używany przy zapytaniach semantycznych.
