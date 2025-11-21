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
title: "🔧 BIOS / UEFI — narzędzia operacyjne"






---

# 🔧 BIOS / UEFI — narzędzia operacyjne

> [!summary]+ 🎯 Cel
> Wejście do firmware. Zmiana ustawień startowych. Ustawienie boot order. Restart przez sieć. Minimalny kontakt fizyczny z maszyną.


## 🖥️ 1. Host bez BMC (PC / mini PC)

> [!info]+ 💡 Kiedy używasz tej metody
> Masz zwykłą płytę / desktop / SFF box bez iDRAC / iLO / IPMI. Czyli brak kontrolera serwerowego.

### 🔁 `systemctl reboot --firmware-setup`

```bash
systemctl reboot --firmware-setup
```

> [!note] 📌 Co to robi
> - Wymusza restart prosto do UEFI/BIOS.
> - Nie trzeba łapać DEL/F2 ręcznie na POST.
> - Działa gdy host startuje w UEFI i ma systemd (Proxmox tak).

> [!warning] 🔒 Ograniczenie
> Nie zmienia ustawień BIOS automatycznie. Tylko otwiera firmware setup.


### 📜 `efibootmgr`

Podgląd wpisów EFI:
```bash
efibootmgr -v
```

Ustaw kolejność bootu:
```bash
efibootmgr -o 0003,0000,0001
```

> [!tip]+ 🧭 Po co to
> - Ustawiasz kolejność bootu (np. PXE najpierw).
> - Nie musisz wchodzić do BIOS żeby zmienić boot order.
> - Dobre przy awaryjnym odpaleniu z innego dysku.

> [!fail] 🚫 Limit
> Nie rusza innych parametrów firmware (VT-x, SR-IOV, turbo, fan curve).


## 🖲️ 2. IPMI / BMC (sprzęt serwerowy)

Dotyczy serwerów z kontrolerem out-of-band (OOB):
- 🟦 Dell iDRAC  
- 🟨 HPE iLO  
- 🟩 Supermicro IPMI  

Każdy taki kontroler ma własny adres IP. Nie jest to IP Proxmoxa.

### ⚡ `ipmitool`

Restart zdalny:
```bash
ipmitool -I lanplus -H <IP_BMC> -U <USER> -P <PASS> chassis power cycle
```

Wymuś jednorazowy boot z PXE / innego urządzenia:
```bash
ipmitool -I lanplus -H <IP_BMC> -U <USER> -P <PASS> chassis bootdev pxe
```

Odczyt czujników (temp, wentylatory):
```bash
ipmitool -I lanplus -H <IP_BMC> -U <USER> -P <PASS> sensor
```

> [!abstract]+ 🛰️ Zastosowanie
> - Zdalny power cycle.
> - Wymuszenie źródła bootu przed POST.
> - Monitoring temperatury i wentylatorów.

> [!danger] ❗ Nie robi tego
> - Nie zapisze nowych opcji BIOS typu Virtualization=Enabled.
> - To jest sterowanie zasilaniem i kolejnością startu, nie pełna edycja firmware.


### 🖥️🔌 KVM-over-IP (iDRAC Virtual Console / iLO Remote Console / Supermicro KVM)

> [!info]+ 🧷 Funkcja
> - Zdalny ekran od pierwszej sekundy POST.
> - Zdalna klawiatura (F2 / DEL / ESC itd.).
> - Możesz wejść do BIOS i zmieniać wszystko ręcznie bez fizycznego dostępu.

> [!success] ✅ Efekt
> To jest zdalny monitor + zdalna klawiatura. Jakbyś siedział przy serwerze.

> [!warning] 🔐 Uwaga
> - W starszych iDRAC/iLO pełny KVM może wymagać licencji Enterprise.
> - BMC powinien mieć osobny VLAN / dostępy tylko z sieci admin.


## 🏭 3. CLI vendorów (automatyczna zmiana BIOS)

Cel: ustawiasz wartości BIOS skryptowo i wciskasz je przy restarcie. Dobre do standaryzacji węzłów.

### 🟦 Dell PowerEdge → `racadm`

Przykład: włączenie wirtualizacji CPU
```bash
racadm set BIOS.ProcSettings.ProcVirtualization Enabled
racadm jobqueue create BIOS.Setup.1-1 -r Graceful
```

Mechanika Dell:
1. Ustawiasz parametr w profilu BIOS (np. ProcVirtualization=Enabled).
2. Tworzysz job w kolejce zmian BIOS.
3. Robisz restart (graceful).
4. iDRAC stosuje zmiany podczas POST.

> [!tip]+ 🎛️ Co możesz zmienić
> - Wirtualizacja CPU
> - Hyper-Threading / LogicalProc
> - Turbo Boost
> - Profile zasilania
> - Boot order

> [!example] 🔁 Zastosowanie
> - Masowe ustawienie jednakowych parametrów na wielu serwerach Dell.
> - Automatyzacja przez Ansible/bash bez klikania w iDRAC GUI.


### 🟨 HPE ProLiant → `hponcfg` / `conrep`

Eksport profilu BIOS do XML:
```bash
conrep -s -f /root/romprofile.xml
```

Edycja XML i ponowne wczytanie:
```bash
conrep -l -f /root/romprofile.xml
```

> [!info]+ 📂 Co ogarniasz
> - Kolejność bootu
> - Funkcje CPU
> - Polityki energii
> - Często także parametry storage / RAID (model-dependent)

`hponcfg`:
- Lokalna konfiguracja iLO z poziomu działającego systemu.
- Nie zawsze wymaga restartu żeby zmieniać ustawienia kontrolera iLO.

> [!success] 📦 Zastosowanie
> - Klonowanie BIOS setup między identycznymi ProLiantami.
> - Szybka normalizacja serwerów pod jeden standard.


### 🟩 Supermicro → `IPMICFG`

> [!note]+ 📡 Funkcje
> - Konfiguracja IPMI/BMC z poziomu systemu.
> - Odczyt FRU.
> - Ustawianie zachowania wentylatorów.
> - W połączeniu z KVM-over-IP masz pełną kontrolę BIOS i chłodzenia.

> [!warning] 🌡️ Dlaczego ważne
> - Zarządzanie krzywą wentylatorów wpływa na temperaturę GPU/CPU w racku i na głośność.


## 🏢 4. Intel AMT / vPro (stacje robocze klasy biznes)

Dotyczy desktopów klasy enterprise z AMT/vPro (np. OptiPlex wyższych serii, EliteDesk, ThinkCentre Tiny).

Narzędzie: **MeshCommander / MeshCmd**

> [!info]+ 🖥️ Co dostajesz
> - Zdalne włączenie / wyłączenie / restart hosta.
> - KVM sprzętowy od POST (jak iDRAC/iLO).
> - Podgląd ekranu BIOS i pełna klawiatura.
> - Zmiana urządzenia bootującego.

> [!tip] 🧩 Po co
> Użyte gdy masz „prawie serwer”, ale formalnie to nadal desktop bez klasycznego IPMI.

> [!warning] 🔑 Warunek
> AMT musi być aktywowany i mieć ustawione hasło oraz sieć. Bez tego KVM nie działa.


## 🌐 5. Redfish API (nowe generacje serwerów)

> [!abstract]+ 🛠️ Opis
> Redfish = REST API dla BMC. Standard branżowy.

Możliwości:
- Czytanie parametrów BIOS jako JSON.
- Nadpisanie parametrów BIOS (np. wirtualizacja = Enabled).
- Zaplanowanie restartu który zastosuje zmiany.
- Zdalne power on/off/reset.

> [!todo]+ 🤖 Use case
> - Integracja z provisioningiem bare metal.
> - Automatyczne ustawienie profilu firmware przed instalacją hypervisora.
> - Ansible / Terraform dla fizycznych nodów, nie tylko VM.

> [!fail] 🔒 Ograniczenie
> Redfish wymaga kontrolera, który realnie to wspiera (nowsze iDRAC / iLO / Supermicro BMC). Na tanim desktopie nie działa.


## 🧭 6. Szybki wybór strategii

> [!hint]+ 🟩 Masz zwykły desktop / mini PC (brak BMC)
> - `systemctl reboot --firmware-setup` → wymuś wejście do UEFI bez klawiatury.
> - `efibootmgr` → zmień kolejność bootu bez wchodzenia do UEFI.
> - Reszta (VT-x, IOMMU, SR-IOV, fan curve) i tak ręcznie w firmware.

> [!hint]+ 🟦 Masz serwer z BMC (iDRAC / iLO / IPMI)
> - `ipmitool` → power cycle, bootdev, sensory.
> - KVM-over-IP → pełna zmiana BIOS przez sieć.
> - `racadm` / `hponcfg` / `IPMICFG` → automatyczne ustawienia BIOS bez klikania.
> - Redfish → API.

> [!hint]+ 🟨 Masz stację roboczą z Intel vPro AMT
> - MeshCommander → KVM od POST i zdalne sterowanie bootem.
> - BMC-like kontrola bez prawdziwego BMC.


## 🗂️ 7. Szybki katalog narzędzi

> [!info]+ 🔗 Narzędzia główne
> - `systemctl reboot --firmware-setup` — wymusza wejście do UEFI przy następnym restarcie.
> - `efibootmgr` — ustawia kolejność bootu wpisów UEFI z poziomu działającego systemu.
> - `ipmitool` — power cycle, bootdev PXE, sensory. Wymaga IPMI/BMC.
> - KVM-over-IP (iDRAC / iLO / Supermicro KVM) — zdalny ekran i klawiatura od POST, pełny dostęp do BIOS.
> - `racadm` (Dell) — zmiana ustawień BIOS skryptowo i kolejka jobów.
> - `hponcfg` / `conrep` (HPE) — eksport/import profilu BIOS jako XML. Klonowanie ustawień między serwerami.
> - `IPMICFG` (Supermicro) — konfiguracja IPMI i wentylatorów z poziomu OS.
> - MeshCommander (Intel AMT / vPro) — KVM i kontrola bootu na desktopach klasy biznes.
> - Redfish API — REST do BIOS/power/boot dla nowych kontrolerów BMC.


> [!success]+ ✅ Minimalny pakiet startowy na Proxmox host
> ```bash
> apt update && apt install -y ipmitool efibootmgr
> # Dell: zainstaluj racadm + iDRAC Service Module (vendor)
> # HPE: hponcfg / conrep (vendor)
> # Supermicro: IPMICFG (vendor)
> # MeshCommander: z osobnego hosta do AMT/vPro
> ```
>
> BMC/IPMI trzymaj w osobnym VLAN lub tylko przez VPN. Nie wystawiaj tego do sieci użytkowników.

## 🔗 Backlinks

- [[jakubc]]
- [[INDEX]]
- [[core]]

---
*Auto-generated backlinks for cluster connectivity*
