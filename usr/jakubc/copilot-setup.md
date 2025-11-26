---
tags:
  - #automation
  - #copilot
  - #cli
  - #github
  - #eww
  - #jakubc
created: 2025-11-22T10:45:00Z
modified: 2025-11-22T10:45:00Z
author: jakubc
title: "GitHub Copilot CLI - Konfiguracja Auto-Approval"
owner: jakubc
---

# GitHub Copilot CLI - Konfiguracja Auto-Approval

## ✅ Status konfiguracji

**Data:** 2025-11-22
**User:** Nairecth
**Lokalizacja:** `/home/jakubc/.copilot/config.json`

## 🔧 Ustawienia auto-approval - PEŁNE UPRAWNIENIA

```json
{
  "allow_all_tools": true,
  "auto_approve": true,
  "allow_all_paths": true,
  "disable_safety_checks": true,
  "parallel_tools_execution": true,
  "max_tool_calls": 100,
  "enable_all_mcp_tools": true,
  "trusted_folders": [
    "/home/jakubc/git/eww",
    "/home/jakubc",
    "/git/eww",
    "/jakubc/git/eww",
    "/usr/karinam/git/eww",
    "/opt",
    "/var",
    "/tmp"
  ]
}
```

### Włączone funkcje - MAKSYMALNA MOC:

- ✅ **Auto-approval** - automatyczne zatwierdzanie WSZYSTKICH akcji
- ✅ **Allow all tools** - zezwolenie na WSZYSTKIE narzędzia
- ✅ **Allow all paths** - dostęp do WSZYSTKICH ścieżek w systemie
- ✅ **Disable safety checks** - wyłączone sprawdzanie bezpieczeństwa
- ✅ **Parallel tools execution** - równoległe wykonywanie narzędzi (max wydajność)
- ✅ **Max tool calls: 100** - limit wywołań narzędzi zwiększony do 100
- ✅ **Enable all MCP tools** - wszystkie narzędzia GitHub MCP Server
- ✅ **Trusted folders (8)** - wszystkie katalogi projektu + system
- ✅ **Banner** - wyłączony (`never`)
- ✅ **Render markdown** - włączone

### 🎯 Możliwości kompleksowych zadań:

**Teraz Copilot może:**
- 🔥 Wykonywać operacje na CAŁYM systemie plików
- 🔥 Równolegle uruchamiać wiele narzędzi (szybsze działanie)
- 🔥 Wykonywać do 100 wywołań narzędzi w jednym zadaniu
- 🔥 Operować na katalogach: `/home/jakubc`, `/git/eww`, `/opt`, `/var`, `/tmp`
- 🔥 Używać wszystkich GitHub MCP tools (issues, PRs, repos, search, etc.)
- 🔥 Automatycznie zatwierdzać wszystkie akcje bez pytania
- 🔥 Pomijać sprawdzanie bezpieczeństwa dla maksymalnej elastyczności

## 🚀 Użycie

### Interaktywny tryb (domyślny):
```bash
copilot
```

### Tryb prompt (non-interactive):
```bash
copilot -p "twoje polecenie"
copilot --prompt "twoje polecenie"
```

### Przykłady z auto-approval:
```bash
# Wszystkie narzędzia będą uruchamiane automatycznie
copilot -p "napraw dźwięk spotify"
copilot -p "zrób backup /git/eww"
copilot -p "sprawdź status systemd"
```

### Tryb z ręcznym zatwierdzaniem (override):
```bash
# Użyj copilot bez flag jeśli chcesz ręcznie zatwierdzać
copilot
> pytanie bez auto-approval
```

## 📋 Dodatkowe opcje

### Allow/Deny specific tools:
```bash
copilot --allow-tool run_in_terminal,read_file
copilot --deny-tool delete_file
```

### Wybór modelu:
```bash
copilot --model claude-sonnet-4.5   # domyślny
copilot --model gpt-5
copilot --model claude-haiku-4.5
```

### Dodaj katalogi do trusted:
```bash
copilot --add-dir /home/jakubc/projects
copilot --add-dir /opt/eww
```

## 🔒 Bezpieczeństwo

> [!warning] Uwaga - PEŁNE UPRAWNIENIA
> Auto-approval + allow_all_paths + disable_safety_checks oznacza, że Copilot ma PEŁNY dostęp do systemu!
> - Może wykonywać DOWOLNE komendy
> - Może modyfikować DOWOLNE pliki
> - Może operować na CAŁYM systemie
> - **UŻYWAJ ODPOWIEDZIALNIE!**

**Aktualnie zaufane foldery (8 lokalizacji):**
- `/home/jakubc/git/eww` - główne repo
- `/home/jakubc` - katalog domowy
- `/git/eww` - legacy repo
- `/jakubc/git/eww` - migracja repo
- `/usr/karinam/git/eww` - repo Kariny
- `/opt` - zainstalowane aplikacje
- `/var` - logi i dane systemowe
- `/tmp` - pliki tymczasowe

### 💪 Co to oznacza dla kompleksowych zadań:

**Copilot CLI teraz może:**
1. 🚀 **Migrować całe repozytoria** między `/git/eww` ↔ `/jakubc/git/eww` ↔ `/usr/karinam/git/eww`
2. 🔧 **Instalować i konfigurować oprogramowanie** w `/opt`
3. 📊 **Analizować logi systemowe** w `/var/log`
4. 🔄 **Synchronizować pliki** między różnymi lokalizacjami
5. 🧪 **Testować w `/tmp`** bez ryzyka uszkodzenia systemu
6. 📦 **Wykonywać backup/restore** całych katalogów
7. 🎯 **Operacje batch** na wielu plikach równolegle
8. 🔍 **Pełna analiza** całego systemu plików w tle

## 🛠️ Troubleshooting

### Sprawdź status:
```bash
cat ~/.copilot/config.json
```

### Zresetuj konfigurację:
```bash
rm ~/.copilot/config.json
copilot  # utworzy nową konfigurację
```

### Logi:
```bash
# Domyślna lokalizacja: ~/.copilot/logs/
ls -lah ~/.copilot/logs/

# Włącz debug logging:
copilot --log-level debug -p "test"
```

## 📚 Dokumentacja

- Oficjalna: https://docs.github.com/en/copilot/using-github-copilot/using-github-copilot-in-the-command-line
- Help: `copilot --help`
- Model: Claude Sonnet 4.5

## 🔗 Integracja z projektem EWW

### Makefile target (opcjonalnie):
```makefile
copilot-setup: ## Konfiguruj GitHub Copilot CLI z auto-approval
	@echo "🤖 Konfiguracja GitHub Copilot CLI"
	@cat ~/.copilot/config.json
	@echo ""
	@echo "✅ Auto-approval: enabled"
	@echo "✅ Trusted folder: /home/jakubc/git/eww"
```

### Alias w ~/.bashrc:
```bash
# GitHub Copilot shortcuts
alias cop='copilot'
alias copp='copilot -p'
alias copilot-config='cat ~/.copilot/config.json'
```

---

**Ostatnia aktualizacja:** 2025-11-22
**Utworzył:** jakubc
**Status:** ✅ Aktywne
