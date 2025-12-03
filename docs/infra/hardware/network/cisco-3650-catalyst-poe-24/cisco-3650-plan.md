---
tags:
  - #cisco
  - #network
  - #plan
created: 2025-11-23T22:44:32Z
modified: 2025-12-01T20:15:00Z
author: jakubc
title: "Cisco 3650 — plan wdrożenia"
status: planning
owner: jakubc
---

# Cisco 3650 — plan wdrożenia

Plan przejścia z Netgear FS108 na Catalyst 3650-24P PoE z VLAN i PoE dla hostów, AP i kamer (GaryNet).

## 🎯 Cele
- Zero downtime przy przepięciu hostów z FS108.
- Wydzielenie VLAN (LAN, IoT/PoE, Mgmt) + PoE dla AP/kamer.
- Utrzymanie źródła prawdy w repo (`cisco-3650-ports`, `cisco-3650-specs`).

## 🛠️ Fazy i akceptacja
0) **Tymczasowe obejście (do czasu dual-WAN)**  
   - [[../tp-link_tl-wr902ac]] w trybie WISP/Client: łączy się z hotspotem (iPhone) po Wi-Fi, daje NAT na porcie RJ45.  
   - RJ45 z TL-WR902AC → WAN routera (tymczasowy WAN2) lub bezpośrednio do uplinku (jeśli router nie ma dwóch WAN).  
   - Utrzymaj izolację: własna podsieć z TL-WR902AC, brak mostkowania do LAN.
1) **Przygotowanie**  
   - Aktualny `running-config` do backupu (TFTP/USB).  
   - `show inventory`/`show version` w `cisco-3650-specs`.  
   - Potwierdzony uplink `C3KX-NM-1G (4×1G SFP)`.
2) **Montaż fizyczny**  
   - Szafa U42, wysoko (U38–U42); patch do routera dual-WAN.  
   - Oba PSU podpięte do UPS, opisane przewody.  
   - Stack ports zamknięte/capped (jeśli brak stack).
3) **Config bazowy**  
   - Hostname, mgmt IP (VLAN Mgmt), SSH, AAA lokalne.  
   - Syslog/SNMP placeholdery; `logging event link-status` dla Gi1/0/1–8.  
   - Uplink trunk (VLAN 1, Mgmt), access profile dla Gi1/0/x zgodnie z `cisco-3650-ports`.
4) **Migracja hostów (Faza 4–5)**  
   - Kolejno: GERC → ASUS Z77 → Lenovo M710q → Dell T140.  
   - Każdy port: opis, VLAN 1, PoE wg potrzeb, test ping/internet.  
   - Stary FS108 działa równolegle do zakończenia.
5) **Stabilizacja (Faza 6)**  
   - `show power inline` po podpięciu AP/kamer.  
   - Backup `startup-config` do repo; uzupełnienie `cisco-3650-ports` i `cisco-3650-specs`.  
   - Update `docs/infra/hardware/network/network` + topology GaryNet.

## ✅ Checklist operacyjny
- [ ] Backup starych konfiguracji (FS108 jeżeli dostępne) + Catalyst `startup-config`.
- [ ] Uzgodnione IP zarządzania + VLAN Mgmt.
- [ ] Audyt patchcordów (uplink + kluczowe hosty) zakończony.
- [ ] Po migracji: test WAN, LAN, PoE (AP/kamery), monitoring link-status.
- [ ] TL-WR902AC skonfigurowany (WISP/Client) i wpięty jako tymczasowy WAN.

## 🔗 Referencje
- [[cisco-3650-ports]]
- [[cisco-3650-specs]]
- [[ops/2025-11-23~initial-setup]]
- [[../network-deployment]]
