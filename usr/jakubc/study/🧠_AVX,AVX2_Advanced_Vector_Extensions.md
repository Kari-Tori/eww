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
title: "🧠 AVX i AVX2 **Advanced Vector Extensions**"






owner: jakubc
---


# 🧠 AVX i AVX2 **Advanced Vector Extensions**

> [!summary] **Definicja**
> **AVX (Advanced Vector Extensions)** i **AVX2** to **rozszerzenia zestawu instrukcji x86/x86‑64** typu **SIMD**. Nie są mikroarchitekturą. Dodają 256‑bitowe rejestry **YMM**, kodowanie **VEX** i trzy‑operandowe instrukcje. **AVX** koncentruje się na FP, **AVX2** rozszerza pełne 256‑bit na INT i wprowadza `gather`.

> [!info] **ISA ≠ mikroarchitektura**
> **ISA** to „co CPU umie” (instrukcje i rejestry). **Mikroarchitektura** to „jak CPU jest zbudowane” (np. Haswell, Zen). AVX/AVX2 należą do ISA, a nie do nazw pokroju Haswell/Zen.


## 🗓️ Historia i znaczenie historyczne

| Rok | Producent | Mikroarchitektura | Wydarzenie |
|---:|:--|:--|:--|
| **2011** | Intel | **Sandy Bridge** | Pierwszy **AVX** w mainstreamie. |
| **2011 Q4** | AMD | **Bulldozer** | Pierwsze **AVX** u AMD. |
| **2013** | Intel | **Haswell** | Debiut **AVX2** + `gather`. |
| **2015→2017** | AMD | **Excavator → Zen** | **AVX2** w AMD wchodzi do mainstreamu. |

> [!tip] **Dlaczego to było ważne**
> AVX ustandaryzował 256‑bit SIMD na x86. AVX2 scalił świat INT i FP w 256‑bit, co uprościło pisanie jąder numerycznych i przyspieszyło biblioteki HPC/AI.


## 🧩 Architektura rozszerzeń

- **Rejestry:** `XMM` 128‑bit, **`YMM` 256‑bit** (XMM = dolna połówka YMM).  
- **AVX (FP):** `add/sub/mul/div/sqrt`, blend/permute, ładowania/zapisy wyrównane i niewyrównane.  
- **AVX2 (INT):** 256‑bit dla INT8/16/32/64, szerokie shifty, `vperm*`, `vinserti128`/`vextracti128`, **`vpgather*`**.  
- **FMA3:** formalnie osobne, zwykle współwystępuje z AVX2.  
- **OS:** wymagane **XSAVE/XRSTOR** i bit **OSXSAVE**; poprawne bity w **XCR0** dla SSE i AVX.


## 🧪 Znaczenie w AI (CPU inference i pre/post‑processing)

> [!tip] **Biblioteki korzystające z AVX/AVX2**
> - **oneDNN** — dispatcher ISA, sterowanie przez `ONEDNN_MAX_CPU_ISA`.  
> - **FBGEMM** (PyTorch x86) — optymalizacje INT8 wymagają **AVX2+**.  
> - **XNNPACK** — szybkie jądra na x86/ARM/WASM.  
> - **ONNX Runtime** — ścieżki x86 wykorzystują AVX/AVX2 gdy dostępne.  
> - **llama.cpp / ggml** — ścieżki AVX/AVX2 dla LLM na CPU z kwantyzacjami.

**Kiedy AVX2 ma sens**  
- Małe batch’e, niska latencja, ograniczone TDP, brak GPU.  
- Operator‑heavy pre/post‑processing (konwersje, normalizacje, softmax, GEMV).  
- INT8/FP16 emulowane na CPU i klasyczne DSP/CV.

**Ograniczenia**  
- **AVX ratio offset**: długie wektorowe ładunki obniżają turbo.  
- **`gather`** na starszych rdzeniach bywa wolny; preferuj data‑layouty SoA i przetasowania zamiast rozproszonych dostępów.  
- **Łatki bezpieczeństwa (GDS/Downfall)** mogą spowolnić ścieżki z `gather`.


## 🌍 Gdzie spotykane (architektury i platformy)

> [!abstract] **x86, gdzie jest AVX/AVX2**
> - **Intel**: AVX od **Sandy Bridge**; **AVX2** od **Haswell**; szeroko w Core/Xeon kolejnych generacji. Wybrane linie niskomocowe historycznie ograniczone.  
> - **AMD**: AVX od **Bulldozer**; **AVX2** od **Excavator**, powszechnie od **Zen**.

> [!note] **Gdzie nie ma AVX/AVX2**
> - **ARM/Apple Silicon**: brak AVX; odpowiedniki **NEON/AdvSIMD** i **SVE2**.  
> - **RISC‑V**: brak AVX; odpowiednik **RVV (RISC‑V Vector)**.  
> - **POWER/POWERPC**: brak AVX; odpowiednik **VSX/AltiVec**.  
> - **MIPS**: brak AVX; odpowiednik **MSA**.


## 🛠️ Programowanie

**Flagi kompilatora**  
- GCC/Clang: `-mavx`, `-mavx2` (opcjonalnie `-mfma`) lub `-march=haswell` / `-march=znver1` i nowsze.

**Detekcja w runtime (skrót)**  
```c
// CPUID: wsparcie AVX/AVX2 + OSXSAVE
// XGETBV(XCR0): wymagane bity SSE(1) i AVX(2)
// Użyj ścieżek AVX/AVX2 tylko jeśli (XCR0 & 0x6) == 0x6
```

**Praktyka danych**  
- Wyrównuj do 32 B, minimalizuj cross‑lane.  
- Unikaj niewyrównanych dostępów w gorących pętlach.  
- Eliminuj `gather` przez przekształcenie layoutu lub prefetch/transpozycje.


## ✅ Checklist operacyjny

- [ ] Włącz `-mavx2 -mfma` lub `-march=haswell/znver1`.  
- [ ] Użyj bibliotek z dispatcherem ISA (oneDNN/FBGEMM/XNNPACK/ONNX Runtime).  
- [ ] Zapewnij fallback SSE2/NEON/SVE2 i wybór w runtime.  
- [ ] Profiluj IPC, BW i udział `gather`; mierz wpływ AVX‑offset.  
- [ ] Zweryfikuj łatki GDS w firmware/OS dla docelowych CPU.


## 🔗 Materiały źródłowe i referencje
- AVX/AVX2 — przegląd: https://en.wikipedia.org/wiki/Advanced_Vector_Extensions  
- Intel SDM: https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html  
- Haswell new instructions (AVX2): https://community.intel.com/t5/Intel-ISA-Extensions/Haswell-New-Instructions-posted/td-p/807600  
- oneDNN: https://github.com/oneapi-src/oneDNN  
- FBGEMM: https://github.com/pytorch/FBGEMM  
- XNNPACK: https://github.com/google/XNNPACK  
- ONNX Runtime: https://onnxruntime.ai/  
- llama.cpp: https://github.com/ggml-org/llama.cpp  
- ARM NEON: https://developer.arm.com/documentation/101028/0010/Advanced-SIMD--Neon--intrinsics  
- ARM SVE2: https://developer.arm.com/architectures/instruction-sets/sve  
- RISC‑V RVV: https://github.com/riscv/riscv-v-spec

## 🔗 Backlinks

- [[jakubc]]
- [[INDEX]]
- [[core]]

---
*Auto-generated backlinks for cluster connectivity*