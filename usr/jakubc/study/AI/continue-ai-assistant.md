---
version: 0.0.1
modified: 2025-11-25
title: Continue - AI Coding Assistant
category: AI Tools
type: IDE Extension
status: Recommended
cost: FREE
ollama_support: YES
created: 2025-11-25
---

# Continue - AI Coding Assistant

## Podstawowe informacje

- **Typ:** Interactive coding assistant
- **Integracja:** VS Code / JetBrains
- **Licencja:** Apache 2.0 (Open Source)
- **Koszt:** FREE
- **Repozytorium:** https://github.com/continuedev/continue
- **Dokumentacja:** https://docs.continue.dev

## Główne funkcje

### 1. Tab Autocomplete
- Automatyczne uzupełnianie kodu podczas pisania
- Kontekstowe sugestie
- Działa jak GitHub Copilot, ale lokalnie

### 2. Chat w IDE
- Pytania o kod w oknie VS Code
- Wyjaśnienia funkcji
- Code review w czasie rzeczywistym
- Sugestie refaktoringu

### 3. Code Actions
- "Napisz tę funkcję"
- "Dodaj testy"
- "Dokumentuj to"
- "Znajdź błąd"

## Konfiguracja z Ollama

### Moja gotowa konfiguracja
Lokalizacja: `/home/karinam/git/eww/dev/cfg/continue-config.json`

```json
{
  "models": [
    {
      "title": "Qwen 2.5 Coder 7B (Remote)",
      "provider": "ollama",
      "model": "qwen2.5-coder:7b",
      "apiBase": "http://localhost:11434"
    },
    {
      "title": "Llama 3 8B (Remote)",
      "provider": "ollama",
      "model": "llama3:8b",
      "apiBase": "http://localhost:11434"
    }
  ],
  "tabAutocompleteModel": {
    "title": "Qwen Autocomplete",
    "provider": "ollama",
    "model": "qwen2.5-coder:7b",
    "apiBase": "http://localhost:11434"
  },
  "embeddingsProvider": {
    "provider": "ollama",
    "model": "nomic-embed-text",
    "apiBase": "http://localhost:11434"
  }
}
```

## Instalacja

### Krok 1: Instalacja rozszerzenia
```bash
code --install-extension continue.continue
```

### Krok 2: Konfiguracja
```bash
# Stwórz katalog konfiguracyjny
mkdir -p ~/.continue

# Skopiuj gotową konfigurację
cp /home/karinam/git/eww/dev/cfg/continue-config.json ~/.continue/config.json
```

### Krok 3: Sprawdź Ollama
```bash
# Sprawdź czy Ollama działa
curl http://localhost:11434/api/tags

# Pobierz potrzebne modele (jeśli nie masz)
ollama pull qwen2.5-coder:7b
ollama pull llama3:8b
ollama pull nomic-embed-text
```

### Krok 4: Restart VS Code
- Zamknij i otwórz VS Code
- Continue powinno być aktywne w pasku bocznym

## Użycie

### Autocomplete
- Po prostu pisz kod
- Continue będzie podpowiadać w szarym kolorze
- `Tab` aby zaakceptować

### Chat
- Otwórz panel Continue (ikona w pasku bocznym)
- Zadawaj pytania o kod
- Zaznacz kod → kliknij prawym → "Continue: ..."

### Komendy
- `Ctrl+L` - Otwórz chat
- `Ctrl+I` - Inline edit
- `Ctrl+Shift+R` - Refactor selection

## Zalety

✅ **Całkowicie darmowe** - licencja open source  
✅ **Lokalnie z Ollama** - zero kosztów API, prywatność  
✅ **Wbudowane w VS Code** - tam gdzie pracujesz  
✅ **Tab autocomplete** - productivity boost  
✅ **Prosty setup** - 5 minut  
✅ **Kontrola** - Ty decydujesz o zmianach

## Wady

⚠️ **Nie autonomiczny** - asystent, nie agent  
⚠️ **Wymaga interakcji** - musisz akceptować sugestie  
⚠️ **Lokalne modele** - wolniejsze niż GPT-4

## Przypadki użycia

### Idealne dla:
- Codzienne kodowanie z asystentem
- Quick questions o kod
- Code explanations
- Refactoring suggestions
- Writing tests
- Documentation

### NIE idealne dla:
- Autonomiczne wykonywanie całych tasków
- "Zrób to za mnie od A do Z"
- Duże refaktoringi bez nadzoru

## Porównanie z alternatywami

| Funkcja | Continue | GitHub Copilot | Cursor |
|---------|----------|----------------|--------|
| Koszt | FREE | $10-19/m | $20/m |
| Ollama | ✅ | ❌ | ❌ |
| Lokalne | ✅ | ❌ | Częściowo |
| VS Code | ✅ | ✅ | Własny editor |
| Open Source | ✅ | ❌ | ❌ |

## Podsumowanie

**Continue = najlepszy wybór dla lokalnego AI coding assistant**

- Darmowy i open source
- Działa z moją lokalną Ollamą
- Prosty w setupie
- Produktywność od zaraz
- Pełna kontrola nad kodem

## Status
✅ **Gotowe do użycia** - mam już config w `/git/eww/dev/cfg/`

## Limity pamięci (zapobiega OOM w VS Code)

### Problem
Continue + Ollama mogą zużywać za dużo RAM → VS Code crashuje (OOM)

### Rozwiązanie
Konfiguracja limitów w `/etc/systemd/system/ollama.service.d/override.conf`:

```ini
[Service]
Environment="OLLAMA_MAX_LOADED_MODELS=1"    # Tylko 1 model w VRAM
Environment="OLLAMA_NUM_PARALLEL=1"          # 1 request na raz
Environment="OLLAMA_MAX_QUEUE=2"             # Max 2 w kolejce
Environment="OLLAMA_KEEP_ALIVE=2m"           # Zwalniaj po 2 min
```

**Restart po zmianach:**
```bash
sudo systemctl daemon-reload
sudo systemctl restart ollama
```

### Efekt
- RAM: ~2-3 GB mniej używane
- VRAM: tylko 1 model naraz (swap gdy przełączasz)
- VS Code: stabilny, bez crashy

## Następne kroki
1. Install extension
2. Copy config
3. Verify Ollama
4. Configure limits (jeśli OOM)
5. Start coding!

## 🔗 Backlinks

- [[usr/jakubc/study/AI/AI]]
- [[usr/jakubc/jakubc]]
- [[EWW-MAP]]