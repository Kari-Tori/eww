---
version: 0.0.1
title: "Onboarding - Przewodnik dla nowych użytkowników"
created: 2025-12-03
modified: 2025-12-03
tags:
  - setup
  - onboarding
  - tutorial
status: active
owner: karinam
---

# Onboarding - Przewodnik dla nowych użytkowników EWW

## 🎯 Cel tego dokumentu

Ten przewodnik przeprowadzi Cię przez **wszystkie wymagane kroki** konfiguracji środowiska do pracy z repozytorium EWW.

**Czas: ~30 minut**

## ✅ Wymagania wstępne

- [ ] Git zainstalowany (`git --version`)
- [ ] Node.js zainstalowany (`node --version`) - dla semver
- [ ] Obsidian zainstalowany (lub VS Code)
- [ ] Dostęp do repozytorium: https://github.com/Nairecth/eww

## 📦 Krok 1: Klonowanie repo (5 min)

```bash
# Sklonuj repozytorium
git clone https://github.com/Nairecth/eww.git
cd eww

# Sprawdź wersję
cat VERSION
# Powinno zwrócić: 0.0.6
```

## 🔧 Krok 2: Instalacja semver (5 min)

**WYMAGANE** - system wersjonowania używa `semver` CLI.

### Metoda 1: npm (zalecane)
```bash
npm install -g semver
semver --version
```

### Metoda 2: brew (macOS)
```bash
brew install semver
semver --version
```

### Weryfikacja
```bash
semver -i patch 0.0.1
# Powinno zwrócić: 0.0.2
```

**Jeśli nie działa:**
- Zobacz: `docs/versioning/install-semver.md` → Troubleshooting

## 🪝 Krok 3: Konfiguracja Git hooks (2 min)

**WYMAGANE** - hook automatycznie wersjonuje pliki `.md` przy każdym commicie.

```bash
# Zainstaluj hooks (jeden command!)
make install-hooks

# Sprawdź czy działa
git config core.hooksPath
# Powinno zwrócić: .githooks
```

**Test hooka:**
```bash
# Edytuj dowolny plik .md
echo "Test" >> README.md
git add README.md
git commit -m "test: weryfikacja hooka"
# Powinieneś zobaczyć: "✅ Podbito wersję..."
```

## 🔮 Krok 4: Konfiguracja Obsidian (10 min)

### 4.1 Otwórz vault
1. Obsidian → Open folder as vault
2. Wybierz katalog `/path/to/eww`

### 4.2 Zainstaluj wymagane pluginy

**Plugin 1: Obsidian Git** (WYMAGANY)
1. Settings → Community plugins → Turn on community plugins
2. Browse → Szukaj "Obsidian Git"
3. Install → Enable
4. Settings → Obsidian Git:
   - Auto-backup interval: `10` minut
   - Auto-pull on boot: ON
   - Auto-pull interval: `5` minut
   - Commit message: `vault backup: {{date}}`

**Plugin 2: Templater** (WYMAGANY)
1. Browse → "Templater"
2. Install → Enable
3. Settings → Templater:
   - Template folder: `dev/templates`
   - Trigger on file creation: ON

**Plugin 3: Folder Note** (zalecane)
- Automatyczne `README.md` dla folderów

### 4.3 Skróty klawiszowe (zalecane)
Hotkeys → Obsidian Git:
- Commit and push: `Ctrl+Shift+G`
- Pull: `Ctrl+Shift+P`
- Open git view: `Ctrl+Shift+S`

**Pełna konfiguracja:** `docs/setup/obsidian-config.md`

## 📝 Krok 5: Szablon dla nowych plików (5 min)

Utwórz `dev/templates/note-template.md`:

```markdown
---
version: 0.0.1
title: "{{title}}"
created: <% tp.date.now("YYYY-MM-DD") %>
modified: <% tp.date.now("YYYY-MM-DD") %>
tags:
  -
status: draft
---

# {{title}}

## Zawartość

```

**Test szablonu:**
1. `Ctrl+N` - nowy plik
2. Command Palette → "Templater: Insert template"
3. Wybierz `note-template`
4. Frontmatter powinien być automatycznie wypełniony

## 🧪 Krok 6: Weryfikacja workflow (3 min)

### Test 1: Commit z hooka
```bash
# Utwórz testowy plik
echo "# Test" > test-versioning.md
git add test-versioning.md
git commit -m "test: weryfikacja wersjonowania"

# Sprawdź czy wersja została dodana
cat test-versioning.md
# Powinno zawierać frontmatter z version: 0.0.1
```

### Test 2: Bump wersji projektu
```bash
# Sprawdź aktualną wersję
make version

# Podbij patch
make bump-version BUMP=patch

# Sprawdź czy wersja wzrosła
make version
```

### Test 3: Obsidian Git
1. Edytuj dowolny plik w Obsidian
2. Zapisz (`Ctrl+S`)
3. Poczekaj 10 minut (auto-commit) LUB `Ctrl+Shift+G` (ręczny commit)
4. Sprawdź Git log: `git log --oneline -3`

## 📚 Krok 7: Dokumentacja (przeczytaj!)

**Musisz znać:**
1. **Wersjonowanie:** `docs/versioning/README.md` - jak działa system
2. **Szybki start:** `docs/versioning/quickstart.md` - podstawowe komendy
3. **Contributing:** `CONTRIBUTING.md` - zasady kontrybuowania

**Przydatne:**
- `docs/versioning/semver-workflow.md` - szczegółowy workflow
- `docs/concepts/wersjonowanie.md` - oryginalny koncept
- `AGENTS.md` - kontekst dla AI (jeśli używasz Copilot)

## 🎯 Checklist zakończenia onboardingu

### Instalacja i konfiguracja
- [ ] Sklonowane repo
- [ ] `semver` zainstalowany i działa
- [ ] Git hooks skonfigurowane (`make install-hooks`)
- [ ] Obsidian otwarty w vault EWW
- [ ] Plugin Obsidian Git zainstalowany i skonfigurowany
- [ ] Plugin Templater zainstalowany
- [ ] Szablon `note-template.md` utworzony

### Weryfikacja
- [ ] Test 1: Commit z automatycznym wersjonowaniem - PASS
- [ ] Test 2: Bump wersji projektu - PASS
- [ ] Test 3: Obsidian Git auto-commit - PASS
- [ ] Przeczytano `docs/versioning/README.md`
- [ ] Przeczytano `CONTRIBUTING.md`

### Zrozumienie
- [ ] Wiem jak podbić wersję projektu (`make bump-version BUMP=patch`)
- [ ] Wiem że hook automatycznie wersjonuje pliki .md
- [ ] Wiem jak używać szablonów w Obsidian
- [ ] Wiem gdzie szukać pomocy (docs/versioning/)

## 🚀 Pierwsze kroki po onboardingu

### Twoja pierwsza zmiana
1. Utwórz branch: `git checkout -b feat/moja-funkcja`
2. Wprowadź zmiany
3. Commit: `git commit -m "feat: dodaję moją funkcję"`
   - Hook automatycznie zaktualizuje wersje w plikach .md
4. Push: `git push origin feat/moja-funkcja`
5. Otwórz Pull Request na GitHub

### Codzienne użycie
1. **Rano:** Otwórz Obsidian (auto-pull)
2. **W ciągu dnia:** Edytuj pliki normalnie
3. **Co 10 min:** Auto-commit przez Obsidian Git
4. **Przed końcem dnia:** Sprawdź status (`git status`)

### Bump wersji projektu
**Kiedy?**
- **patch** (0.0.6 → 0.0.7): drobne poprawki, docs
- **minor** (0.0.6 → 0.1.0): nowe funkcje
- **major** (0.0.6 → 1.0.0): breaking changes

```bash
make bump-version BUMP=patch
# Lub minor/major
```

## 🆘 Pomoc i wsparcie

### Problem z konfiguracją?
1. **Semver:** `docs/versioning/install-semver.md` → Troubleshooting
2. **Obsidian:** `docs/setup/obsidian-config.md` → Troubleshooting
3. **Git hooks:** Sprawdź `git config core.hooksPath` (powinno być `.githooks`)

### Pytania o workflow?
- `docs/versioning/semver-workflow.md` - szczegółowy workflow
- `docs/versioning/README.md` - główny index dokumentacji

### Gdzie pytać?
- GitHub Issues: https://github.com/Nairecth/eww/issues
- Slack/Discord: (TODO: dodać link)

## 📊 Co dalej?

Po zakończeniu onboardingu:
1. Przeczytaj `business/story.md` - poznaj historię projektu
2. Przeczytaj `business/roadmap.md` - poznaj cele
3. Przeczytaj `ZERO-WASTE-POLICY.md` - poznaj misję
4. Zacznij kontrybuować! Zobacz `CONTRIBUTING.md`

## 🔗 Powiązane dokumenty

- [[../versioning/README|Dokumentacja wersjonowania]]
- [[../versioning/quickstart|Szybki start]]
- [[obsidian-config|Konfiguracja Obsidian]]
- [[../versioning/install-semver|Instalacja semver]]

---

**Witamy w zespole EWW!** 🎉

**Autor:** karinam
**Data:** 2025-12-03
**Wersja:** 0.0.1
