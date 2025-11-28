created: 2025-11-26T13:46:18Z
modified: 2025-11-26T13:46:18Z
author: karinam
---
title: Git Workflow dla projektu eww
description: Workflow synchronizacji między upstream i forkami
tags:
  - git
  - workflow
  - github
created: 2025-11-26T13:46:18Z
modified: 2025-11-26T13:46:18Z
author: karinam
---

# Git Workflow

## Architektura repozytoriów

```
Nairecth/eww (upstream)
    ↓ fetch
Lokalnie (karinam/git/eww)
    ↓ push
Kari-Tori/eww (origin/fork)
    ↓ Pull Request
Nairecth/eww (merge przez Jakuba)
```

## Zasady

### Main ↔ Main
- **Tylko main → main** (bez feature branches)
- Conventional Commits obowiązkowe
- Każdy commit musi mieć zgodną wersję (VERSION + tag + frontmatter)

### Remotes

```bash
upstream    git@github.com:Nairecth/eww.git (fetch)
origin      git@github.com:Kari-Tori/eww.git (fetch + push)
```

## Codzienne workflow

### 1. Fetch zmian z upstream

```bash
git fetch upstream
git fetch origin
```

### 2. Merge upstream/main

```bash
git checkout main
git merge upstream/main
```

**Rozwiązywanie konfliktów:**
- `docs/index.md` - merge obu wersji
- Pliki osobiste (usr/karinam/*) - zachowaj swoje ("ours")
- Wspólne pliki - merge manualnie

### 3. Praca lokalna

```bash
# Zmiany w plikach
git add .
git commit -m "feat(area): opis zmiany"

# Sprawdź wersje
make check-versions

# Opcjonalnie: bump wersji
make bump-version BUMP=0.0.0.X
```

### 4. Push do origin (fork)

```bash
git push origin main
```

**Problemy z push:**
- Repo za duże → push partiami (patrz: docs/software/git/merge-workflow.md)
- Push się zawiesza → `killall -9 git` i retry
- Wolne połączenie → opcja B (squash) lub C (Jakub merguje ręcznie)

### 5. Pull Request do upstream

```bash
# Jeśli fork ma wspólną historię:
gh pr create --repo Nairecth/eww --base main --head Kari-Tori:main \
  --title "feat: opis zmian" \
  --body "Opis szczegółowy"

# Jeśli nie ma wspólnej historii:
# Notify Jakuba → manual merge
```

## GitHub Actions

### Automatyczny sync fork (.github/workflows/sync-fork.yml)
- **Trigger:** codziennie o 02:00 UTC lub manual
- **Akcja:** `git merge upstream/main`
- **Push:** automatyczny do origin/main

### Testy (.github/workflows/tests.yml)
- **ShellCheck:** wszystkie *.sh i bin/*
- **BATS:** testy z tests/ lub dev/tests/
- **Version check:** sprawdza spójność VERSION/tag/frontmatter

## Pull Request Template

Szablon w `.github/PULL_REQUEST_TEMPLATE.md` zawiera:
- [ ] Opis zmian
- [ ] Typ zmian (bug fix, feature, docs, etc.)
- [ ] Checklist (style, testy, shellcheck, dokumentacja)
- [ ] Powiązane issues

## Przydatne komendy

```bash
# Status synchronizacji
git log --oneline upstream/main..HEAD  # Commity do push
git log --oneline HEAD..upstream/main  # Commity do pull

# Sprawdź ile commitów różnicy
git rev-list --count origin/main..HEAD

# Remote info
git remote -v
git ls-remote origin main
git ls-remote upstream main

# Cleanup zawieszonych push
killall -9 git

# Squash ostatnich N commitów
git reset --soft HEAD~N
git commit -m "feat: squashed changes"
```

## Konwencje commitów

Format: `type(scope): description`

**Typy:**
- `feat:` - nowa funkcjonalność
- `fix:` - poprawka błędu
- `docs:` - dokumentacja
- `style:` - formatowanie
- `refactor:` - refaktoring bez zmian funkcjonalności
- `test:` - testy
- `chore:` - maintenance (build, deps, config)

**Scope:** opcjonalne (core, dev, lib, docs, usr)

**Przykłady:**
```bash
git commit -m "feat(lib): dodaj funkcję parsowania wersji"
git commit -m "fix(bin): napraw init-eww.sh shellcheck warnings"
git commit -m "docs: zaktualizuj README z nową strukturą"
git commit -m "chore: bump VERSION to 0.0.0.5"
```

## Proces review

1. **Karina** - tworzy PR lub notyfikuje Jakuba
2. **Jakub** - review zmian
3. **Feedback** - poprawki jeśli potrzebne
4. **Merge** - Jakub merguje do upstream/main
5. **Sync** - automatyczny sync fork lub manual fetch

## Troubleshooting

### "no history in common" przy PR
**Przyczyna:** Fork nie jest prawdziwym forkiem upstream

**Rozwiązanie:**
```bash
# Jakub merguje ręcznie:
git remote add karina git@github.com:Kari-Tori/eww.git
git fetch karina
git merge karina/main
```

### Push zawiesza się
**Przyczyna:** Repo za duże, wolne połączenie

**Rozwiązanie:** Patrz `docs/software/git/merge-workflow.md`

### Konflikty merge
**Strategia:**
- Własne pliki (usr/karinam/*) - zachowaj swoje
- Wspólne pliki - merge manualnie
- Git artifacts (.gitignore, .github/) - merge obu

## Referencje

- [Merge Workflow](../software/git/merge-workflow.md)
- [CONTRIBUTING.md](../../CONTRIBUTING.md)
- [AGENTS.md](../../AGENTS.md)
- [Conventional Commits](https://www.conventionalcommits.org/)
