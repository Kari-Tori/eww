---
title: "Development - Aktywny rozwój projektów"
created: 2025-12-02
modified: 2025-12-02
tags:
  - folder_note
  - development
  - coding
---

# Development - Rozwój 🔧

Etap 4 cyklu życia projektu: **Aktywny development (kod, testy, iteracje)**.

## 🎯 Cel tego etapu

- Implementacja zaplanowanych features
- Pisanie testów (unit, integration, E2E)
- Code reviews i quality assurance
- Iteracyjny development (sprints)
- Dokumentacja techniczna
- Continuous integration

## 📋 Co powinno być w development?

Każdy projekt w tym folderze powinien zawierać:

- **src/** - kod źródłowy
- **tests/** - testy automatyczne
- **docs/** - dokumentacja techniczna
- **README.md** - setup guide, contribution guidelines
- **CHANGELOG.md** - historia zmian
- **.github/** - CI/CD workflows, issue templates
- **docker-compose.yml** - środowisko dev (opcjonalnie)

## 📁 Aktywne projekty

*Lista projektów w aktywnym development:*

- [[obsidian]] - Integracja Obsidian
- [[odoo]] - Odoo ERP

## 🔄 Przejście do następnego etapu

Projekt jest gotowy do przejścia do **[[staging]]** gdy:

- [ ] MVP features zakończone
- [ ] Testy jednostkowe przechodzą (coverage > 70%)
- [ ] Testy integracyjne przechodzą
- [ ] Code review zakończone
- [ ] Dokumentacja aktualna
- [ ] No critical bugs
- [ ] Performance benchmarks met
- [ ] Security scan passed

## 📄 Development Workflow

### Git Workflow

```bash
# Utwórz feature branch
git checkout -b feat/feature-name

# Commit z Conventional Commits
git commit -m "feat(scope): add feature X"

# Push i create PR
git push origin feat/feature-name
```

### Testing Strategy

```bash
# Unit tests
npm test

# Integration tests
npm run test:integration

# E2E tests
npm run test:e2e

# Coverage
npm run test:coverage
```

### Code Quality

```bash
# Linting
npm run lint

# Formatting
npm run format

# Type checking
npm run typecheck
```

## 🔗 Backlinks

- [[dev]]
- [[planning]] - Poprzedni etap
- [[staging]] - Następny etap
- [[INDEX]]
