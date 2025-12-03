---
tags:
  - research
  - audio
  - receiver
  - eww
  - onkyo
created: 2025-12-01T21:59:12Z
modified: 2025-12-01T22:02:30Z
author: karinam
title: "Research: Onkyo TX-NR609"
owner: karinam
status: "do weryfikacji"
production_year: 2011
---

# 🎛️ Research: Onkyo TX-NR609

> ℹ️ **Opis skrócony**  
> Sieciowy amplituner AV 7.2 z HDMI 1.4a, dekodowaniem Dolby TrueHD/DTS-HD MA, upscalingiem wideo (Marvell Qdeo), streamingiem sieciowym (DLNA/Spotify) i certyfikacją THX Select2 Plus. Rocznik ok. 2011.

## 🧭 Profil sprzętu

- 🎯 **Segment/klasa:** średnia półka AVR z siecią (HDMI 1.4a, 3D, ARC, 4K upscaling wczesnej generacji).
- 🗓️ **Rok:** ok. 2011 (premiera 2011Q1).
- 🧩 **Użycie w EWW:** testy audio HDMI/TrueHD/DTS-HD, streaming DLNA, dawca HDMI-board/transformatora/terminali.
- 🛠️ **Priorytet:** weryfikacja HDMI/DSP (znane usterki serii), test sieci (LAN), test termiki na HDMI board.

## 📑 Specyfikacja

- 🔊 **Moc katalogowa:** ~7 × 100 W (8 Ω, 1 kHz, 0.7% THD, 2 ch driven); realnie ~70–80 W/ch (20 Hz–20 kHz).
- 🎚️ **Dekodery:** Dolby TrueHD, DTS-HD MA, Dolby Digital Plus, Pro Logic IIz; THX Select2 Plus.
- 🔌 **HDMI:** 6× in / 1× out (1.4a, 3D, ARC), wczesny 4K upscaling (Qdeo) — sprawdzić stabilność.
- 🎛️ **Analog/cyfra:** wejścia RCA (CD/TV/SAT), SPDIF opt/coax, pre-out sub x2, Zone 2 line-out.
- 🌐 **Sieć:** Ethernet (DLNA, Spotify/vTuner; brak Wi-Fi), sterowanie przez app/HTTP (wczesne API).
- ⚡ **Zasilanie:** 230V AC (EU), IEC C13.

## 💷 Rynek i cena

- **Segment premiery (2011):** średnia półka sieciowa AVR z HDMI 1.4a.
- **Cena premierowa (MSRP):** ok. 599 USD / ~549 EUR (EU); wartości orientacyjne z katalogów Onkyo/recenzji.
- **Rynek wtórny (2025):** ~£70–£150 za w pełni sprawne sztuki z pilotem; uszkodzone/bez dźwięku/HDMI ~£20–£40.
- **Zainteresowanie:** umiarkowane dla hobbystów (HDMI + HD audio); spadające ze względu na brak HDMI 2.1/eARC. Często kupowane na części (HDMI board, trafo, terminale).
- **Kanały:** eBay (największa płynność), lokalnie Gumtree/Facebook Marketplace (odbiór osobisty ze względu na wagę).

## 🔍 Identyfikacja szybka

- Front: duży enkoder, logo THX Select2 Plus, przyciski szybkiego wyboru, gniazdo słuchawkowe, wejście front HDMI/USB (w części wersji), wyświetlacz fluorescencyjny.
- Tył: 6× HDMI in / 1× HDMI out (ARC), SPDIF opt/coax, liczne RCA (7.2), podwójne sub pre-out, Zone 2 out, gniazdo LAN, IEC C13.

## 🎨 Status i priorytety

> 🟥 **ALERT (ryzyko krytyczne)**  
> Brak dźwięku/no audio (DSP/HDMI board), przegrzewanie HDMI board, zimne luty BGA/układy DSP — wymaga pomiarów i testu termicznego.
>
> 🟧 **UWAGA (prawdopodobne usterki)**  
> HDMI handshake/ARC niestabilne, zawieszki firmware, sieć DLNA/Spotify nie łączy, wentylacja słaba — sprawdzić wersję FW i temperatury.
>
> 🟩 **OK (plan podstawowy)**  
> Inspekcja wizualna, test zasilania, HDMI handshake, dekodery TrueHD/DTS-HD, test LAN (ping/DLNA), szybki test audio 7.1 z sub-out.

## ⚠️ Typowe usterki / ryzyka

- Brak dźwięku (all channels) → znana wada DSP/HDMI board w serii; przegrzanie, zimne luty, kondensatory na boardzie.
- HDMI drop/black screen → przegrzanie HDMI board, słabe lutowania, wadliwe kable; sprawdzić handshake i HDCP.
- Sieć nie działa → uszkodzony kontroler LAN lub FW; test ping/HTTP API.
- Protect/relay click loop → DC offset na końcówkach, przebite tranzystory, uszkodzone rezystory emiterowe.
- Przester/clip na wysokich poziomach → zasilanie/filtracja, kondensatory PSU, termika końcówek.

## 🧪 Plan testów

- 🔍 Inspekcja wizualna: kondensatory HDMI/PSU, ślady grzania na HDMI board, stan radiatorów, kurz.
- ⚡ Pomiary wstępne: pobór prądu standby/start, klik przekaźnika, DC offset na frontach (bez obciążenia).
- 🎥 HDMI: handshake z TV (ARC/CEC off/on), test 1080p/24 + 3D; sprawdź stabilność i dropy.
- 🎼 Audio: test Dolby TrueHD/DTS-HD z HDMI i SPDIF, wyjścia 7.2 + sub-out, Zone 2 line-out.
- 🌐 Sieć: ping do adresu LAN, DLNA discovery, test stream (jeśli serwer dostępny); sprawdzić FW.
- 🌡️ Termika: 15–30 min obciążenie 8 Ω (front), monitor temperatury HDMI board/końcówki.
- 🔈 Hałas/buczenie: trafo/PSU; ocena dokręcenia blach i kondensatorów.

## ♻️ Części do odzysku (jeśli rozbiórka)

- HDMI board (Marvell Qdeo), transformator, radiator, moduły końcówek mocy, terminale głośnikowe, przekaźniki, enkoder głośności, potencjometry, gniazda HDMI/SPDIF, płytka LAN/USB, wentylator (jeśli obecny).

## 💰 Wartość części z rozbiórki (szacunki, UK/EU)

- HDMI board (sprawny, bez dropów): £20–£40.
- Transformator: £15–£30 (sprawny, bez buczenia).
- Moduły końcówek mocy + radiator: £12–£25 (zestaw kanałów).
- Terminale głośnikowe/przekaźniki: £6–£12 (zestaw).
- Płytka LAN/USB: £5–£10.
- Enkoder/gałka front, przyciski, panel VFD: £5–£12 (jeśli jasny, bez wypaleń).
- Obudowa/chassis/gałki: £6–£12 (odbiór lokalny).

## 📝 Notatki do uzupełnienia

- Dodać link/plik manuala serwisowego (schemat + parts list).
- Zanotować numer seryjny i rewizję HDMI board; sprawdzić, czy dotyczyła go akcja serwisowa Onkyo (no-audio fix).
- Wpisać wersję firmware i dostępność aktualizacji (jeśli nadal hostowane).

## 🔗 Backlinki

- [[ops/research/research]]
