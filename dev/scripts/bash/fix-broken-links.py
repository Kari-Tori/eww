#!/usr/bin/env python3
"""
Naprawia broken links - usuwa lub tworzy pliki
"""
import os, re
from pathlib import Path
from datetime import datetime

SKIP = {'.git', '.github', '.obsidian', '.vscode', '.continue', 'archive', 'node_modules'}

def find_broken_links():
    all_files = set()
    for root, dirs, _ in os.walk('.'):
        dirs[:] = [d for d in dirs if d not in SKIP and not d.startswith('.')]
        for f in os.listdir(root):
            if f.endswith('.md'):
                p = os.path.join(root, f)[2:]
                all_files.add(p)
                all_files.add(p[:-3])
                all_files.add(os.path.basename(p)[:-3])
    
    broken = {}
    for root, dirs, _ in os.walk('.'):
        dirs[:] = [d for d in dirs if d not in SKIP and not d.startswith('.')]
        for fname in os.listdir(root):
            if not fname.endswith('.md'): continue
            filepath = os.path.join(root, fname)[2:]
            try:
                content = open(filepath, encoding='utf-8').read()
                links = re.findall(r'\[\[([^\]|]+)(?:\|[^\]]+)?\]\]', content)
                for link in links:
                    # Skip images, attachments, anchors
                    if any(x in link.lower() for x in ['img/', 'attachments/', '.jpg', '.png', '.pdf', '#^']):
                        continue
                    
                    exists = any(v in all_files for v in [link, link + '.md', os.path.basename(link)])
                    
                    if not exists:
                        if filepath not in broken: broken[filepath] = {}
                        broken[filepath][link] = broken[filepath].get(link, 0) + 1
            except: pass
    
    return broken

def should_create(link, count):
    """Czy stworzyć plik zamiast usuwać link?"""
    # Twórz jeśli często używany
    if count >= 5: return True
    
    # Twórz jeśli wygląda na ważny
    important = ['dashboard', 'index', 'readme', 'sop', 'template']
    if any(x in link.lower() for x in important): return True
    
    return False

def create_placeholder(link):
    """Stwórz placeholder file"""
    # Określ ścieżkę
    if '/' in link:
        filepath = link if link.endswith('.md') else link + '.md'
    else:
        # Umieść w docs/placeholders/
        os.makedirs('docs/placeholders', exist_ok=True)
        filepath = f"docs/placeholders/{link}.md"
    
    # Stwórz directory jeśli trzeba
    os.makedirs(os.path.dirname(filepath) if '/' in filepath else '.', exist_ok=True)
    
    # Treść
    content = f"""---
title: "{link}"
description: "Placeholder - do uzupełnienia"
category: placeholder
tags:
  - placeholder
  - todo
created: {datetime.now().strftime('%Y-%m-%d')}
author: EWW Team
---

# {link}

> **⚠️ PLACEHOLDER** - Ten plik wymaga uzupełnienia

## TODO

- [ ] Dodaj właściwą treść
- [ ] Zaktualizuj frontmatter
- [ ] Dodaj powiązania

---

**Status:** Placeholder (auto-created)  
**Created:** {datetime.now().strftime('%Y-%m-%d %H:%M')}
"""
    
    try:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        return True
    except:
        return False

def remove_link_from_file(filepath, link):
    """Usuń link z pliku"""
    try:
        content = open(filepath, encoding='utf-8').read()
        
        # Pattern dla tego linku
        patterns = [
            rf'\[\[{re.escape(link)}\]\]',
            rf'\[\[{re.escape(link)}\|[^\]]+\]\]',
            rf'- \[\[{re.escape(link)}(?:\|[^\]]+)?\]\]\n',
        ]
        
        for pattern in patterns:
            content = re.sub(pattern, '', content)
        
        # Usuń puste linie
        content = re.sub(r'\n\n\n+', '\n\n', content)
        
        open(filepath, 'w', encoding='utf-8').write(content)
        return True
    except:
        return False

# Main
print("🔧 Naprawiam broken links...\n")
broken = find_broken_links()

created = 0
removed = 0
skipped = 0

# Zbierz statystyki wszystkich linków
all_broken_links = {}
for filepath, links in broken.items():
    for link, count in links.items():
        all_broken_links[link] = all_broken_links.get(link, 0) + count

print(f"Znaleziono {len(all_broken_links)} unique broken links\n")
print("🔨 Akcje:\n")

# Najpierw stwórz często używane
for link, total_count in sorted(all_broken_links.items(), key=lambda x: x[1], reverse=True)[:20]:
    if should_create(link, total_count):
        if create_placeholder(link):
            print(f"  ✅ Utworzono: {link} (używany {total_count}x)")
            created += 1

# Teraz usuń pozostałe
print("\n📝 Usuwam rzadkie broken links...\n")
for filepath, links in list(broken.items())[:100]:
    for link in links.keys():
        if link not in all_broken_links or all_broken_links[link] < 5:
            if remove_link_from_file(filepath, link):
                removed += 1

print(f"\n✅ Zakończono!\n")
print(f"📊 Statystyki:")
print(f"   • Utworzonych placeholders: {created}")
print(f"   • Usuniętych linków: {removed}")
print(f"   • Pozostałych: {len(all_broken_links) - created}")

