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
title: "🧠 ARM — kompendium architektury (A/R/M)"






owner: jakubc
---

# 🧠 ARM — kompendium architektury (A/R/M)

> [!summary] **Definicja**
> **ARM** to **rodzina architektur procesorów RISC** i odpowiadający im **zestaw instrukcji (ISA)** projektowane przez Arm Ltd. Nie jest to pojedynczy procesor ani producent układów. **Profile**: **A** (Application), **R** (Real‑time), **M** (Microcontroller). W wariancie **A** kluczowe są tryby **AArch64** (64‑bit) i **AArch32** (32‑bit).

> [!info] **ISA vs mikroarchitektura**
> **ISA** definiuje instrukcje, rejestry, poziomy przywilejów, model pamięci. **Mikroarchitektura** to implementacja ISA (np. **Cortex‑A78**, **Neoverse N2**, **Apple M4**, **Qualcomm Oryon**).


## 🗺️ Profile i zastosowania

| Profil | Przykłady rdzeni | Zastosowania | Cechy |
|:--|:--|:--|:--|
| **A (Application)** | Cortex‑A7x/A5x/A3x, **Neoverse** (N1/N2/V1), Apple M‑series, Qualcomm Oryon | Telefony, laptopy, serwery | **AArch64/AArch32**, MMU, EL0–EL3, NEON, często SVE/SVE2 (Armv9) |
| **R (Real‑time)** | Cortex‑R5/R8/R52 | Automotive, storage, dyski SSD | Determinizm, MPU, bezpieczeństwo funkcjonalne |
| **M (Microcontroller)** | Cortex‑M0+/M3/M4/M7/M33/M55/M85 | IoT, MCU, RTOS | Bardzo niskie zużycie energii, brak MMU; **Helium (M‑Profile Vector Extension)** w M55/M85 |


## 🧩 Kluczowe elementy architektury (profil A)

- **ISA:** **AArch64** (64‑bit, domyślny we współczesnych SoC) i **AArch32** (wygaszany).  
- **Poziomy przywilejów:** **EL0** (user), **EL1** (kernel), **EL2** (virtualization), **EL3** (secure monitor).  
- **Pamięć i wirtualizacja:** Stronicowanie wielopoziomowe, **Stage‑1/Stage‑2** translacje, TLB, cache L1/L2/L3, koherencja przez interkonekty (CCI/CCN/CMN/DSU).  
- **Bezpieczeństwo:** **TrustZone** (Normal vs Secure World), **PAC** (Pointer Authentication), **MTE** (Memory Tagging), **BTI** (Branch Target Identification).  
- **Wektory i SIMD:** **NEON/AdvSIMD** 128‑bit; **SVE** (128–2048 bit, zmienny rozmiar); **SVE2** poszerza INT/bit‑ops dla ogólnego przetwarzania.  
- **big.LITTLE / DynamIQ:** Heterogeniczne klastry wydajnych i oszczędnych rdzeni, wspólny L3/DSU, sprzętowe planowanie mocy.


## 🗓️ Kamienie milowe

| Rok | Wydarzenie | Znaczenie |
|---:|:--|:--|
| **1985** | ARM1 (Acorn) | Początek lekkiego RISC. |
| **2005** | Armv7‑A + **NEON** | SIMD 128‑bit w mobile. |
| **2011/2013** | **Armv8‑A** → pierwsze 64‑bit SoC (AArch64) | Migracja mobile do 64‑bit. |
| **2018→** | **Neoverse** | Wejście ARM do serwerów/HPC w skali. |
| **2021→** | **Armv9‑A** + **SVE2**, MTE, PAC ulepszenia | Generacja skupiona na AI, bezpieczeństwie i wektorach. |

> [!tip] **Wniosek**
> Linia **A** stała się uniwersalna: od telefonów po serwery i laptopy. Wektorowe rozszerzenia i bezpieczeństwo są kluczowe dla nowoczesnych obciążeń.


## 🤖 ARM a AI

**Na CPU (profil A):**  
- **NEON** przyspiesza operatory CV/DSP i lekką inferencję (konwolucje 1×1/3×3, aktywacje, normalizacje, GEMV).  
- **SVE/SVE2** ułatwia skalowanie szerokości wektora bez rekompilacji kodu źródłowego (programowanie „vector‑length agnostic”).  
- **Biblioteki:** **XNNPACK**, **TFLite**, **oneDNN‑acl**/**Compute Library** dla ARM, **ONNX Runtime** ma ścieżki na NEON/SVE2.  
- **Use‑cases:** małe batch’e, niska latencja, edge i mobile bez dedykowanego NPU.

**Poza CPU (na tym samym SoC):**  
- **GPU** (Mali/Immortalis, Apple, Adreno) i **NPU/DSP** (Apple ANE, Qualcomm Hexagon, MediaTek APU) wykonują główne jądra ML; CPU ARM obsługuje planowanie, pre/post‑processing i fallback.

> [!warning] **Ograniczenia**
> Brak **AVX/AVX2/AVX‑512**. Wydajność wektorowa zależy od **NEON/SVE2** i przepustowości pamięci. Implementacja **SVE2** zależy od producenta i SKU — nie każde Armv9‑A musi mieć pełny zestaw w praktyce.


## 🏗️ Gdzie spotykana (próbki implementacji)

- **Mobile:** Cortex‑A7x/A5x, Qualcomm Oryon, MediaTek Dimensity, Samsung Exynos, Apple A‑series.  
- **Laptopy/desktop:** Apple **M‑series**, Qualcomm **Snapdragon X** (Windows on ARM).  
- **Serwery/HPC:** **AWS Graviton** (Neoverse), **Ampere Altra/One**, **Fujitsu A64FX** (SVE, HPC).  
- **RT/MCU:** Cortex‑R w automotive/storage; Cortex‑M w IoT i sprzęcie wbudowanym.


## 🛠️ Programowanie i wykrywanie cech

**Kompilatory**  
- GCC/Clang (AArch64): `-march=armv8-a` lub `-march=armv9-a` + `-mcpu=<cel>` (np. `cortex-a78`, `neoverse-n2`).  
- 32‑bit (AArch32): `-mfpu=neon` + `-mfloat-abi=hard/softfp` w zależności od ABI.  
- SVE: `-msve-vector-bits=<128|256|...>` w Clang/LLVM; intrinsics `<arm_sve.h>`.  
- NEON: intrinsics z `<arm_neon.h>`.

**Wykrywanie w runtime (Linux, skrót)**  
```c
#include <sys/auxv.h>
#include <asm/hwcap.h>
#include <stdio.h>

int main(void){
  unsigned long hwcap  = getauxval(AT_HWCAP);
  unsigned long hwcap2 = getauxval(AT_HWCAP2);
  int has_neon = (hwcap & HWCAP_ASIMD) != 0;   // AArch64: NEON/AdvSIMD
  int has_sve  = (hwcap & HWCAP_SVE)   != 0;
  int has_sve2 = (hwcap2 & HWCAP2_SVE2)!= 0;   // jeśli zdefiniowane w toolchainie
  printf("NEON=%d SVE=%d SVE2=%d\n", has_neon, has_sve, has_sve2);
  return 0;
}
```

**Dobre praktyki**  
- Projektuj jądra **data‑oriented**; ograniczaj ruch cross‑lane i niewyrównane dostępy.  
- Wykorzystuj **VL‑agnostic** dla SVE/SVE2.  
- Korzystaj z **Compute Library/XNNPACK/TFLite** zamiast pisać wszystko ręcznie.


## ✅ Checklist operacyjny

- [ ] Dobierz target: `-march=armv8-a` lub `-march=armv9-a` + konkretny `-mcpu`.  
- [ ] Włącz NEON/SVE2 zgodnie z docelowym sprzętem; trzymaj **fallback** skalarny.  
- [ ] Użyj bibliotek z dispatchingiem ISA na ARM (ACL/XNNPACK/ORT/TFLite).  
- [ ] Profiluj pamięć i wektory; zwróć uwagę na cache i prefetch.  
- [ ] Jeśli SoC ma **NPU/GPU**, przenieś ciężkie jądra i zostaw CPU dla sterowania i klejenia pipeline’u.


## 🔍 Tabela skrótów

| Skrót | Rozwinięcie | Znaczenie |
|:--|:--|:--|
| **ISA** | Instruction Set Architecture | Zestaw instrukcji i reguł programowych |
| **AArch64/AArch32** | ARM 64‑bit / 32‑bit | Tryby wykonania kodu |
| **EL0–EL3** | Exception Levels | Poziomy przywilejów |
| **NEON/AdvSIMD** | SIMD 128‑bit | Wektoryzacja w profilach A |
| **SVE/SVE2** | Scalable Vector Extension | Wektory o zmiennej długości |
| **PAC/MTE/BTI** | Pointer Auth / Memory Tagging / Branch Target ID | Twarde mechanizmy bezpieczeństwa |
| **DSU** | DynamIQ Shared Unit | Wspólny L3/interconnect w klastrach |
| **TrustZone** | Secure World vs Normal World | Izolacja bezpieczeństwa na EL3 |


## 📌 Notatki końcowe

- ARM nie jest kompatybilny binarnie z x86. Potrzebne są natywne buildy lub translacja JIT.  
- W praktyce **NEON** jest powszechny; **SVE2** rośnie w Armv9‑A, ale dostępność zależy od rdzenia/producenta.  
- CPU ARM w AI najczęściej pełni rolę koordynatora, a duże jądra wykonują **GPU/NPU/DSP**.

## 🔗 Backlinks

- [[jakubc]]
- [[INDEX]]
- [[core]]

---
*Auto-generated backlinks for cluster connectivity*
