---
tags:
  - #automation
  - #docs
  - #eww
  - #graph
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T18:00:00Z
modified: 2025-11-21T18:00:00Z
author: jakubc
title: "📊 RAPORT CZYSZCZENIA GRAFU OBSIDIANA"






owner: jakubc
---



# 📊 RAPORT CZYSZCZENIA GRAFU OBSIDIANA

**Data:** 2025-11-21  
**Lokalizacja:** `/home/jakubc/git/eww`


## 🎯 PROBLEM

**Przed czyszczeniem:**
- 5996 plików .md
- **57% (3431 plików) bez żadnych linków** ← główny problem
- 21% (1315 plików) z wikilinkami
- 1310 pustych/prawie pustych plików (≤3 linie)

**Efekt:** Graf Obsidiana pełen niezwiązanych kropek, brak nawigacji, chaos.


## ✅ CO ZOSTAŁO ZROBIONE

### 1. Usunięcie Pustych Plików
- **1310 plików** → `.cleanup/empty/`
- Zachowano strukturę folderów dla łatwej weryfikacji

### 2. Archiwizacja Starych Vaultów
- **5 kopii starych vaultów** → `.cleanup/old-vaults/`
- Zwolniono miejsce i uprościono strukturę

### 3. Utworzenie Systemu INDEX
Utworzono główny `INDEX.md` i sub-indexy dla:
- `eww/INDEX.md` - E-Waste Workshop
- `business/INDEX.md` - Biznes
- `dev/INDEX.md` - Development
- `usr/karinam/INDEX.md` - Workspace Kariny
- `usr/jakubc/INDEX.md` - Workspace Jakuba
- `META/INDEX.md` - CI/CD & Pipelines
- `docs/index.md` - Dokumentacja
- `archive/INDEX.md` - Archiwum
- `Tags/INDEX.md` - System tagów

### 4. Konsolidacja Daily Notes
- **36 daily notes** → `journal/daily/`
- Utworzono `journal/INDEX.md`


## 📈 STATYSTYKI PO CZYSZCZENIU

| Metryka | Przed | Po | Zmiana |
|---------|-------|-------|--------|
| Pliki .md (aktywne) | 5996 | 3723 | **-2273 (-38%)** |
| Puste pliki | 1310 | 0 | -1310 ✓ |
| Pliki INDEX | 0 | 9+ | +9 ✓ |
| Daily notes (scentralizowane) | 0 | 36 | +36 ✓ |


## 🔍 CO DALEJ - REKOMENDACJE

### Priorytet 1: Połącz INDEX z zawartością
**Status:** INDEX files utworzone, ale trzeba dodać więcej linków wewnętrznych

**Akcje:**
```bash
# Dodaj linki w najważniejszych plikach
1. Otwórz INDEX.md w Obsidian
2. Nawiguj przez podfoldery
3. W plikach o wartościowej treści dodaj:
   - [[INDEX]] na górze
   - Linki do powiązanych tematów
```

### Priorytet 2: Usuń stary vault z inbox
**Status:** Stara kopia nadal w `inbox/e-waste_workshop_vault/` (7.1GB)

**Akcja:**
```bash
cd /home/jakubc/git/eww
rm -rf inbox/e-waste_workshop_vault
```

### Priorytet 3: Dodaj auto-linking dla tagów
**Status:** Dużo plików z tagami, ale bez wzajemnych połączeń

**Akcja:**
1. W Obsidian Settings → Files & Links → włącz "Automatically update internal links"
2. Użyj Dataview queries w INDEX files:
```markdown
## Pliki z tagiem #eww
```dataview
LIST FROM #eww
```
```

### Priorytet 4: Sprawdź i zachowaj wartościowe orphany
**Status:** ~2000 plików bez linków nadal istnieje

**Akcja:**
```bash
# Lista największych orphanów (mogą być wartościowe)
find . -name "*.md" ! -path "./.cleanup/*" ! -path "./inbox/e-waste_workshop_vault/*" -exec sh -c '
    if ! grep -qE "\[\[.*\]\]" "$1" 2>/dev/null; then
        wc -l "$1" 2>/dev/null
    fi
' _ {} \; | sort -rn | head -20
```

### Priorytet 5: Git commit zmian
**Status:** Dużo zmian, warto commitować etapami

**Akcja:**
```bash
git add INDEX.md */INDEX.md journal/
git commit -m "feat: add INDEX files and consolidate journal"

git add .cleanup/
git commit -m "chore: move empty files and old vaults to cleanup"
```


## 📁 STRUKTURA VAULT PO CZYSZCZENIU

```
/home/jakubc/git/eww/
├── INDEX.md                    ← GŁÓWNY PUNKT WEJŚCIA
├── eww/                        ← E-Waste Workshop
│   └── INDEX.md
├── business/                  ← Biznes
│   └── INDEX.md
├── dev/                        ← Development
│   └── INDEX.md
├── usr/
│   ├── karinam/               ← Workspace Kariny
│   │   └── INDEX.md
│   └── jakubc/                ← Workspace Jakuba
│       └── INDEX.md
├── journal/                    ← Daily notes (nowe)
│   ├── INDEX.md
│   └── daily/                 ← 36 daily notes
├── docs/                       ← Dokumentacja
│   └── INDEX.md
├── archive/                    ← Archiwum
│   └── INDEX.md
├── Tags/                       ← System tagów
│   └── INDEX.md
├── META/                       ← CI/CD
│   └── INDEX.md
└── .cleanup/                   ← DO WERYFIKACJI I USUNIĘCIA
    ├── empty/                 ← 1310 pustych plików
    └── old-vaults/            ← Stare kopie vaultów
```


## 🎨 POPRAWA GRAFU W OBSIDIAN

1. **Otwórz INDEX.md** - to centrum grafu
2. **Graph View Settings:**
   - Włącz: "Orphans" (czerwone) - pokażą się pliki bez linków
   - Filters → Add → "path:.cleanup" (exclude)
   - Filters → Add → "path:inbox/e-waste_workshop_vault" (exclude)
3. **Zobacz różnicę** - powinno być ~40% mniej niezwiązanych kropek


## ⚠️ BEZPIECZEŃSTWO

**Wszystkie usunięte pliki są w `.cleanup/`**

Możesz je przywrócić:
```bash
# Przywróć wszystko
cp -r .cleanup/empty/* .

# Lub wybiórczo
cp .cleanup/empty/usr/karinam/konkretny-plik.md usr/karinam/
```

**Po weryfikacji (tydzień?), usuń `.cleanup/`:**
```bash
rm -rf .cleanup/
```


## 📞 WSPARCIE

Jeśli coś poszło nie tak:
1. Sprawdź `.cleanup/` - wszystko tam jest
2. Git history - możesz cofnąć commity
3. Backup vaulta: `inbox/e-waste_workshop_vault/` (do usunięcia po weryfikacji)


**Koniec raportu**
