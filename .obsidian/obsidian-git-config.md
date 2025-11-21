# 🔧 Konfiguracja Obsidian Git

## Settings → Obsidian Git

### ⏰ Auto-backup
- **Vault backup interval**: `10` min
- **Auto pull interval**: `10` min  
- **Auto pull on startup**: ✅ ON
- **Disable push**: ❌ OFF
- **Pull updates on startup**: ✅ ON

### 📝 Commit message
- **Commit message**: `vault backup: {{date}} {{time}}`
- **{{date}} format**: `YYYY-MM-DD`
- **{{time}} format**: `HH:mm:ss`

### 🎯 Advanced
- **Disable notifications**: ❌ (chcesz widzieć)
- **Show status bar**: ✅ ON
- **Line author**: ✅ ON (git blame w edytorze!)
- **Diff view on mobile**: ✅ ON

### 🚀 Hotkeys (Community Plugins)
- `Ctrl+G C` - Commit
- `Ctrl+G P` - Push
- `Ctrl+G U` - Pull
- `Ctrl+G S` - Source control view

## 🎯 Workflow
1. Edytujesz notki w Obsidian
2. Co 10 min auto-commit + push
3. Historia w Git (CLI lub GitHub)
4. Sync między maszynami automatyczny!

## ⚡ Bonus: Git w Obsidian
- Right-click plik → **File history** (git log!)
- Source control panel (Ctrl+G S)
- Diff view inline
- Blame annotations
