---
tags:
  - #network
  - #diagram
  - #topology
created: 2025-12-01T21:25:00Z
modified: 2025-12-01T21:35:00Z
modified: 2025-12-01T22:10:00Z
author: jakubc
title: "Network Topology — EWW"
status: draft
owner: jakubc
---

# Network Topology — EWW

Stan **aktualny (bez Catalysta)**: hotspot iPhone → Wi-Fi Lenovo Y700 → ICS RJ45 → ASUS DSL-N16 → Netgear FS108 → hosty. IP podane tam, gdzie znane. Kolory: WAN czerwony, bridge fiolet, gateway pomarańcz, switch niebieski, hosty zielone.

```mermaid
flowchart TD
  classDef wan fill:#ffe0e0,stroke:#c00,stroke-width:1.2px;
  classDef bridge fill:#f1e0ff,stroke:#7b3fc9,stroke-width:1.2px;
  classDef gw fill:#ffe9cc,stroke:#c60,stroke-width:1.2px;
  classDef sw fill:#e0ecff,stroke:#1f66d1,stroke-width:1.2px;
  classDef host fill:#e5ffe5,stroke:#2b8a3e,stroke-width:1.2px;
  classDef link dashed:#666;
  classDef diag fill:#e0f7ff,stroke:#0094c7,stroke-width:1.2px;

  subgraph WAN
    iphone["📱 iPhone hotspot\nWi-Fi LTE"]
    garynet["🌐 GaryNet (Sky)\nRJ45 w ścianie\nobecnie odłączone"] 
  end

  subgraph Bridge
    y700["💻 Lenovo Y700\nWi-Fi ↔ RJ45 ICS (vimbr0/virbr0)\nIP: 10.42.0.1 (enp9s0)\nIP: 172.20.10.2 (wlp8s0)\nBT: yes"]
  end

  subgraph Gateway
    asus["🛡️ ASUS DSL-N16\n192.168.0.10\nGateway LAN (WAN z Y700)\nLAN→Netgear + ASUS Z77"]
  end

  subgraph Switch
    netgear["🔀 Netgear FS108\nFastEthernet (100 Mb/s)\nEdge DEV"]
  end

  subgraph Diag["Diag (GaryNet Wi-Fi)"]
    tplink["📡 TL-WR902AC (Share ETH)\nRJ45 z GaryNet → NAT Wi-Fi (diag)\nSSID: diag/TBD"]
    laptop["💻 Laptop diag\nWi-Fi → TL-WR902AC\nDostęp do Sky ER115"]
  end

  subgraph Hosts
    gerc["🖥️ GERC WS\n192.168.0.99\nLAN + Wi-Fi + BT"]
    z77["🖥️ ASUS Z77\n192.168.0.77\n2×RJ45 + Wi-Fi + BT"]
    m710["🖥️ Lenovo M710q\n192.168.0.88 (Proxmox)"]
    t140["🖥️ Dell T140\n192.168.0.102 (Proxmox)"]
  end

  %% Aktualne połączenia
  iphone -. "Wi-Fi LTE" .-> y700:::bridge
  y700 -->|"RJ45 WAN\n~300 Mb/s ICS"| asus:::gw
  asus -->|"LAN 100 Mb/s"| netgear:::sw
  asus -->|"LAN 100 Mb/s"| z77:::host
  netgear -->|"FE 100 Mb/s"| gerc:::host
  netgear -->|"FE 100 Mb/s"| m710:::host
  netgear -->|"FE 100 Mb/s"| t140:::host

  %% GaryNet diag AP (jedyny punkt podpięcia GaryNet)
  garynet -->|"RJ45"| tplink:::diag
  tplink -->|"Wi-Fi"| laptop:::diag

  class iphone,garynet wan;
  class y700 bridge;
  class asus gw;
  class netgear sw;
  class gerc,z77,m710,t140 host;
  class tplink,laptop diag;
```

## 📋 Lista urządzeń (skrót)
- **📱 iPhone hotspot** — źródło internetu (Wi-Fi).
- **💻 Lenovo Y700** — most Wi-Fi → RJ45 (ICS, vimbr0/virbr0) dla WAN; IP: 10.42.0.1 (enp9s0), 172.20.10.2 (wlp8s0); BT: tak.
- **🛡️ ASUS DSL-N16** — gateway 192.168.0.10, NAT/Firewall dla 192.168.0.0/24.
- **🔀 Netgear FS108** — edge switch FastEthernet (DEV/hosty).
- **🖥️ Hosty** — GERC (192.168.0.99, LAN + Wi-Fi + BT), ASUS Z77 (192.168.0.77, 2×RJ45 + Wi-Fi + BT), Lenovo M710q (192.168.0.88/Proxmox), Dell T140 (192.168.0.102/Proxmox).
- **🌐 GaryNet** — RJ45 w ścianie (Sky, podpięte tylko do TL-WR902AC diag; brak połączenia z ASUS DSL-N16).
- **📡 TL-WR902AC (diag)** — w trybie Share ETH z RJ45 GaryNet, wystawia Wi-Fi (diag SSID) do diagnostyki routera Sky ER115.

## 🧭 Bloki (tekst)
- **WAN:** iPhone hotspot (Wi-Fi); GaryNet RJ45 tylko do diag AP (nie do ASUS DSL-N16).
- **Bridge:** Lenovo Y700 (ICS) — 10.42.0.1 (enp9s0), 172.20.10.2 (wlp8s0), BT.
- **Gateway:** ASUS DSL-N16 — 192.168.0.10; LAN do Netgear i bezpośrednio do ASUS Z77.
- **Switch:** Netgear FS108 — FastEthernet 100 Mb/s do hostów.
- **Hosty:** GERC 192.168.0.99 (LAN/Wi-Fi/BT), ASUS Z77 192.168.0.77 (2×RJ45/Wi-Fi/BT), Lenovo M710q 192.168.0.88 (Proxmox), Dell T140 192.168.0.102 (Proxmox).
- **Diag:** TL-WR902AC (Share ETH) + Wi-Fi diag → laptop z dostępem do Sky ER115 (GaryNet).

## 🗒️ Do uzupełnienia
- IP dla ewentualnych IoT/PoE.
- IP dla GaryNet (router Sky) po ponownym podłączeniu.
- Plan docelowy (dual-WAN + Catalyst) pozostaje w `network-deployment*.md`.

## 🔗 Backlinki

- [[network]]
- [[tp-link_tl-wr902ac]]
- [[cisco-3650-catalyst-poe-24/cisco-3650-catalyst-poe-24]]
- [[netgear_fs108/netgear_fs108]]
- [[devices/asus-dsl-n16/asus-dsl-n16]]
