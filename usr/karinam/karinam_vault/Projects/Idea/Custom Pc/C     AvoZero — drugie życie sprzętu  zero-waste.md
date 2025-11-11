---
title: 'E‑Waste Workshop — Wariant C: boczna komora Avocado + włącznik na górze-: „AvoZero — drugie życie sprzętu | zero-waste"'
subtitle: Side‑pod dla pestki awokado oraz relokacja przycisku PWR
owner: Karina
created: 2025-11-02
status: plan
tags:
  - eww
  - pc-mod
  - avocado
  - hydro
  - sidepod
  - acrylic
  - led
  - airflow
cssclass: eww-dashboard
banner: Cover_Projekt_C_pretty.png
banner_y: "85"
author: Karina
idea: Karina
sticker: emoji//1f951
color: "linear-gradient(45deg, #23d4fd 0%, #3a98f0 50%, #b721ff 100%)"
aliases:
  - C     AvoZero — drugie życie sprzętu | zero-waste
---

> Hasło: **E‑Waste Workshop: w środku moc, na szczycie życie.**  
> Cel: odseparowana boczna komora na kiełkowanie pestki awokado. Włącznik zasilania komputera przeniesiony na górę obudowy.

# 0. Założenia
- Obudowa: mid‑tower ATX. Komora boczna jako **zewnętrzny moduł** przykręcany do panelu bocznego. Brak łączności powietrznej z komorą PC.
- Komora side‑pod: akryl 3 mm. Wymiary startowe 300 × 120 × 300 mm. Drzwiczki serwisowe z uszczelką neoprenową. Wewnątrz **szklany słoik** z pestką.
- Metoda kiełkowania: woda w słoiku z koszykiem net‑pot oraz kołnierzem neoprenowym. Bez kabli w środku słoika.
- Oświetlenie: LED 12 V poza słoikiem. Presety różowe jak w poprzednich wariantach.
- Włącznik PWR na topie: przycisk chwilowy 16 mm z ring LED. Do złącza PWR_SW na płycie głównej.

---

# 1. Architektura
```
  [TOP obudowy]         [Przycisk PWR 16 mm LED]  ← przewód do PWR_SW
        ↑
        │
[Panel boczny] ── [SIDE‑POD 300×120×300]  ── brak wymiany powietrza z PC
                    |  drzwiczki z uszczelką
                    |  tacka ociekowa 2–3 mm
                    |  słoik z pestką awokado
                    |  LED po zewnętrznej
Dół PC: intake z filtrami. Tył/góra: exhaust. Odstęp boczny ≥ 10 mm.
```

Bezpieczeństwo: podwójne zabezpieczenie przed wodą. Słoik zamknięty. Pod słoikiem tacka ociekowa. W side‑podzie brak elektroniki.

---

# 2. Krok po kroku

## 2.1. Pomiary i projekt
1. Zdejmij panel boczny. Zaznacz punkty mocowania side‑poda. Dodaj dystans 3–5 mm pod neopren.
2. Zaplanuj ścieżkę przewodów LED i przewodów do przycisku PWR. Wyznacz przepust z gumową przelotką.
3. Rozrysuj front drzwiczek side‑poda. Przewidź zawiasy i zamknięcia magnetyczne.

**Narzędzia:** miarka, kątownik, marker, taśma malarska.

## 2.2. Budowa side‑poda
1. Docięcie akrylu 3 mm: 2 boki 300×300, dno 300×120, sufit 300×120, plecy 300×300, front z drzwiczkami lub pełny i osobne drzwiczki.
2. Składanie: klej akrylowy lub silikon neutralny. Krawędzie wygładzić, odtłuścić IPA.
3. Drzwiczki: zawiasy meblowe mini. Uszczelka neoprenowa 10 mm po obwodzie.
4. Wkład dolny: tacka ociekowa z akrylu 2–3 mm. Luz 5–10 mm z każdej strony.
5. Przepust kablowy: grommet gumowy 12–16 mm. Krawędzie zabezpieczone listwą U.

**Materiały:** akryl 3 mm, klej akrylowy lub silikon neutralny, uszczelka neoprenowa, zawiasy, magnesy, listwa U, grommet, tacka z akrylu.

## 2.3. Słoik i pestka
1. Słoik szklany 1–1.5 l z pokrywą. W pokrywie otwór pod **net‑pot 2 in**. Wypełnij obrzeże kołnierzem neoprenowym. 
2. Pestka: umyj, ściągnij cienką brązową skórkę. Strona szeroka w dół. Poziom wody dotyka spodu pestki.
3. Dodaj kilka granulek **LECA** w koszyku dla stabilizacji. Możesz owinąć słoik czarną folią, aby ograniczyć glony.
4. Woda: wymiana co 7 dni. Temperatura 20–25°C. Światło pośrednie. Po korzeniu 3–5 cm możesz przejść na hydro lub do ziemi.

**Materiały:** słoik 1–1.5 l, net‑pot 2 in, kołnierz neoprenowy, LECA, folia maskująca (opcjonalnie).

## 2.4. Montaż side‑poda do panelu bocznego
1. Otwory w panelu: 4–6 punktów M4. Podkładki gumowe pod śruby. 
2. Taśma neoprenowa między panelem a podstawką pod side‑pod.
3. Przykręć koszyki montażowe od środka panelu, wsuwaj side‑pod na śruby, dociągnij nakrętki motylkowe.

## 2.5. LED w side‑podzie
1. Kanały aluminiowe z dyfuzorem przy górnej i tylnej krawędzi podu. Taśma LED RGB 12 V wewnątrz podu, ale **poza słoikiem**.
2. Zasilacz i kontroler poza obudową PC. Przewody w peszlu. Zrób pętlę kapilarną.
3. Presety: ciepły róż oraz zimny róż jak wcześniej.

## 2.6. Włącznik na górze
1. Zaplanuj miejsce na topie. Nałóż taśmę malarską. Wywierć otwór **16 mm** pod przycisk.
2. Przeciągnij przewód do złącza **PWR_SW** na płycie. Polaryzacja nie ma znaczenia dla styków NO.
3. LED ring: podłącz do **PLED+ PLED-** lub do 5 V z rezystorem zgodnie z kartą przycisku.
4. Test: naciśnij. Komputer powinien wstać i wyłączyć się prawidłowo po krótkim przytrzymaniu.

**Materiały:** przycisk chwilowy 16 mm z LED, przewód w koszulce, szybkozłączki Dupont lub JST, peszel, przelotka.

## 2.7. Testy końcowe
1. Test szczelności: 24–48 h. Brak kondensacji na wewnętrznych ściankach podu. Brak wilgoci w komorze PC.
2. Test zalania: wlej 50 ml wody na tackę ociekową. Sprawdź że nic nie wycieka na panel boczny.
3. Termika: porównaj temperatury CPU i GPU przed i po montażu. Spadek airflowu bocznego skompensuj wentylatorami front + tył + góra.

---

# 3. BOM i kosztorys (GBP, orientacyjnie)
**A. Side‑pod i montaż**  
- Akryl 3 mm cięty na wymiar 5 arkuszy: **15–25**  
- Klej akrylowy lub silikon neutralny 300 ml: **5–7**  
- Uszczelka neoprenowa 10 mm, 2 m: **6–9**  
- Zawiasy mini + magnesy + wkręty: **8–12**  
- Listwa krawędziowa U 1 m: **4–7**  
- Grommet gumowy i peszel: **6–9**  
- Tacka akryl 2–3 mm: **5–10**  
**Suma A:** **49–79**

**B. Mod awokado**  
- Słoik 1–1.5 l z pokrywą: **5–10**  
- Net‑pot 2 in + kołnierz neoprenowy: **3–6**  
- LECA 2 l: **5–7**  
- Folia maskująca czarna lub osłona: **3–5**  
- Paski testowe pH lub płyn do odkamieniania mikro: **3–5**  
**Suma B:** **19–33**

**C. LED**  
- Taśma LED RGB 12 V 2–3 m z kontrolerem i zasilaczem: **20–35**  
- Kanały aluminiowe z dyfuzorem 2 m: **10–20**  
- Opaski, rzepy, klej VHB: **5–8**  
**Suma C:** **35–63**

**D. Przycisk PWR TOP**  
- Przycisk chwilowy 16 mm z ring LED: **8–12**  
- Przewód, koszulki, złączki, przelotka: **3–6**  
**Suma D:** **11–18**

**RAZEM WARIANT C:** **114–193 GBP**  
Nie obejmuje malowania i okna frontu z wariantu A. Jeśli łączysz z malowaniem i klarem, dolicz **~£61–£118** według wcześniejszego planu.

---

# 4. Narzędzia wg operacji
| Operacja | Narzędzia |
|---|---|
| Pomiary i projekt | miarka, kątownik, marker, taśma malarska |
| Cięcie akrylu | nożyk do akrylu lub piła do tworzyw, pilnik, papier 240–600 |
| Składanie boxu | pistolet do silikonu lub aplikator kleju akrylowego, silikonownik |
| Montaż do panelu | wiertarka, nitonakrętki M4 lub śruby M4, klucze, podkładki gumowe |
| Słoik i osprzęt | otwornica lub step‑bit do pokryw, nożyczki, skalpel |
| LED | wkrętarka, nożyk, ewentualnie lutownica 40 W, koszulki termokurczliwe |
| PWR TOP | wiertarka, otwornica 16 mm, peszel, ściągacz izolacji |

---

# 5. Presety LED
- Ciepły róż: R 100 procent, G 10–15 procent, B 0–5 procent.  
- Zimny róż: R 80–90 procent, G 0–10 procent, B 15–25 procent.

---

# 6. Checklist bezpieczeństwa
- Brak kabli w słoiku. LED na zewnątrz słoika.  
- Dwa poziomy ochrony przed wodą: słoik zamknięty plus tacka ociekowa.  
- Pętla kapilarna na przewodach LED. Grommet w panelu.  
- Dodatkowy test 48 h przed włożeniem podu do panelu.  
- Listwa z RCD dla całego stanowiska.  
- Kontrola glonów: ogranicz światło do poziomu umiarkowanego i osłaniaj dół słoika.

---

# 7. Harmonogram
Dzień 1 projekt i cięcie. Dzień 2 składanie i montaż podu. Dzień 3 PWR TOP i LED. Dzień 4 testy szczelności i termiki. Dzień 7 start pestki.

---

# 8. Notatki
- Po pojawieniu się korzenia 3–5 cm rozważ przejście do hydro z pożywką o niskim stężeniu lub przesadzenie do ziemi w osobnej donicy.  
- Side‑pod można wykończyć folią opalizującą lub lakierem, aby spiąć stylistycznie z białym z zewnątrz i różem w środku.
