---
version: 0.0.1
title: "Automatyczne wersjonowanie w EWW"
created: 2025-12-03
modified: 2025-12-03
tags:
  - workflow
  - versioning
  - automation
  - documentation
status: active
---

# Automatyczne wersjonowanie w EWW

## 🎯 Cel

Zapewnić spójne wersjonowanie wszystkich plików Markdown w repozytorium oraz automatyzację tego procesu.

## 🔄 Workflow

### 1. Odbudowa historii (jednorazowo)

Odbuduj wersje dla wszystkich istniejących plików na podstawie historii Git:

```bash
# Najpierw dry-run (sprawdź co zostanie zmienione)
make rebuild-history-dry

# Jeśli OK, wykonaj właściwą odbudowę
make rebuild-history
```

**Co robi ten krok:**
- Analizuje historię Git dla każdego pliku `.md`
- Ustawia `created` na datę pierwszego commitu
- Ustawia `modified` na datę ostatniego commitu
- Ustawia `version` bazując na liczbie commitów:
  - 1-99 commitów: `0.0.{N}`
  - 100+ commitów: `0.{N/100}.{N%100}`

**Przykład:**
```yaml
---
version: 0.0.5      # Plik miał 5 commitów
created: 2025-11-09  # Pierwszy commit
modified: 2025-12-03 # Ostatni commit
---
```

### 2. Instalacja pre-commit hook (automatyzacja)

Zainstaluj hook, który będzie automatycznie wersjonował pliki przy każdym commicie:

```bash
make install-hooks
```

**Co robi hook:**
- Przy każdym `git commit` sprawdza zmodyfikowane pliki `.md`
- Automatycznie podbija `version` (patch: `0.0.1` → `0.0.2`)
- Aktualizuje `modified` na dzisiejszą datę
- Dodaje zmiany do commitu

**Dezinstalacja:**
```bash
make uninstall-hooks
```

### 3. Manualne wersjonowanie (opcjonalnie)

Jeśli nie chcesz używać hooka lub potrzebujesz większej kontroli:

```bash
# Podbij patch version projektu
make bump-version BUMP=patch

# Synchronizuj wersje w frontmatterach
make sync-versions
```

## 📊 Monitorowanie i raporty

### Raport braków wersji

Sprawdź które pliki nie mają `version` w frontmatterze:

```bash
make version-report
```

Raport zapisywany w: `docs/reports/frontmatter-version-gap.md`

### Sprawdzenie spójności

Waliduj zgodność wersji między Git tag, plikiem `VERSION` i frontmatterami:

```bash
make check-versions
```

## 🛠️ Komendy

| Komenda | Opis |
|---------|------|
| `make rebuild-history` | Odbuduj wersje z historii Git |
| `make rebuild-history-dry` | Pokaż co zostanie zmienione (dry-run) |
| `make install-hooks` | Zainstaluj pre-commit hook |
| `make uninstall-hooks` | Usuń pre-commit hook |
| `make version-report` | Raport braków wersji |
| `make check-versions` | Sprawdź spójność wersji |
| `make sync-versions` | Synchronizuj wersje w frontmatterach |

## 📋 Polityka wersjonowania

### Automatyczne (pre-commit hook)

- **Patch bump:** Każda modyfikacja pliku automatycznie podbija ostatnią cyfrę
- **Modified date:** Zawsze aktualizowane na dzień commitu
- **Created date:** Pozostaje bez zmian

### Manualne (większe zmiany)

Jeśli dokonujesz dużych zmian (np. breaking changes, nowe sekcje):

1. Edytuj `version` w frontmatterze ręcznie:
   - **Patch** (`0.0.X`): drobne poprawki, typo, formatowanie
   - **Minor** (`0.X.0`): nowa sekcja, istotne rozszerzenie
   - **Major** (`X.0.0`): breaking changes, całkowita przebudowa

2. Lub użyj `make bump-version BUMP=minor|major` dla całego projektu

## 🔧 Integracja z Obsidian

W Obsidianie używamy **Obsidian Git** plugin:

1. **Auto pull on open:** Pobiera zmiany przy otwarciu vaulta
2. **Auto commit:** Automatyczny commit co X minut
3. **Auto push:** Automatyczny push po commicie

**Konfiguracja Obsidian Git:**
- Settings → Community Plugins → Obsidian Git
- Pull updates on startup: `ON`
- Auto commit interval: `10` (minut)
- Auto push: `ON`

**Ważne:** Pre-commit hook zadziała automatycznie przy każdym commicie z Obsidiana!

## 🚨 Rozwiązywanie problemów

### Hook nie działa

```bash
# Sprawdź czy hook istnieje
ls -la .git/hooks/pre-commit

# Sprawdź uprawnienia
chmod +x .git/hooks/pre-commit

# Reinstaluj
make uninstall-hooks
make install-hooks
```

### Konflikt wersji

Jeśli masz konflikty w `version` po merge:

1. Ręcznie zdecyduj która wersja jest poprawna
2. Uruchom `make sync-versions` aby zsynchronizować
3. Commit zmian

### Semver nie działa

```bash
# Sprawdź instalację
which semver

# Zainstaluj jeśli brak
npm install -g semver
```

## 📚 Referencje

- [SemVer 2.0.0](https://semver.org/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Git hooks documentation](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
- [[docs/reference/semver-workflow|Semver Workflow]]
- [[docs/quickstart-semver|Quick Start: Semver]]

## 🔗 Backlinks

- [[docs]]
- [[workflow]]
- [[dev/ideas/wersjonowanie]]
