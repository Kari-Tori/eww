---
title: "Planning - Planowanie projektów"
created: 2025-12-02
modified: 2025-12-02
tags:
  - folder_note
  - development
  - planning
---

# Planning - Planowanie 📋

Etap 3 cyklu życia projektu: **Szczegółowe planowanie (scope, timeline, architektura)**.

## 🎯 Cel tego etapu

- Precyzyjne zdefiniowanie scope projektu
- Ustalenie szczegółowego timeline'u z milestones
- Zaprojektowanie architektury technicznej
- Alokacja zasobów (ludzie, budżet, narzędzia)
- Identyfikacja i mitygacja ryzyk
- Przygotowanie środowiska deweloperskiego

## 📋 Co powinno być w planowaniu?

Każdy projekt w tym folderze powinien zawierać:

- **scope.md** - zakres projektu (MVP, features, boundaries)
- **timeline.md** - harmonogram z milestones i deadlines
- **architecture.md** - architektura techniczna, diagramy
- **resources.md** - zasoby (team, budget, tools)
- **risks.md** - analiza ryzyk i plany awaryjne
- **wireframes/** - mockupy, prototypy, diagramy UX

## 📁 Aktywne plany

*Lista projektów w fazie planowania:*

- *(brak aktywnych planów)*

## 🔄 Przejście do następnego etapu

Plan jest gotowy do przejścia do **[[development]]** gdy:

- [ ] Scope zatwierdzony przez stakeholders
- [ ] Timeline ustalony z realistycznymi milestones
- [ ] Architektura zaprojektowana i zatwierdzona
- [ ] Zasoby przydzielone (team assigned)
- [ ] Środowisko dev przygotowane
- [ ] Repository utworzone
- [ ] Pierwszy sprint zaplanowany

## 📄 Szablony planowania

Użyj szablonów:
- [[template-scope]]
- [[template-timeline]]
- [[template-architecture]]
- [[template-resources]]

```bash
# Utwórz folder dla planu
mkdir -p dev/planning/nazwa-projektu/{wireframes,diagrams}

# Skopiuj szablony
cp dev/planning/template-*.md dev/planning/nazwa-projektu/
```

## 🔗 Backlinks

- [[dev]]
- [[concepts]] - Poprzedni etap
- [[development]] - Następny etap
- [[INDEX]]
