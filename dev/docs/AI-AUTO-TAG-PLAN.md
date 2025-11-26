---
tags:
  - #automation
  - #development
  - #eww
  - #knowledge
  - #linux
  - #productivity
  - #secondbrain
created: 2025-11-21
author: jakubc

owner: jakubc
---

# 🤖 AI Auto-Tag System - Plan Wdrożenia

## 📊 Scope

- **572 pliki MD** do przetworzenia
- **7 tagów** dla każdego pliku (kontekstowe, generowane przez AI)
- **Continue.dev + Ollama** (100% lokalne, bez wysyłania danych)

---

## 🎯 System składa się z 3 skryptów:

### 1. `setup-continue-ollama.sh` - Instalacja i konfiguracja
```bash
./scripts/setup-continue-ollama.sh
```

**Co robi:**
- Instaluje Ollama (jeśli brak)
- Pobiera model CodeLlama 13B (~7GB)
- Konfiguruje Continue.dev API
- Uruchamia lokalny serwer AI

**Czas:** ~15-30 min (pobieranie modelu)

---

### 2. `clean-all-tags.sh` - Wyczyszczenie starych tagów
```bash
./scripts/clean-all-tags.sh
```

**Co robi:**
- Usuwa wszystkie frontmatter YAML z plików
- Czyści stare tagi
- Przygotowuje pliki do AI tagowania

**Czas:** ~30 sekund (572 pliki)

---

### 3. `ai-auto-tag.sh` - Główny proces tagowania
```bash
./scripts/ai-auto-tag.sh
```

**Co robi:**
- Iteruje przez wszystkie 572 pliki MD
- Dla każdego pliku:
- Progress bar: `[125/572] Processing: ./core/docker.md ✓ #docker #containers #devops ...`

**Czas:** ~47 minut (572 pliki × 5s/plik)

---

## 🔧 Przykład wygenerowanego YAML:

**Przed:**
```markdown
# Docker Setup Guide

Docker is a containerization platform...
```

**Po AI tagowaniu:**
```yaml
---
created: 2024-11-15
modified: 2025-11-21
---

# Docker Setup Guide

Docker is a containerization platform...
```

---

## 📈 Estimate czasu całkowitego:

1. **Setup Continue+Ollama:** 15-30 min (jednorazowo)
2. **Czyszczenie tagów:** 30s
3. **AI auto-tag:** 47 min (572 × 5s)

**TOTAL:** ~50 minut (pierwsze uruchomienie)  
**TOTAL:** ~48 minut (kolejne - bez setupu)

---

## ✅ Gotowe do uruchomienia!

**Krok 1:** Setup
```bash
cd /home/jakubc/git/eww
./scripts/setup-continue-ollama.sh
```

**Krok 2:** Wyczyść stare tagi
```bash
./scripts/clean-all-tags.sh
```

**Krok 3:** AI tagowanie
```bash
./scripts/ai-auto-tag.sh
```

**Monitoruj progress:**
```bash
# W drugim terminalu
watch -n1 cat /tmp/ai-tag-progress.txt
tail -f /tmp/ai-tag-log.txt
```

---

## 🔒 Bezpieczeństwo

- **100% lokalnie** - Continue.dev + Ollama działa na twoim komputerze
- **Brak wysyłania danych** - żadne pliki nie wychodzą na zewnątrz
- **Open source** - CodeLlama model od Meta

---

## 📝 Logi

- **Progress:** `/tmp/ai-tag-progress.txt` (current/total)
- **Full log:** `/tmp/ai-tag-log.txt` (każdy plik + tagi)

tags:
  - #setup
  - #docker
  - #plan
  - #eww
  - #general
  - #general
  - #general
tags:
  - #setup
  - #docker
  - #plan
  - #eww
  - #general
  - #general
  - #general

# 🤖 AI Auto-Tag System - Plan Wdrożenia

## 📊 Scope

- **572 pliki MD** do przetworzenia
- **7 tagów** dla każdego pliku (kontekstowe, generowane przez AI)
- **Continue.dev + Ollama** (100% lokalne, bez wysyłania danych)


## 🎯 System składa się z 3 skryptów:

### 1. `setup-continue-ollama.sh` - Instalacja i konfiguracja
```bash
./scripts/setup-continue-ollama.sh
```

**Co robi:**
- Instaluje Ollama (jeśli brak)
- Pobiera model CodeLlama 13B (~7GB)
- Konfiguruje Continue.dev API
- Uruchamia lokalny serwer AI

**Czas:** ~15-30 min (pobieranie modelu)


### 2. `clean-all-tags.sh` - Wyczyszczenie starych tagów
```bash
./scripts/clean-all-tags.sh
```

**Co robi:**
- Usuwa wszystkie frontmatter YAML z plików
- Czyści stare tagi
- Przygotowuje pliki do AI tagowania

**Czas:** ~30 sekund (572 pliki)


### 3. `ai-auto-tag.sh` - Główny proces tagowania
```bash
./scripts/ai-auto-tag.sh
```

**Co robi:**
- Iteruje przez wszystkie 572 pliki MD
- Dla każdego pliku:
  - Odczytuje zawartość
  - Wysyła do lokalnego AI (Ollama)
  - Otrzymuje 7 kontekstowych tagów
  - Aktualizuje frontmatter YAML
- Progress bar: `[125/572] Processing: ./core/docker.md ✓ #docker #containers #devops ...`

**Czas:** ~47 minut (572 pliki × 5s/plik)


## 🔧 Przykład wygenerowanego YAML:

**Przed:**
```markdown
# Docker Setup Guide

Docker is a containerization platform...
```

**Po AI tagowaniu:**
```yaml
tags:
  - #docker
  - #containers
  - #devops
  - #infrastructure
  - #deployment
  - #cloud-native
  - #automation
created: 2024-11-15
modified: 2025-11-21

# Docker Setup Guide

Docker is a containerization platform...
```


## 📈 Estimate czasu całkowitego:

1. **Setup Continue+Ollama:** 15-30 min (jednorazowo)
2. **Czyszczenie tagów:** 30s
3. **AI auto-tag:** 47 min (572 × 5s)

**TOTAL:** ~50 minut (pierwsze uruchomienie)  
**TOTAL:** ~48 minut (kolejne - bez setupu)


## ✅ Gotowe do uruchomienia!

**Krok 1:** Setup
```bash
cd /home/jakubc/git/eww
./scripts/setup-continue-ollama.sh
```

**Krok 2:** Wyczyść stare tagi
```bash
./scripts/clean-all-tags.sh
```

**Krok 3:** AI tagowanie
```bash
./scripts/ai-auto-tag.sh
```

**Monitoruj progress:**
```bash
# W drugim terminalu
watch -n1 cat /tmp/ai-tag-progress.txt
tail -f /tmp/ai-tag-log.txt
```


## 🔒 Bezpieczeństwo

- **100% lokalnie** - Continue.dev + Ollama działa na twoim komputerze
- **Brak wysyłania danych** - żadne pliki nie wychodzą na zewnątrz
- **Open source** - CodeLlama model od Meta


## 📝 Logi

- **Progress:** `/tmp/ai-tag-progress.txt` (current/total)
- **Full log:** `/tmp/ai-tag-log.txt` (każdy plik + tagi)

