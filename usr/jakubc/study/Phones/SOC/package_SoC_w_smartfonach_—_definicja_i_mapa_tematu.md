---
version: 0.0.4
tags:
  - #automation
  - #development
  - #eww
  - #jakubc
  - #knowledge
  - #linux
  - #secondbrain
created: 2025-11-21
modified: 2025-12-01
author: jakubc
title: "📦 System-on-Chip (SoC) — co to jest"






owner: jakubc
---
title: "📦 SoC w smartfonach — definicja, architektura, ekosystem"
version: 1.0

# 📦 System-on-Chip (SoC) — co to jest

> [!Definition]
> **System-on-Chip (SoC)** to pojedynczy układ scalony, który łączy główne bloki komputera mobilnego: CPU, GPU, NPU/DSP, ISP, kodeki wideo, kontrolery pamięci i I/O, bezpieczeństwo oraz logikę zarządzania energią.  
> Bloki pracują w jednej przestrzeni adresowej i komunikują się przez koherentny **interconnect/fabric**.

> [!Note] Granice pojęcia
> - **AP vs SoC:** „Application Processor” to część aplikacyjno-multimedialna; modem 4G/5G bywa w tym samym krzemie albo osobno.  
> - **SoC vs SiP/PoP:** pamięć LPDDR często jest pakowana **PoP** nad SoC; **SiP** integruje wiele chipów w jednym module.  
> - **RF front-end, PMIC:** zwykle oddzielne układy na płycie, ściśle współpracujące z SoC.


## 🧱 Architektura — główne bloki

- **CPU** 🧠  
  Rdzenie Arm (big/mid/little), klastry z cache L1/L2, czasem L3/system cache. **DVFS** i stany C/P do oszczędzania energii.
- **GPU** 🎨  
  Grafika 2D/3D i compute (Vulkan/OpenGL). Zwykle tile-based rendering, dedykowane jednostki tekstur i rastrowania.
- **NPU / DSP** 🧮  
  Akceleracja AI i sygnałów (INT8/INT4/FP16). Niska latencja, wysoka efektywność TOPS/W.
- **ISP** 📷  
  Pipeline foto/wideo: demosaicing, HDR, denoise, tonemapping, stabilizacja, depth/segmentation.
- **Kodeki wideo** 🎞️  
  Sprzętowy enkoder/dekoder H.264, HEVC, AV1; obsługa 4K/8K zależnie od generacji.
- **Łączność** 📡  
  Modem LTE/5G (baseband), GNSS. Może być zintegrowany lub jako osobny chip.
- **Pamięć i I/O** 💾  
  Kontrolery **LPDDR4X/LPDDR5(X)**, magazyn **UFS 3.x/4.x**, PCIe, USB, SD, MIPI CSI/DSI, DMA.
- **Bezpieczeństwo** 🔐  
  TEE/TrustZone, Secure Enclave, Root-of-Trust, kryptografia sprzętowa, bezpieczny boot.
- **Wyświetlacz i kamera** 🖥️📸  
  MIPI **DSI/CSI**, kompozytor, skalery, timing controller.
- **Audio** 🎧  
  DSP audio, AEC/NS, kodeki; czasem zewnętrzny kodek w PMIC-audio.
- **Zarządzanie energią** 🔋  
  Gating zegara/napięcia, QoS, współpraca z **PMIC** i schedulerem systemu.

> [!Tip] Interconnect / NoC
> Spójność i przepustowość zapewniają AMBA AXI/CHI, sieci **NoC** (np. Arm CMN, Arteris). Priorytety QoS ograniczają jitter i opóźnienia.


## 🧠 Hierarchia pamięci

- **Rejestry → L1I/D → L2 (na klaster) → L3/System Cache → DRAM (LPDDR5X) → UFS**  
- Bufory w ISP/NPU/GPU minimalizują dostęp do DRAM. Spójność cache zmniejsza koszty synchronizacji.


## 🧩 Pakowanie i montaż

- **PoP (Package-on-Package):** DRAM na wierzchu SoC. Krótka ścieżka, niskie opóźnienia.  
- **SiP (System-in-Package):** wiele chipów w jednym module.  
- **FO-WLP/FOPLP, InFO, RDL:** zaawansowane formy łączeń i wyprowadzeń.  
- **PMIC** zwykle w osobnym QFN/BGA; **RF front-end** w modułach FEM (PA/LNA/dupleksery).


## 🚀 Możliwości (use-cases)

- **On-device AI**: rozpoznawanie, generacja, asystenty offline.  
- **Fotografia obliczeniowa**: HDR w locie, nocne, bokeh, segmentacja.  
- **Gry 3D**: render wieloprzebiegowy, ray tracing w nowszych generacjach.  
- **Multimedia**: 4K/8K, wysoka liczba FPS, kodeki nowej generacji.  
- **Łączność**: 5G NSA/SA, agregacja pasm, Wi-Fi 6/7, BT, UWB.  
- **Bezpieczeństwo**: biometryka, bezpieczne płatności, izolacja kluczy.


## 🏭 Ekosystem i firmy

### 👑 Projektanci SoC (smartfony)
- **Apple** — A-series. <https://www.apple.com>  
- **Qualcomm** — Snapdragon. <https://www.qualcomm.com>  
- **MediaTek** — Dimensity/Helio. <https://www.mediatek.com>  
- **Samsung System LSI** — Exynos. <https://semiconductor.samsung.com>  
- **Google** — Tensor. <https://store.google.com/us/magazine/google_tensor>  
- **UNISOC** — T/SC-series. <https://www.unisoc.com>  
- **HiSilicon** — Kirin* (zależne od rynku). <https://www.hisilicon.com>

### 🧩 Dostawcy IP (bloki i narzędzia)
- **Arm** — CPU (Cortex, Oryon licencja CPU inna), Mali GPU, interconnect. <https://www.arm.com>  
- **Imagination** — PowerVR GPU. <https://www.imaginationtech.com>  
- **Qualcomm** — Adreno GPU (wewnętrzne IP). <https://www.qualcomm.com>  
- **Cadence Tensilica** — DSP. <https://www.cadence.com>  
- **CEVA** — DSP, AI IP. <https://www.ceva-dsp.com>  
- **Synopsys** — PHY/serdes, kontrolery. <https://www.synopsys.com>

### 🧪 Foundry i pakowanie (OSAT)
- **TSMC** — 5/4/3/2-nm klasy leading-edge, InFO/CoWoS/SoIC. <https://www.tsmc.com>  
- **Samsung Foundry** — 4/3-nm, ePoP/FCBGA. <https://semiconductor.samsung.com/foundry>  
- **SMIC** — procesy dojrzałe. <https://www.smics.com>  
- **OSAT**: **ASE**, **Amkor**, **JCET**, **SPIL**.


## ⚖️ Kluczowe kompromisy projektowe

> [!Info]
> - **Wydajność vs pobór mocy:** dobór rdzeni, częstotliwości i napięć, DVFS, leakage.  
> - **Przepustowość pamięci vs koszty:** szerokość kontrolera, taktowanie DRAM, rozmiary cache.  
> - **Powierzchnia krzemu vs funkcje:** więcej bloków = większy die i gorszy uzysk.  
> - **Termika w smartfonie:** limitowana objętość, throttling długotrwały.  
> - **Fragmentacja software:** sterowniki, kernel, BSP, aktualizacje bezpieczeństwa.


## 🔍 Jak oceniać SoC w praktyce

- **CPU:** generacja rdzeni, liczba klastrów, cache L2/L3.  
- **GPU:** generacja, wsparcie API, RT/mesh shading, stabilność FPS.  
- **NPU/DSP:** TOPS i efektywność, wsparcie INT8/FP16, ONNX/NNAPI.  
- **ISP/Wideo:** AV1 decode/encode, limity rozdzielczości/FPS, HDR, multi-cam.  
- **Pamięć/Magazyn:** LPDDR5(X) przepustowość, UFS 4.0/4.1.  
- **Łączność:** 5G SA/NSA, agregacja, Wi-Fi 7/6E, BT 5.3, UWB.  
- **Bezpieczeństwo:** TEE, aktualizacje, certyfikacje (FIPS/CC gdy istotne).  
- **Termika:** zachowanie pod długim obciążeniem, throttling.


## 📚 Glosariusz skrótów

- **AP** — Application Processor.  
- **BSP** — Board Support Package.  
- **DVFS** — Dynamic Voltage and Frequency Scaling.  
- **ISP** — Image Signal Processor.  
- **NPU/DSP** — Neural/Signal Processing Unit.  
- **NoC** — Network-on-Chip.  
- **PMIC** — Power Management IC.  
- **PoP/SiP** — Package-on-Package / System-in-Package.  
- **TEE** — Trusted Execution Environment.  
- **UFS/LPDDR** — interfejs magazynu / pamięć DRAM mobilna.


## 🔗 Materiały startowe
- Arm: <https://www.arm.com>  
- Qualcomm Snapdragon: <https://www.qualcomm.com>  
- MediaTek Dimensity: <https://www.mediatek.com>  
- Samsung LSI / Exynos: <https://semiconductor.samsung.com>  
- Google Tensor: <https://store.google.com/us/magazine/google_tensor>  
- TSMC: <https://www.tsmc.com> • Samsung Foundry: <https://semiconductor.samsung.com/foundry>

## 🔗 Backlinks

- [[jakubc]]
- [[INDEX]]
- [[core]]

---
*Auto-generated backlinks for cluster connectivity*