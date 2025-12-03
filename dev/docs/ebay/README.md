---
version: 0.0.1
tags:
  - #docs
  - #ebay
  - #api
  - #oauth
  - #integracje
created: 2025-12-01
modified: 2025-12-01
title: "eBay Developers – pakiet startowy"
owner: ai
---

# eBay Developers – pakiet startowy

## Co znajdziesz
- Pobrane README z oficjalnych SDK eBay OAuth (Node.js, Python) – snapshoty Apache-2.0.
- Szybkie notatki wdrożeniowe (`oauth-notes.md`) z przykładami tokenów i środowisk.
- Linki do portalu eBay Developers, sandboxu i przeglądarek API.

## Pobrane materiały (offline)
- `downloaded/README-ebay-oauth-nodejs.md` – README z repo `eBay/ebay-oauth-nodejs-client` (Apache-2.0).
- `downloaded/README-ebay-oauth-python.adoc` – README z repo `eBay/ebay-oauth-python-client` (Apache-2.0).
- Daty pobrania: 2025-11-29. Aktualizacja: `curl -L https://raw.githubusercontent.com/eBay/ebay-oauth-nodejs-client/master/README.md -o downloaded/README-ebay-oauth-nodejs.md` i analogicznie dla wersji Python.

## Kluczowe linki online
- Portal i konto dev: https://developer.ebay.com/ (rejestracja, klucze sandbox/prod)
- OAuth przegląd: https://developer.ebay.com/api-docs/static/oauth-tokens.html
- Authorization Code Grant: https://developer.ebay.com/api-docs/static/oauth-auth-code-grant.html
- Client Credentials Grant: https://developer.ebay.com/api-docs/static/oauth-client-credentials-grant.html
- Zakresy OAuth: https://developer.ebay.com/api-docs/static/oauth-scopes.html
- Buy APIs overview: https://developer.ebay.com/api-docs/buy/static/overview.html
- Sell APIs overview: https://developer.ebay.com/api-docs/sell/static/overview.html
- API Explorer: https://developer.ebay.com/api-docs/api-explorer/ (wymaga logowania)
- Sandbox register: https://developer.ebay.com/my/register (konto i klucze testowe)

_Uwaga: część stron blokuje automatyczne pobieranie (anti-bot); najlepiej otworzyć w przeglądarce zalogowanej._

## Szybki start (skrót)
1) Utwórz konto w eBay Developers, wygeneruj klucze i redirect URI (sandbox + production).
2) Wybierz grant: `client_credentials` (token aplikacyjny) lub `authorization_code` (token użytkownika + refresh).
3) Skonfiguruj SDK (`oauth-notes.md`) lub użyj własnych żądań HTTP; zadbaj o właściwe `scope` i `redirectUri`.
4) Testuj w sandbox (`api.sandbox.ebay.com`); po walidacji przełącz `PRODUCTION`.
5) Odświeżaj tokeny cyklicznie (`refresh_token`), zapisuj czasy wygaśnięcia i pilnuj rate-limitów API.

## ⏱️ Limity API eBay
- Limity są przydzielane per API/endpoint i różnią się między sandbox a produkcją; eBay zwraca bieżące wartości w nagłówkach odpowiedzi.
- Kluczowe nagłówki: `x-ebay-c-request-limit`, `x-ebay-c-rate-limit-remaining`, `x-ebay-c-rate-limit-reset` (nazwy mogą się różnić per API).
- Rekomendacja: logować nagłówki limitów przy każdym wywołaniu, kalibrować batch/interwał cronów, reagować na 429 (zmniejszyć batch, wydłużyć interwał, backoff) oraz na 401 (odświeżyć token).

## Utrzymanie folderu
- Nie edytuj plików z `downloaded/` (snapshoty źródeł); własne notatki trzymaj w `oauth-notes.md`.
- Dodając nowe materiały, dopisz źródło, datę pobrania i licencję.

## 🔗 Backlinks

- [[dev/docs/ebay/ebay]]
- [[docs/docs]]
- [[INDEX]]