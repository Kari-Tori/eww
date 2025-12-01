---
title: Integracja dwukierunkowa eBay ↔ Odoo
description: Szkielet prac integracyjnych w katalogu dev/odoo/ebay_sync
---

# 📦 dev/odoo/ebay_sync

Cel: dwukierunkowa integracja eBay ↔ Odoo (produkty, stany, zamówienia, wysyłki) bez zmiany codziennego workflow Kariny.

## 🗺️ Kontekst i środowisko
- eBay to źródło prawdy dla istniejących listingów; Odoo przejmuje zarządzanie stockiem/cenami w przód.
- Użytkownik końcowy (Karina) pracuje jak dotąd – integracja działa w tle, idempotentnie.
- Infra:
  - Proxmox na Dell T140: `192.168.0.102`
  - VM Odoo app: `192.168.0.200`
  - VM Odoo DB (PostgreSQL): `192.168.0.201`
- Wersja Odoo: 18 (sprawdzać najnowszą GA), Community Edition.

## 🎯 Zakres funkcjonalny (MVP)
1) Autoryzacja: OAuth2 + refresh; konfiguracja sandbox/production w modelu ustawień Odoo (`ir.config_parameter`).
2) Backfill listingów z eBay wraz z kategoriami/podkategoriami; tworzenie brakujących kategorii w Odoo przy imporcie; zachowanie `ebay_listing_id`/`ebay_sku` i drzewa kategorii.
3) Import zamówień z idempotencją (`ebay_order_id`, `ebay_order_line_id`), podatkami, kosztami wysyłki i tworzeniem partnerów.
4) Sync stock/cen z Odoo → eBay (batch, retry/backoff na 429/5xx).
5) Fulfillment: publikacja statusów i trackingów z Odoo do eBay; kolejka retry + logi techniczne.
6) Monitoring/testy: metryki limitów eBay, czasy odpowiedzi, sandbox + testy jednostkowe/integracyjne z fixture’ami JSON.

## 🔄 Architektura wymiany danych
- Pull (cron): Orders/Inventory API w krótkich odstępach; prostsze, ale obciąża limity.
- Push (webhook eBay Notifications API) – preferowane: destination `WEBHOOK`, subskrypcje orders/fulfillment/inventory; publiczny HTTPS 443, stały FQDN, cert, reverse proxy do `/api/ebay/webhook`; challenge + podpisy; asynchroniczna kolejka; fallback na cron.

## 🔐 Konfiguracja i sekrety
- Klucze eBay (sandbox/prod), app id, cert id, RUName/redirect URI, refresh token – w `ir.config_parameter`, rozdział per środowisko.
- Przełącznik środowisk, flaga trybu testowego, logowanie techniczne.
- Mapowania SKU/variantów, podatków i kategorii – w `docs/`.

## ⏱️ Crony (pull/push)
- Orders: webhook lub cron co 1–2 min (sandbox), produkcja zgodnie z limitami.
- Pull (eBay → Odoo, pełny asortyment): co 5–10 min, przyrostowo z `updated_since`, idempotencja po `ebay_listing_id/sku`, log różnic/błędów.
- Push (Odoo → eBay, pełny asortyment): co 5–10 min, batch + retry/backoff, idempotencja po SKU/listing; pełny sync stock/cen z Odoo.
- Fulfillment: on-change lub krótki cron.
- Refresh tokenów: przed wygaśnięciem (bufor), alerty na 401.

### 📥 Pull: eBay → Odoo (stock co 10 min)
- API: Sell Inventory (`getInventoryItem` per SKU) lub Orders, jeśli stan wynika z fulfillmentu; wybierz endpoint z najmniejszymi limitami.
- Zakres: pełny asortyment zmapowanych SKU (`ebay_sku`/`ebay_listing_id`); pobieraj przyrostowo (`updated_since` + zapas).
- Kategorie: przy imporcie pobieraj kategorie/podkategorie eBay i twórz brakujące kategorie w Odoo z zachowaniem hierarchii (drzewo).
- Idempotencja: `ebay_sku`/`ebay_listing_id` + timestamp; zapisuj last success/licznik prób.
- Retry/backoff: 429/5xx – exponential backoff, max prób, log techniczny.
- Błędy: logi techniczne + metryki (czas, liczba rekordów, 4xx/5xx); alerty na 4xx/401.
- Bezpieczeństwo: token z buforem; osobne credentials prod/sandbox.
- Rezultat: aktualizacja `qty_available`/`virtual_available` w Odoo + log różnic; brak zmian = brak zapisu.

### 📤 Push: Odoo → eBay (ceny/stock co 5–10 min)
- Trigger: zmiany stock/cen w Odoo; aglomerowane w batch (np. 50–100 SKU per request) w zależności od limitów.
- API: Sell Inventory (`bulkUpdatePriceQuantity` lub ekwiwalent), z idempotency key per batch.
- Idempotencja: per SKU/listing + idempotency key; przechowuj status batcha i ostatni `request-id`.
- Retry/backoff: 429/5xx – exponential backoff, limit prób; przerwij batch przy 4xx trwałym.
- Walidacja: sprawdzaj odpowiedzi częściowe (sukces/błędy per SKU); zapisz log techniczny, wskaż rekordy do ponownego wysłania.
- Bezpieczeństwo: token z buforem; osobne credentials prod/sandbox.

### 📊 Limity i metryki (eBay)
- Monitoruj nagłówki limitów (`x-ebay-*`) i zapisuj per-cron: liczba requestów, 429/5xx, czas odpowiedzi, liczba przetworzonych SKU/zamówień.
- Budżet roboczy (konserwatywny, do tuningu po obserwacji nagłówków): pull ≤ 30 req/10 min; push ≤ 60 req/10 min. Przy >80% budżetu zmniejsz batch lub wydłuż interwał.
- Alerty na serie 429/401 lub wzrost czasu odpowiedzi; loguj z `deliveryId`/`request-id` (jeśli dostępne).

## 🗂️ Struktura katalogu
- `docs/` – mapowania pól, sekwencje sync, kontrakty API.
- `scripts/` – prototypy CLI (OAuth, sandbox, sync jednostkowy).
- `odoo_addon/` – moduł Odoo (manifest, modele, crony, webhooki).
- `tests/` – testy i fixture’y (pytest/BATS/JSON).

## ✅ TODO (do uszczegółowienia)
- Model konfiguracyjny Odoo (sandbox/prod) z walidacją braków kluczy.
- Mapowania SKU/variantów i podatków w `docs/`.
- Prototyp CLI: refresh tokenu, ping Orders API (sandbox), healthcheck/webhook verifier.
- Crony: stock/orders/fulfillment zgodnie z harmonogramem; retry/backoff + logi.

## 📚 Dokumentacja referencyjna
- [eBay Developers (OAuth, API)](../../docs/ebay/README.md)
- [Odoo Developer](../../docs/odoo/README.md)
- [PostgreSQL (current)](../../docs/postgresql/README.md)

## 🔗 Backlinks
- [[dev/dev|dev]]
- [[docs/INDEX|INDEX]]
- [[dev/projects/Odoo/Odoo|Odoo (projekty)]]
- [[dev/projects/Odoo/odoo_ebay_sync_mvp/odoo_ebay_sync_mvp|odoo_ebay_sync_mvp]]
