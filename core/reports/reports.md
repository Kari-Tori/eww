---
tags:
  - #folder_note
  - #reports
  - #core
  - #automation
folder_color: 65331
folder_stats:
  md_files: 2
  total_files: 2
  subdirs: 0
created: 2025-11-23T01:58:00Z
modified: 2025-11-23T01:58:00Z
author: jakubc
title: "Reports - Auto-generowane raporty systemowe"
owner: jakubc
---

# Reports - Auto-generowane raporty

> Folder zawiera raporty generowane automatycznie przez skrypty i cron

## 📊 Dostępne raporty

### repo-stats.md ⚡ AUTO-UPDATE CO 5 MIN

**Lokalizacja**: `core/reports/repo-stats.md`  
**Symlink**: `/eww-stats.md` → `core/reports/repo-stats.md`  
**Update**: Automatycznie co 5 minut przez cron  
**Źródło**: `scripts/generate-stats.sh`

**Zawartość**:
- Ogólne statystyki (pliki .md, .sh, katalogi)
- Top foldery (docs, usr, core, dev)
- Graph View stats
- Cleanup history

## 🔄 Auto-update przez Cron

### Konfiguracja

```bash
make setup-stats-cron    # Dodaj cron job (co 5 min)
make show-stats-cron     # Pokaż aktualny cron
```

### Cron job

```cron
*/5 * * * * cd /home/jakubc/git/eww && bash scripts/generate-stats.sh >/dev/null 2>&1
```

**Efekt**: repo-stats.md jest zawsze świeży (max 5 min opóźnienia)

## 🛠️ Ręczna aktualizacja

```bash
make stats               # Wygeneruj natychmiast
bash scripts/generate-stats.sh
```

## 📁 Struktura

```
core/reports/
├── reports.md           # Ten plik (folder_note)
└── repo-stats.md        # Statystyki repo (⚡ auto-update)
```

## 🔗 Dostęp

Z każdego miejsca w repo:
```markdown
[[repo-stats]]           # Link Obsidian
[[core/reports/repo-stats]]
```

Z root:
```bash
cat eww-stats.md         # Symlink → core/reports/repo-stats.md
```

## 📊 Statystyki w YAML

```yaml
auto_update: true
update_interval: 5min
modified: 2025-11-23T01:58:00Z  # Aktualizowane co 5 min
```

## 🎯 Dlaczego core/reports/?

1. **Logiczne miejsce**: Core = systemowe funkcje
2. **Organizacja**: Wszystkie raporty w jednym miejscu
3. **Auto-maintenance**: Folder_note + auto-update
4. **Folder_stats**: Zgodne z systemem EWW
5. **Backwards compatible**: Symlink w root

## 🚀 Przyszłe raporty

Planowane do dodania:
- `graph-performance.md` - Wydajność grafu (co 30 min)
- `git-activity.md` - Aktywność commitów (daily)
- `folder-sizes.md` - Rozmiary folderów (hourly)
- `health-check.md` - Status systemu (co 15 min)

---

**Auto-maintained** | Folder color: 🔵 Blue (RGB 65331)
