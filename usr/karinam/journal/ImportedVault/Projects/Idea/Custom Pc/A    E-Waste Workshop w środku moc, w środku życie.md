---
title: 'Custom PC Kariny — Biało/Róż + Terrarium "E-Waste Workshop: w środku moc, w środku życie."'
owner: Karina
created: 2025-11-02
status: plan
tags:
  - pc-mod
  - case-mod
  - terrarium
  - acrylic
  - led
  - eww
cssclass: eww-dashboard
color: "linear-gradient(344deg, var(--mk-color-base-60) 0%, #ff9188 50%, #ff5acd 100%)"
sticker: lucide//flower-2
type: note
banner: Projects/Idea/Custom Pc/Projekt A Cover.png
banner_y: "87"
photo:
aliases:
  - "A     E-Waste Workshop: w środku moc"
  - w środku życie
---

# Cel
Zbudować **customową obudowę PC**: z zewnątrz biała, w środku różowa, **z przednią szybą** oraz **izolowanym terrarium** dla roślin. Całość ma wyglądać estetycznie i **nie wprowadzać wilgoci** do komory komputera. Oświetlenie: **ciepły róż** i **zimny róż** (RGB pozwoli ustawić oba presety).

> **Założenie bezpieczeństwa**: Terrarium to **osobny, szczelny moduł** (akrylowy box) wstawiony do obudowy i **uszczelniony taśmą neoprenową + silikonem**. Oświetlenie LED montujemy **poza** terrarium (świeci przez akryl).

---

# Architektura i przepływ powietrza
```
[FRONT okno akrylowe]
|  Intake (dół)  |  Terrarium (box 30×20×20)  |  Komora PC (GPU/CPU)
|  Intake (dół)  |  ——uszczelka——             |  ——— airflow ———>
                         ↑ LED RGB (poza terrarium)
Tył: 120 mm exhaust   Góra: 120/140 mm exhaust
Dół: 2×120 mm intake z filtrami
```
- **Terrarium** stoi przy boku frontu/środka. Krawędzie między boxem a blachą podklejone **neoprenem** (uszczelka), brak wymiany powietrza z komorą PC.
- **PC airflow**: dół (intake) → płyta/GPU/CPU → tył/góra (exhaust). Frontowa szyba **nie** ogranicza wlotu (wloty z dołu + ewentualnie z boków).

---

# KROK PO KROKU

## 1) Pomiary i rozrys
1. Zmierz front obudowy i zdecyduj **okno ~A4 (210×297 mm)** albo inne, by zachować marginesy i sztywność.
2. Zaznacz taśmą malarską obszar cięcia + narysuj linie markerem.
3. Zmierz wnętrze: gdzie stanie **box 30×20×20 cm**. Zaznacz punkty mocowania i prowadzenia przewodów LED.

**Sprzęt:** miarka, suwmiarka, kątownik, taśma malarska, marker.

---

## 2) Cięcie frontu pod szybę
1. **Nawierć** po rogach (∅ 6–8 mm) – unikniesz pęknięć przy cięciu.
2. **Przetnij** panel: mini-szlifierka/Dremel (tarczki do metalu) **albo** nożyce/„nibbler” do blachy.
3. **Wyrównaj** pilnikami + papier ścierny 240→600. Odtłuść IPA.
4. **Osłoń** miejsce cięcia U-profilową **listwą gumową** (na krawędzia).
5. Docięty **arkusz akrylu 3 mm (A4)** przymiarka „na sucho”.

**Sprzęt:** wiertarka + stopniowy wiertło (step-bit), Dremel + tarczki, nibbler ręczny, pilniki płaskie/okrągłe, papiery 240/400/600, okulary, maska FFP2, rękawice.
**Materiały:** listwa U (1 m), akryl 3 mm (A4), IPA/odtłuszczacz.

---

## 3) Malowanie (zewnętrzny biały / wewnętrzny róż)
1. **Matowanie**: 600–800 grit, odtłuścić.
2. **Podkład do metalu/plastiku** – 1–2 cienkie warstwy, 10–15 min przerwy.
3. **Kolor**: 
   - wnętrze: **róż (spray)** – 2–3 cienkie warstwy,
   - zewnętrz: **biały** – 2–3 cienkie warstwy.
4. **Lakier bezbarwny** (1K dla łatwości lub 2K dla twardości) – 2 warstwy, 15–20 min odstępu.
5. **Utwardzanie**: 24 h min (1K), 48 h zalecane; 2K pracować w wentylowanym miejscu, w masce.

**Sprzęt:** stojaki/sznury do zawieszenia, maska lakiernicza (A2P3), rękawice nitrylowe.
**Materiały:** podkład 400 ml, biały 400 ml, róż 400 ml, lakier bezbarwny 400 ml.

---

## 4) Terrarium – moduł szczelny
**Wariant bez klejenia** (szybko): kup **akrylowy box 30×20×20 cm** z pokrywą, do środka warstwy:
- **LECA** (keramzyt) 2–3 cm → **węgiel aktywny** 0.5–1 cm → **siatka** (bariera) → **mech torfowiec (sphagnum)** cienko → **substrat** dla roślin (niska warstwa). Rośliny: fittonia, mchy, hypoestes, paprocie mini.
- Jednorazowe **zraszanie** startowe, zamknąć pokrywę. Ma działać jak **„closed terrarium”** (obieg własny).

**Uszczelnienie w obudowie:**
- Taśma **neoprenowa** na krawędziach boxu (jak uszczelka), dodatkowo cienka fuga **silikonem neutralnym** między boxem a blachą (opcjonalnie rozbieralne).
- **Brak kabli do wnętrza boxu** – LED świeci **z zewnątrz** przez akryl (brak ryzyka przecieku).

**Sprzęt:** nożyk, nożyczki, szpachelka/silikonownik.
**Materiały (terrarium):** box akrylowy 30×20×20, LECA, węgiel aktywny (akwariowy), siatka, sphagnum, substrat, rośliny.

> *Tip:* połóż pod boxem cienką **tackę ociekową** z akrylu lub PETG (nawet 1–2 mm) – ochroni dno obudowy „na wszelki wypadek”.

---

## 5) Oświetlenie LED (ciepły/zimny róż)
- **Strip 12 V RGB (5 m, kit z zasilaczem/kontrolerem)** – ustaw dwa presety:
  - **ciepły róż**: przewaga *R* + odrobina *G*,
  - **zimny róż**: *R* + *B*.
- Prowadzenie: dookoła krawędzi terrarium (po **zewnętrzu boxu**), dodatkowe odcinki na belkach wewnątrz komory PC. Zadbaj o **odstęp od szyb** (mniej hot-spotów).
- Zasilanie: z zestawu (12 V), **bez podpinania do PSU PC** na początek. Kable porządkowo w peszlu, przepust przez **gumowy przelot**.

**Sprzęt:** lutownica (opc.), koszulki termokurczliwe, opaski, peszel.
**Materiały:** zestaw LED 12 V (taśma + sterownik + zasilacz), przeloty gumowe, filtry przeciwkurzowe na intake.

---

## 6) Montaż szyby frontowej
1. Docięty **akryl 3 mm** w **listwie U** na brzegach.
2. Mocowanie: **kątowniki M3** od środka lub **taśma VHB + silikon** w narożach (demontowalne).
3. Sprawdź **szczelność** i brak brzęczenia (taśma neoprenowa jako podkład pod mocowanie).

---

## 7) Wentylatory i testy
- **Dół:** 2×120 mm intake + **filtry**.
- **Tył:** 1×120 mm exhaust.
- **Góra:** 1×120/140 mm exhaust.
- **Test 24 h:** wyłącz PC, zostaw LED i terrarium – sprawdź czy **brak kondensacji** na zewnętrznej stronie boxu i **zero wilgoci** w komorze PC (higrometr mile widziany).

---

# Sprzęt wg operacji
| Operacja | Narzędzia |
|---|---|
| Pomiary/rysunek | miarka, suwmiarka, kątownik, taśma, marker |
| Cięcie frontu | wiertarka + step-bit, Dremel + tarczki do metalu **lub** nibbler, pilniki, papiery 240–600 |
| Malowanie | stojaki, maska A2P3, rękawice, ściereczki bezpyłowe |
| Uszczelnienia | pistolet do silikonu, nożyk, silikonownik |
| LED | nożyk do taśmy, lutownica (opc.), koszulki, opaski, peszel |
| Montaż okna | wkrętarka, kątowniki M3, taśma VHB, listwa U |
| Porządkowanie | trytki, rzepy, peszle, odtłuszczacz IPA |

---

# Materiały i kosztorys (orientacyjnie, GBP)
> Ceny są **orientacyjne** (UK) – lista źródeł i przykładowe oferty masz w notatkach do rozmowy. 

- Akryl 3 mm A4 (okno): **£2.25**
- Akrylowy box 30×20×20 (terrarium): **£26.39**
- Listwa krawędziowa U (1 m): **£4.99**
- Taśma neoprenowa uszczelniająca: **£6.99**
- Silikon neutralny 300 ml: **£4.96**
- Tarczki Dremel do metalu (zestaw): **£10.25**
- Nibbler ręczny do blachy: **£10.15**
- Wiertła stopniowe (zestaw): **£8.49**
- Filtry 120 mm (2 szt.): **£5.90**
- Przeloty gumowe (pakiet): **£3.00**
- Wentylatory ARCTIC P12 (5-pack, użyjesz 3): **£31.97**
- Zestaw LED RGB 12 V 5 m (zasilacz + sterownik): **£29.08**
- Podkład spray 400 ml: **£8.41**
- Farba spray **biała** 400 ml: **£6.73**
- Farba spray **róż** 400 ml: **£6.73**
- Lakier bezbarwny **1K** 400 ml: **£9.97**
- Drobne okucia/śruby/kątowniki: **£5.00**
- PPE (maska, rękawice): **£5.00**

**Suma (wariant z lakierem 1K): `£186.26`**  
**Opcja PRO – lakier 2K**: +`~£16.41` ⇒ **`~£202.67`**

---

# Checklista bezpieczeństwa
- **Brak kabli w terrarium.** LED na zewnątrz boxu.
- **Uszczelki + silikon**: brak wymiany powietrza i wilgoci z komorą PC.
- **Odstęp** 10–20 mm między boxem a elementami PC (GPU/VRM).
- **Test wycieku**: przed montażem postaw terrarium na kartonie 24 h.
- **Lakierowanie**: na zewnątrz/ w wentylacji, 2K tylko w **masce A2P3**.

---

# Ustawienia LED (presety)
- **Ciepły róż**: R 100%, G 10–15%, B 0–5%.
- **Zimny róż**: R 80–90%, G 0–10%, B 15–25%.
Zapisz dwa presety w pilocie/apce.

---

# Notatki końcowe
- Szybę frontową polecam w **akrylu** (łatwiejszy obróbka). Hartowanego szkła **nie tnij** domowo.
- Jeśli chcesz rozbudować: **kanały aluminiowe** do LED + dyfuzory, **mini-higrometr** w komorze PC (monitoring wilgotności).
