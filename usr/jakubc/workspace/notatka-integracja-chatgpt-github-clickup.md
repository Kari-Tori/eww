---
title: Krótka notatka – jak spiąć ChatGPT Business, GitHub, Copilot i ClickUp
description: TODO - uzupełnij opis.
---

# Krótka notatka – jak spiąć ChatGPT Business, GitHub, Copilot i ClickUp

## Schemat (dopieszczony)

```text
          ┌─────────────────┐
          │ ChatGPT Business│
          │  (2 użytkowników) 
          └──────┬───┬──────┘
                 │   │
         connector│   │connector
             GitHub   ClickUp
                 │       │
           ┌─────▼─────┐ ▼
           │  GitHub   │ │
           │  1 repo   │ │
           └─────┬─────┘ │
                 │       │
        (clone)  │       │zadania, statusy
                 │       │(taski, sprinty)
           ┌─────▼─────┐
           │  IDE +    │
           │ GitHub    │
           │ Copilot   │
           └───────────┘
```

## Jak to działa operacyjnie

- **ClickUp** – trzyma zadania (Backlog, Sprinty, Bugi).  
- **GitHub (1 repo)** – trzyma kod; commity/PR mają ID zadań z ClickUp (`ABC-123`), integracja je linkuje.  
- **GitHub Copilot** – pomaga pisać kod w IDE na sklonowanym repo.  
- **ChatGPT Business** – przez connectory widzi:
  - kod w repo (GitHub),
  - taski i statusy (ClickUp),
  i pomaga w: planowaniu, review, dokumentacji.

## Minimalny flow

1. Task w ClickUp → ID: `ABC-123`.  
2. Branch w GitHub: `feature/ABC-123-opis`.  
3. Kod z pomocą Copilota → commity z `ABC-123` w opisie.  
4. PR → automatycznie podpięty do zadania w ClickUp.  
5. ChatGPT:
   - analizuje kod z repo,
   - przegląda taski w ClickUp,
   - sugeruje plan, review, dokumentację itd.
