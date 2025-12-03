---
version: 0.0.1
title: "Konfiguracja Obsidian dla EWW"
created: 2025-12-03
modified: 2025-12-03
tags:
  - setup
  - obsidian
  - configuration
status: active
owner: karinam
---

# Konfiguracja Obsidian dla EWW

## 📋 Wymagane pluginy

### 1. Obsidian Git (WYMAGANY)
Automatyczne wersjonowanie i synchronizacja z Git.

**Instalacja:**
1. Settings → Community plugins → Browse
2. Szukaj "Obsidian Git"
3. Install → Enable

**Konfiguracja:**
```json
{
  "autoSaveInterval": 10,
  "autoPullInterval": 5,
  "autoPullOnBoot": true,
  "disablePush": false,
  "pullBeforePush": true,
  "disablePopups": false,
  "listChangedFilesInMessageBody": false,
  "showStatusBar": true,
  "updateSubmodules": false,
  "syncMethod": "merge",
  "customMessageOnAutoBackup": false,
  "autoBackupAfterFileChange": false,
  "treeStructure": false,
  "refreshSourceControl": true,
  "basePath": "",
  "differentIntervalCommitAndPush": false,
  "changedFilesInStatusBar": false,
  "showedMobileNotice": true,
  "refreshSourceControlTimer": 7000,
  "showBranchStatusBar": true,
  "setLastSaveToLastCommit": false,
  "submoduleRecurseCheckout": false,
  "gitDir": "",
  "showFileMenu": true,
  "lineAuthor": {
    "show": false
  },
  "autoCommitMessage": "vault backup: {{date}}"
}
```

**Skróty klawiszowe (zalecane):**
- `Ctrl+Shift+G` - Commit & Push
- `Ctrl+Shift+P` - Pull
- `Ctrl+Shift+S` - Status

### 2. Templater (WYMAGANY)
Szablony z automatycznym wersjonowaniem.

**Instalacja:**
1. Settings → Community plugins → Browse
2. Szukaj "Templater"
3. Install → Enable

**Konfiguracja:**
- Template folder: `dev/templates/`
- Automatic jump to cursor: ON
- Trigger on file creation: ON

**Szablon z wersjonowaniem:**
Zapisz w `dev/templates/note-template.md`:
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

### 3. Natural Language Dates (opcjonalnie)
Łatwiejsze wpisywanie dat.

### 4. Folder Note (zalecane)
Automatyczne README.md dla folderów.

## ⚙️ Ustawienia Obsidian

### Pliki i linki
- **New file location:** `Same folder as current file`
- **Default location for new attachments:** `assets/`
- **Automatically update internal links:** ON

### Edytor
- **Readable line length:** OFF (pełna szerokość)
- **Strict line breaks:** ON
- **Show frontmatter:** ON
- **Fold heading:** ON
- **Fold indent:** ON

### Wygląd
- **Base color scheme:** Dark (lub według preferencji)
- **Themes:** Minimal (lub inny wspierający frontmatter)

## 🔧 Git hooks - WYMAGANE

Po sklonowaniu repo **MUSISZ** uruchomić:

```bash
cd /path/to/eww
make install-hooks
```

Lub:
```bash
./dev/scripts/setup-githooks.sh
```

To skonfiguruje automatyczne wersjonowanie plików `.md` przy każdym commicie.

## 🚀 Workflow w Obsidian

### Codzienne użycie
1. Otwórz vault (auto-pull przy starcie)
2. Edytuj pliki normalnie
3. Plugin Git auto-commituje co 10 minut
4. Ręczny commit: `Ctrl+Shift+G`

### Tworzenie nowego dokumentu
1. `Ctrl+N` - nowy plik
2. Użyj szablonu Templater (automatyczny frontmatter)
3. Frontmatter zawiera już `version: 0.0.1`
4. Przy pierwszym commicie hook zaktualizuje daty

### Edycja istniejącego dokumentu
1. Edytuj plik
2. Zapisz (`Ctrl+S`)
3. Przy commicie:
   - Pre-commit hook automatycznie podbije `version` (patch)
   - Zaktualizuje `modified` na dzisiejszą datę
   - Dodaj i commituje zmiany

## 📝 Checklist konfiguracji

- [ ] Zainstalowano Obsidian Git
- [ ] Skonfigurowano auto-commit (10 min)
- [ ] Skonfigurowano auto-pull przy starcie
- [ ] Zainstalowano Templater
- [ ] Ustawiono folder szablonów: `dev/templates/`
- [ ] Utworzono szablon `note-template.md` z frontmatterem
- [ ] Uruchomiono `make install-hooks` w terminalu
- [ ] Przetestowano workflow (utworzenie pliku, edycja, commit)
- [ ] Sprawdzono czy `version` i `modified` są aktualizowane

## 🆘 Troubleshooting

### Obsidian Git nie commituje
- Sprawdź: Settings → Obsidian Git → Auto-backup interval (powinno być 10)
- Sprawdź: czy vault jest otwarty w poprawnej lokalizacji
- Sprawdź logi: Command Palette → "Obsidian Git: Open Git log"

### Hook nie aktualizuje wersji
- Sprawdź czy hook jest zainstalowany: `git config core.hooksPath`
- Powinno zwrócić: `.githooks`
- Jeśli nie: uruchom `make install-hooks`

### Konflikty przy pull
- Obsidian Git automatycznie merguje
- W razie problemów: użyj VS Code do rozwiązania konfliktów

### Brak semver
```bash
npm install -g semver
# lub
brew install semver  # macOS
```

## 🔗 Powiązane dokumenty

- [[../versioning/README|Dokumentacja wersjonowania]]
- [[../versioning/quickstart|Szybki start]]
- [[onboarding|Onboarding nowych użytkowników]]

---

**Autor:** karinam
**Data:** 2025-12-03
**Status:** Aktywna konfiguracja
