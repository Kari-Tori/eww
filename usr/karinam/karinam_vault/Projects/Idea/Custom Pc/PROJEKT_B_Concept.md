---
title: "PROJEKT B — „E-Waste Workshop: w środku moc, na szczycie życie.”"
alias:
  - Projekt B
  - Top Terrarium
  - Power inside. Life on top.
owner: Wielki Implementator
status: active
updated: 2025-11-03 01:13 UTC
tags:
  - eww
  - product
  - concept-b
  - terrarium
  - diy
  - zero-waste
  - top-module
cssclass: eww-dashboard rich neon-pink
space: 03_DEVELOPMENT/PRODUCTS/TERRARIUM_PC/Concept_B
accent_color: "#FF5FA2"
accent_secondary: "#FFFFFF"
---

![](sandbox:/mnt/data/A_digital_photograph_showcases_a_custom-built_mid-.png)

> **Hasło:** *E‑Waste Workshop: w środku moc, na szczycie życie.*  
> **Cel:** Zintegrować **zamkniętą komorę** nad obudową tak, aby **górny panel PC był jej podłogą**, a **góra komory pełniła rolę pokrywy**. Komora jest **szczelna** i **nie łączy się powietrznie** z wnętrzem PC.

---

# 0. Założenia
- Obudowa: **mid‑tower ATX** (skaluj do swoich paneli).  
- Wymiar komory start: **320 × 220 × 120 mm** (szer × gł × wys). Dla mchów i niskich roślin.  
- **Top PC = podłoga** komory, wzmocniony **ramką nośną** od spodu.  
- Komora **zamknięta**; **LED na zewnątrz** komory, świeci przez akryl.  
- Airflow PC: **bez top‑exhaust** lub **kanały boczne** (opcjonalny „komin”).

# 1. Przekrój (schemat)
```
[Pokrywa akryl 5 mm]  ← zawiasy + magnesy
┌──────────────────────────────────────────┐
│ Zamknięta komora (ściany akryl 4 mm)     │
│ LED w kanałach na zewnątrz ścian         │
└──────────────────────────────────────────┘
[Uszczelka neopren 10×3]  ← kołnierz izolujący
════════════════════════════════════════════  ← Top obudowy = podłoga
[Bariera wodna topu: EPDM 1 mm / lakier epoksydowy / blacha Al 1.5 mm]
[Ramka nośna od spodu: alu 15×15/2020 + nitonakrętki M4]
```

# 2. Krok po kroku

## 2.1. Wzmocnienie topu
1. Zdemontuj top. Od spodu przyłóż **ramkę nośną** (alu 15×15 lub 2020) w obrysie komory.  
2. Zamocuj przez **nitonakrętki M4** lub śruby M4 z dystansami.  
3. W narożach dodaj **kątowniki**. Ugięcie \< **0.5 mm** pod **10 kg**.

**Narzędzia:** wiertarka, nitownica do nitonakrętek, klucze, pilnik.  
**Materiały:** profil alu, kątowniki, M4, nitonakrętki.

## 2.2. Uszczelnienie podłogi (topu) — *jedna z metod*
- **EPDM 1 mm** przyklejony do topu (naddatek 10 mm).  
- **Blacha Al 1.5 mm** + taśma **VHB** + silikon neutralny po obwodzie.  
- **Lakier epoksydowy 2×** jako bariera wodna.  
Krawędzie oklej **neoprenem 10×3** jako kołnierz pod ściany komory.

## 2.3. Ściany komory (akryl 4 mm)
- Panele: front/tył **320×120**, boki **220×120**.  
- Krawędzie sfazować (P400→P600), odtłuścić IPA.  
- Klej akrylowy na **kołnierzu neoprenowym** + spoina **silikonem** od wewnątrz.  
- Krawędzie zewnętrzne: **listwa U** (opcjonalnie).

## 2.4. Pokrywa (akryl 5 mm)
- Płyta **330×230 mm** (zakładka 5 mm/stronę).  
- **Zawiasy mini** z tyłu; **magnesy neodymowe** lub zatrzaski z przodu.  
- Uszczelka **neopren 10×3** między pokrywą a ścianami.

## 2.5. LED
- **Kanały aluminiowe z dyfuzorem** po **zewnętrznej** ścian komory (dół/tył/boki).  
- Taśma **RGB 12 V**. Presety: **ciepły róż R100/G10–15/B0–5**, **zimny róż R80–90/G0–10/B15–25**.  
- Zasilacz **poza obudową**. Przewody w **peszlu** z **pętlą kapilarną**.

## 2.6. Airflow PC
- **Wariant 1:** wyłącz top‑exhaust. **Dół 2×120 intake**, **tył 120 exhaust**.  
- **Wariant 2:** **kanały boczne 15–20 mm** między komorą a krawędzią topu, wylot z tyłu na radiator 120/140.

## 2.7. Wnętrze komory
- Podłoże: **niska misa** lub tacka akrylowa z rantem 5–10 mm.  
- Warstwy: **LECA → węgiel aktywny → siatka → cienki sphagnum → substrat**.  
- Gatunki: **fittonia, selaginella, mchy, pilea depressa**. **Zero kabli** w środku.

## 2.8. Testy akceptacyjne
- **Szczelność**: 24–48 h. Krople na ściankach OK, brak przecieków.  
- **Obciążenie**: 10–15 kg na środku komory — brak trwałego ugięcia.  
- **Termika**: porównaj CPU/GPU przed/po, skoryguj krzywe wentylatorów.

---

# 3. BOM i koszt (GBP, orientacyjnie)

**Konstrukcja**  
- Profil alu 15×15/2020 + łączniki: **£22–£40**  
- Nitonakrętki M4 + śruby/podkładki: **£8–£12**  
- EPDM 1 mm (A3) **lub** blacha Al 1.5 mm 330×230: **£8–£18**  
- Akryl 4 mm (2×320×120 + 2×220×120): **£12–£20**  
- Akryl 5 mm (pokrywa 330×230): **£8–£12**  
- Uszczelki neoprenowe 10×3 (3 m): **£7–£10**  
- Klej akrylowy + silikon neutralny: **£9–£14**  
- Zawiasy mini + magnesy/zatrzaski: **£6–£10**  
- Listwa U (2 m): **£6–£9**  
**Suma konstrukcja:** **£86–£145**

**LED i okablowanie**  
- Taśma RGB 12 V + kontroler + zasilacz: **£25–£45**  
- Kanały alu z dyfuzorem 2–3 m: **£10–£20**  
- Peszle, przeloty, opaski: **£5–£8**  
**Suma LED:** **£40–£73**

**Terrarium (wkład)**  
- Misa/tacka niska: **£5–£10**  
- LECA + węgiel + siatka + sphagnum + substrat: **£25–£38**  
- Rośliny 2–4 szt.: **£10–£18**  
**Suma wkład:** **£40–£66**

**RAZEM (B2):** **~£166–£284**  
*(+ malowanie i okno frontu z wariantu A: **+£61–£100**)*

---

# 4. Narzędzia
Wiertarka, nitownica do nitonakrętek M4, klucze imbusowe, piła do alu lub wyrzynarka z brzeszczotem do metalu, pilniki, nożyk do akrylu, papier 240/400/600, silikonownik, taśma malarska, IPA, peszle, trytki.

# 5. Ryzyka i kontrola
- **Wilgoć**: komora zamknięta; LED poza komorą; kołnierz neopren + silikon.  
- **Ugięcie topu**: ramka nośna + test 10–15 kg.  
- **Termika**: brak top‑exhaust kompensuj tyłem i dołem; opcjonalne kanały.  
- **Serwis**: pokrywa na zawiasach + magnesy; łatwy dostęp do roślin.

# 6. Lista cięć (do zlecenia)
- Akryl 4 mm: **2× 320×120**, **2× 220×120**.  
- Akryl 5 mm: **1× 330×230** (pokrywa).  
- EPDM 1 mm **lub** Al 1.5 mm: **330×230** (bariera podłogi).  
- Profil alu 15×15: **2× 320**, **2× 220** + 4× narożne.

# 7. Harmonogram
**D+1** ramka nośna + uszczelnienie topu → **D+2** ściany + pokrywa → **D+3** LED + wkład terrarium + testy 24–48 h.

# 8. Notatki
- Jeśli potrzebny top‑exhaust, zastosuj **kanał boczny 15–20 mm** z siatką i filtrem, całkowicie oddzielony od komory kołnierzem EPDM.  
- Pokrywę można dociążyć **szkłem 4 mm** z rantem dla odporności na zarysowania (wymaga innego mocowania zawiasów).
