---
title: "Następne kroki standaryzacji docs/"
description: "Plan dalszych działań zgodnie z globalnymi standardami"
version: 0.0.6
category: documentation
tags:
  - planning
  - standardization
  - roadmap
  - docs
language: pl
created: 2025-12-03
updated: 2025-12-03
author: karinam + copilot
owner: jakubc
---

# Następne kroki standaryzacji docs/

## ✅ Wykonane (Faza 1)

- [x] Scalono duplikaty `assets/`, `guide/`, `wiki/`
- [x] Zmieniono `infra/infra/` → `infra/configuration/`
- [x] Zaktualizowano folder notes
- [x] Utworzono dokumentację: STANDARDIZATION-LOG.md, MERGE-DUPLICATES-PLAN.md, DOCS-STRUCTURE-ANALYSIS.md

## 🎯 Priorytetowe następne kroki

### **Krok 2: Przeniesienie katalogów poza docs/** (szybkie wygrane)

#### 2.1 Przenieś `docs/infra/reports/` → `docs/reports/`
```bash
mv docs/infra/reports/ docs/reports/

# Uzasadnienie:
# - To raporty REPO (FULL-INDEX, STATUS-REPO, CLEANUP-LOG), nie infrastruktury
# - Powinny być na poziomie docs/, nie w infra/
# - 13 plików, 0 zależności od infra/
```

**Czas:** 5 min
**Ryzyko:** Niskie
**Impact:** Średni (lepsza organizacja)

---

#### 2.2 Usuń/przenieś `docs/infra/site/` (build artifacts - 2.8 MB!)
```bash
# Opcja A: Dodaj do .gitignore (zalecane)
echo "docs/infra/site/" >> .gitignore
rm -rf docs/infra/site/

# Opcja B: Przenieś do archive
mv docs/infra/site/ docs/archive/legacy-site-build/

# Uzasadnienie:
# - To artefakty buildu MkDocs/Jekyll (HTML, sitemap.xml)
# - Nie powinny być w repo (2.8 MB!)
# - Generowane automatycznie przy każdym build
```

**Czas:** 2 min
**Ryzyko:** Niskie (można odtworzyć z buildu)
**Impact:** Wysoki (zmniejszenie repo o 2.8 MB, czystszy kod)

---

#### 2.3 Scal `docs/infra/dashboards/` (tylko 2 pliki)
```bash
# Opcja A: Przenieś do monitoring/
mkdir -p docs/infra/monitoring/
mv docs/infra/dashboards/ docs/infra/monitoring/dashboards/

# Opcja B: Przenieś do reports/ (jeśli to raporty, nie dashboardy)
mv docs/infra/dashboards/* docs/reports/dashboards/
rmdir docs/infra/dashboards/

# Uzasadnienie:
# - Tylko 2 pliki (dashboards.md, 1 dashboard tygodniowy)
# - Za mało na osobny folder
# - Dashboardy to część monitoringu lub raportów
```

**Czas:** 3 min
**Ryzyko:** Niskie
**Impact:** Średni (lepsza hierarchia)

---

#### 2.4 Zmień `docs/infra/vm/` → `docs/infra/virtualization/`
```bash
mv docs/infra/vm/ docs/infra/virtualization/

# Zaktualizuj README.md
mv docs/infra/virtualization/vm.md docs/infra/virtualization/README.md

# Uzasadnienie:
# - Nazwa "vm" jest niejasna (virtual machines? vendor management?)
# - "virtualization" jest zgodna z globalnymi standardami
# - Obsługuje także kontenery (Docker, LXC), nie tylko VM
```

**Czas:** 5 min
**Ryzyko:** Niskie
**Impact:** Średni (jaśniejsza nazwa)

---

### **Krok 3: Reorganizacja wewnętrzna infra/** (średni priorytet)

#### 3.1 Uporządkuj `docs/infra/areas/`
```bash
# Sprawdź zawartość
ls -la docs/infra/areas/

# Opcja A: Scal z location/ (jeśli to strefy fizyczne)
mv docs/infra/areas/* docs/infra/location/zones/
rmdir docs/infra/areas/

# Opcja B: Scal z hardware/ (jeśli to obszary sprzętowe)
# (wymaga analizy zawartości)

# Uzasadnienie:
# - Niejasna nazwa "areas" (co to są areas?)
# - Może się pokrywać z location/ lub hardware/
```

**Czas:** 10 min
**Ryzyko:** Średnie (trzeba przeanalizować zawartość)
**Impact:** Średni

---

#### 3.2 Uporządkuj `docs/infra/references/`
```bash
# Przenieś pliki do odpowiednich miejsc:

# Specyfikacje techniczne → docs/reference/specifications/
mv docs/infra/references/yaml-frontmatter-spec.md docs/reference/specifications/
mv docs/infra/references/ENDPOINTS.md docs/reference/specifications/
mv docs/infra/references/EWW-MAP.md docs/reference/specifications/

# Przewodniki → docs/infra/guide/ lub docs/guides/
mv docs/infra/references/SSH-REMOTE-GUIDE.md docs/infra/guide/
mv docs/infra/references/Study.md docs/archive/

# Przykłady config → docs/infra/configuration/examples/
mkdir -p docs/infra/configuration/examples/
mv docs/infra/references/ssh-config.example docs/infra/configuration/examples/
mv docs/infra/references/workspace.example.json docs/infra/configuration/examples/

# Pozostałe → docs/
mv docs/infra/references/Obsidian_Links.md docs/software/obsidian/
mv docs/infra/references/ctrl_h_dolphin.md docs/wiki/

# Usuń pusty folder
rmdir docs/infra/references/

# Uzasadnienie:
# - "references" to mix różnych typów dokumentów
# - Każdy dokument powinien być w logicznym miejscu
# - Lepsza nawigacja
```

**Czas:** 15 min
**Ryzyko:** Średnie (wiele plików)
**Impact:** Wysoki (znacznie lepsza organizacja)

---

#### 3.3 Uporządkuj `docs/infra/legacy/`
```bash
# Przenieś do głównego archiwum
mv docs/infra/legacy/ docs/archive/legacy-infra-docs/

# Uzasadnienie:
# - Legacy docs powinny być w archive/, nie w infra/
# - Spójność z resztą archiwum
# - Łatwiejsze ignorowanie w wyszukiwaniu
```

**Czas:** 2 min
**Ryzytek:** Niskie
**Impact:** Niski (porządek)

---

### **Krok 4: Utworzenie nowych katalogów** (opcjonalne, długoterminowe)

#### 4.1 Utwórz `docs/getting-started/`
```bash
mkdir -p docs/getting-started/

# Przenieś/utwórz:
# - installation.md (jak zainstalować EWW)
# - first-steps.md (pierwsze kroki)
# - configuration.md (podstawowa konfiguracja)

# Uzasadnienie:
# - Każdy projekt potrzebuje quick start
# - Zgodne z Diátaxis Framework
# - Ułatwia onboarding nowym użytkownikom
```

**Czas:** 30 min (z tworzeniem treści)
**Ryzyko:** Niskie
**Impact:** Wysoki (lepsze onboarding)

---

#### 4.2 Utwórz `docs/reference/`
```bash
mkdir -p docs/reference/{cli,configuration,specifications}

# Przenieś:
# - docs/infra/references/* → specifications/
# - docs/yaml-frontmatter-spec.md → specifications/
# - Config docs → configuration/

# Uzasadnienie:
# - Centralne miejsce dla dokumentacji referencyjnej
# - Zgodne z Diátaxis Framework
# - Łatwy dostęp do specs
```

**Czas:** 20 min
**Ryzyko:** Średnie
**Impact:** Wysoki

---

#### 4.3 Utwórz `docs/operations/`
```bash
mkdir -p docs/operations/{runbooks,procedures,checklists}

# Uzasadnienie:
# - Miejsce na runbooki operacyjne
# - SOP (Standard Operating Procedures)
# - Checklists
```

**Czas:** 10 min
**Ryzyko:** Niskie
**Impact:** Średni (przygotowanie na przyszłość)

---

### **Krok 5: Migracje między głównymi katalogami** (duże zmiany)

#### 5.1 Migracja `docs/software/` → `development/tools/`
```bash
# Zgodnie z RESTRUCTURE-MAP.md:
mv docs/software/code/ development/tools/vscode/
mv docs/software/git/ development/tools/git/
mv docs/software/github/ development/tools/github/
mv docs/software/obsidian/ development/tools/obsidian/

# Uzasadnienie:
# - docs/software/ to narzędzia DEV, nie dokumentacja
# - Powinny być w development/
# - Zgodne z planem reorganizacji
```

**Czas:** 15 min
**Ryzyko:** Średnie (duża zmiana)
**Impact:** Wysoki (lepsza separacja concerns)
**Wymaga:** Koordynacji z planem RESTRUCTURE-MAP

---

#### 5.2 Rename `docs/infra/` → `docs/infrastructure/`
```bash
mv docs/infra/ docs/infrastructure/

# Zaktualizuj wszystkie linki (find & replace)
find docs/ -type f -name "*.md" -exec sed -i 's|docs/infra/|docs/infrastructure/|g' {} +

# Uzasadnienie:
# - "infrastructure" jest pełną nazwą, nie skrótem
# - Zgodne z globalnymi standardami
# - Lepsza czytelność
```

**Czas:** 20 min (+ testy)
**Ryzyko:** Wysokie (wiele linków)
**Impact:** Wysoki (profesjonalna nazwa)

---

## 📋 Rekomendowany plan działania

### **Tydzień 1: Quick wins** (łatwe, szybkie)
- [ ] **Dzień 1:** Przenieś `reports/` (Krok 2.1)
- [ ] **Dzień 1:** Usuń `site/` (Krok 2.2) → **-2.8 MB!**
- [ ] **Dzień 2:** Scal `dashboards/` (Krok 2.3)
- [ ] **Dzień 2:** Rename `vm/` → `virtualization/` (Krok 2.4)
- [ ] **Dzień 3:** Przenieś `legacy/` (Krok 3.3)

**Rezultat:** Czystszy `docs/infra/`, -2.8 MB w repo, lepsza hierarchia

---

### **Tydzień 2: Reorganizacja wewnętrzna** (średnie)
- [ ] **Dzień 1-2:** Uporządkuj `references/` (Krok 3.2)
- [ ] **Dzień 3:** Przeanalizuj i scal `areas/` (Krok 3.1)
- [ ] **Dzień 4:** Utwórz `docs/reference/` (Krok 4.2)
- [ ] **Dzień 5:** Zaktualizuj wszystkie linki

**Rezultat:** Logiczna struktura, łatwa nawigacja

---

### **Tydzień 3: Nowe katalogi** (opcjonalne)
- [ ] **Dzień 1-2:** Utwórz `getting-started/` + treść (Krok 4.1)
- [ ] **Dzień 3:** Utwórz `operations/` (Krok 4.3)
- [ ] **Dzień 4-5:** Testy, dokumentacja

**Rezultat:** Kompletna dokumentacja zgodna z Diátaxis

---

### **Później: Duże migracje** (wymaga koordynacji)
- [ ] Migracja `software/` → `development/` (Krok 5.1)
- [ ] Rename `infra/` → `infrastructure/` (Krok 5.2)
- [ ] Zgodność z RESTRUCTURE-MAP.md

**Rezultat:** Pełna zgodność z globalnymi standardami

---

## 🎯 Metryki sukcesu

### Przed:
- Duplikaty: ~~4~~ → **0** ✅
- Rozmiar `docs/`: ~4.3 MB
- Build artifacts w repo: 2.8 MB ❌
- Katalogi w `docs/infra/`: 13

### Po (cel):
- Duplikaty: **0** ✅
- Rozmiar `docs/`: **~1.5 MB** ✅ (-2.8 MB)
- Build artifacts w repo: **0** ✅
- Katalogi w `docs/infra/`: **8-10** (scalone)
- Nowe katalogi: `getting-started/`, `reference/`, `operations/`
- Zgodność z Diátaxis: **100%**

---

## 🔗 Powiązania

- [[STANDARDIZATION-LOG]] - Log wykonanych zmian
- [[DOCS-STRUCTURE-ANALYSIS]] - Pełna analiza
- [[RESTRUCTURE-MAP]] - Globalny plan
- [[MERGE-DUPLICATES-PLAN]] - Plan scalenia

---

## 🔗 Backlinks

- [[docs/docs]]
- [[STANDARDIZATION-LOG]]
- [[DOCS-STRUCTURE-ANALYSIS]]
