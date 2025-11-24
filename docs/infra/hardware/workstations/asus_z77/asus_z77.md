---
tags:
  - #Asus_Z77
  - #automation
  - #docs
  - #eww
  - #infrastructure
  - #linux
  - #star-wars
  - #folder_note
created: 2025-11-21T15:00:00Z
modified: 2025-11-22T17:15:00Z
author: jakubc
title: "asus_z77 — karta główna"






owner: jakubc
---



# asus_z77 — karta główna

Jednostka robocza Kariny oparta o płytę Asus Z77. Poniższe sekcje opisują jej zastosowanie, parametry, zadania i historię operacyjną.

## ℹ️ Opis i zastosowanie
> [!info] Profil jednostki  
> - 💻 **Rola:** Workstation Kariny (desktop kreatywny / AI) z GPU GTX 1660 Ti i zestawem 2 monitorów + TV.  
> - 📸 **Workflow:** zgrywanie zdjęć z telefonu przez WhatsApp (iCloud tymczasowo wyłączony), research przedmiotów, przygotowanie opisów i upload listingów eBay.  
> - 📺 **Tryb TV:** obecnie Jakub pracuje na tej maszynie podpiętej do telewizora Samsung 65", więc pełni ona też rolę centrum multimedialnego.  
> - 🧩 **Infrastruktura:** wpięta ok. Q4 2024, po modernizacji GPU i wymianie dysków; regularnie serwisowana (ostatnio chłodzenie, sprzedaż GTX 1030).

## ⚙️ Specyfikacja (Dataview)
```dataview
TABLE icon AS " ", model AS "Model", specs AS "Specyfikacja", value AS "Wartość"
FROM "docs/infra/hardware/workstations/asus_z77"
WHERE component
SORT file.name
```

## 🗂️ Indeks folderu
- `motherboard-asus-p8z77-v-deluxe.md`, `cpu-intel-i7-3770k.md`, `ram-corsair-vengeance-16gb.md`, `gpu-nvidia-gtx1660ti.md`, `psu-tbd.md`, `pcie-wifi-go.md`, `storage/`
- `case/` (np. `case-index.md`, `case-chassis.md`, `case-fans.md`, `case-cpu-cooler.md`, `case-cpu-fans.md`)
- `ops/` – oś czasu operacji i serwisów

## ✅ Zadania @karinam (folder asus_z77)
```dataview
TASK
FROM "docs/infra/hardware/workstations/asus_z77"
```

## ✅ Zadania globalne (wszystkie pliki)
```dataview
TASK
FROM ""
WHERE contains(text, "asus_z77")
```

## 📝 Notatki operacyjne = Ops timeline
> [!abstract] 2022-05-01 · [Zakup](ops/2022-05-01~zakup.md)
> - Jednostka kupiona na eBayu za ~£80 (sprzedawca odmówił oddania dysku, po eskalacji otrzymaliśmy zwrot). Stała bez dysku ~2 lata.  
> - TODO: podlinkować transakcję i potwierdzić dokładny dzień zakupu.

> [!info] 2024-02-01 · [Pierwszy dysk + reinstalacje](ops/2024-02-01~pierwszy-dysk.md)
> - Tymczasowy SSD → wielokrotne reinstalli Kubuntu → awaria nośnika.  
> - TODO: dodać logi reinstalli (daty, wersje, nośniki ISO).

> [!success] 2024-06-01 · [Modernizacja GPU](ops/2024-06-01~modernizacja-gpu.md)
> - GTX 1660 Ti Windsurf w miejsce EVGA GTX 1030; stara karta leżała w zapasie i została sprzedana ok. 2 tyg. temu za £32.  
> - TODO: podlinkować aukcję i datę sprzedaży/montażu.

> [!important] 2024-10-01 · [Wdrożenie do infrastruktury](ops/2024-10-01~wdrozenie.md)
> - Formalne wpięcie do środowiska operacyjnego (GTX 1660 Ti + pierwszy dysk).  
> - TODO: dodać wpis z rejestru assetów.

> [!info] 2025-03-01 · [Drugi dysk – SK hynix](ops/2025-03-01~drugi-dysk.md)
> - Instalacja docelowego SSD SK hynix 512 GB (obecny dysk systemowy).  
> - TODO: dopisać datę instalacji, SMART i powiązane reinstallacje.

> [!note] 2025-05-01 · [Serwis chłodzenia](ops/2025-05-01~serwis-chlodzenia.md)
> - Karina serwisowała wentylatory, by ustabilizować temperaturę.  
> - TODO: wpisać temperatury odniesienia i profil wentylatorów.

> [!tip] 📔 Log reinstalli (ciągły)
> - Każda wymiana/awaria dysku → reinstall Kubuntu.  
> - TODO: spiąć timeline (`data`, `wersja`, `powód`) z kartą dysku i notatkami serwisowymi.

- [ ] @karinam dopisać numery seryjne obudowy/zasilacza i świeży stan konserwacji.

## Historia zmian
| Data | Opis |
| --- | --- |
| 2025-11-22 | Dodano sekcję konfiguracji sieciowej i diagnozę problemu z internetem. |
| 2025-11-19 | Utworzono strukturę folderu i linki do komponentów. |

## 📑 Index plików

- [cpu-intel-i7-3770k](cpu-intel-i7-3770k.md)
- [gpu-nvidia-gtx1660ti](gpu-nvidia-gtx1660ti.md)
- [motherboard-asus-p8z77-v-deluxe](motherboard-asus-p8z77-v-deluxe.md)
- [pcie-wifi-go](pcie-wifi-go.md)
- [psu-tbd](psu-tbd.md)
- [ram-corsair-vengeance-16gb](ram-corsair-vengeance-16gb.md)

## 📁 Podfoldery

- [case/](case/case.md)
- [ops/](ops/ops.md)
- [storage/](storage/storage.md)

## 🔗 Backlinks

- [[EWW-MAP]]
- [[GRAPH-MAP]]
- [[GRAPH-CORE]]
- [[GRAPH-BUSINESS]]
- [[GRAPH-CONFIG]]


## 🌐 Konfiguracja sieciowa
> [!info] Parametry sieciowe
> - 🔌 **Interfejs:** enp13s0 (MAC: 8a:7f:75:bf:88:f0, permaddr: c8:60:00:a2:e2:c0)
> - 📍 **IP statyczny:** 192.168.0.77/24
> - 🚪 **Gateway:** 192.168.0.10 (router, MAC: 88:d7:f6:63:40:b8)
> - 🌍 **DNS:** 127.0.0.53 (systemd-resolved)
> - 📱 **WiFi:** wlp11s0 (DOWN, MAC: fc:b3:bc:35:67:bd) - karta PCIe WiFi Go
> - 🔌 **Ethernet 2:** eno1 (NO-CARRIER, MAC: c8:60:00:a2:f1:fe)
> - 👤 **Użytkownik:** karinam
> - 💻 **OS:** Ubuntu 25.04 (kernel 6.14.0-36-generic x86_64)

## 🔍 Diagnoza - 2025-11-22
> [!warning] Problem z dostępem do internetu
> - ❌ Brak połączenia z internetem (ping 8.8.8.8: 100% packet loss)
> - ✅ Sieć lokalna działa (ping 192.168.0.10 OK)
> - 🚧 Pakiety wychodzące zatrzymują się na routerze (hop 1), brak odpowiedzi z WAN dla 8.8.8.8
> - 🔧 Przyczyna (aktualna hipoteza): filtracja/konfiguracja sieciowa na hoście asus_z77 (router działa — GERC ma internet)
> - 📋 Status: Firefox nie ładuje stron z powodu braku internetu (nie problem aplikacji)
> - 🧪 Kroki wykonane lokalnie: `nmcli d status`, `ip addr show enp13s0`, `ip route` i `ip neigh` potwierdziły statyczny adres 192.168.0.77/24 oraz prawidłową komunikację L2 z bramą (MAC 88:d7:f6:63:40:b8); `ping`/`traceroute 8.8.8.8` zatrzymują się na routerze.
> - 🤝 Testy dwustronne: `gerc (192.168.0.99) → asus_z77` i `asus_z77 → gerc` — ping OK, co potwierdza, że LAN działa poprawnie.
> - 🌍 Odniesienie: `gerc → internet` działa (ping 8.8.8.8/curl OK), więc WAN/router są funkcjonalne; usterka jest lokalna dla asus_z77 (konfiguracja lub firewall).
> - 🧱 Podejrzenia: `sudo ufw status`, `sudo nft list ruleset` i profil NetworkManager mogą ujawnić blokadę ruchu wychodzącego lub nieprawidłowe DNS; dodatkowo agent Cloudflare Zero Trust (WARP) mógł wymusić tryb „always-on” i po resecie routera zablokować ruch do WAN.
> - 📡 Wyniki SSH (2025-11-22 19:20): `warp-cli status` zwraca `Status update: Connecting (Performing happy eyeballs to 162.159.192.1:443)` oraz `warp-cli settings` → `Always On: true`, `warp-svc` uruchamia setki procesów `warp-dex traceroute 162.159.192.1`, co wskazuje na zapętlone próby zestawienia tunelu i możliwą blokadę całego ruchu internetowego.
> - ✅ Fix tymczasowy (2025-11-22 18:00): `warp-cli disconnect` oraz `echo 'ciastko33' | sudo -S systemctl stop warp-svc` przywracają wyjście na WAN — `ping 8.8.8.8` przechodzi, a `curl -I http://example.com` i `curl -I https://example.com` zwracają 200. Pozostaw usługę zatrzymaną lub przeprojektuj politykę CFZT (split tunnel jak na GERC) przed ponownym włączeniem.
> - 🌐 Dalsze działania: 
>   1. W przeglądarce otworzyć `http://192.168.0.10`, zalogować się `admin/admin`, potwierdzić że router/WAN jest online.
>   2. Lokalnie: `warp-cli status`, `sudo systemctl status warp-svc`; jeśli aktywny tryb blokuje ruch, wykonaj `warp-cli disable-always-on`, `warp-cli disconnect`, `sudo systemctl stop warp-svc` i ponownie sprawdź ping 8.8.8.8.
>   3. Po identyfikacji przyczyny, zsynchronizuj polityki Zero Trust z GERC i ponownie włącz klienta (`warp-cli connect`) lub skonfiguruj split tunnel.
>   4. Równolegle przejrzeć `journalctl -u NetworkManager` oraz porównać ustawienia profilu z GERC.

## 🔐 Dostęp / SSH
- **SSH (LAN):** `ssh karinam@192.168.0.77` — hasło `ciastko33`.
- **Uwaga:** Dane dostępowe są przechowywane tutaj na potrzeby operacyjne; po wdrożeniu bezpieczniejszego sekret-store przenieść je do managera haseł.
