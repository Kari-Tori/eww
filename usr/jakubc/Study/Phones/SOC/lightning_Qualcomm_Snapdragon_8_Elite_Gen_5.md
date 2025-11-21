---
tags:
  - #automation
  - #development
  - #eww
  - #jakubc
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21T18:00:00Z
modified: 2025-11-21T18:00:00Z
author: jakubc
title: "⚡ Qualcomm Snapdragon 8 Elite Gen 5"






---

# ⚡ Qualcomm Snapdragon 8 Elite Gen 5
`SM8850-AC · 3 nm TSMC N3P · Oryon Gen3 · Adreno 840 + HPM 18 MB · Hexagon NPU · X85 5G · FastConnect 7900`

> [!SUMMARY] 🚀 Skrót
> 2025, flagowy SoC 3 nm. 8 rdzeni Oryon, Adreno 840 z HPM 18 MB, NPU Hexagon (INT2/4/8, FP8/16). LPDDR5X, UFS 4.1. X85 5G i Wi‑Fi 7 w FastConnect 7900. Ekrany do 4K@120 lub QHD+@240.


## 🔧 Specyfikacja

> [!SUMMARY] 🧩 Zakres  
> 64‑bit. Priorytet: gry, wideo pro, AI on‑device. Część wartości zależna od urządzenia.

### 🧠 CPU — Oryon Gen3
- 8C = **2× Prime ~4.6 GHz** + **6× Performance ~3.62 GHz**.  
- ARMv9.2‑A. Sprzętowe MAC/Matrix, DVFS, wyspy zasilania.  
- **Cache:** brak oficjalnych liczb L2/L3; źródła podają sprzecznie (np. 24/8 MB vs 12/16 MB). Traktuj jako **przybliżenia**.

### 🎮 GPU — Adreno 840 (deep‑dive)
> [!TIP] Architektura i cele
> Nowa generacja z naciskiem na „sustained” FPS i niższy pobór przy długich sesjach. Deklarowane **+~23%** perf i **−~20%** energii vs poprzednik.

- **Pamięć bliska:** **Adreno HPM 18 MB** — dedykowany cache przy GPU. Redukuje ruch do RAM i poprawia stabilność klatek.  
- **Raster + geometra:** **Mesh Shading**, ulepszenia w dużej geometrii i złożonych scenach (UE5).  
- **Ray tracing:** sprzętowy RT z wyższą sprawnością vs Gen4.  
- **Taktowanie i organizacja:** raporty branżowe wskazują taktowanie do **~1.2 GHz** i „sliced” design. **Qualcomm nie podaje** oficjalnej liczby CU/ALU — wartości traktować jako **szacunki**.  
- **API / sterowniki:** **Vulkan 1.3**, **OpenGL ES 3.2**, **OpenCL 3.0 FP** (warianty zależą od obrazu systemu).  
- **Vulkan tile heap:** sterownikowy „tile memory heap” ułatwia alokację kafelkową (**VK_QCOM_tile_memory_heap**) — mniej transferów, niższe zużycie energii.  
- **Kodeki / media:** sprzętowe **AV1 decode** w bloku wideo; wsparcie HEVC/H.264.
- **Praktyka testowa:** większy zysk w scenach z dużą geometrią (np. Aztec‑class), mniejszy tam, gdzie ścieżki nie korzystają z HPM/tile heap.

### 🧮 NPU — Hexagon
- **Precyzje:** **INT2/4/8**, **FP8/16**, FP16.  
- **Techniki:** **Micro‑Tile Inferencing**, **Direct Link** z CPU/GPU, 64‑bitowa wirtualizacja pamięci.  
- **Zastosowania:** LLM on‑device, vision, ASR/TTS, tłumaczenia.

### 🗃 Pamięć systemowa
- **LPDDR5X** do ~**5300 MHz**, do **24 GB**.  
- **64‑bit** (4×16‑bit). Timingi zależne od OEM.

### 💾 Magazyn / I/O
- **UFS 4.1** (zgodność 4.0).  
- **USB 3.1 Gen2**.  
- **MIPI** CSI/DSI wg implementacji OEM.

### 🖥 Wyświetlacze
- Na urządzeniu: **4K@120** lub **QHD+@240**.  
- Zewnętrzny: **8K@30** lub **4K@120**.  
- HDR10/10+/HLG/Dolby Vision, 10‑bit, Rec.2020.

### 📷 ISP / Media
- Potrójny **Spectra** (20‑bit), foto do ~**320 MP**.  
- Wideo: **4K@120** nagrywanie, **1080p@480** slo‑mo; **8K HDR@60** odtwarzanie.  
- **APV** i computational video: kontekstowy AF/AE/AWB.

### 🌐 Łączność
- **Snapdragon X85 5G**: **DL ~12.5 Gb/s**, **UL ~3.7 Gb/s**.  
- **FastConnect 7900**: **Wi‑Fi 7 + Bluetooth 5.4 + UWB**, XPAN, optymalizacja latencji.  
- Wielosystemowe **GNSS** (zakres wg urządzenia).

### 🔐 Bezpieczeństwo
- **TEE**, **SPU/StrongBox**, **hypervisor Type‑1**, **C2PA**.  
- Oddzielne domeny dla kluczy i płatności (wg OEM).

### 🔊 Audio
- **LE Audio/LC3**, nowoczesne profile BT; detale wg implementacji producenta.

### 📊 Tabela szybkich parametrów
| Blok | Parametry kluczowe |
|---|---|
| CPU | 2P ~4.6 GHz + 6P ~3.62 GHz, ARMv9.2‑A |
| GPU | Adreno 840, **HPM 18 MB**, RT, UE5 opt., Vulkan 1.3 |
| NPU | INT2/4/8, FP8/16, Micro‑Tile, Direct Link |
| RAM | LPDDR5X do 24 GB, ~5300 MHz, 64‑bit |
| Storage | UFS 4.1, zgodność 4.0 |
| Ekrany | 4K@120 lub QHD+@240, zewn. 8K@30 |
| Modem/Radio | X85 5G, Wi‑Fi 7 + BT 5.4 + UWB |

> [!WARNING] 🔍 Niepewności spec  
> Wartości **L2/L3** i szczegóły jednostek GPU różnią się między źródłami. Dokumentacja producenta nie ujawnia pełnych liczb. Dodawaj adnotacje o wariancie urządzenia, firmware i limicie mocy.


## 🏭 Produkcja

> [!INFO] 🧱 Proces i struktura
- **Węzeł:** TSMC **N3P** (3 nm), FinFET + EUV.  
- **Charakterystyka:** ~+5% perf lub −5–10% mocy vs N3E, ~+4% gęstości.  
- **Topologia bloków:** klastry CPU ↔ L2/L3, **Adreno 840 + HPM 18 MB**, Hexagon NPU, potrójny Spectra, kontrolery LPDDR5X/UFS/USB/Display, interfejsy do **X85** i **FastConnect 7900**.  
- **Szac. die:** ~126 mm².

> [!ABSTRACT] 🧪 Materiały i pakiet
- **Krzem:** wafle 300 mm Cz‑Si.  
- **BEOL:** Cu + low‑k/SiCOH, bariery Ta/TaN; Co/TiN w kontaktach/MOL w wybranych warstwach.  
- **Pakiet:** flip‑chip **FC‑CSP/PoP** na substracie **ABF**.  
- **Połączenia:** kule BGA Sn‑Ag‑Cu, underfill epoksydowy.

> [!ATTENTION] 💸 Koszt — model szacunkowy
**Założenia:** średnica wafla 300 mm; die ~126.2 mm²; DPW z korektą krawędzi.  
**Szac. DPW (brutto):** 500.8 szt./wafel

**Tabela koszt/die vs. yield (przykłady):**

|Cena wafla [USD]|Yield|Szac. DPW (brutto)|Koszt/brutto die [USD]|Koszt/dobry die [USD]|
|---|---|---|---|---|
|18000|60%|500.8|35.94|59.91|
|18000|70%|500.8|35.94|51.35|
|18000|80%|500.8|35.94|44.93|
|22000|60%|500.8|43.93|73.22|
|22000|70%|500.8|43.93|62.76|
|22000|80%|500.8|43.93|54.91|
|25000|60%|500.8|49.92|83.2|
|25000|70%|500.8|49.92|71.32|
|25000|80%|500.8|49.92|62.4|


> [!NOTE] Interpretacja  
> „Koszt produkcji” ≠ „cena sprzedaży SoC”. Do kosztu krzemu i pakowania dochodzą R&D, IP/licencje, testy, marże i wsparcie OEM.


## 📱 Zastosowanie

> [!TIP] 🎯 Profile użycia
- **Gry AAA mobilne:** RT, HPM 18 MB → stabilniejsze FPS.  
- **Wideo pro:** APV + computational video → montaż mobilny.  
- **AI on‑device:** LLM w INT4/FP8, tłumaczenia, ASR, vision.

> [!EXAMPLE] 📲 Urządzenia 2025/26
- Flagowe smartfony: serie Xiaomi, OnePlus, iQOO, vivo, ROG, Samsung (warianty z 8E Gen5).  
- Handheldy z Androidem: projekty nastawione na niską latencję Wi‑Fi 7 i stabilność GPU.

### 🛒 Wskazówki zakupu
- 🔧 **Chłodzenie:** większa komora parowa, lepsze odprowadzanie ciepła.  
- 🧠 **RAM:** 16–24 GB LPDDR5X.  
- ⚡ **Storage:** UFS 4.1.  
- 📶 **Łączność:** Wi‑Fi 7 320 MHz, UWB.  
- 🔋 **Sustained:** testy 30+ min.


## 🔗 Linki referencyjne
> **Oficjalne PDF/briefy:**  
> • Snapdragon 8 Elite Gen 5 — product brief: https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/Snapdragon-8-Elite-Gen-5-product-brief.pdf  
> • Snapdragon X85 5G Modem‑RF — brief: https://docs.qualcomm.com/bundle/publicresource/87-87284-1_REV_B_Qualcomm_x85_5G_Modem_RF_Product_Brief.pdf  
> • FastConnect 7900 — brief: https://docs.qualcomm.com/bundle/publicresource/87-73970-1_REV_C_Qualcomm_FastConnect_7900_Mobile_Connectivity_System_Product_Brief.pdf  


*Wersja: 2025-10-30 12:31 UTC*

## 🔗 Backlinks

- [[jakubc]]
- [[INDEX]]
- [[core]]

---
*Auto-generated backlinks for cluster connectivity*
