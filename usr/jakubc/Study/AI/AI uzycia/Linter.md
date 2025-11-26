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
title: "Linter notatek"






owner: jakubc
---

# Linter notatek

## Cel
Wymuszenie jednego standardu zapisu notatek tak aby dało się je automatycznie przetwarzać.

## Wejście
- Surowy plik .md od człowieka.
- Plik importowany z zewnątrz.

## Wyjście
- Plik .md z poprawionym formatowaniem.
- Uporządkowany YAML w nagłówku.

## Zakres działania
- Kolejność pól w YAML zgodna ze schematem.
- Daty w ISO YYYY-MM-DD.
- Wymuszenie nagłówka H1 jako tytułu.
- Usunięcie zbędnych spacji i zduplikowanych pustych linii.
- Wymuszenie stylu list punktowanych.
- Oznaczenie sekcji "Stan", "Diagnoza", "Dalsze kroki" tam gdzie ma to sens operacyjnie.

## Integracja
- Uruchamiane przy zapisie notatki albo przez batch job.
- Może być skrypt bash lub Python.
- Linter nie zmienia treści merytorycznej. Tylko format.

## 🔗 Backlinks

- [[jakubc]]
- [[INDEX]]
- [[core]]

---
*Auto-generated backlinks for cluster connectivity*
