---
created: 2025-11-21
modified: 2025-11-25
version: 0.0.4
tags:
  - #folder_note
  - #infrastructure
title: "infra"
---

# infra

Notatka folderu dla `docs/infra` - dokumentacja infrastruktury E-Waste Workshop.

## 📁 Podfoldery

- [[architecture]] - Architektura systemowa i decyzje architektoniczne
- [[configuration]] - Konfiguracje (ansible, systemd, hooks, core, examples)
- [[guide]] - Przewodniki infrastrukturalne (11 plików)
- [[hardware]] - Sprzęt fizyczny (servers, workstations, network, peripherals)
- [[location]] - Lokalizacja fizyczna 77C Church Lane (zones: devices, network, workshop)
- [[monitoring]] - Monitoring i dashboardy
- [[tags]] - Legacy symlink do dev/obsidian/tags/
- [[virtualization]] - Maszyny wirtualne i konteneryzacja

## 📄 Pliki w tym folderze

- [[RESTRUCTURE-MAP]] - Mapa migracji struktury katalogów
- [[status_sieci]] - Status sieci (legacy)

## 📦 Przeniesione (2025-12-03)

- `reports/` → `docs/reports/` (raporty repo, nie infra)
- `site/` → usunięto (build artifacts, dodano do .gitignore)
- `dashboards/` → `monitoring/dashboards/`
- `vm/` → `virtualization/`
- `legacy/` → `docs/archive/legacy-infra-docs/`
- `references/` → rozdzielono:
  - Specyfikacje → `docs/reference/specifications/`
  - Przewodniki → `guide/`
  - Przykłady → `configuration/examples/`
- `areas/` → `location/zones/`
- `location.md` → `location/site-overview.md`

## 🔗 Backlinki

- [[docs]]