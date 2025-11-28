created: 2025-11-26T13:42:28Z
modified: 2025-11-26T13:42:28Z
author: karinam
---
title: Workflow merge z upstream (Nairecth/eww → Kari-Tori/eww)
description: Instrukcja synchronizacji forka z upstream repository
updated: 2025-11-26
tags:
  - git
  - workflow
  - merge
  - upstream
created: 2025-11-26T13:42:28Z
modified: 2025-11-26T13:42:28Z
author: karinam
---

# Workflow merge z upstream

## Kontekst

- **Upstream:** `Nairecth/eww` (główne repo Jakuba)
- **Origin:** `Kari-Tori/eww` (mój fork)
- **Workflow:** Nairecth/eww → lokalnie → Kari-Tori/eww → PR → Nairecth/eww

## Konfiguracja remotes

```bash
# Upstream (Jakub)
git remote add upstream git@github.com:Nairecth/eww.git

# Origin (Karina)
git remote add origin git@github.com:Kari-Tori/eww.git

# Sprawdź
git remote -v
```

## Proces synchronizacji

### 1. Fetch z upstream

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
- Konflikty w `docs/index.md` i plikach osobistych
- Strategia: wybierz "ours" dla plików osobistych, merge dla wspólnych
- `git add <plik> && git commit`

### 3. Push do origin

⚠️ **Problem:** Repo za duże (284MB+, 12,137 obiektów)

**Rozwiązania:**

#### Opcja A: Push partiami (wolne połączenie)
```bash
# Push po 1 commicie z pauzą
for i in {131..152}; do
  commit=$(git rev-list --reverse upstream/main..HEAD | sed -n "${i}p")
  git push origin "$commit:refs/heads/main"
  sleep 2
done
```

#### Opcja B: Squash commitów
```bash
# Ostatnie N commitów do 1
git reset --soft HEAD~8
git commit -m "feat: cleanup repo - reorganizacja struktury"
git push origin main --force
```

#### Opcja C: Jakub merguje ręcznie
```bash
# Na komputerze Jakuba:
git remote add karina git@github.com:Kari-Tori/eww.git
git fetch karina
git merge karina/main
```

## Cleanup wykonany (2025-11-26)

### Reorganizacja struktury
- ✅ `eww/inbox → core/inbox` (2.7GB gitignored)
- ✅ `projects/init → dev/projects/`
- ✅ `scripts/* → dev/scripts/`
- ✅ `systemd/* → dev/systemd/`
- ✅ `tests/* → dev/tests/`

### Usunięte pliki
- ✅ 402 cache files (`.makemd/`, `.obsidian/icons/`)
- ✅ Duplikaty konfiguracyjne z `core/`
- ✅ Duże pliki z inbox (>100MB)

### Dodane pliki
- ✅ LICENSE (MIT)
- ✅ CONTRIBUTING.md
- ✅ CODE_OF_CONDUCT.md
- ✅ SECURITY.md
- ✅ README.md
- ✅ INDEX.md

### Aktualizacja .gitignore
```gitignore
core/inbox/
.obsidian/icons/
dev/Projects/obsidian/plugins/
**/.makemd/thumbnails/
**/.makemd/*.mdc
```

## Status (2025-11-26)

- ✅ **143/152 commitów** pushed do Kari-Tori/eww
- ⏳ **9 commitów** pozostało (squashed do 1)
- ❌ Push zawiesza się (repo za duże, połączenie 100KB/s)

## Problemy napotkane

### 1. Push fails - "unexpected disconnect"
**Przyczyna:** Repository za duże (284MB), wolne połączenie (100-300 KB/s)

**Rozwiązanie:** Push partiami po 10-20 commitów z pause 2-3s

### 2. Git się zawiesza
**Przyczyna:** Commity z dużymi plikami (journal import 421 plików, AI docs 1015 plików)

**Rozwiązanie:**
```bash
killall -9 git
git status
```

### 3. "no history in common" przy tworzeniu PR
**Przyczyna:** Fork nie ma wspólnej historii z upstream

**Rozwiązanie:** Jakub musi zmergować ręcznie lub sync fork na GitHubie

## Następne kroki

1. **Dokończ push** - kontynuuj push ostatnich commitów
2. **Notify Jakub** - wyślij wiadomość z linkiem do repo
3. **PR ręcznie** - Jakub: `git remote add karina ...`

## Wiadomość dla Jakuba

```markdown
Cześć! Zmergowałam Twoje zmiany i uporządkowałam repo.

Repo: https://github.com/Kari-Tori/eww

Dodaj jako remote i zmerguj:
git remote add karina git@github.com:Kari-Tori/eww.git
git fetch karina
git merge karina/main

Zmiany:
- Merge 143 commitów z upstream/main
- Reorganizacja struktury (dev/, core/inbox/)
- Cleanup 402 cache files
- Dokumentacja (LICENSE, CONTRIBUTING.md, etc.)

Ready for review! 🙏
```

## Przydatne komendy

```bash
# Sprawdź ile commitów do push
git rev-list --count origin/main..HEAD

# Sprawdź rozmiar repo
git count-objects -vH

# Sprawdź ostatni pushed commit
git ls-remote origin main

# Sprawdź local HEAD
git rev-parse HEAD

# Kill zawieszone push
pkill -9 -f "git push"

# Squash ostatnich N commitów
git reset --soft HEAD~N
git commit -m "message"
```

## Referencje

- [Git Workflow](../../workflow/)
- [CONTRIBUTING.md](../../../CONTRIBUTING.md)
- [AGENTS.md](../../../AGENTS.md)
