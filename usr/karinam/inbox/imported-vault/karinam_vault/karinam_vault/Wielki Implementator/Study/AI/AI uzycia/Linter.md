---
id: sb-linter
title: Linter notatek
type: spec/module
status: draft
owner: Jakub
tags:
  - linter
  - markdown
  - standaryzacja
  - secondbrain
created: 2025-10-27
updated: 2025-10-27
aliases: [Linter notatek]
linter-yaml-title-alias: Linter notatek
date created: poniedziałek, październik 27. 2025, 1:46:36 pm
date modified: poniedziałek, październik 27. 2025, 1:52:45 pm
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
