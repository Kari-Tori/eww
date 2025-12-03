---
title: PokexGames - AI Companion
description: Pomysł na AI companion dla gry MMORPG PokexGames inspirowanej Pokemon
version: 0.0.5
created: 2025-12-02
updated: 2025-12-03
status: idea
tags:
  - idea
  - pokexgames
  - ai
  - gaming
  - mmorpg
  - pokemon
owner: karinam
---

# PokexGames

## Opis projektu

**PokeXGames** to darmowa przeglądarkowa gra MMORPG inspirowana światem Pokemon. Gracze mogą łapać i trenować własną drużynę z ponad 400 stworów, wybierać różne profesje (Inżynier, Poszukiwacz Przygód, Stylista, Professor) oraz budować swoje dziedzictwo jako Mistrz.

## Linki

- 🌐 Strona główna: [pokexgames.com](https://pokexgames.com)
- 📱 [Instagram](https://www.instagram.com/playpokexgames)
- 📘 [Facebook](https://www.facebook.com/pokexgames)
- 🐦 [Twitter](https://twitter.com/pokexgames)
- 💬 [Discord](https://discord.com/invite/3Hxs4XT)

## Funkcjonalności

- Ponad 400 stworzeń do złapania i trenowania
- System profesji (Inżynier, Poszukiwacz Przygód, Stylista, Professor)
- Multiplayer - tysiące graczy online
- Tworzenie przedmiotów, mechanizmów i dekoracji
- Eksploracja grobowców i odkrywanie tajemnic
- Hodowla jagód o unikalnych właściwościach

## Cel projektu

Stworzenie AI companion, który będzie:
- Grał w PokeXGames jako towarzysz
- Komunikował się wewnątrz gry
- Wspierał gracza w rozgrywce
- Uczył się strategii i taktyk

## Architektura AI Companion

### Komponenty

1. **Game Interface Layer** - komunikacja z grą
   - OCR do odczytu interfejsu gry
   - Automatyzacja akcji w grze (kliki, ruchy)
   - Parser danych z gry (HP, lokalizacja, inwentarz)

2. **AI Decision Engine** - podejmowanie decyzji
   - Model LLM do komunikacji (GPT/Claude/Llama)
   - System strategii walki
   - Zarządzanie drużyną Pokemon
   - Planowanie tras i zadań

3. **Communication Module** - komunikacja z graczem
   - Parser czatu w grze
   - Generator odpowiedzi kontekstowych
   - System komend głosowych (opcjonalnie)

4. **Memory & Learning** - pamięć i uczenie
   - Baza wiedzy o Pokemon (statystyki, typy, ruchy)
   - Historia interakcji z graczem
   - Zapisywanie strategii i doświadczeń

### Technologie

- **Python** - główny język
- **OpenCV / Tesseract** - OCR i rozpoznawanie obrazu
- **PyAutoGUI** - automatyzacja interfejsu
- **LangChain** - orchestracja AI
- **ChromaDB / FAISS** - vector database dla pamięci
- **Lokalne modele LLM** - patrz sekcja poniżej

## Silniki AI - lokalne modele

### Modele językowe (LLM)

| Model | Rozmiar | RAM | VRAM | Szybkość | Jakość | Przypadek użycia |
|-------|---------|-----|------|----------|--------|------------------|
| **Llama 3.2 3B** | 3B | 8GB | 4GB | ⚡⚡⚡ | ⭐⭐⭐ | Szybkie odpowiedzi czatu |
| **Llama 3.1 8B** | 8B | 16GB | 8GB | ⚡⚡ | ⭐⭐⭐⭐ | Balans szybkość/jakość |
| **Mistral 7B** | 7B | 16GB | 6GB | ⚡⚡ | ⭐⭐⭐⭐ | Dobre rozumowanie |
| **Phi-3 Mini** | 3.8B | 8GB | 4GB | ⚡⚡⚡ | ⭐⭐⭐ | Niskie wymagania |
| **Gemma 2 9B** | 9B | 16GB | 8GB | ⚡⚡ | ⭐⭐⭐⭐ | Wysokiej jakości |
| **Qwen 2.5 7B** | 7B | 16GB | 6GB | ⚡⚡ | ⭐⭐⭐⭐ | Wielojęzyczny |

#### Modele Vision (do OCR i rozpoznawania gry)

| Model | Rozmiar | VRAM | Przypadek użycia |
|-------|---------|------|------------------|
| **LLaVA 1.6 7B** | 7B | 8GB | OCR + rozumienie UI |
| **MiniCPM-V 2.6** | 8B | 8GB | Szybkie vision |
| **Qwen2-VL 7B** | 7B | 8GB | Vision + text |

#### Frameworki uruchomieniowe

1. **Ollama** (ZALECANE - najprostsze)
   - Instalacja: `curl -fsSL https://ollama.com/install.sh | sh`
   - Użycie: `ollama run llama3.2:3b`
   - API kompatybilne z OpenAI
   - Auto-zarządzanie modelami

2. **llama.cpp** (dla maksymalnej wydajności)
   - Kompilacja z CUDA/ROCm
   - Kwantyzacja (Q4, Q5, Q8)
   - Najniższe zużycie pamięci

3. **vLLM** (dla produkcji)
   - Najszybszy inference
   - Batch processing
   - Wymaga GPU

### Strategia wyboru modeli

```python
# Szybkie decyzje in-game → Llama 3.2 3B (kwantyzacja Q4)
# Złożone strategie → Llama 3.1 8B (kwantyzacja Q5)
# Vision/OCR → MiniCPM-V 2.6 (kwantyzacja Q4)
# Wszystko działa lokalnie - zero kosztów API, pełna prywatność
```

## Wymagania sprzętowe

### Minimalna konfiguracja (Budget)

```
CPU: 4 rdzenie (Intel i5/AMD Ryzen 5)
RAM: 16GB DDR4
GPU: NVIDIA GTX 1660 (6GB VRAM) lub AMD RX 6600
Dysk: 50GB SSD
Model: Llama 3.2 3B + Phi-3 Mini (kwantyzacja Q4)
FPS gry: 30-60 (może wymagać obniżenia jakości)
```

### Zalecana konfiguracja (Optimal)

```
CPU: 8 rdzeni (Intel i7/AMD Ryzen 7)
RAM: 32GB DDR4/DDR5
GPU: NVIDIA RTX 3060 (12GB VRAM) lub RTX 4060 Ti
Dysk: 100GB NVMe SSD
Model: Llama 3.1 8B + MiniCPM-V 2.6 (kwantyzacja Q5/Q8)
FPS gry: 60+ (pełna jakość)
```

### Konfiguracja enthusiast (Maksymalna wydajność)

```
CPU: 12+ rdzeni (Intel i9/AMD Ryzen 9)
RAM: 64GB DDR5
GPU: NVIDIA RTX 4070 Ti/4080 (16GB VRAM)
Dysk: 200GB NVMe SSD
Model: Llama 3.1 70B (kwantyzacja Q4) + Qwen2-VL
FPS gry: 144+ (ultra jakość)
Możliwość równoległego przetwarzania
```

### Kwantyzacja - zmniejszenie wymagań VRAM

| Format | Jakość | VRAM (7B model) | Szybkość |
|--------|--------|-----------------|----------|
| FP16 | 100% | 14GB | Wolna |
| Q8 | 99% | 8GB | Średnia |
| Q5_K_M | 95% | 5GB | Szybka |
| Q4_K_M | 90% | 4GB | Bardzo szybka |
| Q3_K_M | 80% | 3GB | Ultra szybka |

### Benchmark wydajności (tokens/s)

**Llama 3.1 8B Q4_K_M:**
- RTX 4090: ~120 tok/s
- RTX 4070: ~80 tok/s
- RTX 3060: ~50 tok/s
- GTX 1660: ~25 tok/s
- CPU (16 rdzeni): ~8 tok/s

## Optymalizacja dla EWW (używany sprzęt)

Sprawdź swój sprzęt:
```bash
# GPU
lspci | grep -i vga
nvidia-smi  # dla NVIDIA

# RAM
free -h

# CPU
lscpu | grep -E "Model name|CPU\(s\):"
```

### Strategia wdrożenia na dostępnym sprzęcie

1. **Jeśli masz GPU NVIDIA (6GB+)**
   ```bash
   # Zainstaluj Ollama
   curl -fsSL https://ollama.com/install.sh | sh

   # Pobierz model
   ollama pull llama3.2:3b

   # Test
   ollama run llama3.2:3b "Cześć, jestem twoim AI companion!"
   ```

2. **Jeśli masz tylko CPU/słabe GPU**
   ```bash
   # Użyj najmniejszych modeli z kwantyzacją Q4
   ollama pull phi3:mini
   ollama pull llama3.2:1b  # ekstremalnie lekki
   ```

3. **Monitoring zużycia zasobów**
   ```bash
   # Podczas działania AI + gry
   htop
   watch -n 1 nvidia-smi
   ```

## Koszty rozwiązania lokalnego

- **Sprzęt**: już posiadany (£0) lub upgrade GPU: £200-£600 (jednorazowo)
- **Energia**: ~£5-15/mies (zależnie od użytkowania)
- **Opłaty za API**: £0 ✅ (wszystko lokalnie)
- **Prywatność**: pełna ✅ (dane nie opuszczają komputera)

### Etapy rozwoju

#### Faza 1: Podstawy (MVP) - 2-3 tygodnie
- [ ] Rozpoznawanie interfejsu gry (OCR) - 3-5 dni
- [ ] Podstawowa automatyzacja (ruch, walka) - 4-6 dni
- [ ] Odczyt czatu w grze - 2-3 dni
- [ ] Proste odpowiedzi tekstowe - 2-3 dni
- [ ] Instalacja i konfiguracja Ollama - 1 dzień

**Wynik:** Bot potrafi się poruszać, walczyć i odpowiadać na proste pytania

#### Faza 2: Inteligencja - 3-4 tygodnie
- [ ] Integracja z lokalnym LLM (Llama 3.2 3B) - 4-5 dni
- [ ] System decyzyjny (walka, eksploracja) - 5-7 dni
- [ ] Zarządzanie drużyną Pokemon - 4-5 dni
- [ ] Strategia wyboru profesji - 3-4 dni
- [ ] Baza wiedzy Pokemon (typy, efektywności) - 3-4 dni

**Wynik:** Bot podejmuje inteligentne decyzje i rozumuje strategicznie

#### Faza 3: Zaawansowane funkcje - 4-6 tygodni
- [ ] Model Vision (MiniCPM-V) dla lepszego OCR - 5-7 dni
- [ ] Uczenie się z rozgrywki (reinforcement learning) - 7-10 dni
- [ ] Współpraca z graczem (questy, walki Boss) - 5-7 dni
- [ ] Wymiana przedmiotów i Pokemon - 3-4 dni
- [ ] Osobowość i styl konwersacji - 4-5 dni
- [ ] System pamięci długoterminowej (ChromaDB) - 3-4 dni

**Wynik:** Bot ma osobowość, uczy się i współpracuje z graczem

#### Faza 4: Optymalizacja - 2-3 tygodnie
- [ ] Multi-threading dla płynności - 4-5 dni
- [ ] Dashboard monitoringu (Flask/Streamlit) - 3-4 dni
- [ ] Optymalizacja wydajności (profiling) - 3-4 dni
- [ ] API dla zewnętrznych integracji - 2-3 dni
- [ ] Dokumentacja użytkownika - 2-3 dni

**Wynik:** Produkcyjny, zoptymalizowany system

## Harmonogram wdrożenia

### Scenariusz ekspresowy (minimum viable product)
**Czas: 6-8 tygodni (1.5-2 miesiące)**
- Tylko Faza 1 + Faza 2
- Podstawowa funkcjonalność
- Jeden model (Llama 3.2 3B)
- Proste strategie walki

### Scenariusz zbalansowany (recommended)
**Czas: 12-16 tygodni (3-4 miesiące)**
- Faza 1 + Faza 2 + Faza 3 (częściowo)
- Inteligentny companion z osobowością
- Dwa modele (LLM + Vision)
- Zaawansowane strategie

### Scenariusz pełny (production-ready)
**Czas: 16-24 tygodnie (4-6 miesięcy)**
- Wszystkie fazy
- Pełna funkcjonalność
- Optymalizacja i monitoring
- Dokumentacja i API

### Praca w godzinach

| Intensywność | Godz/tydzień | MVP (Faza 1+2) | Zbalansowany | Pełny |
|--------------|--------------|----------------|--------------|-------|
| **Hobby** (5-10h) | 5-10h | 10-14 tyg | 20-28 tyg | 30-40 tyg |
| **Part-time** (15-20h) | 15-20h | 6-8 tyg | 12-16 tyg | 16-24 tyg |
| **Full-time** (35-40h) | 35-40h | 3-4 tyg | 6-8 tyg | 8-12 tyg |

### Kamienie milowe (Milestones)

**Tydzień 1-2:** 🎯 Setup środowiska
- Instalacja Python, Ollama, dependencies
- Pierwszy test z modelem lokalnym
- Podstawowy kod do łączenia z grą

**Tydzień 3-4:** 🎯 Pierwszy ruch
- Bot loguje się do gry
- Porusza się po mapie
- Rozpoznaje podstawowe elementy UI

**Tydzień 5-6:** 🎯 Pierwsza walka
- Bot inicjuje walkę
- Wybiera ataki
- Wygrywa prostą walkę

**Tydzień 8-10:** 🎯 Pierwsza konwersacja
- Bot odpowiada na pytania w czacie
- Używa LLM do generowania odpowiedzi
- Rozumie kontekst rozmowy

**Tydzień 12-14:** 🎯 Autonomiczny gameplay
- Bot samodzielnie gra przez 1h
- Łapie Pokemon
- Zarządza inwentarzem

**Tydzień 16-20:** 🎯 Inteligentny companion
- Współpraca z graczem
- Zaawansowane strategie
- Osobowość i preferencje

### Czynniki ryzyka (mogą wydłużyć czas)

⚠️ **Techniczne:**
- Problemy z OCR (nieczytelny interfejs) - +1-2 tyg
- Anti-bot detection - +2-4 tyg (obejście)
- Słaby sprzęt (długie inference) - +1-2 tyg (optymalizacja)

⚠️ **Projektowe:**
- Złożoność mechanik gry - +2-3 tyg
- Brak dokumentacji API gry - +1-2 tyg
- Zmiany w grze (updates) - +1 tyg na adaptację

⚠️ **Edukacyjne:**
- Uczenie się Computer Vision - +1-2 tyg
- Uczenie się LLM integration - +1 tyg
- Uczenie się game automation - +1 tyg

### Rekomendacja start

**Podejście iteracyjne (ZALECANE):**
1. **Sprint 1 (2 tyg):** Proof of concept - bot się loguje i porusza
2. **Sprint 2 (2 tyg):** Bot walczy i odpowiada na czacie
3. **Sprint 3 (2 tyg):** Integracja z LLM - inteligentne decyzje
4. **Dalej:** Dodawanie funkcji co 1-2 tygodnie

**Przewidywany czas do działającego MVP: 6-8 tygodni** przy part-time (15-20h/tyg)

## Struktura projektu

```
pokexgames/
├── pokexgames.md           # Główna dokumentacja
├── ai-companion/           # Kod AI companion
│   ├── game_interface/     # Interfejs z grą
│   ├── ai_engine/          # Silnik AI
│   ├── communication/      # Moduł komunikacji
│   ├── memory/             # System pamięci
│   └── utils/              # Narzędzia pomocnicze
├── data/                   # Dane i bazy wiedzy
│   ├── pokemon_db/         # Baza Pokemon
│   ├── strategies/         # Strategie i taktyki
│   └── chat_history/       # Historia konwersacji
├── tests/                  # Testy
└── docs/                   # Dokumentacja techniczna
```

## Wyzwania techniczne

1. **Terms of Service** - sprawdzić regulamin gry (czy boty są dozwolone)
2. **Anti-bot detection** - unikanie wykrycia jako bot
3. **Performance** - OCR i AI w czasie rzeczywistym
4. **Reliability** - stabilność połączenia i działania

## Linki

- [[dev]]
- [[INDEX]]
