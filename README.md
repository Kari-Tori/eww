---
title: E-Waste Workshop
description: Dokumentacja biznesu E-Waste Workshop - recykling, refabrykacja i automatyzacja
version: 0.0.0.5
author: E-Waste Workshop Team
repository: https://github.com/Nairecth/eww
website: https://e-wasteworkshop.co.uk
tags:
  - e-waste
  - recycling
  - refurbishment
  - automation
  - business
  - workshop
language: pl
license: MIT
---

# ♻️ E-Waste Workshop

[![Website](https://img.shields.io/badge/Website-🏠%20E--Waste_Workshop-10AB1C?style=for-the-badge&logo=recycle&logoColor=white)](https://e-wasteworkshop.co.uk)
[![YouTube](https://img.shields.io/badge/YouTube-Subs%2018-ff0000?style=for-the-badge&logo=youtube)](https://www.youtube.com/channel/UCe31iZazQVN678Yqn62u3GA)
[![GitHub](https://img.shields.io/badge/GitHub-16\,827%20files-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Nairecth/eww)
[![eBay](https://img.shields.io/badge/eBay-Sold%20Items%2067-0064d2?style=for-the-badge&logo=ebay&logoColor=white)](https://www.ebay.co.uk/usr/e-waste_workshop)
[![License](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](LICENSE)

> **E-Waste Workshop** to startup technologiczny z misją recyklingu i refabrykacji elektroniki oraz sprzętu gospodarstwa domowego. Łączymy automatyzację, AI, druk 3D i HomeLab, aby projektować procesy odzysku i rewitalizacji.

## 🎯 Czym się zajmujemy

- 🔧 **Recykling elektroniki** - odzysk komponentów, materiałów i surowców
- 🛠️ **Refabrykacja sprzętu** - naprawa i modernizacja urządzeń
- 🤖 **Automatyzacja procesów** - AI, skrypty, workflow automation
- 🏠 **HomeLab** - infrastruktura do testowania i development
- 📦 **Sprzedaż odrestaurowanych produktów** - eBay, strona, social media
- 📹 **Edukacja** - YouTube, dokumentacja, dzielenie się wiedzą

## 📂 Struktura repozytorium

```
eww/
├── business/          # Procesy biznesowe, governance, metodyki
├── usr/              # Katalogi użytkowników (jakubc, karinam, gary)
├── core/             # Konfiguracje systemowe, workflow, inbox
├── dev/              # Narzędzia deweloperskie, skrypty, projekty
├── lib/              # Biblioteki Bash
├── bin/              # Binaria wykonywalne
├── docs/             # Dokumentacja projektu
├── archive/          # Archiwum historyczne
├── AGENTS.md         # Kontekst dla AI Coding Agents
├── CHANGELOG.md      # Historia zmian
├── CONTRIBUTING.md   # Jak kontrybuować
├── LICENSE           # Licencja MIT
└── Makefile          # Automatyzacja zadań
```

## 🚀 Quick Start

### Dla użytkowników

```bash
# Sklonuj repozytorium
git clone https://github.com/Nairecth/eww.git
cd eww

# Przejrzyj dokumentację
cat docs/README.md
```

### Dla developerów

```bash
# Sprawdź dostępne komendy
make help

# Uruchom testy
bats dev/tests/

# Sprawdź składnię
shellcheck lib/*.sh bin/*
```

## 📖 Dokumentacja

- **[docs/README.md](docs/README.md)** - Główna dokumentacja
- **[AGENTS.md](AGENTS.md)** - Kontekst dla AI Coding Agents
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Jak kontrybuować
- **[core/workflow/](core/workflow/)** - Workflow i procesy
- **[business/](business/)** - Governance, metodyki, procesy biznesowe

## 🛠️ Stack technologiczny

- **Język**: Bash 5.2+, Python (narzędzia pomocnicze)
- **OS**: Ubuntu/Kubuntu 24.04 LTS
- **Automatyzacja**: Make, systemd, GitHub Actions
- **Dokumentacja**: Markdown, Obsidian
- **Versionowanie**: Git, Semantic Versioning
- **Testing**: BATS (Bash Automated Testing System)

## 🤝 Kontrybuowanie

Wkład mile widziany! Zobacz [CONTRIBUTING.md](CONTRIBUTING.md) dla szczegółów.

1. Fork projektu
2. Utwórz branch (`git checkout -b feat/amazing-feature`)
3. Commit zmian (`git commit -m 'feat: dodaj amazing feature'`)
4. Push do brancha (`git push origin feat/amazing-feature`)
5. Otwórz Pull Request

## 📜 Licencja

Projekt jest dostępny na licencji **MIT**. Zobacz [LICENSE](LICENSE) dla szczegółów.

## 📧 Kontakt

- **Website**: https://e-wasteworkshop.co.uk
- **YouTube**: https://www.youtube.com/channel/UCe31iZazQVN678Yqn62u3GA
- **eBay**: https://www.ebay.co.uk/usr/e-waste_workshop
- **GitHub**: https://github.com/Nairecth/eww
- **Email**: astriblast@gmail.com

## 🌟 Status projektu

- ✅ **Aktywny development**
- 📦 Wersja: `0.0.0.5` (Pre-MVP)
- 🎯 Cel: MVP Q1 2025
- 🔄 Ostatni commit: Zobacz [CHANGELOG.md](CHANGELOG.md)

## 🙏 Podziękowania

- Społeczność open-source za narzędzia i inspiration
- GitHub za platformę i infrastrukturę
- Wszystkim kontrybutrom i supporterom projektu

---

**♻️ Razem redukujemy e-waste i tworzymy wartość z odpadów elektronicznych! 🌍**
