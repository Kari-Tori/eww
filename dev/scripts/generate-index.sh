#!/usr/bin/env bash
# generate-index.sh - Generuje główny plik INDEX.md
set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
readonly INDEX_FILE="$PROJECT_ROOT/INDEX.md"
readonly VERSION_FILE="$PROJECT_ROOT/config/VERSION"

# Kolory
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

# Funkcje pomocnicze
log_info() {
    echo -e "${BLUE}[INFO]${NC} $*"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $*"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $*"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $*" >&2
}

# Pobierz wersję projektu
get_version() {
    if [[ -f "$VERSION_FILE" ]]; then
        cat "$VERSION_FILE"
    else
        echo "0.0.0.0"
    fi
}

# Pobierz datę w formacie ISO
get_date() {
    date -u +%Y-%m-%dT%H:%M:%SZ
}

# Zlicz pliki Markdown
count_md_files() {
    find "$PROJECT_ROOT" -type f -name "*.md" 2>/dev/null | wc -l
}

# Zlicz skrypty Bash
count_sh_files() {
    find "$PROJECT_ROOT" -type f -name "*.sh" 2>/dev/null | wc -l
}

# Zlicz katalogi główne (bez ukrytych)
count_directories() {
    find "$PROJECT_ROOT" -maxdepth 1 -type d ! -name ".*" ! -path "$PROJECT_ROOT" | wc -l
}

# Sprawdź czy katalog ma folder note
has_folder_note() {
    local dir="$1"
    local basename
    basename=$(basename "$dir")
    [[ -f "$dir/$basename.md" ]]
}

# Generuj linię tabeli dla katalogu
generate_table_row() {
    local dir="$1"
    local description="$2"
    local basename
    basename=$(basename "$dir")

    if has_folder_note "$dir"; then
        echo "| \`$basename/\` | $description | [$basename.md]($basename/$basename.md) |"
    else
        echo "| \`$basename/\` | $description | ❌ Brak |"
    fi
}

# Główna funkcja generująca INDEX.md
generate_index() {
    local version
    local date_now
    local md_count
    local sh_count
    local dir_count

    version=$(get_version)
    date_now=$(get_date)
    md_count=$(count_md_files)
    sh_count=$(count_sh_files)
    dir_count=$(count_directories)

    log_info "Generuję INDEX.md..."
    log_info "Wersja: $version"
    log_info "Pliki .md: $md_count"
    log_info "Pliki .sh: $sh_count"
    log_info "Katalogi: $dir_count"

    cat > "$INDEX_FILE" <<EOF
---
tags:
  - #automation
  - #development
  - #eww
  - #folder_note
  - #index
  - #knowledge
  - #linux
  - #secondbrain
created: $date_now
modified: $date_now
author: jakubc
title: "📁 INDEX — Główny indeks repozytorium E-Waste Workshop"
---

# 📁 INDEX — Główny indeks repozytorium E-Waste Workshop

> **Nawigacja centralna** — szybki dostęp do wszystkich obszarów projektu

## 🎯 Skróty nawigacyjne

- 📖 [README.md](README.md) — wprowadzenie do projektu
- 📋 [CHANGELOG.md](CHANGELOG.md) — historia zmian
- 🤖 [docs/AGENTS.md](docs/AGENTS.md) — kontekst dla AI
- 🎯 [docs/MVP.md](docs/MVP.md) — cele MVP
- 📊 [docs/FULL-INDEX.md](docs/FULL-INDEX.md) — pełny indeks plików
- 🗺️ [EWW-MAP.md](EWW-MAP.md) — mapa koncepcyjna
- 📜 [STATUS-REPO.md](STATUS-REPO.md) — status repozytorium

## 🗂️ Struktura katalogów głównych

### 💼 Obszary biznesowe i zarządcze

| Katalog | Opis | Folder Note |
|---------|------|-------------|
$(generate_table_row "$PROJECT_ROOT/business" "Procesy biznesowe, finanse, sprzedaż")
$(generate_table_row "$PROJECT_ROOT/core" "SOP, polityki, szablony zarządcze")

### 🛠️ Obszary techniczne

| Katalog | Opis | Folder Note |
|---------|------|-------------|
$(generate_table_row "$PROJECT_ROOT/dev" "Warsztat deweloperski, PoC")
$(generate_table_row "$PROJECT_ROOT/scripts" "Automaty i narzędzia wsadowe")
$(generate_table_row "$PROJECT_ROOT/tools" "Narzędzia analityczne")

### 📚 Dokumentacja i konfiguracja

| Katalog | Opis | Folder Note |
|---------|------|-------------|
$(generate_table_row "$PROJECT_ROOT/docs" "Centralna dokumentacja techniczna")
$(generate_table_row "$PROJECT_ROOT/config" "Fragmenty konfiguracji bash/git")

### 🏗️ Infrastruktura

| Katalog | Opis | Folder Note |
|---------|------|-------------|
$(generate_table_row "$PROJECT_ROOT/infra" "Ansible, inventory, IaC")

### 👥 Obszary użytkowników

| Katalog | Opis | Folder Note |
|---------|------|-------------|
$(generate_table_row "$PROJECT_ROOT/usr" "Vault'y użytkowników (gitignore)")
$(generate_table_row "$PROJECT_ROOT/var" "Dane runtime, heartbeat")

### 📦 Pomocnicze

| Katalog | Opis | Folder Note |
|---------|------|-------------|
$(generate_table_row "$PROJECT_ROOT/archive" "Archiwa i backupy (gitignore)")
$(generate_table_row "$PROJECT_ROOT/Tags" "Taksonomia Obsidian")

## 📄 Pliki kluczowe w katalogu głównym

### Dokumentacja podstawowa
- \`README.md\` — główne wprowadzenie do projektu
- \`CHANGELOG.md\` — historia wersji (Keep a Changelog)
- \`config/VERSION\` — aktualny numer wersji ($version)

### Konfiguracja i automatyzacja
- \`Makefile\` — codzienne zadania (TODO, sync, migracje)
- \`init-eww.sh\` — podstawowy skrypt inicjalizacyjny

### Statusy i mapy
- \`STATUS-REPO.md\` — aktualny stan repozytorium
- \`EWW-MAP.md\` — mapa koncepcyjna projektu
- \`TAG-STRATEGY.md\` — strategia tagowania

## 🎨 System tagowania

### Tagi główne
- \`#eww\` — wszystkie pliki projektu
- \`#folder_note\` — folder notes / indeksy Waypoint
- \`#index\` — pliki indeksowe
- \`#automation\` — automatyzacja i skrypty
- \`#development\` — kod i narzędzia dev
- \`#docs\` — dokumentacja
- \`#knowledge\` — baza wiedzy

### Tagi obszarów
- \`#business\` — biznes i operacje
- \`#infrastructure\` — infrastruktura
- \`#linux\` — system Linux
- \`#productivity\` — produktywność
- \`#secondbrain\` — second brain / PKM

## 🔍 Jak nawigować?

1. **Szybki start**: Przejdź do [README.md](README.md)
2. **Konkretny obszar**: Wybierz katalog z tabeli powyżej
3. **Folder note**: Każdy katalog ma plik \`katalog/katalog.md\` z opisem
4. **Pełny przegląd**: Zobacz [docs/FULL-INDEX.md](docs/FULL-INDEX.md)
5. **Graf Obsidian**: Otwórz folder note i przełącz na lokalny graf

## 🛠️ Narzędzia indexowania

- \`make index\` — regeneruj wszystkie indeksy
- \`scripts/generate-index.sh\` — generuj INDEX.md automatycznie
- \`scripts/check-folder-notes.sh\` — sprawdź kompletność folder notes

## 📊 Statystyki

\`\`\`
Wersja: $version
Katalogi główne: $dir_count
Pliki .md: $md_count
Pliki .sh: $sh_count
Ostatnia aktualizacja: $(date +%Y-%m-%d)
\`\`\`

---

> [!TIP] Wskazówka
> Każdy folder note jest oznaczony tagiem \`#folder_note\` i świeci na niebiesko w grafie Obsidian. Używaj lokalnego grafu dla lepszej nawigacji w obrębie konkretnego obszaru.

> [!NOTE] Konwencja
> Wszystkie odwołania do ikon wykorzystują standard opisany w [docs/infra/assets/icons.md](docs/infra/assets/icons.md).
EOF

    log_success "Wygenerowano $INDEX_FILE"
}

# Główna funkcja
main() {
    cd "$PROJECT_ROOT" || {
        log_error "Nie można przejść do katalogu projektu: $PROJECT_ROOT"
        exit 1
    }

    generate_index

    log_success "Indexowanie zakończone!"
}

main "$@"
