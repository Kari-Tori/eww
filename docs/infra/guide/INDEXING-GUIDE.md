created: 2025-11-21T20:46:25Z
modified: 2025-11-24T22:34:18Z
author: jakubc
---
tags:
  - #automation
  - #development
  - #docs
  - #eww
  - #index
  - #knowledge
  - #navigation
title: "📑 System Indexowania — Przewodnik"
owner: jakubc
created: 2025-11-21T20:46:25Z
modified: 2025-11-24T22:34:18Z
author: jakubc
---

# 📑 System Indexowania — Przewodnik

> Kompletny przewodnik po systemie indexowania i nawigacji w repozytorium E-Waste Workshop

## 🎯 Przegląd

System indexowania w E-Waste Workshop składa się z trzech warstw:

1. **Główny INDEX.md** — centralny punkt nawigacji w katalogu głównym
2. **Folder notes** — pliki `katalog/katalog.md` dla każdego katalogu
3. **Narzędzia automatyzacji** — skrypty do generowania i weryfikacji indeksów

## 📁 Struktura indeksów

### Główny INDEX.md

Lokalizacja: `/home/jakubc/git/eww/INDEX.md`

Zawiera:
- 🎯 Skróty nawigacyjne do kluczowych dokumentów
- 🗂️ Tabelę katalogów głównych z opisami
- 🎨 System tagowania
- 🔍 Instrukcje nawigacji
- 📊 Statystyki projektu

### Folder Notes

Każdy katalog ma swój folder note: `katalog/katalog.md`

Format:
```markdown
created: 2025-11-21T20:46:25Z
modified: 2025-11-24T22:34:18Z
author: jakubc
---
tags:
  - #folder_note
  - #eww
  - #katalog_specyficzny
title: "📂 nazwa_katalogu"
created: 2025-11-21T20:46:25Z
modified: 2025-11-24T22:34:18Z
author: jakubc
---

# 📂 nazwa_katalogu

> Opis katalogu

## 📋 Zawartość
[lista plików i podkatalogów]

## 🔗 Powiązania
[linki do powiązanych dokumentów]
```

## 🛠️ Narzędzia

### generate-index.sh

**Lokalizacja:** `scripts/generate-index.sh`

**Funkcje:**
- Automatyczne generowanie INDEX.md
- Wykrywanie katalogów głównych
- Zliczanie plików .md i .sh
- Weryfikacja folder notes
- Generowanie tabel z linkami

**Użycie:**
```bash
# Bezpośrednio
./scripts/generate-index.sh

# Przez Makefile
make index
```

**Cechy:**
- Pobiera wersję z `config/VERSION`
- Używa kolorów w output
- Loguje wszystkie kroki
- Tworzy kompletny frontmatter YAML

### check-folder-notes.sh

**Lokalizacja:** `scripts/check-folder-notes.sh`

**Funkcje:**
- Weryfikacja folder notes w katalogu głównym
- Sprawdzanie podkatalogów (do N poziomów)
- Generowanie szablonów dla brakujących
- Raportowanie z kolorami

**Użycie:**
```bash
# Sprawdź tylko główne katalogi
./scripts/check-folder-notes.sh

# Sprawdź do głębokości 3
./scripts/check-folder-notes.sh -d 3

# Utwórz brakujące
./scripts/check-folder-notes.sh -c

# Przez Makefile
make check-folders
```

**Opcje:**
- `-c, --create` — tworzy brakujące folder notes
- `-d, --depth N` — sprawdza do głębokości N (domyślnie 2)
- `-h, --help` — pokazuje pomoc

### update-folder-indexes.sh

**Lokalizacja:** `scripts/update-folder-indexes.sh`

**Funkcje:**
- Automatyczne generowanie indeksów plików i podfolderów
- Aktualizacja istniejących indeksów
- Bezpieczne backupy przed modyfikacją
- Wsparcie dla jednego folderu lub wszystkich

**Użycie:**
```bash
# Aktualizuj wszystkie folder notes
./scripts/update-folder-indexes.sh -a

# Aktualizuj tylko jeden folder
./scripts/update-folder-indexes.sh docs

# Przez Makefile
make update-indexes
```

**Co dodaje:**
- Sekcja `## 📑 Index plików` — lista plików .md w folderze
- Sekcja `## 📁 Podfoldery` — lista podfolderów z linkami do ich folder notes

**Opcje:**
- `-a, --all` — aktualizuj wszystkie (domyślnie)
- `-h, --help` — pokazuje pomoc

## 🔧 Makefile Targets

### make index

Regeneruje główny INDEX.md z aktualną strukturą projektu.

```bash
make index
```

**Wykonuje:**

1. Uruchamia `scripts/generate-index.sh`
2. Skanuje strukturę katalogów
3. Zlicza pliki
4. Generuje INDEX.md z aktualnymi danymi

### make check-folders

Sprawdza kompletność folder notes w całym projekcie.

```bash
make check-folders
```

**Wykonuje:**

1. Uruchamia `scripts/check-folder-notes.sh`
2. Sprawdza katalogi główne
3. Sprawdza podkatalogi (do 2 poziomów)
4. Raportuje brakujące folder notes

### make update-indexes

Aktualizuje indeksy plików i podfolderów we wszystkich folder notes.

```bash
make update-indexes
```

**Wykonuje:**

1. Uruchamia `scripts/update-folder-indexes.sh -a`
2. Dla każdego folder note dodaje/aktualizuje:
   - Sekcję `## 📑 Index plików`
   - Sekcję `## 📁 Podfoldery`
3. Tworzy backupy przed modyfikacją

## 🎨 System tagowania

### Tagi indexowe

- `#index` — główne pliki indeksowe
- `#folder_note` — wszystkie folder notes (kolor niebieski w grafie)

### Tagi obszarów

- `#automation` — automatyzacja
- `#development` — kod deweloperski
- `#docs` — dokumentacja
- `#knowledge` — baza wiedzy
- `#navigation` — nawigacja

## 📊 Statystyki

Obecny stan (2025-11-21):

```text
Wersja projektu: 0.0.0.5
Katalogi główne: 12
Podkatalogi (poziom 2): 53
Podkatalogi (poziom 3): 178
Wszystkie katalogi: 304
Folder notes: 391 (100% pokrycie wszystkich katalogów!)
Folder notes z indeksami: 300+ (76.7%+)
Pliki .md: 664
Pliki .sh: ~116
Aktualizacja: make update-indexes-all (5 sekund dla 300+ katalogów)
```

## 🔍 Nawigacja

### W terminalu

```bash
# Wyświetl INDEX.md
cat INDEX.md

# Z kolorowaniem (bat)
bat INDEX.md

# Z Markdown rendering (glow)
glow INDEX.md
```

### W VS Code

1. Otwórz `INDEX.md`
2. Kliknij link do folder note
3. Używaj breadcrumbs do nawigacji

### W Obsidian

1. Otwórz `INDEX.md`
2. Przełącz na lokalny graf (`Ctrl+Shift+G`)
3. Folder notes świecą na niebiesko
4. Kliknij węzeł aby otworzyć

## 🚀 Workflow

### Dodawanie nowego katalogu

1. Stwórz katalog:
   ```bash
   mkdir nowy-katalog
   ```

2. Wygeneruj folder note:
   ```bash
   ./scripts/check-folder-notes.sh -c
   ```

3. Edytuj folder note:
   ```bash
   code nowy-katalog/nowy-katalog.md
   ```

4. Zaktualizuj INDEX.md:
   ```bash
   make index
   ```

### Regularna konserwacja

```bash
# Co tydzień
make check-folders  # Sprawdź folder notes
make index          # Zaktualizuj INDEX.md
make update-indexes # Zaktualizuj indeksy w folder notes

# Co miesiąc
make frontmatter    # Zaktualizuj frontmatter
make readme-check   # Sprawdź spójność README
```

## 🐛 Troubleshooting

### INDEX.md nie generuje się

```bash
# Sprawdź uprawnienia
ls -l scripts/generate-index.sh

# Nadaj uprawnienia
chmod +x scripts/generate-index.sh

# Uruchom bezpośrednio
./scripts/generate-index.sh
```

### Brakuje folder notes

```bash
# Sprawdź które brakują
./scripts/check-folder-notes.sh

# Wygeneruj automatycznie
./scripts/check-folder-notes.sh -c
```

### Makefile target nie działa

```bash
# Sprawdź składnię Makefile
make -n index

# Sprawdź logi błędów
make index 2>&1 | tee debug.log
```

## 📚 Powiązane dokumenty

- [INDEX.md](../INDEX.md) — główny indeks
- [README.md](../README.md) — wprowadzenie do projektu
- [docs/FULL-INDEX.md](../docs/FULL-INDEX.md) — pełny indeks plików
- [Makefile](../Makefile) — wszystkie targety
- [docs/infra/legacy/MAKEFILE-GUIDE.md](MAKEFILE-GUIDE.md) — przewodnik po Makefile

## 🔗 Zobacz też

- [eww.md](../eww.md) — główny folder note projektu
- [STATUS-REPO.md](../STATUS-REPO.md) — status repozytorium
- [EWW-MAP.md](../EWW-MAP.md) — mapa koncepcyjna

created: 2025-11-21T20:46:25Z
modified: 2025-11-24T22:34:18Z
author: jakubc
---

> [!TIP] Automatyzacja
> System indexowania jest w pełni zautomatyzowany. Wystarczy uruchamiać `make index` regularnie, aby utrzymać aktualny stan nawigacji.

> [!NOTE] Folder notes
> Każdy folder note powinien być oznaczony tagiem `#folder_note` — dzięki temu świeci na niebiesko w grafie Obsidian i jest łatwo rozpoznawalny.
