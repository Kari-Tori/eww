---
tags:
  - #GERC
  - #folder_note
  - #automation
  - #docs
  - #eww
  - #infrastructure
  - #linux
  - #star-wars
created: 2025-11-22T00:00:00Z
modified: 2025-11-22T00:00:00Z
author: jakubc
title: "Storage — index"






owner: jakubc
---



# Storage — index

Ten folder trzyma karty każdego nośnika danych w systemie GERC.

## Podsumowanie dysków

### System główny (boot)
- **nvme0n1:** Samsung MZVPV512HDGL 512 GB NVMe (system główny `/`)

### Dodatkowe dyski
- **sda:** WDC WD5003ABYX 500 GB SATA (RAID/storage)
- **sdb:** WDC WD5003ABYX 500 GB SATA (RAID/storage)
- **sdc:** Hypertec SSD 120 GB SATA (storage/backup)
- **sdd:** WDC WD20PURX 2 TB SATA (Purple - surveillance/archive)
- **sde:** Toshiba MG04ACA400E 4 TB SATA (enterprise - data storage)

## Pliki urządzeń

- [NVMe - Samsung 512GB](storage-nvme-samsung-512gb.md) - dysk systemowy
- [SATA - WDC 500GB (sda)](storage-sata-wdc-500gb-sda.md)
- [SATA - WDC 500GB (sdb)](storage-sata-wdc-500gb-sdb.md)
- [SATA - Hypertec SSD 120GB (sdc)](storage-sata-hypertec-ssd-120gb.md)
- [SATA - WDC Purple 2TB (sdd)](storage-sata-wdc-purple-2tb.md)
- [SATA - Toshiba 4TB (sde)](storage-sata-toshiba-4tb.md)

## Statystyki łączne
- **Liczba dysków:** 6 (1× NVMe, 5× SATA)
- **Pojemność łączna:** ~7.6 TB
- **Wykorzystanie systemu (/):** 161 GB / 469 GB (37%)
- **Wolne miejsce (/):** 285 GB

## Topologia SATA
> [!info] Płyta X99-PRO: 10× SATA 6Gb/s + M.2
> - **Chipset Intel:** 8× SATA 6Gb/s (kontroler główny)
> - **ASMedia ASM1062:** 2× SATA 6Gb/s (dodatkowy kontroler)
> - **M.2 Socket 3:** obsługa NVMe PCIe 3.0 x4 lub SATA
>
> Aktualne wykorzystanie:
> - 5× SATA ports (sda-e)
> - 1× M.2 NVMe (nvme0n1)
> - **Wolne:** 5× SATA ports

## Zadania
- [ ] @karinam dodać pełną listę dysków z numerami seryjnymi.
- [ ] @karinam wykonać testy SMART dla wszystkich dysków i dodać raporty.
- [ ] @karinam opisać politykę backupów (co jest backupowane, gdzie, jak często).
- [ ] @karinam sprawdzić konfigurację RAID (mdadm) dla sda/sdb jeśli są w RAID.
- [ ] @karinam dodać benchmarki dysków (fio, hdparm, crystaldiskmark).
- [ ] @karinam zanotować status health każdego dysku (SMART attributes).
- [ ] @karinam opisać partycjonowanie każdego dysku (sfdisk -l, lsblk -f).
