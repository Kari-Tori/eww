---
tags:
  - #automation
  - #development
  - #eww
  - #jakubc
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T17:00:00Z
modified: 2025-11-21T17:00:00Z
author: jakubc
title: "🧠 EMBEDDINGS AI / SECOND-BRAIN INDEX"






---
---
title: 🧠 EMBEDDINGS AI / SECOND-BRAIN INDEX
  - smart-connections
  - embeddings
  - obsidian
  - ai-index
  - retrieval
  - rag
  - personal
  - blue
  - jakubc
status: draft
updated: 2025-11-21
aliases:
  - 🧠 EMBEDDINGS AI / SECOND-BRAIN INDEX
linter-yaml-title-alias: 🧠 EMBEDDINGS AI / SECOND-BRAIN INDEX
date created: 2025-11-21
date modified: poniedziałek, październik 27. 2025, 9:00:56 pm
layout: article
icon: 🧠
"group:": |-
  ⚡ Smart Connections 
  🚀 High Performance
focus: |-
  semantyczne linkowanie
  wyszukiwanie po znaczeniu
  RAG
secondbrain: "true"
module: embeddings
dv_ready: "true"
color: blue
---

# 🧠 EMBEDDINGS AI / SECOND-BRAIN INDEX

> [!summary] 🎛 Funkcja
> Embedding = zamiana tekstu w wektor liczb → wektor można porównywać → "to jest podobne do tamtego".
>
> Użycie w Secondbrain:
> - 🔗 automatyczne linkowanie notatek
> - 🔍 wyszukiwanie semantyczne ("znajdź podobny SOP / zgłoszenie / objaw")
> - 🧩 RAG
>
> Dwie klasy modeli:
> - ⚡ Smart Connections → 💻 lekkie, lokalne, na laptopie
> - 🚀 High Performance → 🏭 cięższe, 8K kontekst, PL+EN, centralna baza wiedzy

Każdy model ma stałe pola do Dataview:
- `model::`
- `class::` (smart-connections / high-performance)
- `role::` (block_index / note_index / writing-assist)
- `dim::`
- `context_tokens::`
- `params_m::`
- `lang::`
- `multilang::` (true/false)
- `ram_fp16_mb::`
- `cpu_min_threads::`
- `cpu_rec_threads::`
- `gpu_required::` (none / optional / required / recommended)
- `host_ram_gb_min::`
- `tier::` (light / medium / heavy)
- `repo::`

To pozwala filtrować modele z poziomu Obsidiana.

---

## 0. 🏗 ARCHITEKTURA SECOND-BRAIN

### 0.1 🧱 Block index vs 📄 Note index

🧱 **Block index (FRAGMENTY)**  
- Jednostka: 🔩 akapit, ✅ checklist, 🔧 krok naprawy, 🎫 ticket serwisowy  
- Modele krótkiego kontekstu (~512 tokenów)  
- Niski koszt, szybka inferencja  
- Wektor: **384-dim**

📄 **Note index (CAŁE PLIKI)**  
- Jednostka: 📄 pełna notatka `.md`  
  (📘 SOP, 📝 intake, 🛠 raport serwisowy, 🔥 post-mortem)  
- Modele długiego kontekstu (2K / 4K / 8K tokenów)  
- Mają złapać sens całego dokumentu jako jednej całości  
- Wektor: **512–768 dim**

📦 System trzyma DWIE bazy wektorowe:

| Index         | Jednostka wejściowa         | Dim typowy | Kontekst wejściowy     |
|---------------|----------------------------|------------|------------------------|
| 🧱 block_index | fragment (akapit / krok)    | 384        | ~512 tokenów           |
| 📄 note_index  | cały plik `.md`             | 512–768    | 2K / 4K / 8K tokenów   |

> [!warning] 🟥 Krytyczne
> ❌ Nie mieszamy 384-dim z 768-dim w jednym FAISS.  
> 🔐 Każdy indeks ma stały wymiar.  
> 🏷 Każdy wektor zapisuje metadane:  
> `model_name`, `dim`, `context_window`, `index_type`.

---

### 0.2 ✂ Chunking

- ✂ Modele ~512 tokenów → karmimy tylko fragmentami, nie całym plikiem.  
- 📏 Modele 4K / 8K → karmimy całą notatką `.md` bez cięcia.  
- 🪓 Jeśli dokument >8K tokenów → dziel na logiczne sekcje (wejście klienta / diagnoza / naprawa / wynik). Nie tnij losowo w połowie zdania.

---

### 0.3 🌍 Język PL / EN

> [!warning] 🟪 Jeden indeks PL+EN
> Jeśli chcesz jednego wektorowego mózgu i chcesz pytać po PL a dostać wynik z notatki EN:
>
> ✅ wybierasz:
> - 🌍 `EmbeddingGemma-300M`
> - ❄ `snowflake-arctic-embed-m-v2.0`
>
> 🟡 Modele EN-only (Arctic XS/S, Jina, Nomic) nie mapują poprawnie polskich opisów awarii.  
> Jeśli chcesz zostać przy EN-only → zrób indeks EN osobno, PL osobno.

---

### 0.4 🖥 Sprzęt globalnie

Definicje:
- `2t`, `4t`, `8t` = liczba logicznych wątków CPU  
- AVX2 = nowoczesne SIMD w x86_64. Brak AVX2 = wolno

🧠 CPU  
- wymagane: x86_64 z AVX2 albo ARM64 (Apple Silicon)  
- 2t wystarczy dla modeli lekkich  
- modele ~300M parametrów → praktycznie chcą 8t

🎮 GPU  
- 💚 lekkie modele → GPU niepotrzebna  
- 🔴 ciężkie modele (200+ MB fp16) → GPU ≥6–8 GB VRAM drastycznie przyspiesza embedowanie setek plików

💾 RAM hosta  
- 🟢 lekkie (≤70 MB fp16 wag): host 8 GB RAM ok  
- 🟠 średnie (70–220 MB fp16 wag): host 8–16 GB RAM  
- 🔴 ciężkie (≥220 MB fp16 wag): host 16–32 GB RAM  
- ℹ runtime = ~1.2–1.5× wag fp16

---

## 1. ⚡ SMART CONNECTIONS
💻 Profil: Obsidian lokalnie, laptop/NUC/VM, brak mocnej GPU  
Cel: działać ciągle bez zabijania hosta

Podział:
- 1A. 🧱 BLOKOWE (fragmenty → block_index)
- 1B. 📄 LEKKIE NOTE (całe pliki `.md` → note_index light)

---

### 1A. 🧱 MODELE BLOKOWE  
(fragment tekstu, kontekst ~512 tokenów, dim ~384)

#### ❄ snowflake-arctic-embed-xs  |  🟢 LEKKI / DOBRA JAKOŚĆ
model:: snowflake-arctic-embed-xs  
class:: smart-connections  
role:: block_index  
tier:: light  
dim:: 384  
context_tokens:: 512  
params_m:: 22  
lang:: EN  
multilang:: false  
ram_fp16_mb:: 42  
cpu_min_threads:: 2  
cpu_rec_threads:: 4  
gpu_required:: none  
host_ram_gb_min:: 8  
repo:: https://huggingface.co/Snowflake/snowflake-arctic-embed-xs  

🧾 Opis  
❄ Bardzo lekki encoder-only.  
Mały koszt, dobra trafność.  
To jest bazowy model block_index.

🎯 Zastosowanie  
- blokowe porównanie akapitów  
- "czy to już naprawialiśmy"  
- szybkie linkowanie checklist i objawów awarii

Wniosek  
Ustawić jako standard block_index. Stabilny.

---

#### ❄ snowflake-arctic-embed-s  |  🔵 LEPSZA JAKOŚĆ / NADAL LEKKI
model:: snowflake-arctic-embed-s  
class:: smart-connections  
role:: block_index  
tier:: light  
dim:: 384  
context_tokens:: 512  
params_m:: 33  
lang:: EN  
multilang:: false  
ram_fp16_mb:: 63  
cpu_min_threads:: 2  
cpu_rec_threads:: 4  
gpu_required:: none  
host_ram_gb_min:: 8  
repo:: https://huggingface.co/Snowflake/snowflake-arctic-embed-s  

🧾 Opis  
Wersja S rodziny ❄ Arctic.  
Wyższa precyzja semantyczna niż XS.

🎯 Zastosowanie  
- block_index kiedy trafność > minimalny footprint

---

#### 🔎 bge-micro-v2  |  🟡 ULTRA LOW RAM / AWARYJNIE
model:: bge-micro-v2  
class:: smart-connections  
role:: block_index  
tier:: light  
dim:: 384  
context_tokens:: 512  
params_m:: 17.4  
lang:: EN  
multilang:: false  
ram_fp16_mb:: 35  
cpu_min_threads:: 2  
cpu_rec_threads:: 4  
gpu_required:: none  
host_ram_gb_min:: 4  
repo:: https://huggingface.co/TaylorAI/bge-micro-v2  

🧾 Opis  
Model zoptymalizowany pod mały ślad pamięci.  
Chodzi na słabym laptopie / cienkiej VM.

🎯 Zastosowanie  
- block_index na hostach z bardzo małą ilością RAM

Uwaga  
Jakość gorsza niż ❄ Arctic XS/S.  
To jest "mam złom, ale chcę AI".

---

#### 🔎 bge-small (`bge--small`)  |  🔵 LEKKI STANDARD EN
model:: bge-small-en-v1.5  
class:: smart-connections  
role:: block_index  
tier:: light  
dim:: 384  
context_tokens:: 512  
params_m:: 33.4  
lang:: EN  
multilang:: false  
ram_fp16_mb:: 64  
cpu_min_threads:: 2  
cpu_rec_threads:: 4  
gpu_required:: none  
host_ram_gb_min:: 8  
repo:: https://huggingface.co/BAAI/bge-small-en-v1.5  

🧾 Opis  
Klasyczny mały encoder EN.  
W niektórych UI opisywany marketingowo jako `bge--small-4k`.  
Technicznie dalej ~512 tokenów, nie 4K.

🎯 Zastosowanie  
- block_index jeśli nie chcesz rodziny Arctic

---

#### 🧩 gte-tiny  |  🟠 STARY KLASYK
model:: gte-tiny  
class:: smart-connections  
role:: block_index  
tier:: light  
dim:: 384  
context_tokens:: 512  
params_m:: 22.7  
lang:: EN  
multilang:: false  
ram_fp16_mb:: 43  
cpu_min_threads:: 2  
cpu_rec_threads:: 4  
gpu_required:: none  
host_ram_gb_min:: 8  
repo:: https://huggingface.co/TaylorAI/gte-tiny  

🧾 Opis  
Historyczny tani similarity search.

🎯 Zastosowanie  
- block_index

Status  
Zastępowany praktycznie przez ❄ Arctic XS bo Arctic XS daje lepszy quality/cost.

---

#### 🧩 Ivysaur  |  🟣 AUTOCOMPLETE / NOT SEARCH
model:: Ivysaur  
class:: smart-connections  
role:: writing-assist  
tier:: light  
dim:: 384  
context_tokens:: 512  
params_m:: 22.7  
lang:: EN  
multilang:: false  
ram_fp16_mb:: 43  
cpu_min_threads:: 2  
cpu_rec_threads:: 4  
gpu_required:: none  
host_ram_gb_min:: 8  
repo:: https://huggingface.co/Mihaiii/Ivysaur  

🧾 Opis  
To nie jest retrieval wiedzy.  
To jest semantyczne "dokończ myśl".

🎯 Zastosowanie  
- ✍ wspomaganie pisania  
- NIE do block_index / note_index

---

### 1B. 📄 MODELE NOTATKOWE LEKKIE  
(całe pliki `.md`, kontekst 2K–8K, dim ~512)

#### 📄 jina-embeddings-v2-small-en (2K / 4K / 8K)  |  💙 NOTE INDEX LOKALNY
model:: jina-embeddings-v2-small-en  
class:: smart-connections  
role:: note_index  
tier:: medium  
dim:: 512  
context_tokens:: 8000  
params_m:: 33  
lang:: EN  
multilang:: false  
ram_fp16_mb:: 63  
cpu_min_threads:: 4  
cpu_rec_threads:: 8  
gpu_required:: optional  
host_ram_gb_min:: 8  
repo:: https://huggingface.co/jinaai/jina-embeddings-v2-small-en  

🧾 Opis  
Encoder-only (JinaBERT).  
Warianty 2K / 4K / 8K.  
Wersje 4K / 8K → cała notatka `.md` jako jeden embedding bez cięcia.

🎯 Zastosowanie  
- note_index lokalny  
- "pokaż mi inne notatki podobne do tej notatki"

Wdrożenie praktyczne (profil laptop / Obsidian):
- 🧱 block_index → ❄ Arctic XS  
- 📄 note_index → 📄 Jina Small (4K/8K)  
= stabilny Smart Connections offline

---

## 2. 🚀 HIGH PERFORMANCE
🏭 Centralna baza wiedzy.  
📏 Długi kontekst (8K).  
🌍 Opcjonalnie PL+EN.  
🎮 Wymaga mocniejszej maszyny.

Te modele poniżej: 📄 `note_index` high-end.

---

#### 🚀 jina-embeddings-v2-base-en (8K)  |  🔥 DŁUGIE DOKUMENTY EN
model:: jina-embeddings-v2-base-en  
class:: high-performance  
role:: note_index  
tier:: medium  
dim:: 768  
context_tokens:: 8000  
params_m:: 137  
lang:: EN  
multilang:: false  
ram_fp16_mb:: 261  
cpu_min_threads:: 4  
cpu_rec_threads:: 8  
gpu_required:: recommended  
host_ram_gb_min:: 16  
repo:: https://huggingface.co/jinaai/jina-embeddings-v2-base-en  

🧾 Opis  
Większy JinaBERT.  
Czyta ~8K tokenów w jednym przebiegu.  
Nadaje się do długich raportów technicznych po angielsku.

🎯 Zastosowanie  
- note_index high-end (EN)  
- raporty incydentów, audyty, pełne SOP bez chunkingu

---

#### ❄ snowflake-arctic-embed-m  |  🟦 EN / 2K
model:: snowflake-arctic-embed-m  
class:: high-performance  
role:: note_index  
tier:: medium  
dim:: 768  
context_tokens:: 2000  
params_m:: 110  
lang:: EN  
multilang:: false  
ram_fp16_mb:: 210  
cpu_min_threads:: 4  
cpu_rec_threads:: 8  
gpu_required:: optional  
host_ram_gb_min:: 16  
repo:: https://huggingface.co/Snowflake/snowflake-arctic-embed-m  

🧾 Opis  
❄ Arctic M. Krótszy kontekst (~2K), wysoka jakość EN.

🎯 Zastosowanie  
- note_index dla średniej długości dokumentów EN  
- kiedy chcesz jakość Arctic, ale nie potrzebujesz pełnych 8K

---

#### ❄ snowflake-arctic-embed-m-long  |  🔵 EN / 8K
model:: snowflake-arctic-embed-m-long  
class:: high-performance  
role:: note_index  
tier:: medium  
dim:: 768  
context_tokens:: 8000  
params_m:: 137  
lang:: EN  
multilang:: false  
ram_fp16_mb:: 261  
cpu_min_threads:: 4  
cpu_rec_threads:: 8  
gpu_required:: optional  
host_ram_gb_min:: 16  
repo:: https://huggingface.co/Snowflake/snowflake-arctic-embed-m  

🧾 Opis  
Wariant long.  
Do ~8K tokenów EN na raz.  
Odpowiednik `m`, ale dla długich dokumentów.

🎯 Zastosowanie  
- note_index high-end (EN) z długim kontekstem  
- pełne SOP / audyty / incydenty bez dzielenia

---

#### ❄ snowflake-arctic-embed-m-v2.0  |  🟪 PL+EN / 8K / GRUBY
model:: snowflake-arctic-embed-m-v2.0  
class:: high-performance  
role:: note_index  
tier:: heavy  
dim:: 768-1024  
context_tokens:: 8000  
params_m:: 305  
lang:: PL+EN  
multilang:: true  
ram_fp16_mb:: 600  
cpu_min_threads:: 8  
cpu_rec_threads:: 8+  
gpu_required:: required  
host_ram_gb_min:: 24  
repo:: https://huggingface.co/Snowflake/snowflake-arctic-embed-m-v2.0  

🧾 Opis  
❄ Arctic M v2.0.  
8K kontekstu.  
Multilang (PL+EN).  
Ciężkie ~600 MB fp16 (~800 MB runtime).

🎯 Zastosowanie  
- note_index high-end dla PL+EN  
- "jeden mózg firmy" → jeden wspólny indeks wiedzy  
- brak chunkingu do ~8K tokenów

Wniosek  
To jest docelowy silnik kiedy firma potrzebuje *jednego* indeksu PL+EN z pełnym kontekstem.

---

#### 🧬 nomic-embed-text-v1.5  |  🧬 RAG / MAŁY INDEKS
model:: nomic-embed-text-v1.5  
class:: high-performance  
role:: note_index  
tier:: medium  
dim:: 768 (↓512 ↓256 ↓128 ↓64)  
context_tokens:: 8000  
params_m:: 100-138  
lang:: EN  
multilang:: false  
ram_fp16_mb:: 191  
cpu_min_threads:: 4  
cpu_rec_threads:: 8  
gpu_required:: recommended  
host_ram_gb_min:: 8  
repo:: https://huggingface.co/nomic-ai/nomic-embed-text-v1.5  

🧾 Opis  
MRL (Matryoshka).  
Można ciąć wymiar wektora z 768 → 256 → 128 → 64 przy małej utracie jakości.  
To zmniejsza koszt magazynu wektorowego.

🎯 Zastosowanie  
- duży RAG (setki / tysiące dokumentów EN)  
- gdy rozmiar indeksu musi być tani (np. FAISS w RAM edge)

---

#### 🌍 embeddinggemma-300m  |  🟪 PL+EN / 2K / LEPIEJ RAM NIŻ m-v2.0
model:: embeddinggemma-300m  
class:: high-performance  
role:: note_index  
tier:: heavy  
dim:: 768  
context_tokens:: 2000  
params_m:: 300  
lang:: PL+EN  
multilang:: true  
ram_fp16_mb:: 572  
cpu_min_threads:: 8  
cpu_rec_threads:: 8+  
gpu_required:: recommended  
host_ram_gb_min:: 16  
repo:: https://huggingface.co/google/embeddinggemma-300m  

🧾 Opis  
🌍 Encoder-only Gemma.  
Rozumie PL i EN w jednym modelu.  
Działa offline.  
Wspólny indeks PL+EN bez rozdzielania.

🎯 Zastosowanie  
- note_index wielojęzyczny przy krótszych dokumentach (2K kontekstu)  
- zapytanie PL → trafienie EN  
- zapytanie EN → trafienie PL

Ograniczenie  
Kontekst tylko ~2K.  
Długie SOP PL/EN trzeba ciąć.  
Jeśli chcesz PL+EN i długie 8K kontekstu → ❄ `snowflake-arctic-embed-m-v2.0`.

---

## 3. 🔁 PRESETY WDROŻENIOWE

### 3.1 💻 Obsidian lokalnie (laptop / NUC / brak GPU)
preset:: obsidian-local  
class:: preset  
block_index_model:: snowflake-arctic-embed-xs  
note_index_model:: jina-embeddings-v2-small-en  
lang_scope:: EN  
multilang_single_index:: false  
gpu_needed:: false  
min_ram_gb:: 8  

Skład:
- 🧱 block_index → ❄ `snowflake-arctic-embed-xs` (384-dim, ~42 MB fp16, EN)  
- 📄 note_index → 📄 `jina-embeddings-v2-small-en` (4K / 8K, ~512-dim, ~63 MB fp16, EN)

Wymagania:
- CPU: 4t ok  
- GPU: brak wymogu  
- RAM hosta: 8–16 GB

Use case:
- auto-link SOP / checklist / intake w Obsidianie
- codzienna praca offline

---

### 3.2 🔥 Długie SOP po angielsku (8K kontekstu)
preset:: long-en-docs  
class:: preset  
block_index_model:: snowflake-arctic-embed-s  
note_index_model:: jina-embeddings-v2-base-en  
lang_scope:: EN  
multilang_single_index:: false  
gpu_needed:: true  
min_ram_gb:: 16  

Skład:
- 🧱 block_index → ❄ `snowflake-arctic-embed-s` (384-dim)  
- 📄 note_index → 🚀 `jina-embeddings-v2-base-en` (~768-dim, 8K kontekst, ~261 MB fp16)

Wymagania:
- CPU: 8t zalecane  
- GPU: ≥6–8 GB VRAM zalecana przy batchowym embedowaniu  
- RAM hosta: ≥16 GB

Use case:
- audyty, incydenty, raporty po EN
- "pokaż podobny incydent" bez chunkowania długich plików

---

### 3.3 🌍 Jeden mózg PL+EN
preset:: pl-en-shared-brain  
class:: preset  
block_index_model:: snowflake-arctic-embed-s (opcjonalnie tylko EN bloki)  
note_index_model:: snowflake-arctic-embed-m-v2.0 / embeddinggemma-300m  
lang_scope:: PL+EN  
multilang_single_index:: true  
gpu_needed:: true  
min_ram_gb:: 24  

Wariant 🟡 lżejszy (mniej RAM, krótszy kontekst):
- 🌍 `EmbeddingGemma-300M`  
  - dim ~768  
  - kontekst ~2K  
  - ~572 MB fp16  
  - PL+EN

Wariant 🔴 cięższy (więcej RAM, pełne 8K kontekstu):
- ❄ `snowflake-arctic-embed-m-v2.0`  
  - dim ~768–1024  
  - kontekst ~8K  
  - ~600 MB fp16  
  - PL+EN

Wymagania:
- CPU: 8t+  
- GPU: karta ≥8 GB VRAM zalecana  
- RAM hosta:
  - Gemma: ≥16–32 GB  
  - m-v2.0: ≥24–32 GB

Use case:
- centralny indeks wiedzy warsztatu
- PL i EN razem, jedno zapytanie

---

## 4. 🔍 DATAVIEW / ZAPYTANIA

### 4.1 Wszystkie modele embeddingów ze sprzętem
```dataview
TABLE model, class, role, tier, dim, context_tokens, params_m, lang, multilang, ram_fp16_mb, host_ram_gb_min, cpu_min_threads, gpu_required
FROM "."
WHERE module = "embeddings" AND dv_ready = true AND model
SORT class ASC, tier ASC, ram_fp16_mb ASC
```

### 4.2 Modele do block_index (fragmenty)
```dataview
TABLE model, tier, dim, context_tokens, ram_fp16_mb, cpu_min_threads, gpu_required
FROM "."
WHERE role = "block_index"
SORT ram_fp16_mb ASC
```

### 4.3 Modele do note_index (całe pliki `.md`)
```dataview
TABLE model, tier, lang, multilang, context_tokens, dim, ram_fp16_mb, gpu_required
FROM "."
WHERE role = "note_index"
SORT multilang DESC, context_tokens DESC
```

### 4.4 Tylko modele PL+EN
```dataview
TABLE model, context_tokens, ram_fp16_mb, host_ram_gb_min, gpu_required
FROM "."
WHERE multilang = true AND role = "note_index"
SORT context_tokens DESC
```

### 4.5 Presety wdrożeniowe
```dataview
TABLE preset, block_index_model, note_index_model, lang_scope, multilang_single_index, min_ram_gb, gpu_needed
FROM "."
WHERE class = "preset"
SORT min_ram_gb ASC
```

---

## 5. 🔗 REPOZYTORIA (waga modeli do pobrania)

- ❄ snowflake-arctic-embed-xs  
  https://huggingface.co/Snowflake/snowflake-arctic-embed-xs  
- ❄ snowflake-arctic-embed-s  
  https://huggingface.co/Snowflake/snowflake-arctic-embed-s  
- ❄ snowflake-arctic-embed-m  
  https://huggingface.co/Snowflake/snowflake-arctic-embed-m  
- ❄ snowflake-arctic-embed-m-v2.0  
  https://huggingface.co/Snowflake/snowflake-arctic-embed-m-v2.0  
- 📄 jina-embeddings-v2-small-en  
  https://huggingface.co/jinaai/jina-embeddings-v2-small-en  
- 🚀 jina-embeddings-v2-base-en  
  https://huggingface.co/jinaai/jina-embeddings-v2-base-en  
- 🧬 nomic-embed-text-v1.5  
  https://huggingface.co/nomic-ai/nomic-embed-text-v1.5  
- 🌍 embeddinggemma-300m  
  https://huggingface.co/google/embeddinggemma-300m  
- 🔎 bge-micro-v2  
  https://huggingface.co/TaylorAI/bge-micro-v2  
- 🔎 bge-small-en-v1.5  
  https://huggingface.co/BAAI/bge-small-en-v1.5  
- 🧩 gte-tiny  
  https://huggingface.co/TaylorAI/gte-tiny  
- 🧩 Ivysaur  
  https://huggingface.co/Mihaiii/Ivysaur  

---

## 6. 📦 POBIERANIE WAG (`git lfs clone`)

Upewnij się że masz git-lfs:
```bash
sudo apt-get update && sudo apt-get install git-lfs -y
git lfs install
```

🧱 Block index (fragmenty / akapity)
```bash
git lfs clone https://huggingface.co/Snowflake/snowflake-arctic-embed-xs
git lfs clone https://huggingface.co/Snowflake/snowflake-arctic-embed-s
git lfs clone https://huggingface.co/TaylorAI/bge-micro-v2
git lfs clone https://huggingface.co/BAAI/bge-small-en-v1.5
git lfs clone https://huggingface.co/TaylorAI/gte-tiny
git lfs clone https://huggingface.co/Mihaiii/Ivysaur
```

📄 Note index (całe pliki `.md`, lokalnie / Obsidian)
```bash
git lfs clone https://huggingface.co/jinaai/jina-embeddings-v2-small-en
```

🚀 Note index high-end (8K kontekstu, baza wiedzy)
```bash
git lfs clone https://huggingface.co/jinaai/jina-embeddings-v2-base-en
git lfs clone https://huggingface.co/Snowflake/snowflake-arctic-embed-m
git lfs clone https://huggingface.co/Snowflake/snowflake-arctic-embed-m-v2.0
git lfs clone https://huggingface.co/nomic-ai/nomic-embed-text-v1.5
git lfs clone https://huggingface.co/google/embeddinggemma-300m
```

## 🔗 Backlinks

- [[jakubc]]
- [[INDEX]]
- [[core]]

---
*Auto-generated backlinks for cluster connectivity*
