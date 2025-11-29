# Changelog

## [2025-11-23] - Major Cleanup & Auto-Reports

### Added
- ✅ **Auto-Reports System**: `core/reports/repo-stats.md` z auto-update co 5 min
- ✅ **Cron setup**: `make setup-stats-cron` dla automatycznych aktualizacji
- ✅ **Folder_note system**: Każdy folder ma `folder_name.md` z `folder_stats`
- ✅ **Folder colors**: RGB system dla 9 głównych folderów
- ✅ **Documentation**:
  - `docs/AUTO-REPORTS.md` - System auto-raportów
  - `docs/FOLDER-NOTE-SYSTEM.md` - System folder notes
  - `docs/FOLDER-COLOR-SYSTEM.md` - Kolory folderów
  - `docs/CLEANUP-LOG.md` - Historia cleanups

### Changed
- 📍 **Moved**: `eww-stats.md` → `core/reports/repo-stats.md` (symlink w root)
- 🎨 **Graph optimization**: 7,505 nodes → 137 nodes (98.2% redukcja)
- 📊 **Stats format**: Kompaktowy + auto-update metadata

### Removed
- 🗑️ **Obsidian docs**: Usunięto 6,587 plików (~86MB)
  - `docs/infra/software/obsidian/official-en/` (164 pliki)
  - `docs/infra/software/obsidian/official-pl/` (164 pliki)
  - `docs/infra/software/obsidian/resources/` (6,259 plików)
- 🗑️ **Old files**: eww-stats-full.md

### Fixed
- 🐛 **Graph performance**: Z >30s do <2s ładowania
- 🐛 **Color groups**: Z 13 do 5 (optymalne)

## Stats

- **Before**: 7,512 plików .md
- **After**: 930 plików .md
- **Reduction**: 87.7% (-6,582 pliki)
- **Space saved**: ~86MB

---

**Auto-maintained** | See [core/reports/repo-stats.md](core/reports/repo-stats.md) for live stats
