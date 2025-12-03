---
version: 0.0.1
tags:
  - #GERC
  - #automation
  - #docs
  - #eww
  - #infrastructure
  - #linux
  - #planning
  - #star-wars
created: 2025-11-24
modified: 2025-11-24
author: jakubc
title: "Plan mapowania struktury GERC na podstawie Asus Z77"






owner: jakubc
---

# Plan mapowania struktury GERC na podstawie Asus Z77

## 🎯 Cel projektu

Skopiować strukturę dokumentacji z folderu `asus_z77` do `gerc`, wykorzystując pliki Asus Z77 jako szablony. Następnie uzupełnić informacje o GERC przy użyciu CLI i przeskanować całe repozytorium w poszukiwaniu dodatkowych danych.

## 📊 Analiza struktury źródłowej (asus_z77)

### Struktura katalogów
```
asus_z77/
├── asus_z77.md                          # Główny plik jednostki (folder note)
├── cpu-intel-i7-3770k.md                # Procesor
├── motherboard-asus-p8z77-v-deluxe.md   # Płyta główna
├── ram-corsair-vengeance-16gb.md        # Pamięć RAM
├── gpu-nvidia-gtx1660ti.md              # Karta graficzna
├── psu-tbd.md                           # Zasilacz
├── pcie-wifi-go.md                      # Karta PCIe WiFi
├── case/                                # Folder obudowy
│   ├── case-index.md                    # Index obudowy
│   ├── case.md                          # Opis obudowy
│   ├── case-chassis.md                  # Obudowa (chassis)
│   ├── case-fans.md                     # Wentylatory obudowy
│   ├── case-cpu-cooler.md               # Chłodzenie CPU
│   └── case-cpu-fans.md                 # Wentylatory CPU
├── storage/                             # Folder dysków
│   ├── storage-index.md                 # Index storage
│   ├── storage.md                       # Opis storage
│   └── storage-ssd-sk-hynix-sc401.md    # Konkretny dysk
└── ops/                                 # Historia operacyjna
    ├── ops.md                           # Index operacji
    ├── 2022-05-01~zakup.md              # Zakup jednostki
    ├── 2024-02-01~pierwszy-dysk.md      # Pierwszy dysk
    ├── 2024-06-01~modernizacja-gpu.md   # Modernizacja GPU
    ├── 2024-10-01~wdrozenie.md          # Wdrożenie
    ├── 2025-03-01~drugi-dysk.md         # Drugi dysk
    └── 2025-05-01~serwis-chlodzenia.md  # Serwis chłodzenia
```

### Struktura obecna (gerc)
```
gerc/
├── gerc.md           # Główny plik (prosty)
├── cpu.md            # Podstawowe info
├── motherboard.md    # Podstawowe info
├── ram.md            # Podstawowe info
├── gpu.md            # Podstawowe info
├── psu.md            # Podstawowe info
├── case.md           # Podstawowe info
├── cooling.md        # Podstawowe info
├── fans.md           # Podstawowe info
└── storage.md        # Podstawowe info
```

## 🔍 Różnice i co trzeba dodać

### 1. Brakujące foldery
- `gerc/case/` - struktura obudowy, wentylatory, chłodzenie
- `gerc/storage/` - szczegóły dysków, indeks storage
- `gerc/ops/` - historia operacyjna, timeline wydarzeń
- `gerc/pcie/` (opcjonalnie) - dodatkowe karty PCIe

### 2. Brakujące pliki top-level
- Szczegółowe pliki komponentów z modelami (obecnie mamy tylko ogólne nazwy)
- Pliki opisujące konkretne karty PCIe (jeśli są)

### 3. Różnice w zawartości
**Asus Z77 ma:**
- Szczegółowe opisy komponentów z numerami modeli
- Sekcje Dataview do automatycznego zbierania danych
- Zadania dla użytkowników (@karinam)
- Historie zmian
- Tabele specyfikacji z wartościami
- Sekcje "Znaczenie historyczne i odbiór"
- Linki do prekursorów/następców/rywali
- Timeline operacji z konkretnymi datami
- Folder note tags (#folder_note)

**GERC ma:**
- Podstawowe tabele z wartościami "TODO"
- Brak struktury folderowej
- Brak historii operacyjnej
- Minimalne zadania

## 📋 Plan wykonania

### Faza 1: Przygotowanie struktury katalogów (DONE = ✅ | TODO = ⬜)

⬜ **1.1** Utworzyć folder `gerc/case/`
⬜ **1.2** Utworzyć folder `gerc/storage/`
⬜ **1.3** Utworzyć folder `gerc/ops/`
⬜ **1.4** Utworzyć folder `gerc/pcie/` (opcjonalnie, jeśli są dodatkowe karty)

### Faza 2: Kopiowanie i adaptacja plików głównych

⬜ **2.1** Zaktualizować `gerc.md` na podstawie `asus_z77.md`
   - Dodać sekcje: Opis i zastosowanie, Specyfikacja Dataview, Indeks folderu, Zadania, Notatki operacyjne, Historia zmian
   - Zamienić tagi `#Asus_Z77` → `#GERC`
   - Dostosować nazwy komponentów do GERC (Asus X99 Pro zamiast P8Z77)

⬜ **2.2** Zaktualizować `cpu.md` na podstawie `cpu-intel-i7-3770k.md`
   - Rozszerzyć tabelę specyfikacji
   - Dodać zadania dla użytkowników
   - Model: Intel Core i7 (8c/16t) - ustalić konkretny model (np. i7-5960X)

⬜ **2.3** Zaktualizować `motherboard.md` na podstawie `motherboard-asus-p8z77-v-deluxe.md`
   - Dodać sekcje: Znaczenie historyczne, Złącza i kontrolery, Prekursor/Następca/Rywal
   - Rozbudować specyfikację dla Asus X99 Pro
   - Dodać informacje o socketcie LGA2011-v3

⬜ **2.4** Zaktualizować `ram.md` na podstawie `ram-corsair-vengeance-16gb.md`
   - Dodać szczegóły modułów RAM
   - Określić typ DDR4, prędkość, ilość

⬜ **2.5** Zaktualizować `gpu.md` na podstawie `gpu-nvidia-gtx1660ti.md`
   - Dodać szczegóły kart GPU (2× GPU według gerc.md)
   - Określić modele i specyfikacje

⬜ **2.6** Zaktualizować `psu.md` na podstawie `psu-tbd.md`
   - Dodać model zasilacza
   - Określić moc, certyfikat, złącza

### Faza 3: Utworzenie struktury case/

⬜ **3.1** Utworzyć `gerc/case/case-index.md` na podstawie `asus_z77/case/case-index.md`
   - Index wszystkich plików case
   - Linki do podsekcji

⬜ **3.2** Rozdzielić obecny `case.md` na:
   - `case/case-chassis.md` - opis obudowy (chassis)
   - `case/case-fans.md` - wentylatory obudowy
   - Przenieść cooling.md → `case/case-cpu-cooler.md`
   - Przenieść fans.md → `case/case-cpu-fans.md` (lub scalić z case-fans.md)

⬜ **3.3** Utworzyć `case/case.md` jako główny plik folderu case

### Faza 4: Utworzenie struktury storage/

⬜ **4.1** Utworzyć `gerc/storage/storage-index.md` na podstawie `asus_z77/storage/storage-index.md`
   - Lista wszystkich dysków
   - Zadania dla użytkowników

⬜ **4.2** Przenieść `storage.md` → `gerc/storage/storage.md`

⬜ **4.3** Utworzyć pliki dla konkretnych dysków:
   - `storage/storage-ssd-[model].md` dla każdego SSD
   - `storage/storage-hdd-[model].md` dla każdego HDD
   - `storage/storage-nvme-[model].md` dla każdego NVMe (jeśli są)

### Faza 5: Utworzenie historii operacyjnej (ops/)

⬜ **5.1** Utworzyć `gerc/ops/ops.md` jako folder note
   - Wzór z `asus_z77/ops/ops.md`

⬜ **5.2** Utworzyć chronologiczne pliki operacji (przykładowe daty do ustalenia):
   - `ops/YYYY-MM-DD~zakup.md` - zakup jednostki
   - `ops/YYYY-MM-DD~pierwsza-instalacja.md` - pierwsza instalacja systemu
   - `ops/YYYY-MM-DD~modernizacja-gpu.md` - modernizacja GPU (jeśli była)
   - `ops/YYYY-MM-DD~wdrozenie.md` - wdrożenie do infrastruktury
   - `ops/YYYY-MM-DD~dyski.md` - instalacja dysków
   - `ops/YYYY-MM-DD~serwis.md` - serwisy i naprawy

⬜ **5.3** Dodać timeline do `gerc.md` z linkami do plików ops

### Faza 6: Zbieranie informacji przez CLI

⬜ **6.1** Informacje o CPU
```bash
# Model procesora
lscpu | grep "Model name"
cat /proc/cpuinfo | grep "model name" | head -1

# Liczba rdzeni i wątków
lscpu | grep -E "^CPU\(s\)|Core\(s\) per socket|Thread\(s\) per core|Socket\(s\)"

# Taktowanie
lscpu | grep MHz

# Microcode
cat /proc/cpuinfo | grep microcode | head -1
```

⬜ **6.2** Informacje o płycie głównej
```bash
# Model płyty
sudo dmidecode -t baseboard | grep -E "Manufacturer|Product Name|Version"

# BIOS
sudo dmidecode -t bios | grep -E "Vendor|Version|Release Date"

# Chipset
lspci | grep -i "host bridge"
```

⬜ **6.3** Informacje o RAM
```bash
# Szczegóły pamięci
sudo dmidecode -t memory | grep -E "Size|Type:|Speed|Manufacturer|Part Number|Locator"

# Podsumowanie
free -h
lsmem
```

⬜ **6.4** Informacje o GPU
```bash
# Lista GPU
lspci | grep -i vga
lspci | grep -i nvidia

# Szczegóły nvidia (jeśli jest nvidia-smi)
nvidia-smi -L
nvidia-smi --query-gpu=name,driver_version,memory.total --format=csv
```

⬜ **6.5** Informacje o storage
```bash
# Lista dysków
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT,MODEL

# SMART info
sudo smartctl -a /dev/sda
sudo smartctl -a /dev/nvme0n1

# Szczegóły partycji
df -h
```

⬜ **6.6** Informacje o zasilaczu
```bash
# Pobór mocy (jeśli są sensory)
sensors

# Info z dmidecode
sudo dmidecode -t 39
```

⬜ **6.7** Informacje o obudowie i chłodzeniu
```bash
# Wentylatory
sensors | grep -i fan

# Temperatury
sensors | grep -i temp
```

⬜ **6.8** Informacje o kartach PCIe
```bash
# Lista wszystkich urządzeń PCIe
lspci -v

# Szczegółowe info
lspci -vv | grep -A 20 "VGA\|Network\|USB\|SATA"
```

⬜ **6.9** Informacje sieciowe
```bash
# Interfejsy
ip -brief address
nmcli device show

# Hostname
hostname
hostnamectl
```

### Faza 7: Skanowanie repo w poszukiwaniu informacji o GERC

⬜ **7.1** Przeskanować wszystkie pliki markdown w repo
```bash
# Wyszukaj wszystkie wzmianki o GERC/gerc
grep -r "gerc\|GERC" docs/ --include="*.md" | grep -v "gerc/gerc.md"

# Znajdź pliki z informacjami o sprzęcie
grep -r "X99\|LGA2011\|i7.*5960\|i7.*5820\|i7.*6800" docs/ --include="*.md"
```

⬜ **7.2** Sprawdzić znalezione pliki i wyciągnąć informacje:
   - `business/methodologies/DevOps_Methodology.md` - rola GERC w infrastrukturze
   - `business/methodologies/Obsidian_Dashboard.md` - vault hostowany na GERC
   - `docs/ENDPOINTS.md` - adresy IP: 192.168.0.99, gerc.local
   - `yaml/yaml_extra.yaml` - hostname: GERC
   - `Makefile` - backup-gerc
   - `EWW-MAP.md` - tag #GERC z kolorem #0D47A1

⬜ **7.3** Wyciągnąć informacje z innych źródeł:
   - Historia commitów Git dotyczących GERC
   - Logi systemowe (journalctl)
   - Konfiguracje aplikacji
   - Skrypty automatyzacji

### Faza 8: Uzupełnienie informacji w plikach GERC

⬜ **8.1** Uzupełnić wszystkie pola "TODO" danymi z CLI

⬜ **8.2** Dodać informacje znalezione w repo:
   - IP: 192.168.0.99
   - Hostname: GERC / gerc.local
   - Rola: host wszystkiego - laboratorium, produkcja, zarządzanie
   - Vault Obsidian hostowany na GERC
   - Kolor tagu: #0D47A1 (kolor Asusa)

⬜ **8.3** Dodać sekcje specjalne dla GERC (różnice od Asus Z77):
   - Dual GPU setup (w przeciwieństwie do single GPU w Z77)
   - Socket LGA2011-v3 (nowszy niż LGA1155)
   - Platforma X99 (nowsza niż Z77)
   - Więcej rdzeni/wątków

⬜ **8.4** Dodać linki cross-reference między plikami:
   - gerc.md → wszystkie komponenty
   - komponenty → gerc.md
   - storage → dyski konkretne
   - case → cooling, fans
   - ops → komponenty (gdy były instalowane/serwisowane)

### Faza 9: Walidacja i sprawdzenie spójności

⬜ **9.1** Sprawdzić czy wszystkie linki działają (brak broken links)

⬜ **9.2** Sprawdzić czy wszystkie tagi są spójne:
   - #GERC wszędzie gdzie trzeba
   - #folder_note dla folder notes
   - Pozostałe tagi zgodne z konwencją

⬜ **9.3** Sprawdzić czy frontmatter jest kompletny:
   - tags
   - created
   - modified
   - author
   - title

⬜ **9.4** Sprawdzić czy wszystkie sekcje Dataview są poprawne

⬜ **9.5** Uruchomić `make check` lub skrypty walidacyjne

### Faza 10: Dokumentacja i finalizacja

⬜ **10.1** Zaktualizować `docs/infra/hardware/hardware.md` z pełnym opisem GERC

⬜ **10.2** Dodać wpis do `CHANGELOG.md`

⬜ **10.3** Zaktualizować `gerc-mapping-plan.md` - oznaczyć co zostało zrobione

⬜ **10.4** Commit i push zmian

## 🎨 Konwencje nazewnictwa

### Pliki komponentów
- Format: `[component]-[vendor]-[model].md`
- Przykłady:
  - `cpu-intel-i7-5960x.md`
  - `motherboard-asus-x99-pro.md`
  - `gpu-nvidia-gtx1080ti.md` (jeśli jest)
  - `ram-corsair-dominator-64gb.md`
  - `storage-ssd-samsung-970evo.md`

### Pliki w folderach
- `case/case-index.md` - główny index
- `case/case-chassis.md` - obudowa
- `case/case-fans.md` - wentylatory
- `case/case-cpu-cooler.md` - chłodzenie CPU
- `storage/storage-index.md` - główny index
- `storage/storage-ssd-[model].md` - konkretne dyski
- `ops/ops.md` - główny index
- `ops/YYYY-MM-DD~[nazwa-wydarzenia].md` - wydarzenia chronologiczne

### Tagi
- `#GERC` - wszystkie pliki związane z GERC
- `#folder_note` - pliki będące folder notes
- `#automation`, `#docs`, `#eww`, `#infrastructure`, `#linux`, `#star-wars` - standardowe tagi

## 📝 Szablon frontmatter dla GERC

```yaml
---
tags:
  - #GERC
  - #automation
  - #docs
  - #eww
  - #infrastructure
  - #linux
  - #star-wars
created: YYYY-MM-DDTHH:MM:SSZ
modified: YYYY-MM-DDTHH:MM:SSZ
author: jakubc
title: "[Tytuł pliku]"
---
```

## 🚀 Kolejność wykonania (rekomendowana)

1. **Faza 6** (CLI) - zebrać najpierw wszystkie dane techniczne
2. **Faza 7** (Skanowanie) - zebrać kontekst z repo
3. **Faza 1** (Struktura) - utworzyć foldery
4. **Faza 2-5** (Pliki) - skopiować i dostosować pliki
5. **Faza 8** (Uzupełnienie) - uzupełnić dane
6. **Faza 9** (Walidacja) - sprawdzić spójność
7. **Faza 10** (Finalizacja) - dokumentacja i commit

## 📊 Metryki sukcesu

- ✅ Wszystkie foldery utworzone (case/, storage/, ops/)
- ✅ Wszystkie pliki skopiowane i dostosowane
- ✅ Wszystkie TODO wypełnione prawdziwymi danymi
- ✅ Historia operacyjna udokumentowana (min. 3 wydarzenia)
- ✅ Brak broken links
- ✅ Wszystkie tagi spójne
- ✅ Frontmatter kompletny we wszystkich plikach
- ✅ Dataview queries działają
- ✅ Commit i push wykonany

## 🔧 Narzędzia pomocnicze

### Skrypty do utworzenia
```bash
# gerc-collect-info.sh - zbiera wszystkie info z CLI
# gerc-validate-links.sh - sprawdza linki
# gerc-frontmatter-check.sh - sprawdza frontmatter
# gerc-generate-index.sh - generuje indeksy
```

## 📚 Referencje

- Źródło: `/docs/infra/hardware/workstations/asus_z77/`
- Cel: `/docs/infra/hardware/workstations/gerc/`
- Przykłady: wszystkie pliki w `asus_z77/` jako szablony
- Dokumentacja: `docs/infra/hardware/hardware.md`

## ✅ Status: TODO

**Utworzono:** 2025-11-22
**Ostatnia aktualizacja:** 2025-11-22
**Status:** 📋 Plan gotowy do realizacji
**Właściciel:** jakubc
**Wykonawcy:** jakubc, @karinam

---
*Ten dokument będzie aktualizowany podczas realizacji projektu. Każda ukończona faza będzie oznaczana ✅.*

## 🔗 Backlinks

- [[docs/infra/hardware/workstations/gerc/gerc]]
- [[docs/docs]]
- [[INDEX]]