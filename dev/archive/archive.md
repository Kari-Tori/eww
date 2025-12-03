---
title: "Archive - Archived projects"
created: 2025-12-02
modified: 2025-12-02
tags:
  - folder_note
  - archive
  - completed
  - abandoned
---

# Archive - Archiwum 📦

Etap 7 (finalny) cyklu życia projektu: **Projekty zakończone lub porzucone**.

## 🎯 Cel tego katalogu

- Przechowywanie historii zakończonych projektów
- Lessons learned z porzuconych projektów
- Kod źródłowy jako referencja
- Knowledge preservation
- Inspiracja dla przyszłych projektów

## 📁 Struktura archiwum

### completed/
Projekty zakończone sukcesem:
- Wdrożone i później wycofane
- Osiągnęły cele i zakończono development
- Zastąpione nowszymi rozwiązaniami

### abandoned/
Projekty porzucone:
- Nie zakończone z różnych powodów
- Zmiany priorytetów
- Niewykonalne technicznie
- Brak zasobów

## 📋 Co powinno być w archiwum?

Każdy zarchiwizowany projekt powinien zawierać:

- **final-report.md** - raport końcowy
- **lessons-learned.md** - wnioski i lekcje
- **code-snapshot/** - snapshot kodu (tag Git)
- **documentation/** - finalna dokumentacja
- **metrics/** - statystyki projektu (jeśli był live)

## 📁 Zarchiwizowane projekty

### Completed ✅
*Projekty zakończone sukcesem:*

- *(brak)*

### Abandoned ❌
*Projekty porzucone:*

- *(brak)*

## 📄 Szablon archiwizacji

### Dla completed projects

```markdown
## [Nazwa projektu]

- **Start:** YYYY-MM-DD
- **End:** YYYY-MM-DD
- **Duration:** X months
- **Status:** Completed successfully
- **Reason for archiving:** [powód]
- **Key achievements:**
  - Achievement 1
  - Achievement 2
- **Final metrics:**
  - Users: X
  - Revenue: £Y
- **Lessons learned:** [[link]]
```

### Dla abandoned projects

```markdown
## [Nazwa projektu]

- **Start:** YYYY-MM-DD
- **Abandoned:** YYYY-MM-DD
- **Stage reached:** [ideas/concepts/planning/development]
- **Reason for abandoning:** [szczegółowy powód]
- **Lessons learned:**
  - Lesson 1
  - Lesson 2
- **Salvageable components:** [co można wykorzystać]
```

## 🔍 Wyszukiwanie w archiwum

### Po technologii
```bash
# Znajdź projekty używające React
grep -r "React" dev/archive/*/README.md
```

### Po dacie
```bash
# Projekty z 2024
find dev/archive -name "*2024*"
```

## 🔗 Backlinks

- [[dev]]
- [[production]] - Poprzedni etap
- [[INDEX]]
