---
title: AvoFloat Dock
description: Wielorazowy uchwyt 3D do kiełkowania pestek awokado Hass (Lidl „Large Avocado”) – specyfikacja, koszty i potencjał sprzedaży w UK.
author: E-Waste Workshop
created: 2025-11-17
updated: 2025-11-28
tags:
  - product
  - avocado
  - 3d-printing
  - e-waste
  - hass
plugins:
  - obsidian-progress-bar
cssclass: avocado-note
---

# 🧊 AvoFloat Dock – uchwyt do kiełkowania pestek

> [!abstract]- Najważniejsze
> - 🌱 Zastępuje wykałaczki: nie kaleczy pestek Hass, utrzymuje tylko „dupkę” w wodzie.
> - 🔁 Wielorazowy PETG + silikon; łatwy do mycia i personalizacji.
> - 💷 Koszt druku ok. 2 GBP, sugerowana cena detaliczna 4.99–7.99 GBP.
> - 📈 Rynek UK nie ma lokalnego odpowiednika – szybka wysyłka to przewaga.
> - 🔗 Pliki STP/STL trzymaj w `dev/3d/avocado_float_dock/` obok instrukcji.
> - 📏 Skalowanie pod Hass: pierścień obsługuje pestki 35–55 mm (typowe dla „Large Avocado” z Lidla).

> [!success]- Sygnatura E-Waste Workshop
> Drukujemy z plastiku odzyskanego w naszym warsztacie (E-Waste Workshop). Możesz więc promować AvoFloat Dock jako produkt „from waste to wow” – recycling elektrośmieci → granulowanie → filament → uchwyt.

> [!quote]- Manifest
> „Zamiast dziurkować pestki wykałaczkami, dajmy im bezpieczny, obiegowy dom. Z elektrośmieci powstaje AvoFloat Dock – narzędzie, które świadczy o tym, że nawet codzienna pestka może mieć lepszy los.”

## 1. 🎯 Po co nam AvoFloat Dock?
- **Zero dziurek.** Pestka siedzi w miękkim gnieździe i opiera się o regulowany pierścień – idealne rozwiązanie dla klientów premium.
- **Wielorazowość.** PETG/PLA + silikonowe wkładki można wrzucić do zmywarki; pierścień dopasowuje się do pestek 35–55 mm.
- **Stabilność.** Trzy łapy dobrze trzymają się słoików 6–9 cm, więc ziarno nie spada przy przypadkowym szturchnięciu.
- **Branding.** Górna powierzchnia = miejsce na logo/QR do instrukcji.

## 2. ⚙️ Specyfikacja i druk
| Element | Materiał / ustawienia | Uwagi |
| --- | --- | --- |
| Korpus | PETG (1.75 mm, dysza 0.4 mm, warstwa 0.2 mm, infill 30 %) | druk ~1 h, można użyć PLA (ścianki ≥1.6 mm) |
| Wkładka | Silikon food-grade 45A / TPU | chroni pestkę, można odlać w prostej formie | 
| Pierścień | PETG/PLA | stopnie co 2 mm, zatrzask na wcisk; kalibrowany pod pestki Hass 35–55 mm |

> [!info]- Ustawienia druku
> - Temperatura dyszy: 240 °C (PETG) / 210 °C (PLA).  
> - Stół: 80 °C (PETG) / 60 °C (PLA) z adhezyjną warstwą kleju.  
> - Brim 5 mm zapobiega podwijaniu łap podczas chłodzenia.  

## 3. 📐 Instrukcja użycia
1. Wybierz pierścień (ustaw stopień na średnicę pestki).  
2. Wciśnij pestkę w silikonowe gniazdo – zostaw 1–2 cm nad pierścieniem.  
3. Połóż uchwyt na słoiku tak, by górna powierzchnia była pozioma, a dół pestki zanurzony na ok. 1 cm.  
4. Wodę wymieniaj co 2–3 dni. Po kiełkowaniu umyj dock w zmywarce i użyj ponownie.

> [!tip]- Wskazówki dla klienta
> - Do zestawu dołącz instrukcję z QR prowadzącym do filmu na YouTube.  
> - Dorzuć krótką miarkę (wydruk 3D) pokazującą sugerowany poziom wody – poprawia UX i zmniejsza liczbę pytań po zakupie.

## 4. 💷 Ekonomia i rynek (UK)
### Koszt jednostkowy
| Składnik | Cena hurtowa | Koszt/szt. |
| --- | --- | --- |
| 30 g PETG (standard) | 17 GBP/kg | ~0.51 GBP |
| Wkładka silikonowa | 6 GBP/10 szt. | 0.60 GBP |
| Prąd + amortyzacja drukarki | — | 0.20 GBP |
| **Razem (standard)** |  | **~1.3 GBP** |
| **Opcja: granulat z E-Waste Workshop** | odzysk własny | ~0 GBP |
+ prowizja platform (Etsy/eBay PayPal) ~0.6 GBP = koszt całkowity ~1.9 GBP.

> [!success]- Recykling = dodatkowy profit
> Drukujemy w E-Waste Workshop z plastiku zmielonego z elektrośmieci. Jeśli użyjemy własnego granulatu zamiast kupnego PETG, koszt materiału spada o ~0.5 GBP/szt., a marża rośnie o 110–180 GBP rocznie (w zależności od wolumenu).

### Scenariusze sprzedaży
- **Bundled z sadzonką:** pipeline 1 sadzonka/dzień → 365 klientów/rok, 60 % z nich dopłaca 4.99 GBP za dock → ok. 220 szt./rok, przychód 1 098 GBP, marża ~680 GBP/rok (56 %).
- **Sprzedaż solo (brak lokalnej konkurencji):** przechwycenie 25–30 kupujących miesięcznie (YouTube/TikTok/Etsy) → 300–360 szt./rok, przychód 1.5–1.8 k GBP, marża ~0.9–1.1 k GBP.

> [!note]- Opłacalność wdrożenia
> - ⏱️ Nakład początkowy to głównie czas (3–4 dni) i kilka kilogramów PETG/PLA + wkładki (~50–70 GBP).  
> - 📉 Próg rentowności: po sprzedaży ~40 szt. (marża 3 GBP/szt.) pokrywasz koszty materiałów/pracy; dalsza produkcja to czysty zysk.  
> - 🧺 Bundlowanie z sadzonką obniża koszt marketingu i zapewnia stały popyt – traktuj to jako domyślną ofertę.

> [!info]- ROI (inwestycja vs. zwrot)
> - Inwestycja startowa: 70 GBP (materiał + wkładki) + 3–4 dni pracy.  
> - Dochód roczny (konserwatywnie 220 szt.): 680 GBP marży → ROI ≈ **870%** w ciągu roku.  
> - Scenariusz rozszerzony (360 szt.): marża 1.1 k GBP → ROI > **1 400%**. Nawet po uwzględnieniu amortyzacji drukarki ROI pozostaje >500%.

### Rynek i przewagi
- Oferty na eBay to głównie szklane wazony lub metalowe uchwyty wysyłane z USA/Chin (koszt dostawy 10–30 GBP).  
- Brak lokalnego, wielorazowego docka; możemy pozycjonować produkt jako „drukowane w Londynie, wysyłka 48 h, możliwość personalizacji”.  
- Warto oferować zestawy 2–3 szt. (np. 7.99 GBP) – wielu klientów kiełkuje równolegle kilka pestek.

## 5. 🚀 Wdrożenie
- **Czas wdrożenia:** 3–4 dni robocze, jeśli masz drukarkę i materiały pod ręką. Dzień 1–2: przygotowanie/druk prototypu + testy; dzień 3: produkcja pierwszej partii i zdjęcia; dzień 4: listingi na eBay/Etsy i pakowanie pierwszych zamówień.  
- **Wymagania sprzętowe:** drukarka 3D FDM (np. Prusa i3 MK3S, Bambu P1P) z dyszą 0.4 mm, materiał PETG/PLA, ewentualnie silikonowe wkładki lub forma do odlewu z TPU. Upewnij się, że stół roboczy pozwala drukować elementy 120×120 mm.  
- **Checkboxy:**  
  - [ ] Przygotuj STL/STEP + instrukcję montażu w `dev/3d/avocado_float_dock/`.  
  - [ ] Wydrukuj serię testową, zweryfikuj tolerancje i stabilność na różnych słoikach.  
  - [ ] Zamów wkładki silikonowe lub wykonaj formy do odlewania z TPU.  
  - [ ] Zrób zdjęcia produktowe (solo + w użyciu) i kartę produktu do ofert eBay/Etsy.  
  - [ ] Dodaj opcję „z AvoFloat Dock” (+2 GBP) przy sprzedaży sadzonek oraz osobne listingi (1 szt., 2 szt.).

## 6. ❓ FAQ
> **Czy można drukować z PLA?**  
> Tak, ale zwiększ grubość ścianek do min. 1.6 mm i unikaj wysokich temperatur przy myciu (lepiej płukać ręcznie).
>
> **Jak czyścić dock?**  
> Korpus wrzucasz do zmywarki (górna półka), wkładkę silikonową/TPU myjesz ręcznie w ciepłej wodzie z mydłem.
>
> **Co z pleśnią?**  
> Dalej trzeba wymieniać wodę, ale brak dziurek zmniejsza ryzyko gnicia tkanek wokół wykałaczek.

## ↩ Powiązania
- [[avocado/avocado.md|Awokado – przewodnik]]
- [[avocado/avocado_dom.md|Awokado Hass w mieszkaniu]]
- [[avocado/avocado_hass.md|Awokado Hass – profil odmiany]]
- [[avocado/avocado_item.md|Awokado – karta produktu]]
