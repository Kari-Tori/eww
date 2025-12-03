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
title: "Embeddings semantyczne"






owner: jakubc
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

## 🔗 Backlinks

- [[jakubc]]
- [[INDEX]]
- [[core]]

---
*Auto-generated backlinks for cluster connectivity*