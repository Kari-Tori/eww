SHELL := bash
PREFIX ?= /usr/local
BINDIR := $(PREFIX)/bin

all:
	@true

install:
	install -d "$(DESTDIR)$(BINDIR)"
	install -m 755 scripts/eww-index.sh "$(DESTDIR)$(BINDIR)/eww-index"
	install -m 755 scripts/eww-init.sh  "$(DESTDIR)$(BINDIR)/eww-init"

uninstall:
	rm -f "$(DESTDIR)$(BINDIR)/eww-index" "$(DESTDIR)$(BINDIR)/eww-init"

# Zarządzanie changelog
changelog:
	@echo "Generowanie changelog z commitów Git..."
	@./dev/bin/eww-changelog --unreleased --dry-run

changelog-update:
	@echo "Aktualizacja CHANGELOG.md..."
	@./dev/bin/eww-changelog --unreleased

changelog-version:
	@if [ -z "$(VERSION)" ]; then \
		echo "Użyj: make changelog-version VERSION=x.y.z.b"; \
		exit 1; \
	fi
	@echo "$(VERSION)" > VERSION
	@./dev/bin/eww-changelog --version $(VERSION)
	@echo "Changelog wygenerowany dla wersji $(VERSION)"

# Wydanie nowej wersji
release:
	@if [ -z "$(VERSION)" ]; then \
		echo "Użyj: make release VERSION=x.y.z.b"; \
		exit 1; \
	fi
	@echo "Tworzę release $(VERSION)..."
	@$(MAKE) changelog-version VERSION=$(VERSION)
	@git add VERSION CHANGELOG.md
	@git commit -m "chore(release): $(VERSION)"
	@git tag -a "v$(VERSION)" -m "Release $(VERSION)"
	@echo "Release $(VERSION) utworzony. Użyj: git push origin main --tags"

# Zarządzanie README
readme-check:
	@echo "Sprawdzanie README.md..."
	@if [ -f scripts/check_readme.sh ]; then \
		bash scripts/check_readme.sh; \
	else \
		echo "Brak skryptu check_readme.sh"; \
	fi

readme-update-version:
	@echo "Aktualizacja wersji w README.md..."
	@if [ -f VERSION ]; then \
		VERSION=$$(cat VERSION | tr -d '[:space:]'); \
		sed -i "s/^Wersja:.*/Wersja: $$VERSION/" README.md; \
		echo "Zaktualizowano wersję na: $$VERSION"; \
	else \
		echo "Brak pliku VERSION"; \
		exit 1; \
	fi

readme-from-branch:
	@if [ -z "$(BRANCH)" ]; then \
		echo "Użyj: make readme-from-branch BRANCH=nazwa-gałęzi"; \
		exit 1; \
	fi
	@echo "Pobieranie README.md z gałęzi $(BRANCH)..."
	@git show origin/$(BRANCH):README.md > README.md
	@echo "README.md zaktualizowany z gałęzi $(BRANCH)"

readme-preview:
	@echo "Podgląd README.md..."
	@if command -v glow >/dev/null 2>&1; then \
		glow README.md; \
	elif command -v bat >/dev/null 2>&1; then \
		bat README.md; \
	else \
		cat README.md; \
	fi

# Automatyczne komentarze w kodzie
comment-add:
	@if [ -z "$(FILE)" ]; then \
		echo "Użyj: make comment-add FILE=ścieżka/do/pliku.sh"; \
		exit 1; \
	fi
	@echo "Dodawanie komentarzy do $(FILE)..."
	@./dev/bin/eww-auto-comment "$(FILE)"

comment-add-all:
	@echo "Dodawanie komentarzy do wszystkich plików w lib/ i dev/bin/..."
	@for file in lib/*.sh dev/bin/eww-*; do \
		if [ -f "$$file" ]; then \
			echo "Przetwarzam: $$file"; \
			./dev/bin/eww-auto-comment "$$file" 2>/dev/null || true; \
		fi \
	done
	@echo "Gotowe!"

comment-preview:
	@if [ -z "$(FILE)" ]; then \
		echo "Użyj: make comment-preview FILE=ścieżka/do/pliku.sh"; \
		exit 1; \
	fi
	@./dev/bin/eww-auto-comment --dry-run "$(FILE)"

# AI-powered helpers (używaj Copilot chat)
help:
	@echo "Dostępne targety:"
	@echo ""
	@echo "📦 Podstawowe:"
	@echo "  make install              - Instaluj skrypty"
	@echo "  make uninstall            - Odinstaluj skrypty"
	@echo ""
	@echo "📝 Changelog:"
	@echo "  make changelog            - Podgląd zmian"
	@echo "  make changelog-update     - Aktualizuj CHANGELOG.md"
	@echo "  make release VERSION=x    - Wydaj nową wersję"
	@echo ""
	@echo "📄 README:"
	@echo "  make readme-preview       - Podgląd README"
	@echo "  make readme-update-version - Aktualizuj wersję"
	@echo "  make readme-from-branch BRANCH=x - Pobierz z gałęzi"
	@echo ""
	@echo "💬 Komentarze:"
	@echo "  make comment-add FILE=x   - Dodaj komentarze"
	@echo "  make comment-add-all      - Komentuj wszystkie pliki"
	@echo ""
	@echo "🌲 Drzewo:"
	@echo "  make tree                 - Drzewo katalogów z opisami"
	@echo "  make tree-full            - Pełne drzewo"
	@echo ""
	@echo "📇 Indeks:"
	@echo "  make index                - Generuj INDEX.md"
	@echo "  make index-preview        - Podgląd INDEX.md"
	@echo ""
	@echo "📝 Frontmatter:"
	@echo "  make frontmatter FILE=x   - Dodaj YAML frontmatter"
	@echo "  make frontmatter-dry FILE=x - Podgląd frontmatter"
	@echo ""
	@echo "🤖 Użyj GitHub Copilot chat do pomocy!"

ai-commit:
	@echo "🤖 Generuję commit message z AI..."
	@git diff --cached > /tmp/eww-diff.txt
	@echo "Poproś Copilot: 'wygeneruj commit message dla zmian w /tmp/eww-diff.txt'"
	@echo "Lub użyj: gh copilot suggest 'commit message dla staged changes'"

ai-review:
	@echo "🤖 Przegląd kodu z AI..."
	@if [ -z "$(FILE)" ]; then \
		echo "Użyj: make ai-review FILE=ścieżka/do/pliku"; \
		echo "Lub: make ai-review-all dla wszystkich zmienionych plików"; \
		exit 1; \
	fi
	@echo "Otwórz Copilot chat i zapytaj: 'przeanalizuj $(FILE)'"

ai-review-all:
	@echo "🤖 Przegląd wszystkich zmian..."
	@git status --short
	@echo ""
	@echo "Poproś Copilot: 'przeanalizuj wszystkie zmiany w projekcie'"

# Drzewo katalogów z opisami
tree:
	@./dev/bin/eww-tree -L 3

tree-full:
	@./dev/bin/eww-tree --full

tree-lib:
	@./dev/bin/eww-tree -L 4 lib

tree-dev:
	@./dev/bin/eww-tree -L 4 dev

# Indeks projektu
index:
	@./dev/bin/eww-index

index-preview:
	@if command -v glow >/dev/null 2>&1; then \
		glow INDEX.md; \
	else \
		cat INDEX.md; \
	fi

# YAML frontmatter
frontmatter:
	@if [ -z "$(FILE)" ]; then \
		echo "Użyj: make frontmatter FILE=ścieżka/do/pliku.md"; \
		exit 1; \
	fi
	@./dev/bin/eww-frontmatter --auto "$(FILE)"

frontmatter-dry:
	@if [ -z "$(FILE)" ]; then \
		echo "Użyj: make frontmatter-dry FILE=ścieżka/do/pliku.md"; \
		exit 1; \
	fi
	@./dev/bin/eww-frontmatter --auto --dry-run "$(FILE)"

.PHONY: all install uninstall changelog changelog-update changelog-version release
.PHONY: readme-check readme-update-version readme-from-branch readme-preview
.PHONY: comment-add comment-add-all comment-preview
.PHONY: tree tree-full tree-lib tree-dev
.PHONY: index index-preview
.PHONY: frontmatter frontmatter-dry
.PHONY: help ai-commit ai-review ai-review-all
