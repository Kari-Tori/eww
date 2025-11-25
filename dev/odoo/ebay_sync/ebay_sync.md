---
title: Integracja dwukierunkowa eBay ↔ Odoo
description: Szkielet prac integracyjnych w katalogu dev/odoo/ebay_sync
---

# dev/odoo/ebay_sync

Cel: integracja dwukierunkowa eBay ↔ Odoo (produkty, stany, zamówienia, wysyłki) bez zmiany workflow Kariny.

## Backstory i daily ops
- Od roku sprzedajemy przedmioty w eww przez eBay; Karina prowadzi listingi, używa ChatGPT do opisów i przeglądarki do operacji.
- Wprowadzamy Odoo ERP (docelowo Odoo 18 + PostgreSQL; sprawdzić najnowszą GA) dla kontroli stanów, zamówień i raportów, bez zmiany dotychczasowego workflow Kariny.
- Klucz: Karina nie zmienia na co dzień narzędzi – integracja ma działać w tle i być idempotentna. eBay zostaje źródłem prawdy dla istniejących listingów; Odoo przejmuje sterowanie stock/cen w przód.

## Środowisko instalacji
- Sprzęt: Dell T140.
- Virtualizacja: Proxmox, 2× VM (aplikacja Odoo) + VM z PostgreSQL.
- Odoo: zainstalowane i spolszczone; podstawowe moduły aktywne.

## Plan wdrożenia
1) Dostępy i konfiguracja: zebrać klucze eBay (sandbox/prod), utworzyć app i refresh token; dodać zmienne do modelu ustawień Odoo (sandbox/production).
2) Model konfiguracyjny Odoo: `ir.config_parameter` na sekrety, przełącznik środowisk, logowanie i flaga trybu testowego.
3) Backfill listingów: import kategorii i ofert z eBay, tworzenie brakujących kategorii w Odoo, mapowanie listing/SKU do produktów i wariantów z zapisaniem `ebay_listing_id`/`ebay_sku`.
4) Import zamówień: cron/webhook, idempotencja (`ebay_order_id`, `ebay_order_line_id`), podatki, koszt wysyłki, tworzenie partnerów.
5) Sync stock/cen (forward): batch, retry/backoff na 429/5xx, raportowanie błędów.
6) Fulfillment: wysyłka statusów i trackingów z Odoo do eBay, kolejka retry, logi techniczne.
7) Monitorowanie: dashboard/kolejka zadań, alerty przy błędach, metryki (limity eBay, czasy odpowiedzi).
8) Testy: sandbox eBay + testy jednostkowe/integracyjne z fixture’ami JSON; scenariusze edge (warianty, brak SKU, zwroty/refundy).

## MVP – wynik
- Wsteczny import wszystkich listingów eBay z kategoriami; tworzymy brakujące kategorie w Odoo.
- Odwzorowanie listing → `product.template/product.product` (warianty) z zachowaniem drzewa kategorii eBay.
- Import zamówień z podatkami i kosztami wysyłki do `sale.order`, tworzenie partnerów.
- Aktualizacja stock/cen z Odoo do eBay (batch, retry/backoff).
- Publikacja trackingów z Odoo do eBay (fulfillment). OAuth2 z refresh tokenem, sekretne dane w `ir.config_parameter`.

## MVP – zakres techniczny
1) Autoryzacja: OAuth2 + refresh; konfiguracja w modelu ustawień (sandbox/production).
2) Import listingów i kategorii (backfill) z zapisem identyfikatorów `ebay_listing_id`/`ebay_sku`.
3) Import zamówień z idempotencją (`ebay_order_id`, `ebay_order_line_id`) i mapowaniem podatków/wysyłek.
4) Sync stock/cen z Odoo → eBay (cron, batch, retry na 429/5xx).
5) Fulfillment: wysyłka statusów i trackingów do eBay; logi techniczne i kolejka retry.

## Struktura
- `docs/` – mapowania pól, sekwencje sync, kontrakty API (payloady eBay/Odoo).
- `scripts/` – prototypy i narzędzia CLI do testów API (OAuth, sandbox, sync jednostkowy).
- `odoo_addon/` – kod modułu Odoo (manifest, modele mapowań, crony, webhooki).
- `tests/` – testy i fixture’y payloadów (pytest/BATS lub przykładowe JSON-y).

## TODO (propozycja)
- Przygotować model konfiguracyjny Odoo (klucze, tryb sandbox/production).
- Opisać mapowania SKU/variantów i podatków w `docs/`.
- Dodać prototyp CLI do odświeżania tokenu i pingowania Orders API (sandbox).
- Zaplanować crony: stock (5–10 min), orders (1–2 min lub webhook), fulfillment (on-change).
- Dodać logi techniczne + retry/backoff w kolejce zadań.
