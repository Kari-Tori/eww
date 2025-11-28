---
tags:
  - #obsidian
  - #graph
  - #installation
  - #documentation
  - #secondbrain
created: 2025-11-23T17:30:00Z
modified: 2025-11-23T17:30:00Z
author: jakubc
title: "Obsidian Graph - Przewodnik instalacji"
owner: jakubc
---

# Obsidian Graph - Przewodnik instalacji

[← Powrót do README](README.md) | [Presety →](presets.md) | [Kolory →](colors.md)

---

## 📋 Spis treści

1. [Gdzie są pliki](#gdzie-są-pliki)
2. [Co robi każdy plik](#co-robi-każdy-plik)
3. [Po co te ustawienia](#po-co-te-ustawienia)
4. [Jak instalować](#jak-instalować)
5. [Troubleshooting](#troubleshooting)

---

## 📁 Gdzie są pliki

### Konfiguracja główna
\`\`\`
.obsidian/graph.json                    # ← Aktywna konfiguracja (ULTIMATE)
.obsidian/app.json                      # Ustawienia vault (graphMaxFileCount)
\`\`\`

### Presety
\`\`\`
.obsidian/graph-business.json           # Business view
.obsidian/graph-jakubc.json             # Personal view
.obsidian/graph-dev.json                # Development view
.obsidian/graph-minimal.json            # Tylko indexy
.obsidian/graph-performance.json        # Max wydajność
.obsidian/graph-ultra-fast.json         # Ultra szybki
\`\`\`

### Narzędzia
\`\`\`
dev/scripts/graph-switch.sh             # Skrypt przełączania presetów
\`\`\`

### Dokumentacja
\`\`\`
docs/infra/software/obsidian/graph/
├── README.md                           # Indeks dokumentacji
├── installation-guide.md               # Ten plik
├── presets.md                          # Szczegóły presetów
└── colors.md                           # Schemat kolorów
\`\`\`

### Backupy
\`\`\`
.obsidian/graph.json.backup-*           # Automatyczne backupy
.obsidian/graph-backups/                # Katalog backupów (tworzy skrypt)
\`\`\`

---

## 🔧 Co robi każdy plik

### \`.obsidian/graph.json\` - Główna konfiguracja

**Przeznaczenie**: Aktywnie używana konfiguracja grafu w Obsidianie

**Kluczowe sekcje**:

\`\`\`json
{
  // === FILTRY ===
  "search": "-path:core/var/logs -path:core/var/status -path:.git",
  
  // === WIDOCZNOŚĆ ===
  "showTags": true,              // ✅ Pokaż tagi jako węzły
  "showAttachments": true,       // ✅ Pokaż załączniki (PDF, PNG)
  "hideUnresolved": true,        // ✅ Ukryj nieistniejące linki
  "showOrphans": false,          // ✅ Ukryj niepowiązane pliki
  
  // === KOLORY ===
  "colorGroups": [               // 18 grup kolorów
    {
      "query": "tag:#folder_note",
      "color": {"a": 1, "rgb": 5227511}
    },
    // ... więcej grup
  ],
  
  // === FIZYKA ===
  "nodeSizeMultiplier": 1.5,     // Rozmiar węzłów
  "lineSizeMultiplier": 2,       // Grubość linii
  "textFadeMultiplier": -0.5,    // Widoczność etykiet (-1=zawsze)
  "centerStrength": 0.4,         // Grawitacja centrum
  "repelStrength": 12,           // Odpychanie węzłów
  "linkStrength": 0.6,           // Siła połączeń
  "linkDistance": 280            // Odległość węzłów (px)
}
\`\`\`

### \`dev/scripts/graph-switch.sh\` - Przełącznik presetów

**Co robi**:
1. Tworzy backup obecnej konfiguracji
2. Kopiuje wybrany preset do \`graph.json\`
3. Sprawdza czy Obsidian wymaga restartu
4. Może przywrócić backup

**Użycie**:
\`\`\`bash
# Interaktywnie
./dev/scripts/graph-switch.sh

# Bezpośrednio
./dev/scripts/graph-switch.sh business
./dev/scripts/graph-switch.sh jakubc
\`\`\`

---

## 💡 Po co te ustawienia

### \`showTags: true\` ✅

**Co to daje**:
- Tagi stają się węzłami grafu (np. #folder_note, #secondbrain)
- Widoczne "huby" tematyczne
- Łatwo znaleźć wszystkie notatki o danym temacie

**Przykład**: 
- Tag \`#folder_note\` → turkusowy węzeł z ~50 połączeniami
- Tag \`#secondbrain\` → magentowy węzeł z połączeniami do wiedzy

**Wyłącz jeśli**: Masz >100 różnych tagów (będzie gęsto)

### \`showAttachments: true\` ✅

**Co to daje**:
- Widoczne pliki PDF, PNG, MP4, etc.
- Widzisz które notatki mają media
- Kompletność dokumentacji

**Przykład**:
- \`diagram.png\` pojawi się jako węzeł
- Połączony z notatkami które go embedują

**Wyłącz jeśli**: Masz >200 załączników (spowolni graf)

### \`hideUnresolved: true\` ✅

**Co to daje**:
- Brak martwych linków w grafie
- Tylko działające połączenia
- Czytelniejszy widok

**Przykład**:
- Link \`[[Nieistniejący Plik]]\` → ukryty w grafie
- Link \`[[Istniejący Plik]]\` → widoczny

**Wyłącz jeśli**: Chcesz zobaczyć co brakuje (planowanie)

### \`showOrphans: false\` ✅

**Co to daje**:
- Brak samotnych, niepołączonych plików
- Graf tylko połączonej wiedzy
- Skupienie na relacjach

**Przykład**:
- Plik bez linków → ukryty
- Plik z >=1 linkiem → widoczny

**Włącz jeśli**: Chcesz znaleźć samotne notatki do linkowania

---

## 🚀 Jak instalować

### ✅ Setup już zainstalowany (2025-11-23)

Konfiguracja ULTIMATE PERFORMANCE jest już aktywna. Sprawdź:

\`\`\`bash
# Sprawdź ustawienia
cat .obsidian/graph.json | jq '{showTags,showAttachments,hideUnresolved,showOrphans}'

# Output powinien być:
# {
#   "showTags": true,
#   "showAttachments": true,
#   "hideUnresolved": true,
#   "showOrphans": false
# }
\`\`\`

### 🔄 Reinstalacja (gdyby coś poszło nie tak)

\`\`\`bash
# 1. Backup
cp .obsidian/graph.json .obsidian/graph.json.backup-manual

# 2. Zamknij Obsidiana
pkill -f obsidian
sleep 2

# 3. Przywróć ULTIMATE preset
cp .obsidian/graph.json.backup-pre-ultimate .obsidian/graph.json

# 4. Uruchom Obsidiana
obsidian &
\`\`\`

### 🎨 Zmiana presetu

\`\`\`bash
# Użyj skryptu (REKOMENDOWANE)
./dev/scripts/graph-switch.sh

# Lub ręcznie
pkill -f obsidian
cp .obsidian/graph-business.json .obsidian/graph.json
obsidian &
\`\`\`

### ⚙️ Edycja ręczna

**WAŻNE**: ZAWSZE zamykaj Obsidiana przed edycją!

\`\`\`bash
# 1. Zamknij Obsidiana
pkill -f obsidian

# 2. Edytuj
nano .obsidian/graph.json

# 3. Sprawdź syntax
cat .obsidian/graph.json | jq . > /dev/null && echo "OK" || echo "BŁĄD JSON"

# 4. Uruchom ponownie
obsidian &
\`\`\`

---

## 🔧 Troubleshooting

### Problem: Graf się nie zmienił

**Objawy**: Edytowałeś \`graph.json\` ale graf wygląda tak samo

**Rozwiązanie**:
\`\`\`bash
# 1. Całkowite zamknięcie Obsidiana
pkill -f obsidian
sleep 5

# 2. Sprawdź czy proces faktycznie zakończony
ps aux | grep obsidian | grep -v grep

# 3. Jeśli nadal działa - force kill
pkill -9 -f obsidian

# 4. Uruchom ponownie
obsidian &
\`\`\`

### Problem: Kolory nie działają

**Objawy**: Pliki mają zły kolor lub brak koloru

**Przyczyny**:
1. Kolejność \`colorGroups\` - pierwsze mają priorytet
2. Query nie pasuje do pliku
3. Cache Obsidiana

**Rozwiązanie**:
\`\`\`bash
# Sprawdź query
cat .obsidian/graph.json | jq '.colorGroups[] | .query' | head -20

# Usuń cache
rm -rf .obsidian/workspace*

# Restart
pkill -f obsidian && sleep 2 && obsidian &
\`\`\`

### Problem: Za wolny / laguje

**Objawy**: Graf się wiesza, Obsidian zwalnia

**Rozwiązania**:

1. **Użyj PERFORMANCE preset**:
\`\`\`bash
./dev/scripts/graph-switch.sh
> Wybierz: 6 (PERFORMANCE)
\`\`\`

2. **Zmniejsz max plików**:
\`\`\`bash
# Edytuj .obsidian/app.json
{
  "graphMaxFileCount": 500  // Było 1000
}
\`\`\`

3. **Ukryj załączniki**:
\`\`\`json
{
  "showAttachments": false,
  "showOrphans": false
}
\`\`\`

### Problem: Obsidian nadpisuje zmiany

**Objawy**: Twoje edycje znikają

**Przyczyna**: Obsidian zapisuje \`graph.json\` przy zamknięciu

**Rozwiązanie**:
- **ZAWSZE** zamykaj Obsidiana przed edycją
- Nie edytuj podczas gdy Obsidian działa
- Używaj skryptu \`graph-switch.sh\` (robi to automatycznie)

### Problem: Brak grup kolorów

**Objawy**: Graf bez kolorów / wszystko szare

**Rozwiązanie**:
\`\`\`bash
# Sprawdź JSON syntax
cat .obsidian/graph.json | jq . > /dev/null

# Jeśli błąd - przywróć backup
cp .obsidian/graph.json.backup-20251123-* .obsidian/graph.json

# Restart
pkill -f obsidian && obsidian &
\`\`\`

---

## 📊 Statystyki instalacji

### Obecna konfiguracja (2025-11-23)

- **Plików markdown**: 927
- **Grup kolorów**: 18
- **Presetów**: 6 (ultimate, business, jakubc, dev, minimal, performance)
- **Max file count**: 1000
- **Parametry fizyki**: Zoptymalizowane dla 900+ plików

### Ustawienia widoczności

| Parametr | Wartość | Efekt |
|----------|---------|-------|
| showTags | ✅ true | Tagi jako węzły |
| showAttachments | ✅ true | PDF/PNG widoczne |
| hideUnresolved | ✅ true | Bez martwych linków |
| showOrphans | ❌ false | Bez samotnych plików |

### Parametry fizyki

| Parametr | Standard | ULTIMATE | Powód |
|----------|----------|----------|-------|
| nodeSizeMultiplier | 1.0 | 1.5 | Lepiej widoczne |
| lineSizeMultiplier | 1.0 | 2.0 | Wyraźniejsze relacje |
| textFadeMultiplier | 0 | -0.5 | Zawsze widoczne nazwy |
| centerStrength | 0.1 | 0.4 | Silne centrum |
| repelStrength | 10 | 12 | Zbalansowane |
| linkDistance | 250 | 280 | Kompaktowy dla 900+ |

---

## 📚 Zobacz także

- [README.md](README.md) - Indeks dokumentacji
- [presets.md](presets.md) - Szczegóły wszystkich 6 presetów
- [colors.md](colors.md) - Schemat 18 kolorów
- [graph-rules.md](graph-rules.md) - Zasady kanoniczne (legacy)

---

**Ostatnia aktualizacja**: 2025-11-23  
**Wersja**: 1.0  
**Autor**: jakubc
