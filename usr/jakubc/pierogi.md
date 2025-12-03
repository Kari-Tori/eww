---
title: Gotowanie pierogow - ujecie termodynamiczne
description: Przepis na gotowanie pierogow z obliczeniami czasu nagrzewania i bilansu ciepla
author: jakubc
created: 2025-12-03T15:59:41Z
updated: 2025-12-03T16:06:29Z
tags:
  - cooking
  - science
  - thermodynamics
---

# Przepis na gotowanie pierogow

> [!abstract] 🧪 Stylowy skrot
> - 🔥 Wrzatek: 3 l + 30 g soli (10 g/l), lekkie wrzenie dla mocnej konwekcji.
> - ⏱️ Czas: 2-3 min lacznie (0.5-1 min do wyplyniecia + 1.5-2 min dogrzewanie).
> - 🎯 Cel: T_srodka 85-90 degC (sonda = zlota sciezka kontrolna).
> - 🧮 Model: przewodzenie 1D, Biot < 0.1, h ~ 400-800 W/(m2*K) → opor powierzchniowy nizszy niz w ciescie.
> - 📐 Kryteria: Bi = h*L/k < 0.1 (dla L=0.01 m, k=0.30 → Bi ≈ 0.013-0.027) → dominacja oporu objętosciowego; Fo = alpha*t/L^2 ~ 1 przy t ≈ 2 min → rdzen dogrzany.

## Cel
> [!info] 🎯 Po co
> - Ustalic praktyczny czas gotowania pierogow z lodowki (start ~5 degC) tak, by farsz osiagnal 80-90 degC bez rozgotowania ciasta.
> - Oprzec decyzje na prawach przewodzenia i konwekcji ciepla.

## Dane i zalozenia fizyczne
> [!note] 📊 Parametry startowe
> - 🌡️ Wrzenie: <span style="color:#d9534f;">100 degC</span>.
> - 🧊 Start pieroga: <span style="color:#0275d8;">5 degC</span>.
> - 🎯 Rdzen farszu: <span style="color:#5cb85c;">85 degC</span> (bezpieczenstwo mikrobiologiczne + tekstura).
> - 📏 Geometria: polgrubosc L = 0.01 m (1 cm do srodka).
> - ⚙️ Wlasciwosci: k = 0.30 W/(m*K), rho = 1100 kg/m3, cp = 3300 J/(kg*K) → alpha ≈ 8.2e-8 m2/s.
> - 🌊 Konwekcja: h ~ 400-800 W/(m2*K); Biot < 0.1 → model przewodzenia 1D z warunkiem konwekcyjnym jest wystarczajacy.
> - 🫧 Obciazenie: garnek 3 l (m_w = 3 kg) + 30 g soli; 10 pierogow = 0.5 kg (m_p).

## Obliczenia czasu dojscia ciepla do srodka
> [!example] 🧾 Obliczenia rdzenia (przewodzenie + konwekcja)
> ```
> t_char ≈ L^2 / (pi^2 * alpha)
> L^2 = (0.01 m)^2 = 1.0e-4 m2
> pi^2 ≈ 9.87
> pi^2 * alpha ≈ 9.87 * 8.2e-8 ≈ 8.1e-7
> t_char ≈ 1.0e-4 / 8.1e-7 ≈ 1.2e2 s ≈ 2.0 min
> ```
> - Interpretacja: po ok. 2 min od zanurzenia srodek farszu zbliza sie do 80-90 degC (przy zachowanej temperaturze otoczenia ~100 degC i intensywnej konwekcji).

> [!example] 🌡️ Bezwymiarowo (kontrola zalozen)
> - Biot: Bi = h*L/k. Dla h = 400-800 W/(m2*K), L = 0.01 m, k = 0.30 W/(m*K) → Bi ≈ 0.013-0.027 < 0.1 → opor w ciescie dominuje, model 1D OK.
> - Fourier: Fo = alpha * t / L^2. Dla t = 120 s, alpha = 8.2e-8, L^2 = 1e-4 → Fo ≈ 0.098. Dla t = 180 s → Fo ≈ 0.147. To zakres, w ktorym rdzen osiaga >80 degC przy stalej T_surf ~ 100 degC.

## Bilans ciepla dla calości (woda + 10 pierogow)
> [!warning] ♨️ Bilans ciepla (10 pierogow)
> - Q_p ≈ m_p * cp * dT = 0.5 kg * 3300 J/(kg*K) * (85 - 5) K ≈ 132 kJ.
> - dT_w ≈ Q_p / (m_w * c_wody) ≈ 132000 J / (3 kg * 4180 J/(kg*K)) ≈ 10.5 K.
> - Wniosek: woda spada z ~100 do ~90 degC, ale nadal utrzymuje konwekcje i szybkie dogrzanie farszu.

## Procedura krok po kroku
- [ ] ♨️ Zagotuj 3 l wody z 30 g soli (10 g/l). Utrzymuj delikatne wrzenie, aby h bylo wysokie.
- [ ] 🌀 Wrzuc pierogi z lodowki (ok. 5 degC). Krotko zamieszaj, by zmniejszyc warstwe graniczna.
- [ ] 🫧 Obserwuj wyplyniecie: 0.5-1 min (spadek gestosci sredniej).
- [ ] ⏲️ Po wyplynieciu gotuj jeszcze 1.5-2.0 min. Laczny czas w wodzie: 2-3 min w zaleznosci od wielkosci i intensywnosci wrzenia.
- [ ] 🌡️ Wyjmij lyzka cedzakowa. Jesli masz sonde: cel 85-90 degC w srodku.

## Dlaczego to dziala (zasady termodynamiki)
> [!tip] 🔍 Uzasadnienie termodynamiczne
> - Przewodzenie (prawo Fouriera) steruje dojściem ciepla do srodka; t_char ~ L^2/alpha definiuje minimum czasu.
> - Konwekcja (prawo Newtona) wzmacnia strumien ciepla; wrzenie daje wysoki h, wiec opor powierzchniowy jest mniejszy od oporu w ciescie.
> - Bilans energii: duza masa wody stabilizuje temperature mimo obciazenia 10 pierogami.
> - Wyplyniecie sygnalizuje nagrzanie zewnetrza i spadek gestosci, ale nie gwarantuje 85 degC w rdzeniu → potrzebny dodatkowy odcinek czasu t_char.

## Skrót decyzyjny
> [!success] ✅ Gotuj tak
> - Wrzuc na wrzatek, wyplyna w 0.5-1 min.
> - Gotuj dalej 1.5-2 min.
> - Wyjmij przy T_srodka ok. 85-90 degC (sonda lub wyczucie). 
