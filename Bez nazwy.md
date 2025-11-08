# Kanban DevOps — E‑Waste Workshop

> Jedna tablica do pracy operacyjnej: incydenty, zmiany, utrzymanie platformy, BizOps. Minimalny przepływ, twarde WIP, szablony kart.

---

## Front‑matter tablicy

```markdown
---
kanban-plugin: board
tags: [board, devops, eww]
wip:
  Triage: 3
  Ready: 7
  In-Progress: 3
  Review/Test: 2
  Deploy/Verify: 1
  Expedite: 1
swimlanes: [EXPEDITE, INCIDENT, CHANGE, MAINTENANCE, PLATFORM, BIZOPS]
---
```

> Wstaw to do pliku `01_OPERACJE/Boards/kanban-eww-devops.md`.

---

## Kolumny

### 🧲 Inbox

Surowe zgłoszenia. Brak pracy, tylko dopisywanie kontekstu.

### 🔬 Triage (WIP 3)

Kwalifikacja: typ, priorytet, właściciel, DoR.

### ✅ Ready (WIP 7)

Gotowe do podjęcia. Bierzemy **pull** tylko stąd.

### 🏗 In‑Progress (WIP 3)

Praca aktywna. Jedna osoba ≤2 karty łącznię.

### 🧪 Review/Test (WIP 2)

PR, testy, staging, smoke.

### 🚀 Deploy/Verify (WIP 1)

Rollout + weryfikacja w produkcji.

### ⛔ Blocked

Musi mieć `blocked:REASON`. Bez tego karta wraca do **Triage**.

### ✅ Done

Zamknięte. Metryki wpisane.

### 🧊 Parked

Nie liczy się do WIP. Przegląd co tydzień.

---

## Lane’y (swimlanes)

- **EXPEDITE**: maks. 1 karta globalnie. Wejście tylko za zgodą właściciela usługi.
    
- **INCIDENT**: P1–P4, SLO i MTTR obowiązkowe.
    
- **CHANGE**: planowane wdrożenia, backout plan.
    
- **MAINTENANCE**: patching, backupy, porządki.
    
- **PLATFORM**: CI/CD, IaC, monitoring.
    
- **BIZOPS**: finanse, eBay/ERP, procesy.
    

---

## Polityki przepływu

- **Pull, nie push.**
    
- **Twarde WIP.** Nie przenoś jeśli narusza limit.
    
- **DoR** (Definition of Ready): opis, cel, typ, priorytet, właściciel, kryteria akceptacji, backout jeśli CHANGE.
    
- **DoD** (Definition of Done): kod/konfig w repo, testy OK, monitoring/alerty zaktualizowane, rollout opisany, metryki dopisane, dokumentacja uzupełniona.
    

---

## Taksonomia etykiet

- **Klasy serwisu:** `class:expedite`, `class:fixed-date`, `class:standard`, `class:intangible`.
    
- **Środowisko:** `env:lab|dev|stg|prod`.
    
- **Domena/usługa:** `service:odoo`, `service:ebay`, `infra:proxmox`, `monitoring:kuma`, `observ:grafana`, `ai:cortex`, `automation:n8n`, `storage:nextcloud`, `pm:openproject`, `finance:firefly`.
    
- **Priorytet:** `P1|P2|P3|P4`.
    

---

## Szablony kart

### 1) INCIDENT

```markdown
Title: [P2][INCIDENT] Usługa X degraduje
Type: incident
Priority: P2
Owner: imię
Env: prod
Service: service:X
Class: standard
Started: {{date:YYYY-MM-DD HH:mm}}
Hypothesis:
Impact/SLO:
Mitigation now:
Rollback plan:
Done when:
Postmortem: link
Labels: incident, {{Service}}, env:{{Env}}, {{Priority}}
Checklist:
- [ ] Reprodukcja i zakres
- [ ] Status komunikat (wewn./zewn.)
- [ ] Tymczasowe obejście
- [ ] RCA hipoteza
- [ ] Fix wdrożony i zweryfikowany
- [ ] Postmortem + akcje prew.
```

### 2) CHANGE

```markdown
Title: [CHANGE] Deploy vX.Y usługi X
Type: change
Impact: low|medium|high
Risk: low|medium|high
Owner: imię
Env: stg→prod
Service: service:X
Class: standard
Plan:
Backout plan:
Tests:
Change window:
Approvals: CAB/owner
Labels: change, {{Service}}, env:{{Env}}
Checklist:
- [ ] PR zrecenzowany
- [ ] Migration plan + backout
- [ ] Monitoring/alerty zaktualizowane
- [ ] Rollout wykonany
- [ ] Weryfikacja po wdrożeniu
- [ ] Dokumentacja uzupełniona
```

### 3) TASK/PLATFORM/BIZOPS

```markdown
Title: [TASK] Cel jednozdaniowy
Type: task
Owner: imię
Class: standard
Estimate: 90m
Acceptance:
- [ ] Kryterium 1
- [ ] Kryterium 2
Labels: platform|bizops, domena
```

---

## Priorytety i SLO

- **P1**: usługa krytyczna martwa. MTTA ≤ 5 min, MTTR ≤ 60 min.
    
- **P2**: silna degradacja. MTTR ≤ 4 h.
    
- **P3**: umiarkowane. ≤ 2 dni.
    
- **P4**: niskie. ≤ 7 dni.
    

---

## Metryki do dopisania na karcie

- **Lead time:** `created → done`.
    
- **Cycle time:** `start → done`.
    
- **Throughput:** karty/tydzień.
    
- **DORA:** deploy freq, change fail rate, MTTR incydentu, lead time do prod.
    

> Minimalnie: w „Done” dopisz lead time, cycle time i czy zmiana zalicza się do DORA.

---

## Przykładowe karty startowe

- **[INCIDENT][P2] Uptime Kuma nie odświeża probe’ów**
    
    - Labels: incident, monitoring:kuma, platform
        
    - Done when: metryki wróciły, brak błędów 1 h
        
- **[CHANGE] Odoo 17 — patch listopadowy**
    
    - Risk: medium. Backout: rollback kontenera. Tests: smoke + faktury
        
- **[PLATFORM] Pipeline backupów Proxmox**
    
    - Cel: snapshoty nocne, retencja 7/30/180
        

---

## Zasady Blocked

- Wejście wyłącznie z powodem: `blocked:$REASON`.
    
- Co 24 h review kart w Blocked.
    
- Jeśli brak akcji → powrót do **Triage**.
    

---

## Rytuały tygodniowe

- **Replenishment (pn, 30 min):** uzupełnij „Ready”.
    
- **Service review (śr, 30 min):** INC, MTTR, SLO.
    
- **Ops retro (pt, 30 min):** usprawnienia przepływu, korekta WIP.
    

---

## Minimalna automatyzacja (n8n — szkic)

1. **Webhook (Kuma Alert) → Function (mapowanie) → Git:Append File**
    
    - Wejście: JSON alertu z Uptime Kuma.
        
    - Mapowanie: `Title`, `Type=incident`, `Priority` z severity, `Service` z monitora, `Started=now()`.
        
    - Akcja: dopisz nową kartę do sekcji **🧲 Inbox** w `kanban-eww-devops.md`.
        
2. **GitHub Action (PR merged) → n8n webhook**
    
    - Reguła: merge do `main` z `Fixes #ID` → przeniesienie karty `In‑Progress → Review/Test`.
        

> Jeżeli nie chcesz automatycznego dopisywania do pliku, alternatywa: integracja z Issues i widok Kanban przez wtyczkę.

---

## Notatki operacyjne

- Limity WIP kalibruj co tydzień wg przepustowości 2–4 tygodni.
    
- Expedite ma pierwszeństwo nad wszystkim, ale tylko jedna karta.
    
- Incydenty wymagają postmortem do 48 h po zamknięciu.