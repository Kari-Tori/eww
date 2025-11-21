SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help

# --- Konfiguracja główna ----------------------------------------------------
TODO_FILE := usr/jakubc/todo.md
TODO_SSH_FILE := usr/jakubc/TODO-SSH.md
SSH_HOST := karinam@192.168.0.77
REMOTE_REPO := /usr/karinam/git/eww
LOCAL_REPO := /jakubc/git/eww
LEGACY_REPO := /git/eww
BACKUP_ROOT := /jakubc/git
LOCAL_GIT_ROOT := /git/eww
CONFIG_CODE := $(HOME)/.config/Code
CONFIG_OBSIDIAN := $(HOME)/.config/obsidian
CONFIG_VSCODE := $(HOME)/.vscode

# --- Helpers -----------------------------------------------------------------
.PHONY: help todo todo-paczki todo-obiad todo-ebay todo-posciel todo-ssh \
	backup-gerc prepare-target ssh-remote-check ssh-remote-git ssh-remote-config \
	sync-dry sync-run sync-perms sync-configs diff-repos sync-legacy-dry \
	sync-legacy set-alias git-verify project-check \
	install uninstall test test-bats lint clean \
	version bump-version changelog readme-check frontmatter frontmatter-dry \
	tag auto-tag git-status git-push obsidian-fix vscode-fix \
	doctor banner status commit graph-report graph-connect graph-dry \
	git-batch git-history git-uncommit index check-folders update-indexes update-indexes-all \
	graph-status graph-validate graph-backup graph-clean \
	repo-check repo-clean repo-stats

help: ## Wyświetl dostępne cele Makefile (plan dnia + operacje SSH + narzędzia eww)
	@echo "E-Waste Workshop :: TODO + TODO-SSH"
	@echo ""
	@awk 'BEGIN {FS = ":.*##"; printf "Dostępne cele:\n\n"} \
		/^[a-zA-Z0-9_.-]+:.*##/ {printf "  %-22s %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo ""
	@echo "Przykład: make sync-run"

# --- Plan dnia (usr/jakubc/todo.md) -----------------------------------------
todo: ## Podgląd pełnego planu dnia z usr/jakubc/todo.md
	@if command -v glow >/dev/null 2>&1; then \
		glow $(TODO_FILE); \
	elif command -v bat >/dev/null 2>&1; then \
		bat $(TODO_FILE); \
	else \
		cat $(TODO_FILE); \
	fi

todo-paczki: ## Instrukcja pakowania i wysyłki (GTX1060 + trzy GTR1660)
	@printf "%s\n" \
		"📦 Wysyłka paczek (zob. usr/jakubc/todo.md)" \
		"1. Paczka #1 – karta GTX1060." \
		"2. Paczka #2 – trzy karty GTR1660." \
		"3. Paczka #3 – kup nową etykietę ≤ 10 £ (najtańsza opcja)." \
		"4. Zdjęcia etykiet i opisy są na WhatsAppie." \
		"5. Pokazujesz kod paczki -> pani drukuje etykietę -> naklejasz." \
		"6. Odbierz potwierdzenia nadania i schowaj." \
		"7. Dostarcz paczki przed zamknięciem okienek."

todo-obiad: ## Instrukcja podgrzania obiadu
	@printf "%s\n" \
		"🍗 Obiad z lodówki:" \
		"- Na pierwszej półce znajdziesz piersi z kurczaka i ziemniaki." \
		"- Podgrzej w piekarniku ~180°C przez ok. 20 minut." \
		"- Dorzuć surówkę stojącą obok."

todo-ebay: ## Przypomnienie o kliencie eBay les.sara61
	@printf "%s\n" \
		"💌 Klientka eBay: les.sara61" \
		"- Napisz jej dzisiaj wiadomość, żeby miała spokojną głowę." \
		"- Potwierdź status wysyłki w spokojnym tonie."

todo-posciel: ## Zadanie z pościelą przed powrotem Kariny
	@printf "%s\n" \
		"🛏️ Pościel:" \
		"- Przed powrotem Kariny zdejmij aktualną pościel." \
		"- Nowy komplet czeka – Karina założy go po przyjściu."

todo-ssh: ## Podgląd szczegółowego planu migracji SSH (usr/jakubc/TODO-SSH.md)
	@if command -v glow >/dev/null 2>&1; then \
		glow $(TODO_SSH_FILE); \
	elif command -v bat >/dev/null 2>&1; then \
		bat $(TODO_SSH_FILE); \
	else \
		cat $(TODO_SSH_FILE); \
	fi

# --- Migracja repo (TODO-SSH) -----------------------------------------------
backup-gerc: ## Krok 1: backup /git/eww do /jakubc/git z timestampem
	@cd $(LOCAL_GIT_ROOT) && git status
	@sudo mkdir -p $(BACKUP_ROOT)
	@ts=$$(date +%Y%m%d_%H%M%S); \
		echo "📦 Tworzę backup do $(BACKUP_ROOT)/eww_backup_$$ts"; \
		sudo cp -a $(LOCAL_GIT_ROOT) "$(BACKUP_ROOT)/eww_backup_$$ts"

prepare-target: ## Krok 2: przygotuj /jakubc/git/eww i prawa
	@sudo mkdir -p $(LOCAL_REPO)
	@sudo chown -R $$USER:$$USER $(BACKUP_ROOT)
	@df -h /jakubc

ssh-remote-check: ## Krok 3: sprawdź ścieżki i miejsce na Asus_Z77
	@ssh $(SSH_HOST) 'cd $(REMOTE_REPO) && hostname && pwd && df -h .'

ssh-remote-git: ## Krok 4: status Gita i ostatnie commity na Asus_Z77
	@ssh $(SSH_HOST) 'cd $(REMOTE_REPO) && git status -sb && git log --oneline -15 && git log --since="2025-10-15" --stat'

ssh-remote-config: ## Krok 5: zrzut konfiguracji VS Code/Obsidian na Asus_Z77
	@ssh $(SSH_HOST) 'tree -L 2 ~/.config/Code > ~/code_config_tree.txt && tree -L 2 ~/.config/obsidian > ~/obsidian_config_tree.txt && ls -la ~/.vscode'

sync-dry: ## Krok 6: rsync dry-run Asus_Z77 -> /jakubc/git/eww
	@rsync -avh --dry-run --progress $(SSH_HOST):$(REMOTE_REPO)/. $(LOCAL_REPO)/

sync-run: ## Krok 6: rsync właściwy Asus_Z77 -> /jakubc/git/eww
	@rsync -avh --progress $(SSH_HOST):$(REMOTE_REPO)/. $(LOCAL_REPO)/

sync-perms: ## Krok 7: napraw uprawnienia w /jakubc/git/eww
	@sudo chown -R $$USER:$$USER $(LOCAL_REPO)
	@find $(LOCAL_REPO) -type d -exec chmod 755 {} \;
	@find $(LOCAL_REPO) -type f -exec chmod 644 {} \;

sync-configs: ## Krok 8: backup i rsync konfiguracji Code/Obsidian/VSCode
	@mkdir -p $(CONFIG_CODE)_backup $(CONFIG_OBSIDIAN)_backup $(CONFIG_VSCODE)_backup
	@cp -a $(CONFIG_CODE)/. $(CONFIG_CODE)_backup/ || true
	@cp -a $(CONFIG_OBSIDIAN)/. $(CONFIG_OBSIDIAN)_backup/ || true
	@cp -a $(CONFIG_VSCODE)/. $(CONFIG_VSCODE)_backup/ || true
	@rsync -avh --progress $(SSH_HOST):~/.config/Code/ $(CONFIG_CODE)/
	@rsync -avh --progress $(SSH_HOST):~/.vscode/ $(CONFIG_VSCODE)/
	@rsync -avh --progress $(SSH_HOST):~/.config/obsidian/ $(CONFIG_OBSIDIAN)/

diff-repos: ## Krok 9: porównaj /git/eww vs /jakubc/git/eww
	@ts=$$(date +%Y%m%d_%H%M); \
		diff -qr $(LEGACY_REPO) $(LOCAL_REPO) | tee $(BACKUP_ROOT)/diff_eww_$$ts.log

sync-legacy-dry: ## Krok 10: dry-run rsync z /git/eww -> /jakubc/git/eww
	@rsync -avh --dry-run --progress $(LEGACY_REPO)/ $(LOCAL_REPO)/

sync-legacy: ## Krok 10: rsync brakujących plików z /git/eww -> /jakubc/git/eww
	@rsync -avh --progress $(LEGACY_REPO)/ $(LOCAL_REPO)/

set-alias: ## Krok 11: dodaj alias proj i otwórz repo w VS Code
	@grep -qxF 'alias proj="cd $(LOCAL_REPO)"' ~/.bashrc || \
		echo 'alias proj="cd $(LOCAL_REPO)"' >> ~/.bashrc
	@. ~/.bashrc
	@if command -v code >/dev/null 2>&1; then \
		code $(LOCAL_REPO); \
	else \
		echo "VS Code niedostępny – pomiń ręcznie"; \
	fi

git-verify: ## Krok 12: sprawdź status/log w nowym repo
	@cd $(LOCAL_REPO) && git status
	@cd $(LOCAL_REPO) && git log --graph --oneline -10

project-check: ## Krok 13: npm install + lint/test/dev w nowym repo
	@cd $(LOCAL_REPO) && npm install
	@cd $(LOCAL_REPO) && npm run lint && npm test
	@cd $(LOCAL_REPO) && npm run dev

# ============================================================================
# Podstawowe operacje eww
# ============================================================================

.PHONY: install uninstall test test-bats lint clean

install: ## Instaluj pomocnicze binaria do PREFIX (domyślnie ~/bin)
	@echo "📦 Instalacja eww..."
	@PREFIX=${PREFIX:-~/bin} && \
		mkdir -p "$$PREFIX" && \
		cp -v bin/eww-* "$$PREFIX/" && \
		chmod +x "$$PREFIX"/eww-* && \
		echo "✅ Zainstalowano do $$PREFIX"

uninstall: ## Usuń zainstalowane binaria eww-*
	@echo "🗑️  Odinstalowanie eww..."
	@PREFIX=${PREFIX:-~/bin} && \
		rm -vf "$$PREFIX"/eww-* && \
		echo "✅ Odinstalowano z $$PREFIX"

test: test-bats ## Uruchom testy Bats

test-bats: ## Uruchom wszystkie testy z tests/
	@echo "🧪 Uruchamiam testy Bats..."
	@command -v bats >/dev/null || (echo "❌ Bats nie zainstalowany: sudo apt install bats" && exit 1)
	@bats tests/

lint: ## Sprawdź kod shellcheck
	@echo "🔍 ShellCheck..."
	@command -v shellcheck >/dev/null || (echo "❌ ShellCheck nie zainstalowany: sudo apt install shellcheck" && exit 1)
	@find bin lib scripts -type f \( -name "*.sh" -o ! -name "*.*" \) -exec shellcheck {} \; 2>&1 | head -50

clean: ## Usuń pliki tymczasowe (*.bak, *.tmp)
	@echo "🧹 Czyszczenie..."
	@find . -type f \( -name "*.bak" -o -name "*.tmp" \) -delete
	@echo "✅ Wyczyszczono"

# ============================================================================
# Wersjonowanie i changelog
# ============================================================================

.PHONY: version bump-version changelog

version: ## Wyświetl aktualną wersję projektu
	@echo "📌 Wersja projektu:"
	@./scripts/version.sh 2>/dev/null || cat VERSION 2>/dev/null || echo "0.0.0"

bump-version: ## Zwiększ wersję (MAJOR, MINOR lub PATCH)
	@echo "🔼 Zwiększanie wersji..."
	@./scripts/bump-version.sh $(BUMP)

changelog: ## Wygeneruj CHANGELOG.md na podstawie commitów
	@echo "📝 Generowanie changelog..."
	@./scripts/generate-changelog.sh || echo "❌ Brak skryptu generate-changelog.sh"

# ============================================================================
# README i dokumentacja
# ============================================================================

.PHONY: readme-check

readme-check: ## Sprawdź spójność README, VERSION i notatek wydania
	@echo "📄 Sprawdzanie README..."
	@./scripts/check_readme.sh

# ============================================================================
# Indexowanie i nawigacja
# ============================================================================

.PHONY: index check-folders

index: ## Regeneruj główny plik INDEX.md
	@echo "📑 Regeneracja INDEX.md..."
	@./scripts/generate-index.sh

check-folders: ## Sprawdź kompletność folder notes
	@echo "📂 Sprawdzanie folder notes..."
	@./scripts/check-folder-notes.sh

update-indexes: ## Aktualizuj indeksy w folder notes (poziom 1)
	@echo "📑 Aktualizacja indeksów w folder notes..."
	@./scripts/update-folder-indexes.sh -a

update-indexes-all: ## Aktualizuj indeksy we WSZYSTKICH folder notes (poziomy 1-3)
	@echo "📑 Aktualizacja WSZYSTKICH indeksów (poziomy 1-3)..."
	@./scripts/update-folder-indexes.sh -a -d 3

graph-status: ## Pokaż status konfiguracji grafu Obsidian
	@./scripts/graph-config.sh status

graph-validate: ## Waliduj konfigurację grafu
	@./scripts/graph-config.sh validate

graph-backup: ## Utwórz backup konfiguracji grafu
	@./scripts/graph-config.sh backup

graph-clean: ## Wyczyść stare backupy grafu
	@./scripts/graph-config.sh clean

repo-check: ## Sprawdź czystość struktury repozytorium
	@./scripts/clean-repo.sh check

repo-clean: ## Wyczyść pliki .bak.* i tymczasowe
	@./scripts/clean-repo.sh clean

repo-stats: ## Pokaż statystyki repozytorium
	@./scripts/clean-repo.sh stats

# ============================================================================
# Frontmatter i tagging
# ============================================================================

.PHONY: frontmatter frontmatter-dry auto-tag

frontmatter: ## Wygeneruj/zaktualizuj frontmatter YAML we wszystkich plikach
	@echo "🏷️  Generowanie frontmatter..."
	@./scripts/eww-frontmatter.sh .

frontmatter-dry: ## Podgląd frontmatter bez zapisywania (dry-run)
	@echo "👁️  Podgląd frontmatter (dry-run)..."
	@./scripts/eww-frontmatter.sh --dry-run . | head -100

auto-tag: ## Automatyczne tagowanie wszystkich plików
	@echo "🏷️  Automatyczne tagowanie..."
	@./scripts/eww-auto-tag.sh . || echo "❌ Brak skryptu eww-auto-tag.sh"

# ============================================================================
# Git operacje
# ============================================================================

.PHONY: tag git-status git-push commit

tag: ## Automatyczne tagowanie Git (eww-auto-tag.sh)
	@echo "🏷️  Tworzenie tagu Git..."
	@./scripts/eww-auto-tag.sh git-tag 2>/dev/null || echo "❌ Użyj: git tag -a v1.0.0 -m 'Release 1.0.0'"

git-status: ## Status Git z podsumowaniem
	@echo "📊 Git status:"
	@git status -sb
	@echo ""
	@echo "Ostatnie 10 commitów:"
	@git log --oneline -10

git-push: ## Push do origin z tagami
	@echo "⬆️  Pushing to origin..."
	@git push origin $(shell git branch --show-current)
	@git push --tags

commit: ## Interaktywny commit z Conventional Commits
	@echo "💬 Commit..."
	@./bin/eww-commit 2>/dev/null || git commit

# ============================================================================
# Narzędzia diagnostyczne i naprawcze
# ============================================================================

.PHONY: obsidian-fix vscode-fix doctor banner status

obsidian-fix: ## Napraw konfigurację Obsidian vault
	@echo "🔧 Naprawianie Obsidian..."
	@./scripts/eww-obsidian-fix.sh --fix

vscode-fix: ## Wyczyść cache VS Code (Service Worker errors)
	@echo "🔧 Czyszczenie VS Code cache..."
	@./scripts/eww-vscode-fix.sh --all

doctor: ## Diagnostyka środowiska (eww-doctor)
	@echo "🩺 Sprawdzanie środowiska..."
	@./bin/eww-doctor 2>/dev/null || echo "❌ Brak bin/eww-doctor"

banner: ## Wyświetl banner eww
	@./bin/eww-banner 2>/dev/null || echo "E-Waste Workshop"

status: ## Status projektu eww (Git + environment)
	@echo "📊 Status projektu E-Waste Workshop"
	@echo ""
	@./bin/eww-status 2>/dev/null || (echo "Git:" && git status -sb && echo "" && echo "Wersja:" && cat VERSION 2>/dev/null)

# ============================================================================
# GitHub & AI Tools
# ============================================================================

.PHONY: github-setup github-auth github-status

github-setup: ## Install GitHub CLI, Copilot, Continue.dev
	@echo "🚀 Installing GitHub & AI tools..."
	@./bin/eww-github-setup

github-auth: ## Authenticate with GitHub CLI
	@echo "🔐 Authenticating with GitHub..."
	@gh auth login

github-status: ## Check GitHub tools status
	@echo "📊 GitHub Tools Status:"
	@echo ""
	@echo "GitHub CLI:"
	@command -v gh >/dev/null && gh --version || echo "  ❌ Not installed"
	@echo ""
	@echo "GitHub Auth:"
	@gh auth status 2>/dev/null || echo "  ❌ Not authenticated"
	@echo ""
	@echo "Copilot CLI:"
	@gh extension list 2>/dev/null | grep copilot || echo "  ❌ Not installed"
	@echo ""
	@echo "VS Code Extensions:"
	@command -v code >/dev/null && code --list-extensions | grep -E "(Continue|copilot)" || echo "  ❌ VS Code not found"

# ============================================================================
# Graf dokumentacji
# ============================================================================

graph-report: ## Raport stanu grafu (połączone/izolowane pliki)
	@python3 scripts/eww-connect-graph.py --report

graph-dry: ## Podgląd proponowanych połączeń (bez zapisywania)
	@python3 scripts/eww-connect-graph.py --dry-run

graph-connect: ## Połącz izolowane węzły grafu (UWAGA: modyfikuje pliki!)
	@echo "🔗 Łączenie izolowanych węzłów grafu..."
	@python3 scripts/eww-connect-graph.py
	@echo "✅ Gotowe. Sprawdź: make graph-report"



# ============================================================================
# Git Batch Commits (max 18 plików/commit dla Obsidian Graph)
# ============================================================================

git-batch: ## Batch commit zmian (max 18 plików/commit)
	@./scripts/git-commit-batch.sh

git-history: ## Pokaż ostatnie 20 commitów
	@git --no-pager log --oneline -n 20 --color=always --graph --decorate

git-uncommit: ## Cofnij ostatni commit (zachowaj zmiany)
	@echo "🔙 Cofam ostatni commit..."
	@git reset HEAD~1
	@echo "✅ Commit cofnięty. Pliki zachowane. Użyj 'make git-batch' do batch commit."

# Makefile.graph - Komendy do zarządzania grafami

.PHONY: graph-help graph-setup graph-clusters graph-tune graph-check graph-reset

graph-help: ## Pokaż pomoc dla grafów
	@echo "🎨 EWW Graph Management"
	@echo "======================"
	@echo ""
	@echo "Dostępne komendy:"
	@echo "  make graph-setup     - Podstawowa konfiguracja grafów"
	@echo "  make graph-clusters  - Konfiguruj izolowane klastry"
	@echo "  make graph-tune      - Interaktywny tuning separacji"
	@echo "  make graph-backlinks - Dodaj backlinki do plików"
	@echo "  make graph-check     - Sprawdź stan klastrów"
	@echo "  make graph-reset     - Przywróć domyślną konfigurację"
	@echo ""

graph-setup: ## Podstawowa konfiguracja grafów
	@echo "🔧 Konfiguracja grafów..."
	bash fix-graph-clusters.sh

graph-clusters: graph-setup ## Alias dla graph-setup

graph-tune: ## Interaktywny tuning separacji
	@echo "🎨 Tuning separacji klastrów..."
	bash tune-graph-separation.sh

graph-backlinks: ## Dodaj backlinki do plików
	@echo "🔗 Dodawanie backlinków..."
	bash auto-backlinks.sh

graph-check: ## Sprawdź stan klastrów
	@echo "🔍 Sprawdzanie klastrów..."
	@for path in core config business usr/jakubc usr/karinam docs infra scripts tools; do \
		if [ -d "$$path" ]; then \
			total=$$(find "$$path" -name "*.md" -type f 2>/dev/null | wc -l); \
			with_links=$$(find "$$path" -name "*.md" -type f -exec grep -l '\[\[' {} \; 2>/dev/null | wc -l); \
			percent=$$((with_links * 100 / total)); \
			echo "  $$path: $$with_links/$$total ($$percent%)"; \
		fi; \
	done

graph-reset: ## Przywróć domyślną konfigurację
	@echo "⚠️  Przywracanie domyślnej konfiguracji..."
	@if [ -f .obsidian/backups/graph.json.backup ]; then \
		cp .obsidian/backups/graph.json.backup .obsidian/graph.json; \
		echo "✅ Przywrócono backup"; \
	else \
		echo "❌ Brak pliku backup"; \
	fi
