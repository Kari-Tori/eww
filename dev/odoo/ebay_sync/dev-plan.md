---
title: Plan rozwoju integracji eBay ↔ Odoo
description: Lista kroków do wdrożenia pełnego sync (pull/push) z cronami
owner: ai
status: draft
---

# 🛠️ Plan rozwoju (eBay ↔ Odoo)

Cel: pełny dwukierunkowy sync asortymentu (stock/ceny) i kategorii, z cronami pull/push co 5–10 min.

## 🖥️ Środowisko
- Proxmox (Dell T140) `192.168.0.102`
- Odoo app (CE 18) `192.168.0.200`
- Odoo DB (PostgreSQL) `192.168.0.201`
- eBay sandbox + production (osobne klucze/redirect URI)

## ✅ Plan kroków (checklista – szczegółowa)
- [ ] **Backup + snapshot (prod)**: zatrzymaj prod na czas snapshotu (app/DB), wykonaj `pg_dump`, zapisz w bezpiecznej lokalizacji.
- [ ] **Klon VM (staging)**: klony app/DB w Proxmox, nowy MAC/IP/hostname/porty, uruchom staging.
- [ ] **Izolacja staging**: klucze eBay sandbox, sandbox DNS/redirect URI, blokada wyjść do prod API/maili (firewall), ograniczone zasoby (1 worker Odoo, mniejsze `shared_buffers`).
- [ ] **Model settings**: dodaj settings w Odoo (sandbox/prod: app id, cert id, RUName, refresh token, tryb test), waliduj brakujące pola.
- [ ] **OAuth**: refresh token z buforem, auto-refresh po 401, log błędów; przechowywanie w `ir.config_parameter`.
- [ ] **Importer kategorii**: pobierz kategorie/podkategorie eBay, twórz brakujące w Odoo z zachowaniem hierarchii.
- [ ] **Backfill listingów**: pełny asortyment przyrostowo (`updated_since`), mapuj `ebay_listing_id`/`ebay_sku`, twórz produkty/warianty i link do kategorii.
- [ ] **Cron pull (eBay → Odoo)**: co 5–10 min; przyrostowo po `updated_since`; idempotencja SKU/listing; retry/backoff na 429/5xx; log różnic/błędów; monitoruj nagłówki limitów.
- [ ] **Cron push (Odoo → eBay)**: co 5–10 min; batch 50–100 SKU `bulkUpdatePriceQuantity`; idempotency key; obsługa częściowych sukcesów; retry/backoff; log request-id/błędy.
- [ ] **Orders/fulfillment**: webhook Notifications API (challenge, podpisy) lub krótki cron; kolejka asynchroniczna; idempotencja po `ebay_order_id`/`ebay_order_line_id`.
- [ ] **Monitoring/limity**: loguj `x-ebay-*` (limit/remaining/reset), metryki 429/401/5xx, alert przy >80% budżetu; raporty per cron.
- [ ] **Testy**: sandbox fixtures, testy jednostkowe/integracyjne pull/push, scenariusze błędów (429/401/5xx, partial success).
- [ ] **Dokumentacja**: zaktualizuj `dev/odoo/ebay_sync/ebay_sync.md` i `dev/docs/ebay/README.md` o realne limity/endpointy; zanotuj parametry cronów.

## ⏳ Szacowany czas wdrożenia (iteracyjnie)
- Przygotowanie środowiska (backup/klon/izolacja staging): ~0,5–1 dnia
- Konfiguracja + OAuth + model settings: ~0,5 dnia
- Kategorie + backfill listingów: ~1–1,5 dnia
- Cron pull/push (logika, retry/backoff, idempotencja): ~1–1,5 dnia
- Orders/fulfillment (webhook/cron, kolejka, podpisy): ~1 dnia
- Monitoring/limity + testy (unit/integration, sandbox fixtures): ~1 dnia
- Dokumentacja i strojenie po testach: ~0,5 dnia

Łącznie: ok. 5,5–6,5 dnia roboczego, z możliwością skrócenia przy reuse gotowych modułów/testów.
## 📌 Założenia operacyjne
- Pull/push opóźnienie akceptowalne: 5–10 min.
- Batch i interwały dostosowywane na podstawie nagłówków limitów.
- Idempotencja po `ebay_listing_id`/`ebay_sku` (pull) i po SKU/listing + idempotency key (push).
