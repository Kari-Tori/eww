#!/usr/bin/env bash
# Tworzy mini-grafy tematyczne dla różnych sekcji repo
set -euo pipefail

VAULT="/home/jakubc/git/eww"

# 1. Graf główny (root + główne foldery)
cat > "$VAULT/GRAPH-MAP.md" << 'EOF'
---
tags: [graph, visualization, index, structure, system]
type: graph-map
icon: 🗺️
---
# 🗺️ Mapa Grafowa Repozytorium

## 📊 Główne Sekcje
- [[INDEX]] - Indeks główny
- [[business/business]] - Logika biznesowa
- [[core/core]] - Rdzeń systemu
- [[usr/usr]] - Profile użytkowników
- [[docs/docs]] - Dokumentacja
- [[infra/infra]] - Infrastruktura
- [[config/config]] - Konfiguracje
- [[scripts/scripts]] - Skrypty

## 🎨 Wizualizacje Tematyczne
- [[GRAPH-BUSINESS]] - Graf logiki biznesowej
- [[GRAPH-CORE]] - Graf komponentów core
- [[GRAPH-USERS]] - Graf użytkowników
- [[GRAPH-DOCS]] - Graf dokumentacji
- [[GRAPH-INFRA]] - Graf infrastruktury

---
**Użycie**: Każdy pod-graf ma max 20-30 linków = szybki rendering
EOF

# 2. Graf business
cat > "$VAULT/GRAPH-BUSINESS.md" << 'EOF'
---
tags: [graph, business, visualization]
type: mini-graph
icon: 💼
---
# 💼 Graf Logiki Biznesowej

## 📁 Struktura Business
EOF
find "$VAULT/business" -name "*.md" -type f | head -20 | while read -r file; do
    name="${file#$VAULT/}"
    name="${name%.md}"
    echo "- [[$name]]" >> "$VAULT/GRAPH-BUSINESS.md"
done

# 3. Graf core
cat > "$VAULT/GRAPH-CORE.md" << 'EOF'
---
tags: [graph, core, system, visualization]
type: mini-graph
icon: ⚙️
---
# ⚙️ Graf Komponentów Core

## 📁 Struktura Core
EOF
find "$VAULT/core" -name "*.md" -type f | head -20 | while read -r file; do
    name="${file#$VAULT/}"
    name="${name%.md}"
    echo "- [[$name]]" >> "$VAULT/GRAPH-CORE.md"
done

# 4. Graf users
cat > "$VAULT/GRAPH-USERS.md" << 'EOF'
---
tags: [graph, users, profiles, visualization]
type: mini-graph
icon: 👥
---
# 👥 Graf Użytkowników

## 🧑 Profile
- [[usr/jakubc/jakubc]] - Jakub C
- [[usr/karinam/karinam]] - Karina M

## 📝 Notatki Użytkowników
EOF
find "$VAULT/usr" -name "*.md" -type f | head -20 | while read -r file; do
    name="${file#$VAULT/}"
    name="${name%.md}"
    echo "- [[$name]]" >> "$VAULT/GRAPH-USERS.md"
done

echo "✅ Utworzono mini-grafy tematyczne"
