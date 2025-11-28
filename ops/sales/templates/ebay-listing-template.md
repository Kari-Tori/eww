---
tags:
  - template
  - sales
  - ebay
  - listing
created: 2025-11-28T19:30:00Z
modified: 2025-11-28T19:30:00Z
author: karinam
title: "Template: eBay Listing"
---

# eBay Listing Template

> Szablon do tworzenia listingów na eBay. Skopiuj i dostosuj do konkretnego przedmiotu.

## Metadane (YAML)

```yaml
---
tags:
  - sales
  - ebay
  - active  # lub: sold, archived
  - [KATEGORIA]  # np: electronics, accessories, parts
created: [DATA]
modified: [DATA]
author: [TWOJE_IMIĘ]
title: "[MARKA] [MODEL] - [STAN] - [KLUCZOWA_CECHA]"
item_id: [ID_Z_INTAKE]
platform: ebay
listing_id: [EBAY_ITEM_NUMBER]
status: draft  # draft/active/sold/archived
price_gbp: [CENA]
cost_basis: [KOSZT_NABYCIA]
listed_date: [DATA_WYSTAWIENIA]
sold_date: [DATA_SPRZEDAŻY]
buyer: [USERNAME_KUPUJĄCEGO]
---
```

## Tytuł eBay (max 80 znaków)

**Format:** `[MARKA] [MODEL] [STAN] [KLUCZOWE_CECHY] [DODATKOWE_KEYWORDS]`

**Przykład:** `Apple iPad Air A1670 64GB Space Grey WiFi + Cellular - Good Condition`

**Twój tytuł:**
```
[WPISZ_TUTAJ]
```

## Kategoria eBay

- Główna kategoria: [np. Consumer Electronics > Computers, Tablets & Networking]
- Podkategoria: [np. iPads, Tablets & eBook Readers > Apple iPads]

## Cena i koszty

- **Cena wystawienia:** £[CENA]
- **Koszt zakupu/nabycia:** £[KOSZT] (jeśli dotyczy)
- **eBay fees (12.8%):** £[PROWIZJA]
- **PayPal fees (~2.9% + 30p):** £[PAYPAL]
- **Shipping cost:** £[WYSYŁKA]
- **Packaging:** £[PAKOWANIE]
- **Profit netto:** £[ZYSK]

## Opis główny

### Condition / Stan

[OPISZ_STAN - Sprawny / Uszkodzony / Częściowo sprawny / For parts]

### Specification / Specyfikacja

- **Model:** [MODEL]
- **Marka:** [MARKA]
- **Year/Rok:** [ROK_JEŚLI_ZNANY]
- **Key specs:** [KLUCZOWE_DANE_TECHNICZNE]
- **Included:** [CO_W_ZESTAWIE]
- **Not included:** [CZEGO_BRAK]

### Description / Opis przedmiotu

[PEŁNY_OPIS - Historia, jak przyszedł, co działa, co nie działa, czyszczenie, testy]

### Defects / Wady i uszkodzenia

[LISTA_WAD - Bądź uczciwy, zdjęcia wszystkich defektów]

### Tested / Testy przeprowadzone

- [ ] Power on test
- [ ] Display test
- [ ] Connectivity test (WiFi/Bluetooth/Cellular)
- [ ] Battery test
- [ ] Camera test
- [ ] Buttons and ports test

**Wyniki testów:**
[OPISZ_WYNIKI]

## Zdjęcia (min 6-8)

1. **Front view** - Widok z przodu
2. **Back view** - Widok z tyłu
3. **Labels/Serial** - Etykiety, numery seryjne
4. **Ports/Buttons** - Porty i przyciski
5. **Screen on** - Włączony ekran
6. **Defects** - Wszelkie defekty/uszkodzenia
7. **Accessories** - Akcesoria (jeśli są)
8. **Packaging** - Jak będzie zapakowany

**Folder zdjęć:** `sales/active/[ITEM_ID]/photos/`

## Shipping / Wysyłka

- **Method:** [Royal Mail / Evri / InPost / DPD]
- **Service:** [Tracked 24/48 / Special Delivery]
- **Cost:** £[KOSZT]
- **Packaging:** [OPIS_PAKOWANIA - Bubble wrap, box, padding]
- **Handling time:** [1-2 business days]

## Returns Policy / Polityka zwrotów

**E-Waste Workshop Returns Policy:**
```
Returns accepted within 14 days.
Buyer pays return shipping.
Item must be in the same condition as sent.
Refund issued upon inspection.
```

## Notes / Notatki wewnętrzne

- Source: [SKĄD_POCHODZI - intake ID, donation, purchase]
- Research notes: [LINK_DO_RESEARCH_JEŚLI_BYŁY]
- Repair history: [LINK_DO_REPAIR_JEŚLI_BYŁ]
- Pricing research: [SOLD_ITEMS_DATA - średnia cena z eBay]
- Special notes: [DODATKOWE_UWAGI]

## Workflow Checklist

- [ ] Przedmiot przetestowany i udokumentowany
- [ ] Zdjęcia zrobione (min 6-8)
- [ ] Research cen na eBay Sold Items
- [ ] Tytuł SEO-optimized (max 80 znaków)
- [ ] Opis kompletny z wadami i zaletami
- [ ] Cena kalkulowana z fees i shipping
- [ ] Kategoria eBay wybrana
- [ ] Shipping method ustalony
- [ ] Returns policy dodana
- [ ] Listing wystawiony na eBay
- [ ] eBay Item Number zapisany w YAML
- [ ] Status zmieniony na 'active'

## Po sprzedaży

- [ ] Buyer username zapisany
- [ ] Sold date zaktualizowana
- [ ] Shipping label wygenerowana
- [ ] Przedmiot zapakowany i sfotografowany
- [ ] Tracking number do kupującego
- [ ] Plik przeniesiony do `sales/sold/`
- [ ] Status zmieniony na 'sold'
