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
title: "Parser treści"






owner: jakubc
---

# Parser treści

## Cel
Konwersja notatki markdown do formatu strukturalnego który można ładować do bazy.

## Wejście
- Plik .md po lintowaniu.

## Wyjście
Obiekt danych w stylu JSON

```json
{
  "id": "eww-asset-iphone11-2025-10-27",
  "title": "iPhone 11 intake",
  "tags": ["eww", "phone", "intake"],
  "status": "intake",
  "owner": "Karina",
  "serial": "FCGH12345",
  "created": "2025-10-27",
  "updated": "2025-10-27",
  "links_internal": ["[[Battery_iPhone11_Spec]]", "[[QC-checklist]]"],
  "text_body": "Telefon przyniesiony przez klienta. Pęknięty ekran. Brak ładowania przez Lightning. Housing czysty. Brak śladów zalania.",
  "path": "02_BUSINESS/EWW/Repair/iPhone11_intake.md"
}
```

## Funkcje parsera
- Czyta YAML i mapuje każde pole na klucz JSON.
- Czyści body z markdownu i zostawia czysty tekst roboczy text_body.
- Wyciąga linki wewnętrzne.
- Wykrywa pola techniczne nawet jeśli nie są w YAML. Przykład adres IP, nazwa hosta, numer seryjny. To można wykrywać przez regex.

## Integracja
- Wynik parsera trafia do dwóch dalszych kroków:
  - Indexowanie
  - Embeddings

## 🔗 Backlinks

- [[jakubc]]
- [[INDEX]]
- [[core]]

---
*Auto-generated backlinks for cluster connectivity*