---
title: "Analiza struktury docs/ i plan reorganizacji"
description: "Szczegółowa analiza zawartości docs/ z propozycją standardowej struktury"
version: 0.0.6
category: documentation
tags:
  - analysis
  - planning
  - structure
  - docs
  - eww
language: pl
created: 2025-12-03
updated: 2025-12-03
author: karinam + copilot
owner: jakubc
---

# 📊 Analiza struktury docs/ i plan reorganizacji

## 🔍 Stan obecny

### Statystyki
- **Rozmiar całkowity:** ~4.3 MB (głównie w `infra/`)
- **Największe katalogi:**
  - `docs/infra/` - 4.3 MB (dokumentacja infrastruktury)
  - `docs/software/` - 916 KB (głównie Obsidian, VS Code)
  - `docs/archive/` - 196 KB (archiwalne materiały)
  - `docs/governance/` - 80 KB (→ już przeniesione do `business/`)

### Struktura drzewa (3 poziomy)

```
docs/
├── archive/                    # 196KB - Archiwum historyczne
│   ├── 03_DEVELOPMENT/        # Stare plany dev
│   ├── 04_TEAM/               # Historia zespołu
│   ├── Idea/                  # Lab AI, pomysły
│   ├── avocado/               # ???
│   ├── obsidian/              # Stare config Obsidian
│   └── trash-recovery/        # Odzyskane pliki
│
├── assets/                     # 100KB - Media
│   ├── assets.md
│   └── map-eww.png            # Mapa projektu
│
├── governance/                 # 80KB - ✅ PRZENIESIONE → business/
│   └── (13 plików .md)
│
├── guide/                      # 12KB - Przewodniki
│   ├── guide.md
│   └── intro.md
│
├── infra/                      # 4.3MB - 🔥 GŁÓWNY KATALOG
│   ├── architecture/          # Architektura systemowa
│   │   ├── Systems_Deep_Dive.md
│   │   └── architecture.md
│   │
│   ├── areas/                 # Strefy fizyczne
│   │   ├── devices/
│   │   ├── network/
│   │   └── workshop/
│   │
│   ├── assets/                # Media dla infra
│   │
│   ├── dashboards/            # Dashboardy (1 plik)
│   │   └── eww_weekly_dashboard_iso_w_45_03_09_11.md
│   │
│   ├── guide/                 # Przewodniki infra (puste?)
│   │
│   ├── hardware/              # 🔧 SPRZĘT (dobrze zorganizowane)
│   │   ├── asus_z77/         # Konkretne PC
│   │   ├── gerc/             # Serwer główny
│   │   ├── kitchen_touchscreen/
│   │   ├── laptops/
│   │   ├── media_amplituner/
│   │   ├── media_soundbar/
│   │   ├── media_tv/
│   │   ├── mobile/
│   │   ├── network/          # 🌐 SIEĆ (szczegółowo)
│   │   │   ├── cisco-3650-catalyst-poe-24/
│   │   │   ├── devices/
│   │   │   ├── netgear_fs108/
│   │   │   ├── status/
│   │   │   ├── cisco-switch-port-map.md
│   │   │   ├── garynet.md            # GaryNet - kluczowe!
│   │   │   ├── network-deployment*.md
│   │   │   ├── network_diagram.md
│   │   │   └── tp-link_tl-wr902ac.md
│   │   ├── rack/
│   │   ├── workstations/
│   │   └── hardware.md
│   │
│   ├── infra/                 # ⚠️ DUPLIKAT nazwy (infra/infra/)
│   │   ├── ansible/          # Playbooki
│   │   ├── core/
│   │   ├── hooks/
│   │   ├── systemd/
│   │   └── infra.md
│   │
│   ├── legacy/                # Stare dokumenty
│   │   ├── MAKEFILE-GUIDE.md
│   │   ├── docs.md
│   │   ├── dokumentacja.md
│   │   └── (5 plików)
│   │
│   ├── references/            # Referencje techniczne
│   │   ├── ENDPOINTS.md
│   │   ├── EWW-MAP.md
│   │   ├── Obsidian_Links.md
│   │   ├── SSH-REMOTE-GUIDE.md
│   │   ├── Study.md
│   │   ├── yaml-frontmatter-spec.md
│   │   └── (10 plików)
│   │
│   ├── reports/               # 📊 Raporty statusu repo
│   │   ├── FULL-INDEX.md     # Index wszystkich plików
│   │   ├── STATUS-REPO.md
│   │   ├── CLEANUP-LOG.md
│   │   ├── FRONTMATTER_REPORT.md
│   │   └── (13 plików)
│   │
│   ├── site/                  # 🌐 Strona WWW (build output?)
│   │   ├── ENDPOINTS/
│   │   ├── assets/
│   │   ├── guide/
│   │   ├── search/
│   │   ├── vendor/
│   │   ├── wiki/
│   │   ├── index.html        # ⚠️ Artefakty buildów
│   │   ├── 404.html
│   │   └── sitemap.xml
│   │
│   ├── tags/                  # → Symlink do dev/obsidian/tags
│   │
│   ├── vm/                    # Maszyny wirtualne
│   │   └── README.md
│   │
│   ├── wiki/                  # Wiki wewnętrzne
│   │
│   ├── infra.md               # Folder note
│   ├── location.md            # 📍 KLUCZOWE - 77C Church Lane
│   └── tags.md
│
├── methodologies/             # 36KB - ✅ PRZENIESIONE → business/
│   └── (7 plików .md)
│
├── software/                  # 916KB - Narzędzia deweloperskie
│   ├── code/                 # VS Code
│   │   ├── plugins/
│   │   ├── README.md
│   │   ├── code-plugins.md
│   │   ├── extensions-status.md
│   │   └── html-css-tools.md
│   │
│   ├── git/                  # Git
│   ├── github/               # GitHub
│   ├── habitica/             # Task manager
│   ├── obsidian/             # 🔥 DUŻY - Obsidian setup
│   │   ├── .obsidian/
│   │   ├── graph/           # Grafy
│   │   ├── plugins/         # Pluginy
│   │   ├── resources/
│   │   ├── OBSIDIAN-SETUP.md
│   │   ├── PLUGINS.md
│   │   ├── obsidian-customization.md
│   │   ├── obsidian-plugins.md
│   │   └── (20+ plików)
│   │
│   ├── vikunja/              # Task manager
│   └── software.md
│
├── wiki/                      # 24KB - Wiki artykuły
│   ├── index.md
│   ├── kubuntu.md
│   ├── neovim.md
│   ├── obsidian.md
│   └── wiki.md
│
├── workflow/                  # 16KB - Przepływy pracy
│   ├── git-workflow.md
│   └── workflow.md
│
└── Pliki główne (root docs/)  # Różne dokumenty
    ├── README.md
    ├── STANDARDS.md          # ⭐ WAŻNE
    ├── RESTRUCTURE-MAP.md    # Przekierowanie
    ├── ENDPOINTS.md
    ├── eww.md
    ├── graph.md
    ├── github-copilot-setup.md
    ├── neovim-guide.md
    ├── narzedzia-deweloperskie.md
    ├── vscode-extensions-recommended.md
    ├── yaml-frontmatter-spec.md
    └── (16 plików)
```

## 🎯 Problemy zidentyfikowane

### 1. **Duplikacja nazw**
- `docs/infra/infra/` - podwójna nazwa (confusion)
- `docs/infra/guide/` vs `docs/guide/` - rozproszenie

### 2. **Mieszanie typów treści**
- `docs/software/` - to narzędzia DEV, nie dokumentacja infra
- `docs/infra/site/` - artefakty buildów (HTML) w dokumentacji
- `docs/infra/dashboards/` - tylko 1 plik (za mało na folder)
- `docs/infra/reports/` - raporty REPO, nie infra

### 3. **Rozproszenie tematyczne**
- Obsidian: `docs/software/obsidian/` + `docs/archive/obsidian/`
- Guides: `docs/guide/` + `docs/infra/guide/`
- References: w wielu miejscach

### 4. **Niejasne kategorie**
- `docs/infra/areas/` - co to są "areas"? (strefy fizyczne? logiczne?)
- `docs/infra/references/` - mix różnych tematów
- Pliki w root `docs/` bez kategorii

### 5. **Build artifacts w repo**
- `docs/infra/site/*.html` - artefakty MkDocs/Jekyll?
- Powinny być w `.gitignore` lub osobnym branchu

## 📋 Propozycja nowej struktury

### Zasady reorganizacji

1. **Separacja concerns:**
   - Infrastructure = hardware + network + configuration
   - Development tools → `development/` (nie w docs!)
   - Operations = runbooks + procedures
   - Reference = specs + standards

2. **Consistency:**
   - Jedna nazwa = jedna rzecz
   - Liczba mnoga dla kolekcji (`guides/`, nie `guide/`)
   - Folder notes wszędzie

3. **Hierarchy:**
   - Max 3-4 poziomy głębokości
   - Logiczne grupowanie

### Docelowa struktura `docs/`

```
docs/
├── README.md                           # Główny index z ToC
├── STANDARDS.md                        # Globalne standardy (zachować)
│
├── getting-started/                    # 🚀 Quick start
│   ├── README.md
│   ├── installation.md                # Jak zainstalować EWW
│   ├── first-steps.md                 # Pierwsze kroki
│   └── configuration.md               # Podstawowa konfiguracja
│
├── guides/                             # 📖 Poradniki (merge: guide/ + infra/guide/)
│   ├── README.md
│   ├── user/                          # Dla użytkowników
│   ├── admin/                         # Dla adminów
│   └── developer/                     # Dla devów
│
├── reference/                          # 📚 Dokumentacja referencyjna
│   ├── README.md
│   ├── cli/                           # Komendy CLI
│   │   └── eww-commands.md
│   ├── configuration/                 # Wszystkie opcje config
│   │   ├── bashrc.md
│   │   ├── gitconfig.md
│   │   └── environment-vars.md
│   ├── specifications/                # Specyfikacje (z infra/references/)
│   │   ├── yaml-frontmatter-spec.md
│   │   ├── ENDPOINTS.md
│   │   └── EWW-MAP.md
│   └── standards/                     # Standardy (oprócz głównego)
│       └── coding-standards.md
│
├── architecture/                       # 🏗️ Architektura (z infra/architecture/)
│   ├── README.md
│   ├── overview.md                    # Przegląd systemu
│   ├── diagrams/                      # Diagramy C4, UML
│   │   └── system-context.md
│   ├── decisions/                     # ADR (Architecture Decision Records)
│   │   └── adr-001-structure.md
│   └── deep-dive/                     # Szczegółowe analizy
│       └── systems-deep-dive.md       # Z infra/architecture/
│
├── infrastructure/                     # 🖥️ GŁÓWNY katalog infra (rename: infra/)
│   ├── README.md                      # Przegląd infrastruktury
│   │
│   ├── location/                      # 📍 Lokalizacja fizyczna
│   │   ├── README.md
│   │   ├── site-overview.md           # 77C Church Lane (z location.md)
│   │   ├── layout/                    # Plany pomieszczeń
│   │   ├── power.md                   # Zasilanie
│   │   └── access.md                  # Kontrola dostępu
│   │
│   ├── hardware/                      # 🔧 Sprzęt (zachować strukturę!)
│   │   ├── README.md
│   │   ├── inventory.md               # Inwentaryzacja
│   │   ├── servers/                   # Serwery
│   │   │   ├── gerc/                  # Z hardware/gerc/
│   │   │   └── servers.md
│   │   ├── workstations/              # Stacje robocze
│   │   │   ├── asus_z77/              # Z hardware/asus_z77/
│   │   │   └── workstations.md
│   │   ├── network/                   # 🌐 SIEĆ (zachować!)
│   │   │   ├── README.md
│   │   │   ├── garynet.md             # KLUCZOWE
│   │   │   ├── topology/
│   │   │   │   ├── network-diagram.md
│   │   │   │   └── network-deployment.md
│   │   │   ├── devices/
│   │   │   │   ├── cisco-3650-catalyst-poe-24/
│   │   │   │   ├── netgear_fs108/
│   │   │   │   └── tp-link_tl-wr902ac.md
│   │   │   ├── configuration/
│   │   │   │   ├── ip-addressing.md
│   │   │   │   ├── dns.md
│   │   │   │   └── cisco-switch-port-map.md
│   │   │   └── status/
│   │   ├── peripherals/               # Urządzenia peryferyjne
│   │   │   ├── kitchen_touchscreen/
│   │   │   ├── media_tv/
│   │   │   ├── media_soundbar/
│   │   │   └── media_amplituner/
│   │   ├── mobile/                    # Urządzenia mobilne
│   │   ├── rack/                      # Szafy rack
│   │   └── laptops/                   # Laptopy
│   │
│   ├── software/                      # 💾 Zainstalowane oprogramowanie
│   │   ├── README.md
│   │   ├── operating-systems/         # OS (Kubuntu, etc.)
│   │   │   └── kubuntu.md             # Z wiki/kubuntu.md
│   │   ├── applications/              # Aplikacje
│   │   └── services/                  # Usługi systemowe
│   │
│   ├── configuration/                 # ⚙️ Konfiguracje (z infra/infra/)
│   │   ├── README.md
│   │   ├── ansible/                   # Z infra/infra/ansible/
│   │   ├── systemd/                   # Z infra/infra/systemd/
│   │   ├── hooks/                     # Z infra/infra/hooks/
│   │   └── core/                      # Z infra/infra/core/
│   │
│   ├── monitoring/                    # 📊 Monitoring
│   │   ├── README.md
│   │   ├── dashboards/                # Z infra/dashboards/
│   │   ├── metrics/
│   │   └── alerts/
│   │
│   ├── virtualization/                # 🖥️ VM (rename: vm/)
│   │   ├── README.md                  # Z infra/vm/README.md
│   │   ├── vms/                       # Poszczególne VM
│   │   └── containers/                # Kontenery (Docker, etc.)
│   │
│   └── security/                      # 🔒 Bezpieczeństwo
│       ├── README.md
│       ├── policies/                  # Polityki
│       ├── access-control/            # Kontrola dostępu
│       └── incidents/                 # Incydenty
│
├── operations/                         # 🔧 Runbooki & SOP
│   ├── README.md
│   ├── runbooks/                      # Runbooki operacyjne
│   ├── procedures/                    # Procedury (z infra/procedures/ - jeśli istnieje)
│   │   ├── maintenance/
│   │   ├── backup-restore/
│   │   ├── disaster-recovery/
│   │   └── troubleshooting/
│   └── checklists/                    # Checklisty
│
├── tutorials/                          # 🎓 Tutoriale
│   ├── README.md
│   └── (tutoriale krok-po-kroku)
│
├── troubleshooting/                    # 🔍 Rozwiązywanie problemów
│   ├── README.md
│   ├── common-issues.md
│   ├── faq.md
│   └── error-codes.md
│
├── reports/                            # 📊 Raporty REPO (z infra/reports/)
│   ├── README.md
│   ├── FULL-INDEX.md                  # Index repo
│   ├── STATUS-REPO.md                 # Status repo
│   ├── CLEANUP-LOG.md                 # Log porządków
│   └── (inne raporty)
│
├── assets/                             # 📁 Media
│   ├── images/
│   ├── diagrams/
│   └── downloads/
│
├── archive/                            # 📦 Archiwum
│   ├── README.md
│   ├── development/                   # Z archive/03_DEVELOPMENT/
│   ├── team/                          # Z archive/04_TEAM/
│   ├── ideas/                         # Z archive/Idea/
│   ├── legacy/                        # Z infra/legacy/
│   └── (reszta)
│
└── wiki/                               # 📚 Wiki wewnętrzne (Obsidian)
    ├── README.md
    ├── index.md
    ├── neovim.md
    ├── obsidian.md
    └── (artykuły)
```

### Przeniesienia do innych katalogów

**NIE w `docs/` (przenieś gdzie indziej):**

```
docs/software/ → development/tools/
  ├── code/           → development/tools/vscode/
  ├── git/            → development/tools/git/
  ├── github/         → development/tools/github/
  ├── obsidian/       → development/tools/obsidian/
  ├── habitica/       → (usuń lub archive/)
  └── vikunja/        → (usuń lub archive/)

docs/workflow/ → development/workflow/ lub core/workflow/
  ├── git-workflow.md → development/workflow/git.md

docs/infra/site/ (HTML builds) → .gitignore lub gh-pages branch
```

## 🔄 Plan migracji (4 fazy)

### Faza 1: Przygotowanie (1-2h)
1. ✅ Utworzyć branch `feat/docs-restructure`
2. ✅ Backup całego `docs/` (do `archive/backup-docs-YYYYMMDD/`)
3. ✅ Utworzyć `docs/MIGRATION-LOG.md` (śledzenie zmian)
4. ✅ Zaktualizować `.gitignore` (wykluczyć HTML builds)

### Faza 2: Rename głównych katalogów (2-3h)
1. `docs/infra/` → `docs/infrastructure/`
2. `docs/guide/` → `docs/guides/`
3. `docs/infra/vm/` → `docs/infrastructure/virtualization/`
4. Utworzyć nowe foldery:
   - `docs/getting-started/`
   - `docs/reference/`
   - `docs/operations/`
   - `docs/tutorials/`
   - `docs/troubleshooting/`

### Faza 3: Reorganizacja wewnętrzna (4-6h)
1. **Infrastructure:**
   - `infra/infra/` → `infrastructure/configuration/`
   - `infra/architecture/` → `docs/architecture/`
   - `infra/references/` → rozdzielić do `reference/specifications/`
   - `infra/reports/` → `docs/reports/`
   - `infra/dashboards/` → `infrastructure/monitoring/dashboards/`
   - `infra/areas/` → przeanalizować i przypisać do `infrastructure/location/` lub `hardware/`
   - `infra/legacy/` → `archive/legacy/`
   - `infra/site/` → usunąć lub przenieść do `.gitignore`

2. **Software → Development:**
   - `docs/software/` → `development/tools/`
   - Merge `docs/archive/obsidian/` + `docs/software/obsidian/` → `development/tools/obsidian/`

3. **Guides & Workflow:**
   - Merge `docs/guide/` + `docs/infra/guide/` → `docs/guides/`
   - `docs/workflow/` → `development/workflow/` lub `core/workflow/`

4. **Archive consolidation:**
   - `docs/archive/` uporządkować podkatalogi
   - `docs/infra/legacy/` → `docs/archive/legacy-docs/`

### Faza 4: Finalizacja (2-3h)
1. Utworzyć/zaktualizować README.md w każdym folderze
2. Zaktualizować wszystkie linki wewnętrzne (grep + sed)
3. Zaktualizować frontmatter (`modified`, `tags`)
4. Uruchomić `make check-versions`, `make index`
5. Commit + PR + review

## 📊 Mapowanie szczegółowe (plik → plik)

### Location & Site
| Źródło | Docelowe |
|--------|----------|
| `docs/infra/areas/workshop/location.md` | `docs/infrastructure/location/site-overview.md` |
| `docs/infra/areas/` | `docs/infrastructure/location/zones/` (lub usunąć) |

### Hardware
| Źródło | Docelowe |
|--------|----------|
| `docs/infra/hardware/*` | `docs/infrastructure/hardware/*` (zachować strukturę!) |
| `docs/infra/hardware/network/garynet.md` | `docs/infrastructure/hardware/network/garynet.md` ⭐ |

### Configuration
| Źródło | Docelowe |
|--------|----------|
| `docs/infra/infra/ansible/` | `docs/infrastructure/configuration/ansible/` |
| `docs/infra/infra/systemd/` | `docs/infrastructure/configuration/systemd/` |
| `docs/infra/infra/hooks/` | `docs/infrastructure/configuration/hooks/` |
| `docs/infra/infra/core/` | `docs/infrastructure/configuration/core/` |

### References & Specs
| Źródło | Docelowe |
|--------|----------|
| `docs/yaml-frontmatter-spec.md` | `docs/reference/specifications/yaml-frontmatter-spec.md` |
| `docs/ENDPOINTS.md` | `docs/reference/specifications/ENDPOINTS.md` |
| `docs/infra/references/EWW-MAP.md` | `docs/reference/specifications/EWW-MAP.md` |
| `docs/infra/references/SSH-REMOTE-GUIDE.md` | `docs/guides/admin/ssh-remote-guide.md` |

### Reports
| Źródło | Docelowe |
|--------|----------|
| `docs/infra/reports/*` | `docs/reports/*` (całość) |

### Archive
| Źródło | Docelowe |
|--------|----------|
| `docs/infra/legacy/*` | `docs/archive/legacy-docs/*` |
| `docs/archive/*` | `docs/archive/*` (uporządkować podkatalogi) |

### Software → Development
| Źródło | Docelowe |
|--------|----------|
| `docs/software/code/` | `development/tools/vscode/` |
| `docs/software/obsidian/` | `development/tools/obsidian/` |
| `docs/software/git/` | `development/tools/git/` |
| `docs/software/github/` | `development/tools/github/` |

### Do usunięcia / .gitignore
| Źródło | Akcja |
|--------|-------|
| `docs/infra/site/*.html` | Dodać do `.gitignore` lub usunąć |
| `docs/infra/site/sitemap.xml` | Artefakt buildu - usunąć |

## ✅ Checklist działań

- [ ] Utworzyć branch `feat/docs-restructure`
- [ ] Backup `docs/` → `archive/backup-docs-20251203/`
- [ ] Utworzyć `docs/MIGRATION-LOG.md`
- [ ] Zaktualizować `.gitignore` (HTML builds)
- [ ] Rename `docs/infra/` → `docs/infrastructure/`
- [ ] Utworzyć nowe foldery główne
- [ ] Przenieść pliki wg tabeli mapowania
- [ ] Utworzyć README.md w każdym nowym folderze
- [ ] Zaktualizować linki wewnętrzne (grep + replace)
- [ ] Zaktualizować frontmatter (daty, tagi)
- [ ] Usunąć puste foldery
- [ ] Sprawdzić duplikaty
- [ ] `make index`
- [ ] `make check-versions`
- [ ] Commit + PR
- [ ] Review + merge
- [ ] Aktualizować `docs/RESTRUCTURE-MAP.md`

## 🎯 Korzyści z reorganizacji

1. **Jasna struktura** - zgodna z globalnymi standardami (Diátaxis, Docs-as-Code)
2. **Łatwiejsza nawigacja** - logiczne grupowanie, max 3-4 poziomy
3. **Separacja concerns** - infra ≠ development tools
4. **Skalowalność** - łatwo dodawać nowe dokumenty
5. **Zgodność z RESTRUCTURE-MAP** - spójność z planem globalnym
6. **Lepsze SEO/indexing** - jeśli kiedyś zrobimy MkDocs/Docusaurus

## 📚 Standardy zastosowane

1. **Diátaxis Framework** (documentation.divio.com):
   - Tutorials (learning-oriented)
   - How-to Guides (problem-oriented)
   - Reference (information-oriented)
   - Explanation (understanding-oriented)

2. **Documentation as Code:**
   - Markdown jako format główny
   - Git do wersjonowania
   - Struktura folderów = struktura nawigacji

3. **ITIL/DevOps hybrid:**
   - `infrastructure/` dla zasobów IT
   - `operations/` dla procesów operacyjnych
   - `architecture/` dla decyzji architektonicznych

4. **Google Developer Documentation Style Guide:**
   - Liczba mnoga dla kolekcji
   - README.md w każdym folderze
   - Jasne nazewnictwo (bez skrótów)

## 🔗 Powiązania

- [[governance/RESTRUCTURE-MAP]] - Globalny plan reorganizacji
- [[STANDARDS]] - Standardy projektu EWW
- [[docs/governance/PLAN-PORZADKOWANIA]] - Plan porządkowania
- [[docs/infra/reports/CLEANUP-LOG]] - Log porządków

## 🔗 Backlinks

- [[docs/docs]]
- [[docs/infra/infra]]
- [[governance/RESTRUCTURE-MAP]]
- [[INDEX]]
