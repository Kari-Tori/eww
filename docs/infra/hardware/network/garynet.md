---
tags:
  - #network
  - #infra
  - #garynet
  - #connection
  - #eww
created: 2025-11-22T21:00:00Z
modified: 2025-11-22T21:00:00Z
author: jakubc
title: "GaryNet - Połączenie z budynkiem Gary'ego"
owner: jakubc
---

# 🌐 GaryNet - Połączenie międzybudynkowe

## 📋 Opis

**GaryNet** to fizyczne połączenie sieciowe między dwoma budynkami:
- **Punkt A:** Gniazdko RJ45 w naszej ścianie (warsztat)
- **Punkt B:** Router Sky należący do Gary’ego (budynek 20 m dalej)
- **Własność/administracja:** Sprzęt i łącze należą do Gary’ego, ale bieżącym adminem (hasła, logi, konfiguracja) jest `jakubc`.

## 🔌 Topologia

```
[Nasz budynek]
    |
    | Gniazdko GaryNet (ściana) — RJ45
    |
    | ~20 m kabel (Cat TBD)
    |
    v
[Budynek Gary'ego]
    |
    | Router Sky (właściciel: Gary, admin: jakubc)
    |
    v
[Internet / Sieć lokalna Gary]
```

## 📐 Parametry fizyczne

- **Długość:** ~20 metrów
- **Typ kabla:** TODO (Cat5e / Cat6 / Cat7?)
- **Gniazdko:** RJ45 w ścianie
- **Instalacja:** TODO (kiedy założono)
- **Stan:** Aktywne / Nieaktywne (do sprawdzenia)

## 🌍 Routing

### Nasz budynek
- **Gateway lokalny:** 192.168.0.10 (ASUS DSL-N16)
- **Sieć:** 192.168.0.0/24
- **Urządzenia:** asus_z77, lenovo_y700, GERC, karinam devices

### Via GaryNet → Router Gary
- **IP routera Gary:** TODO
- **Sieć Gary:** TODO
- **Dostęp:** Mamy / Nie mamy (do ustalenia)
- **Autentykacja:** TODO

## ✅ Dostęp

- [x] **Fizyczny:** TAK - gniazdko w ścianie
- [ ] **Logiczny:** TODO - sprawdzić routing
- [ ] **Uprawnienia:** TODO - uzgodnić z Gary

## 🔧 Konfiguracja

### Na ASUS DSL-N16 (192.168.0.10)
```bash
# Sprawdź czy port GaryNet jest aktywny
# TODO: który port fizyczny?
# TODO: VLAN? Bridge?
```

### Testowanie połączenia
```bash
# Z asus_z77 lub lenovo_y700
ping [IP_routera_Gary]
traceroute [IP_routera_Gary]
```

## 📊 Use Cases

1. **Backup Internet** - jeśli nasz DSL-N16 nie działa
2. **Dostęp do zasobów Gary** - TODO (jakie?)
3. **Sharing bandwidth** - współdzielenie internetu
4. **VPN gateway** - alternatywna droga wyjścia

## 🛜 Router Sky (Gary)
- **Model:** Sky ER115 (ER115)  
- **Firmware:** 4.13.07.04.r  
- **Status (obserwacja):** Modem status = disconnected; WAN port = disconnected (brak synchronizacji WAN / brak linku) — do weryfikacji po stronie Gary’ego.
- **Dostęp:** osiągalny przez Wi‑Fi Sky po wpięciu WR902AC (Share ETH) i połączeniu laptopem.
- **Następny krok:** skontaktować się z Garym i potwierdzić, że router/WAN są aktywne; ustalić czy potrzebny restart lub nowy kabel/uplink.

## ⚠️ Bezpieczeństwo

- [ ] Firewall na DSL-N16 dla GaryNet
- [ ] Oddzielny VLAN dla ruchu GaryNet?
- [ ] MAC filtering?
- [ ] Monitoring ruchu

## 📝 TODO

- [ ] Zmierzyć prędkość połączenia (iperf3)
- [ ] Sprawdzić typ kabla
- [ ] Uzgodnić z Gary zasady dostępu
- [ ] Skonfigurować routing (jeśli potrzebny)
- [ ] Dodać do monitoringu (ping co 5 min)

## 🔗 Powiązane

- [[devices/asus-dsl-n16/asus-dsl-n16]] - Nasz gateway 192.168.0.10
- [[../../hardware/laptops/lenovo_y700/lenovo_y700]] - Laptop z dostępem
- [[network]] - Network overview

---

**Status:** 🟡 Do skonfigurowania  
**Właściciel:** jakubc + Gary  
**Priorytet:** Średni

## 🔗 Backlinks

- [[docs/infra/hardware/network/network]]
- [[docs/docs]]
- [[INDEX]]
