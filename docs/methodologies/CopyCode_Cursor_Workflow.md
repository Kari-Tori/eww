---
title: CopyCode Cursor Workflow
description: Tworzenie strony przy pomocy CopyCode.ai + Cursor
type: file
category: docs
filepath: docs/methodologies/CopyCode_Cursor_Workflow.md
color: green
author: jakubc
owner: jakubc
created: 2025-11-21
updated: 2025-11-21
version: 1.0.0
language: pl
status: active
priority: normal
license: MIT
tags:
  - documentation
  - markdown
  - docs
  - knowledge
keywords:
  - cursor
aliases:

related:
  - docs/readme-checklist.md
  - docs/ENDPOINTS.md
  - docs/yaml-frontmatter-spec.md
  - docs/neovim-guide.md
  - docs/narzedzia-deweloperskie.md
dependencies:
sources:
  - docs/methodologies/CopyCode_Cursor_Workflow.md
backlinks: []
context: "E-Waste Workshop - Bash toolkit for Kubuntu environment setup"
project: eww
repository: https://github.com/Kari-Tori/eww-1
---



# Tworzenie strony przy pomocy CopyCode.ai + Cursor

## Wymagania wstępne

- Zainstalowany edytor **Cursor** (https://cursor.so/)
- Konto na **CopyCode.ai** (https://copycode.ai/)
- Node.js + NPM (jeśli tworzysz stronę opartą na frameworku typu Next.js, Vite, itp.)

---

## 1. Generowanie projektu w CopyCode.ai

1. Wejdź na https://copycode.ai/
2. Wpisz prompt, np.:

   ```
   Stwórz stronę landingową o nazwie E-Waste Workshop:
   - header z logo i menu
   - sekcja "O nas"
   - cennik z 3 planami
   - stopka z linkami
   - użyj TailwindCSS
   ```

3. Pobierz wygenerowany kod lub skopiuj go bezpośrednio do edytora Cursor.

---

## 2. Import projektu do Cursor

1. Otwórz **Cursor**.
2. Utwórz nowy folder projektu (lub otwórz istniejący).
3. Wklej wygenerowane pliki (HTML/CSS/JS lub Next.js/Vue itp.) do struktury projektu.
4. Cursor automatycznie wykryje framework i skonfiguruje środowisko (jeśli zawiera `package.json`).

---

## 3. Edycja kodu z pomocą AI (Cursor)

### Przykłady użycia:

- Zaznacz komponent i wpisz:
  ```
  Przerób to na responsywny komponent Tailwind
  ```

- Wklej kod i wpisz:
  ```
  Dodaj formularz kontaktowy, który wysyła dane do endpointa /api/contact
  ```

- Refaktoryzacja:
  ```
  Podziel ten komponent na mniejsze pliki
  ```

- Backend:
  ```
  Dodaj prosty backend w Express.js do odbierania formularzy
  ```

---

## 4. Stylizacja i personalizacja

- Dodaj kolory i fonty:
  ```
  Użyj palety: czarny, neonowy zielony, szary.
  Font: Orbitron z Google Fonts
  ```

- Optymalizacja UX:
  ```
  Dodaj smooth scrolling, animacje przy przewijaniu i efekt hover dla kart cennika
  ```

---

## 5. Testowanie i optymalizacja

- Testy:
  ```
  Dodaj test jednostkowy do komponentu "PlanCennika"
  ```

- Optymalizacja:
  ```
  Dodaj lazy loading do obrazów i minifikuj CSS
  ```

---

## 6. Deployment (opcjonalnie)

- W Cursor wpisz:
  ```
  Skonfiguruj deployment na Vercel
  ```
- Lub ręcznie:
  - Załóż repozytorium na GitHub
  - Połącz z Vercel (lub Netlify)
  - Automatyczny deploy przy każdym commicie

---

## Gotowe!

Strona działa, kod jest zoptymalizowany, a całość tworzysz szybciej dzięki AI.

---

## Narzędzia

| Funkcja              | Narzędzie         |
|----------------------|------------------|
| Generowanie kodu     | CopyCode.ai       |
| Edycja + AI w IDE    | Cursor            |
| Framework frontend   | Next.js / Vite / HTML |
| Stylizacja           | TailwindCSS       |
| Hosting              | Vercel / Netlify  |
