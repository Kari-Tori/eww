---
alias: [Twilight, G9 Rigger, 7680, Bruxxy, IcarusBuilds, G9, The Twilight]
title: "🛰️ Twilight 7680 — KOMpendium + Roadmapa (Oryginał → MOC1 → MOC2)"
owner: "Wielki Implementator"
status: active
updated: "2025-11-02"
tags: [lego, star-wars, starship, twilight, g9, set-7680, moc, bruxxy, icarusbuilds, roadmap, checklist, bom, make.md, canon, legends, build-plan, minifig, ucs]
cssclass: eww-dashboard rich twilight-theme
space: 03_DEVELOPMENT/LEGO/StarWars/Twilight
series: "Star Wars: The Clone Wars"
stage_current: G0
stage_tags: [#G0, #G1, #G2]
lego_set:
  number: 7680
  name: "The Twilight"
  theme: "Star Wars"
  subtheme: "The Clone Wars"
  year: 2008
  eol: 2009-11
  parts:
    brickset: 882
    bricklink: 867
    lego_bi: 931
  rrp:
    gbp: 68.49
    usd: 99.99
  upc: "673419102728"
  minifigs:
    - sw0183 # Anakin Skywalker (CW)
    - sw0192 # Ahsoka Tano (Padawan)
    - sw0028 # R2-D2
    - sw0193 # Rotta
  market_2025_uk:
    used_gbp: "139–171"
    misb_gbp: "277–310"
starship:
  name: "Twilight"
  model: "G9 Rigger-class light freighter"
  manufacturer: "Corellian Engineering Corporation"
  era: "Clone Wars"
  length_m: 34.1
  hyperdrive_class: 3
  crew_min: 2
  crew_nominal: 2
  nav_seat: true
  astromech_socket: true
  passengers_max_†: 6
  cargo_tonnes_†: 70
  docking_ports: 1
  complement: "Delta‑7B (Anakin)"
  armament:
    - "3 light blaster turrets"
  equipment:
    - "Cargo winch"
  acquisition: "Seized on Teth after TCW (2008) events"
  loss: "Destroyed on Mandalore (Siege of Mandalore)"
links:
  wookieepedia:
    twilight: "https://starwars.fandom.com/wiki/Twilight"
    g9: "https://starwars.fandom.com/wiki/G9_Rigger-class_light_freighter"
  databank: "https://www.starwars.com/databank/twilight"
  brickset: "https://brickset.com/sets/7680-1"
  bricklink: "https://www.bricklink.com/catalogItemInv.asp?S=7680-1"
  rebrickable_bruxxy: "https://rebrickable.com/mocs/MOC-52064/Bruxxy/anakins-the-twilight-the-clone-wars/"
  icarus_flickr: "https://www.flickr.com/photos/149166662@N05/albums/72157717343686003"
budgets_gbp:
  G0:
    min: 140
    max: 170
    total_min: 140
    total_max: 170
  G1:
    min: 85
    max: 175
    total_min: 225
    total_max: 355
  G2:
    min: 900
    max: 1700
    total_min: 1125
    total_max: 2055
---

# ✧ **LEGO Star Wars 7680 – The Twilight**  
**Kompendium + Roadmapa budowy:** **Oryginał → MOC #1 (Bruxxy) → MOC #2 (IcarusBuilds)**

> [!summary] **Mapa etapów**
> 🟩 **Etap 0: Oryginał 7680** — baza do modyfikacji · **£140–£170**  
> 🟨 **Etap 1: MOC #1 (Bruxxy)** — minifig display ~**1418** cz. · **~£225–£355** (łącznie)  
> 🟪 **Etap 2: MOC #2 (IcarusBuilds)** — minifig‑scale „UCS” **~11k+** cz. · **~£900–£1700** części

---

## 🔑 **Ikony i konwencje (styl „Star Wars”)**

> [!legend]
> ✧ — tytuły/sekcje galaktyczne  ·  🔷 — **HOLOCRON** (kanon)  ·  🛸 — statek/jednostka  ·  👨‍✈️ — pilot  ·  🧡 — padawan  ·  🤖 — astromech  ·  🟢 — Hutt  ·  ⛓️ — wyciągarka  ·  📦 — ładownia  ·  ✴️ — wieżyczki blasterowe  ·  🧱 — klocki/oryginał  ·  ⚙️ — upgrade/**MOC**  ·  ⭐ — projekt **UCS**/flagowy  ·  💷 — koszt/budżet  ·  ☑️ — checklisty  ·  † — wartości z **Legends**

> [!dataview] **📈 Panel postępu (zadania #G0/#G1/#G2)**
> ```dataviewjs
> const stages = [
>   { tag: "#G0", name: "🧱 Oryginał" },
>   { tag: "#G1", name: "⚙️ MOC #1" },
>   { tag: "#G2", name: "⭐ MOC #2" }
> ];
> const tasks = dv.current().file.tasks;
> function stats(tag){ const set = tasks.filter(t => t.text.includes(tag)); const total = set.length; const done = set.filter(t => t.completed).length; const pct = total ? Math.round(100*done/total) : 0; return {total,done,pct}; }
> function bar(p){ const n = Math.round(p/10); return "█".repeat(n) + "░".repeat(10-n) + ` ${p}%`; }
> dv.table(["Etap","Ukończone","Wszystkie","Postęp"], stages.map(s=>{ const x=stats(s.tag); return [s.name, x.done, x.total, bar(x.pct)]; }));
> ```

---

## 🔷 **HOLOCRON: G9 Rigger „TWILIGHT” — typ statku (kanon)**

> [!info] **Typ i produkcja**
> 🛸 **Klasa/Model:** *G9 Rigger‑class light freighter*  
> 🏭 **Producent:** Corellian Engineering Corporation (CEC)  
> 🗓️ **Okres użycia:** Wojny Klonów  
> 🎯 **Zastosowanie:** dyskretne misje, transport ładunku/osób, szybkie mody polowe

> [!users] **Załoga — liczba i stanowiska**
> 👥 **Minimalna/Nominalna załoga:** 2 (👨‍✈️ pilot + kopilot)  
> 🧭 **Dodatkowe siedzisko:** nawigator (nie zwiększa pola „crew”)  
> 🤖 **Gniazdo astromecha:** tak

> [!danger] **Uzbrojenie**
> ✴️ **3 lekkie wieżyczki blasterowe** (skrzydła + góra kadłuba) — uzbrojenie typowe dla frachtowców CEC (nie myśliwiec)

> [!example] **Schemat (ASCII) – widok z góry i z boku**
> ```text
>        ┌─────────────── KOKPIT ────────────────┐
>     ___│                                       │___
>    /   │                                       │   >   /    │          [ ✴️  GUN-TOP  ]            │    >  < ✴️  ===O=====[  KADŁUB GŁÓWNY ]=====O===  ✴️ >
>  Skrz. L                                  Skrz. P
>         \_______________________________//
>                    ⛓️  ŁADOWNIA / WYCIĄGARKA
>
> BOK (schematycznie):
>     ▲  góra (GUN-TOP)
>   ┌─┴─────────────┐
>   │   KADŁUB      │  ← ✴️ wieżyczki skrzydeł po lewej/prawej
>   └───────┬───────┘
>           ⛓️  (ładownia)
>
> Legenda: ✴️ wieżyczka blasterowa · ⛓️ wyciągarka/ładownia · O punkty montażu skrzydeł
> ```

> [!note] **Wyposażenie / inne**
> ⛓️ **Wyciągarka w ładowni**  
> 🛠️ Liczne **modyfikacje polowe** (Anakin)  
> 🛸 *(MOC, niekanon):* **Mini‑hangar** pod myśliwiec Anakina (mod display)

> [!table] **Dane techniczne — Canon vs Legends**
> | Parametr | Canon | Legends |
> |---|---|---|
> | Długość | 34.1 m | 34.1 m |
> | Hypernapęd | klasa 3 | klasa 3 |
> | Crew (min/nom) | 2 | 2 |
> | Dodatkowe miejsca | +1 nawigator (kokpit), gniazdo astromecha | j.w. |
> | Pasażerowie | — | 6 |
> | Ładowność | — | 70 t |
> | Luki dokujące | 1 | 1 |
> | Komplement | Delta‑7B Anakina | Delta‑7B |
> | Prędkość atmosferyczna | — | ~700 km/h |
>
> *Uwagi: Dane w kolumnie „Legends” pochodzą z materiałów RPG/Legends; w planie budowy oznaczamy je symbolem **†**.*

> [!quote] **Pozyskanie i utrata**
> 🛬 **Pozyskanie:** przejęty na **Teth** po wydarzeniach z **_The Clone Wars (2008)_**.  
> 💥 **Zniszczenie:** **Mandalore** (działania związane z **Maulem**; okres **Siege of Mandalore**).

> [!list] **Postacie powiązane (Wookieepedia / LEGO)**
> - **Anakin Skywalker** — https://starwars.fandom.com/wiki/Anakin_Skywalker · LEGO: https://brickset.com/minifigs/sw0183  
> - **Ahsoka Tano (Padawan)** — https://starwars.fandom.com/wiki/Ahsoka_Tano · LEGO: https://brickset.com/minifigs/sw0192  
> - **R2‑D2** — https://starwars.fandom.com/wiki/R2-D2 · LEGO: https://brickset.com/minifigs/sw0028  
> - **Rotta** — https://starwars.fandom.com/wiki/Rotta · LEGO: https://brickset.com/minifigs/sw0193  
> - **Obi‑Wan Kenobi** — https://starwars.fandom.com/wiki/Obi-Wan_Kenobi  
> - **Ziro the Hutt** — https://starwars.fandom.com/wiki/Ziro_Desilijic_Tiure  
> - **Asajj Ventress** — https://starwars.fandom.com/wiki/Asajj_Ventress  
> - **Jabba the Hutt** — https://starwars.fandom.com/wiki/Jabba_Desilijic_Tiure  
> - **Maul** — https://starwars.fandom.com/wiki/Maul

> [!link] **Źródła (kanon)**
> - Wookieepedia — Twilight: https://starwars.fandom.com/wiki/Twilight  
> - Wookieepedia — G9 Rigger‑class: https://starwars.fandom.com/wiki/G9_Rigger-class_light_freighter  
> - StarWars.com Databank — Twilight: https://www.starwars.com/databank/twilight  
> - LEGO 7680 (Brickset): https://brickset.com/sets/7680-1

---

> [!dataview] **📡 HOLO‑SPEC (front‑matter → tabela)**
> ```dataviewjs
> const s = dv.current().frontmatter.starship;
> dv.table(["Atrybut", "Wartość"],[
>   ["🛸 Model", s.model],
>   ["🏭 Producent", s.manufacturer],
>   ["📏 Długość (m)", s.length_m],
>   ["🌀 Hyperdrive", "kl. " + s.hyperdrive_class],
>   ["👥 Załoga (min/nom)", `${s.crew_min} / ${s.crew_nominal}`],
>   ["🪫 Pasażerowie†", s["passengers_max_†"]],
>   ["📦 Ładowność† (t)", s["cargo_tonnes_†"]],
>   ["🚪 Luki dokujące", s.docking_ports],
>   ["🛩️ Komplement", s.complement],
>   ["✴️ Uzbrojenie", (s.armament||[]).join(", ")],
>   ["⛓️ Wyposażenie", (s.equipment||[]).join(", ")],
>   ["🗓️ Pozyskanie", s.acquisition],
>   ["💥 Utrata", s.loss],
> ]);
> ```

---

## 🧱 **Fiszka zestawu – LEGO 7680**

> [!abstract] **Parametry**
> 📅 **2008** · 🧪 *The Clone Wars* · 📴 wycofany ~**XI 2009**  
> 💷 **RRP:** **£68.49 / $99.99**  
> 📦 **Pudełko:** ~**57.6 × 38.4 × 9.6 cm** · 🔢 **UPC 673419102728**  
> 📘 **Instrukcje:** **2 tomy PDF** (LEGO Service)  
> 🧩 **Liczba części (źródła):** **882** *(Brickset)* · **867** *(BrickLink)* · **~931** *(LEGO BI)*

> [!tip] **Rynek 2025 (UK)**
> ✅ **Używany komplet:** **~£139–£171** · 🧊 **MISB:** **~£277–£310**

> [!warning] **„Hotspoty” przy zakupie**
> 🧵 **x77ac50** — linka 50 cm · 🏷️ **sticker sheet** · 🔩 **Technic** po 15+ latach · 🧼 **tiles/slopes** do displayu

**Minifigi w pudełku**
- 👨‍✈️ **Anakin Skywalker (CW)** — `sw0183`  
- 🧡 **Ahsoka Tano (Padawan)** — `sw0192`  
- 🤖 **R2‑D2** — `sw0028`  
- 🟢 **Rotta** — `sw0193` *(rzadszy, droższy)*

> [!dataview] **📇 Minifigi — szybki podgląd (Dataview z tej strony)**
> ```dataview
> TABLE WITHOUT ID choice("👨‍✈️ Anakin Skywalker (CW)", "👨‍✈️ Anakin Skywalker (CW)"),
>                  choice("🧡 Ahsoka Tano (Padawan)", "🧡 Ahsoka Tano (Padawan)"),
>                  choice("🤖 R2‑D2", "🤖 R2‑D2"),
>                  choice("🟢 Rotta", "🟢 Rotta")
> FROM this.file
> LIMIT 1
> ```

---

# ✧ **ETAP 0 — ORYGINAŁ 7680 (🧱 baza)**

> [!target] **Cel**
> Uzyskać czysty, kompletny zestaw bazowy z pełnym składem minifigów i stickerów.

### 🧾 **Checklista (Oryginał)**
- [ ] Weryfikacja 4× minifig (**Anakin**, **Ahsoka**, **R2‑D2**, **Rotta**) #G0  
- [ ] Obecność i stan **🧵 x77ac50** + duże **wedge/panele** #G0  
- [ ] **Sticker sheet** — komplet i akceptowalny stan #G0  
- [ ] Pobranie **PDF 2× instrukcji** i backup #G0  
- [ ] Zdjęcia "**przed**" (katalog EWW) #G0

> [!dataview] **☑️ Zadania — Etap 0 (otwarte)**
> ```dataview
> TASK FROM this.file WHERE !completed AND contains(tags, "#G0")
> SORT text ASC
> ```

### 🧩 **BOM (Oryginał – standard projektu)**
> [!info] **Przyjmujemy inventory z LEGO BI ≈ 931 części**  
> **Kontrola punktowa:** linka x77ac50 · zawiasy/Technic · panele/wedge · tile’e frontowe

> [!dataview] **📦 BOM-y w folderze projektu (jeśli istnieją)**
> ```dataview
> TABLE file.link AS "Plik BOM", file.size AS "Rozmiar"
> FROM "03_DEVELOPMENT/LEGO/StarWars/Twilight"
> WHERE regexmatch("^BOM_", file.name)
> SORT file.name ASC
> ```

### 💷 **Koszt (GBP)**
- Zakup: **£140–£170** · Serwis/clean: **£8–£15**

> [!check] **GATE G0 → G1**
> Kompletność potwierdzona · linka i naklejki zaakceptowane · zdjęcia „przed” zrobione

---

# ⚙️ **ETAP 1 — MOC #1: „Anakin’s The Twilight” (Bruxxy)**

> [!target] **Cel**
> Ulepszony **minifig display** ~**1418** cz. + opcjonalny **stand**.

### 🧾 **Checklista (MOC #1)**
- [ ] Zakup **instrukcji (~€10)** i **inwentarza** (Rebrickable) #G1  
- [ ] Import do **BrickLink Wanted List** #G1  
- [ ] **Auto‑select stores → 2–4** (UK/EU) #G1  
- [ ] **Any Color/Substitute** dla elementów **niewidocznych** #G1  
- [ ] Dodać **spares 2–3%** na tile’e/slopes #G1  
- [ ] Zamówić braki, złożyć, dodać **stand + tabliczka** #G1  
- [ ] Zdjęcia "**po**" (katalog EWW) #G1

> [!dataview] **☑️ Zadania — Etap 1 (otwarte)**
> ```dataview
> TASK FROM this.file WHERE !completed AND contains(tags, "#G1")
> SORT text ASC
> ```

### 🧩 **BOM – Delta względem Oryginału**
> [!note] **Donor:** Oryginał 7680 · **Dodatkowe sztuki:** **~500–600**  
> **Najczęstsze braki:** poszycie kadłuba, spójna paleta Technic, detale kokpitu/ogona  
> **Stand:** osobny MOC → osobny mini‑BOM

> [!dataview] **🧱 Części do uzupełnienia (draft)**
> ```dataview
> TABLE WITHOUT ID "Przykład" AS Element, "do uzupełnienia" AS Status
> FROM this.file
> LIMIT 3
> ```

### 💷 **Koszt (GBP)**
- Braki + wysyłki: **~£85–£175** · Instrukcja: **~£9**  
- **Łącznie Etap 0 + 1:** **~£225–£355**

> [!check] **GATE G1 → G2**
> Stabilność skrzydeł/ramion OK · stand + tabliczka zamontowane · zdjęcia „po” gotowe

---

# ⭐ **ETAP 2 — MOC #2: Minifig‑scale G9 (IcarusBuilds)**

> [!target] **Cel**
> Wersja klasy **UCS**: **~11 259** cz., **~102×132** studów, wnętrze wielokomorowe. Opcjonalny **mini‑hangar** jako mod display.

### 🧾 **Checklista (MOC #2)**
- [ ] Zebrać **referencje foto** i wątek autora #G2  
- [ ] Rozbić projekt na **sub‑assembly**: nośna · skrzydło z działem · ogon · kokpit · cargo · poszycie #G2  
- [ ] Zbudować **BOM per moduł** i harmonogram zakupów (partiami) #G2  
- [ ] Testy **ugięcia skrzydła/podpór** na etapach #G2  
- [ ] Zdjęcia finalne i opis build‑log #G2

> [!dataview] **☑️ Zadania — Etap 2 (otwarte)**
> ```dataview
> TASK FROM this.file WHERE !completed AND contains(tags, "#G2")
> SORT text ASC
> ```

### 🧩 **BOM – Delta względem MOC #1**
> [!warning] **Brak oficjalnej instrukcji/BOM** → reverse‑engineering ze zdjęć/wątku  
> Dominują: elementy **nośne** i **poszycie** w spójnej palecie kolorów

> [!dataview] **🛠️ Sub‑assembly (gdy powstaną pliki modułów)**
> ```dataview
> TABLE file.link AS "Moduł", file.mtime AS "Modyfikowany"
> FROM "03_DEVELOPMENT/LEGO/StarWars/Twilight"
> WHERE contains(file.name, "MOC2_")
> SORT file.mtime desc
> ```

### 💷 **Koszt (GBP)**
- Części + wysyłki: **~£900–£1700**  
- **Suma Etap 0 + 1 + 2:** **~£1125–£2055**

> [!check] **GATE G2 — Final**
> Nośna bez ugięć krytycznych · mechanika skrzydła płynna · display ukończony

---

## 🧭 **Roadmapa czasowa**

> [!timeline]
> **T0** — zakup i weryfikacja Oryginału → **G0**  
> **T1** — import MOC #1, zakupy, budowa, stand → **G1**  
> **T2** — plan sub‑assembly MOC #2, batch‑zakupy, build‑log → **G2**

---

## 📊 **Porównanie etapów**
| Etap | Cel | Koszt (GBP) | Trudność | Czas | Skala minifig | Display |
|---|---|---:|:--:|:--:|:--:|:--:|
| 🟩 Oryginał | Baza do modów | 140–170 | ▢ | ▢ | ●●◐ | ●●◐ |
| 🟨 MOC #1 | Ulepszony display | 225–355 | ▣ | ▣ | ●●● | ●●● |
| 🟪 MOC #2 | Ekspozycja premium | 1125–2055 | ■ | ■ | ●●● | ●●●● |

Legenda: ▢ niska · ▣ średnia · ■ wysoka

> [!dataview] **💷 Budżet — kokpit (front‑matter → tabela)**
> ```dataviewjs
> const b = dv.current().frontmatter.budgets_gbp;
> const rows = [["🧱 Oryginał (G0)", b.G0.min, b.G0.max, b.G0.total_min, b.G0.total_max],
>               ["⚙️ MOC #1 (G1)", b.G1.min, b.G1.max, b.G1.total_min, b.G1.total_max],
>               ["⭐ MOC #2 (G2)", b.G2.min, b.G2.max, b.G2.total_min, b.G2.total_max]];
> dv.table(["Etap", "Δ £ min", "Δ £ max", "£ total min", "£ total max"], rows);
> ```

---

## 🛒 **Sourcing + KPI**
> [!tip] **Taktyka zakupowa**
> Minimalizuj sklepy **BrickLink** (MOC #1 **2–4**, MOC #2 **≤6**). **Any Color** wewnątrz. **Spares 2–3%** na kafle i slopes.

> **KPI**
> Stores/Order ≤ 3 (MOC #1), ≤ 6 (MOC #2) · Rare‑tax ≤ 15% · Czas: MOC #1 ≤ 14 dni, MOC #2 ≤ 60 dni partiami.

> [!dataview] **📦 Zamówienia (folder Orders)**
> ```dataview
> TABLE file.link AS "Zamówienie", file.cday AS "Utworzono", file.mday AS "Aktualizowano"
> FROM "03_DEVELOPMENT/LEGO/StarWars/Twilight/Orders"
> SORT file.cday desc
> ```

> [!dataview] **🖼️ Zdjęcia (folder Photos)**
> ```dataview
> LIST file.link
> FROM "03_DEVELOPMENT/LEGO/StarWars/Twilight/Photos"
> ```

---

## 🔗 **Odnośniki (skrót)**
- 7680: Brickset · BrickLink · LEGO Service PDF  
- MOC #1: Rebrickable (Bruxxy) + stand  
- MOC #2: Flickr + Eurobricks (IcarusBuilds)  
- Kanon: Wookieepedia (Twilight, G9 Rigger)

---
