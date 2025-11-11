---
cssclass: kf forest glass
---
# 💠 Karina — FINAL Dashboard

<div class="kf-sticky">
  <div class="kf-left">
```button
name 🗓️ Daily
type template
action 09_TEMPLATES/sd_daily_log.md
```
```button
name 📅 Weekly
type template
action 09_TEMPLATES/sd_weekly_review.md
```
```button
name 🗓️ Monthly
type template
action 09_TEMPLATES/sd_monthly_retrospective.md
```
```button
name 🎓 Sprint
type template
action 09_TEMPLATES/sd_learning_sprint.md
```
```button
name 🧾 eBay listing
type template
action 09_TEMPLATES/ebay_listing.md
```
```button
name 🎬 Video script
type template
action 09_TEMPLATES/video_script.md
```
  </div>
  <div class="kf-right">
    <a class="kf-pill" href="obsidian://search?query=tag:%23s/next">#s/next</a>
    <a class="kf-pill" href="obsidian://search?query=tag:%23ch/ebay">#ch/ebay</a>
    <a class="kf-pill" href="obsidian://search?query=tag:%23ch/youtube">#ch/youtube</a>
    <a class="kf-pill" href="obsidian://search?query=path:06_CONTENT">06_CONTENT</a>
  </div>
</div>

<div class="kf-hero">
  <div class="t">Self‑Development • One Dashboard</div>
  <div class="s">Szybkie akcje • Linki • KPI • Kolejki • Terminy</div>
</div>

## 🔗 Szybki dostęp
<div class="kf-tabs">
  <input type="radio" id="tab-biz" name="tabs" checked>
  <label for="tab-biz">🧾 Biznes</label>
  <input type="radio" id="tab-infra" name="tabs">
  <label for="tab-infra">🖥️ Infra</label>
  <input type="radio" id="tab-social" name="tabs">
  <label for="tab-social">📣 Social</label>
  <input type="radio" id="tab-ship" name="tabs">
  <label for="tab-ship">📦 Wysyłki</label>

  <section class="kf-panel" data-for="tab-biz">
    <div class="kf-grid">
      <a class="kf-tile" href="http://192.168.0.200">🧾 Odoo (Prod)</a>
      <a class="kf-tile" href="https://www.ebay.co.uk/mye/myebay">🛒 eBay — My eBay</a>
      <a class="kf-tile" href="https://www.ebay.co.uk/sl/sell">🧷 eBay — Create listing</a>
      <a class="kf-tile" href="https://www.vinted.co.uk/">👗 Vinted</a>
      <a class="kf-tile" href="https://www.gumtree.com/">📰 Gumtree</a>
      <a class="kf-tile" href="http://192.168.0.214">💷 Firefly III</a>
      <a class="kf-tile" href="http://192.168.0.215">💻 Snipe‑IT</a>
      <a class="kf-tile" href="http://192.168.0.217">📚 Backstage</a>
      <a class="kf-tile" href="http://192.168.0.216">🌐 NetBox</a>
    </div>
  </section>

  <section class="kf-panel" data-for="tab-infra">
    <div class="kf-grid">
      <a class="kf-tile" href="https://192.168.0.88:8006">🧩 Proxmox</a>
      <a class="kf-tile" href="https://192.168.0.213">☁️ Nextcloud</a>
      <a class="kf-tile" href="http://192.168.0.211:5678">🔁 n8n</a>
      <a class="kf-tile" href="http://192.168.0.212:8080">🤖 Ollama WebUI</a>
      <a class="kf-tile" href="http://127.0.0.1:8384">🔄 Syncthing (local)</a>
      <a class="kf-tile" href="https://studio.youtube.com/">▶️ YouTube Studio</a>
    </div>
  </section>

  <section class="kf-panel" data-for="tab-social">
    <div class="kf-grid">
      <a class="kf-tile" href="https://www.tiktok.com/@ewaste_kari">📱 TikTok @ewaste_kari</a>
      <a class="kf-tile" href="https://www.instagram.com/">📷 Instagram</a>
      <a class="kf-tile" href="https://www.canva.com/">🎨 Canva</a>
      <a class="kf-tile" href="https://www.capcut.com/">✂️ CapCut Web</a>
    </div>
  </section>

  <section class="kf-panel" data-for="tab-ship">
    <div class="kf-grid">
      <a class="kf-tile" href="https://www.royalmail.com/track-your-item">📦 Royal Mail</a>
      <a class="kf-tile" href="https://parcelsapp.com/">📦 ParcelsApp</a>
    </div>
  </section>
</div>

<div class="kf-note">Pełna edycja linków: [[00_CORE/Links/Service_Endpoints|Service Endpoints]]</div>

---

## 📈 KPI — ostatnie 7 dni
```dataviewjs
const f = await app.vault.getAbstractFileByPath("07_TRACKERS/Metrics.md");
if (!f) { dv.paragraph("Brak pliku Metrics.md"); return; }
const t = await app.vault.read(f);
const lines = t.split("\n").filter(l => l.trim().startsWith("|") && !l.includes("---"));
if (lines.length < 2){ dv.paragraph("Brak danych"); return; }
const data = lines.slice(1).map(l => l.split("|").slice(1,-1).map(s=>s.trim()));
const parsed = data.map(c => ({date:c[0], sleep:+(c[1]||0), train:+(c[2]||0), focus:+(c[3]||0), mood:+(c[4]||0), energy:+(c[5]||0), posts:+(c[6]||0)})).slice(0,7);
function avg(k){ return parsed.length ? (parsed.reduce((a,b)=>a+(b[k]||0),0)/parsed.length) : 0; }
function sum(k){ return parsed.reduce((a,b)=>a+(b[k]||0),0); }
const stats = [
  {label:"Sen (h) — śr.", val: avg("sleep"), target:7},
  {label:"Focus (min) — suma", val: sum("focus"), target: 120*7},
  {label:"Trening (sesje)", val: sum("train"), target: 3},
  {label:"Posty — suma", val: sum("posts"), target: 5},
  {label:"Nastrój (1–5) — śr.", val: avg("mood"), target: 4},
  {label:"Energia (1–5) — śr.", val: avg("energy"), target: 4},
];
const grid = dv.el("div", "", {cls:"kf-stats"});
for (const s of stats){
  const card = grid.createEl("div", {cls:"kf-stat"});
  card.createEl("div", {cls:"lab", text:s.label});
  card.createEl("div", {cls:"val", text: (Number.isInteger(s.val)? s.val : s.val.toFixed(1)).toString()});
  const p = card.createEl("div", {cls:"kf-progress"});
  p.style.setProperty("--value", Math.min(100, Math.round((Number(s.val)/s.target)*100)));
  p.createEl("div", {cls:"v"});
}
```

## 🧷 eBay Queue
```dataview
TABLE file.link as Note, status, price_gbp as £, file.mtime as Edited
FROM "06_CONTENT" OR "02_PROJECTS/EWW_Sales"
WHERE contains(tags, "#ch/ebay") AND (status="next" OR status="wip")
SORT file.mtime DESC
LIMIT 12
```

## ▶️ Video Queue
```dataview
TABLE file.link as Note, channel, duration_min, file.mtime as Edited
FROM "06_CONTENT"
WHERE contains(tags, "#ch/youtube") OR contains(tags, "#ch/tiktok") OR contains(tags, "#ch/ig")
SORT file.mtime DESC
LIMIT 12
```

## ⏰ Due soon (3 dni)
```dataview
TASK WHERE !completed AND due <= date(today) + dur(3 days)
SORT due ASC
```

---

## 🔭 North Star & Skills
- [[03_AREAS/Self_Development/Vision&NorthStar/NorthStar|North Star]]
- [[03_AREAS/Self_Development/Skills/Skill_Matrix|Skill Matrix]]

> Wymagane wtyczki: **Dataview** + **Buttons**.
