---
title: Obi-Wan Kenobi Delta7
description: Szczegółowa notatka o Delta-7 Teroys, status stripie w Obsidianie oraz planie kolejnych bloków budowy
type: document
category: documentation
status: building
audience: contributors
author: jakubc
platform: Kubuntu 24.04
language: pl
tags:
  - lego
  - delta-7
  - obi-wan
  - minifig
  - obsidian
  - snippet
  - lego-snippet
created: "2025-11-24"
updated: "2025-11-24"
obsidian_snippet: lego-snippet
# Snippet `lego-snippet` znajduje się w `usr/jakubc/hobby/lego/snippets/lego-snippet.css`
required_plugins:
  - dataview
  - obsidian-style-settings
  - metadata-menu
  - obsidian-kanban
  - obsidian-projects
---

<div class="lego-page full-width">
  <header class="lego-hero">
    <div class="lego-hero-top">
      <div>
        <div class="lego-breadcrumb">LEGO / Delta-7 / Obi-Wan</div>
        <h1>Obi-Wan Kenobi Delta7</h1>
        <div class="checklist" aria-label="Stan postaci i statku">
          <span class="check-pill"><input type="checkbox" checked aria-label="Obi-Wan" /><span class="icon">👨</span>Obi-Wan</span>
          <span class="check-pill"><input type="checkbox" checked aria-label="R4-P17" /><span class="icon">🤖</span>R4-P17</span>
          <span class="check-pill"><input type="checkbox" aria-label="Delta-7" /><span class="icon">✈️</span>Delta-7</span>
        </div>
        <div class="lego-progressbar" style="--progress: 16.7%;" aria-label="Progress 1/6">
          <div class="fill"></div>
          <span class="label">Progress: 1/6 (16.7%)</span>
        </div>
      </div>
      <div style="min-width: 260px;">
        <div class="hero-meta">
          <span><span class="label">Start:</span> 2023-11-24</span>
          <span><span class="label">Koszt:</span> £48.99</span>
          <span><span class="label">Klocki:</span> ~244 (projekt)</span>
          <span><span class="label">Fun time:</span> 17.5h</span>
        </div>
      </div>
    </div>
    <div class="lego-actions">
      <a class="lego-btn" href="[[usr/jakubc/hobby/lego/delta-7/delta7.md]]">📊 Dashboard Delta-7</a>
      <a class="lego-btn lego-btn--ghost" href="[[usr/jakubc/hobby/lego/delta-7/obi-wan-kenobi/assets]]">🧱 Assety buildów</a>
      <a class="lego-btn lego-btn--ghost" href="[[usr/jakubc/hobby/lego/delta-7/obi-wan-kenobi/TODO/02-snippety/README]]">🎨 Snippet LEGO</a>
    </div>
  </header>

  <section id="goals">
    <h2>🎯 Cele i zasady</h2>
    <ul>
      <li><strong>Best minifig detail</strong> – zbudować Teroys MOC-222332 Delta-7 w najdokładniejszej skali minifig.</li>
      <li><strong>Max fun, low cost</strong> – maksymalna liczba buildów przy minimalnych kosztach.</li>
    </ul>
  </section>

  <section id="todo">
    <h2>TODO</h2>
    <ul>
      <li>Zebrać informacje o ikonach LEGO/Star Wars dla Obsidiana (<a href="TODO/01-ikonki-informacje/README">link</a>).</li>
      <li>Dopracować LEGO snippet i opisać warianty kolorystyczne (<a href="TODO/02-snippety/README">link</a>).</li>
      <li>Stworzyć Dataview query dla kompaktowego widoku buildów.</li>
      <li>Dodać CSS snippet gridowy (3 kolumny, karty ~300px).</li>
      <li>Poszerzyć metadata o datę, koszt, czas i status każdego bloku.</li>
      <li>Zestawić Metadata Menu dla szybkiej edycji informacji o blockach.</li>
      <li>Wdrożyć Obsidian Kanban do wizualnego trackingu progresu.</li>
    </ul>
  </section>

  <section id="collection">
  </section>

  <section id="stats">
  </section>

  <section id="build-data">
    <h2>Dane z assetów (dataviewjs)</h2>
    ```dataviewjs
    const builds = dv.pages("usr/jakubc/hobby/lego/delta-7/obi-wan-kenobi/assets")
      .where(p => p.type === "build")
      .sort(p => p.date);

    for (let build of builds) {
      dv.paragraph(`
      <div class="build-card">
        <div class="build-card__meta">
          <strong>📊 Dane</strong>
          <span>📅 ${build.date}</span>
          <span>⏱️ ${build.duration_hours}h</span>
          <span>💰 ${build.currency}${build.cost}</span>
          <span>🏪 ${build.shop}</span>
          <span>✅ ${build.status}</span>
          <span>🧱 ${build.parts} części</span>
        </div>
        <div class="build-card__notes">
          <strong>📝 Notatki & zawartość</strong>
          ${build.notes ? build.notes.map(n => `<span>🔹 ${n}</span>`).join("") : ""}
          ${build.includes ? build.includes.map(i => `<span>• ${i}</span>`).join("") : ""}
          ${build.link ? `<span>📖 <a href="${build.link}">Instrukcja</a></span>` : ""}
        </div>
      </div>
      `);
    }
    ```
  </section>

  <section id="roadmap">
    <h2>Build Roadmap</h2>
    <ol>
      <li><strong>Block 1 – LEGO 75333 Obi-Wan's Jedi Starfighter</strong> (completed) – stabilizacja seta bazowego, przygotowane fundamenty.</li>
      <li><strong>Block 2 – OEM build + mc parthon mode</strong> (pending) – modułowe dodatki, specyfikacja.</li>
      <li><strong>Block 3 – Alt build (MOC-151695)</strong> (future) – weryfikacja alternatywnego MOC-u.</li>
      <li><strong>Block 4 – Batch 1+2 (wedge’y, tile’e, slopes)</strong> (future) – uzupełnianie braków, testy tile’i.</li>
      <li><strong>Block 5 – Batch 3 + instrukcja + dokumentacja</strong> (pending) – dokumentacja, canopy, zdjęcia.</li>
      <li><strong>Block 6 – Finalny Teroys Delta-7</strong> (goal) – finalny render, R4-P17, publikacja (nasz czerwony cel).</li>
    </ol>
  </section>

  <section id="links">
    <h2>Linki i notatki</h2>
    <ul>
      <li>Dashboard/status: `[[usr/jakubc/hobby/lego/delta-7/delta7.md]]`</li>
      <li>Techniczna notatka: `[[usr/jakubc/hobby/lego/delta-7/delta-7-notatka.md]]`</li>
      <li>Archiwum: `[[usr/jakubc/hobby/lego/delta-7/archives/obi-wan-kenobi.md]]`</li>
      <li>Assety: `[[usr/jakubc/assets/obi-wan-kenobi/obi-wan-kenobi.md]]`</li>
    </ul>
  </section>

  <section id="snippet">
    <h2>Snippet</h2>
    <p>Włącz `lego-snippet` w <strong>Settings → Appearance → CSS snippets</strong> (lub skopiuj plik <code>usr/jakubc/hobby/lego/snippets/lego-snippet.css</code> do <code>.obsidian/snippets</code>). Snippet stylizuje status strip, build card i roadmapę.</p>
  </section>
</div>
