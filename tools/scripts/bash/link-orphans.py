#!/usr/bin/env python3
"""
Automatycznie łączy orphany z odpowiednimi plikami
"""
import os
import re
from pathlib import Path
from datetime import datetime

EWW_ROOT = Path.cwd()

SKIP_DIRS = {
    '.git', '.github', '.githooks', '.obsidian', '.vscode', 
    '.continue', '.vale', '.space', '.makemd', 'archive', 
    'node_modules', 'plugins', 'themes', 'icons', 'snippets'
}

def extract_wikilinks(content):
    pattern = r'\[\[([^\]|]+)(?:\|[^\]]+)?\]\]'
    return set(re.findall(pattern, content))

def find_orphans_detailed():
    """Znajdź orphans z detalami"""
    all_files = {}
    file_links = {}
    backlinks = {}
    
    for root, dirs, files in os.walk(EWW_ROOT):
        dirs[:] = [d for d in dirs if d not in SKIP_DIRS and not d.startswith('.')]
        for file in files:
            if file.endswith('.md'):
                filepath = Path(root) / file
                rel_path = str(filepath.relative_to(EWW_ROOT))
                all_files[rel_path] = filepath
                file_links[rel_path] = set()
                backlinks[rel_path] = set()
    
    # Skanuj linki
    for rel_path, filepath in all_files.items():
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            links = extract_wikilinks(content)
            for link in links:
                for target in all_files.keys():
                    if link in target or Path(target).stem == link:
                        file_links[rel_path].add(target)
                        backlinks[target].add(rel_path)
        except:
            continue
    
    orphans = [p for p in all_files.keys() 
               if not file_links[p] and not backlinks[p]]
    
    return orphans, all_files

def suggest_links_smart(orphan_path):
    """Zasugeruj inteligentne linki"""
    links = []
    orphan = Path(orphan_path)
    
    # 1. Folder note w tym samym folderze
    folder_note = orphan.parent / f"{orphan.parent.name}.md"
    if folder_note.exists():
        links.append(str(folder_note.relative_to(EWW_ROOT)))
    
    # 2. INDEX w parent folderze
    parent_index = orphan.parent / "INDEX.md"
    if parent_index.exists():
        links.append(str(parent_index.relative_to(EWW_ROOT)))
    
    # 3. Parent folder note
    if orphan.parent != EWW_ROOT:
        parent_folder = orphan.parent.parent / f"{orphan.parent.parent.name}.md"
        if parent_folder.exists():
            links.append(str(parent_folder.relative_to(EWW_ROOT)))
    
    # 4. Hub na podstawie kategorii
    path_str = orphan_path.lower()
    if 'business' in path_str or 'biznes' in path_str:
        links.append('business/business.md')
    elif 'dev' in path_str:
        links.append('dev/INDEX.md')
    elif 'usr' in path_str:
        # Sprawdź user folder
        parts = orphan.parts
        if len(parts) >= 2 and parts[0] == 'usr':
            user_index = Path('usr') / parts[1] / f"{parts[1]}.md"
            if user_index.exists():
                links.append(str(user_index))
    
    # 5. Główny INDEX
    links.append('docs/INDEX.md')
    
    return list(dict.fromkeys(links))[:3]  # Unikalne, max 3

def add_links_to_orphan(filepath, suggested_links):
    """Dodaj sekcję z linkami do orphana"""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
    except:
        return False
    
    # Usuń starą sekcję "Powiązane" jeśli jest
    content = re.sub(r'\n## 🔗 Powiązane dokumenty.*?(?=\n## |\Z)', '', content, flags=re.DOTALL)
    
    # Dodaj nową sekcję
    new_section = "\n\n## 🔗 Powiązane dokumenty\n\n"
    new_section += "*Ten dokument jest częścią:*\n\n"
    
    for link in suggested_links:
        link_name = Path(link).stem
        link_path = link[:-3] if link.endswith('.md') else link
        new_section += f"- [[{link_path}|{link_name}]]\n"
    
    new_section += f"\n---\n\n"
    new_section += f"**Status:** Orphan (automatycznie połączony)  \n"
    new_section += f"**Połączono:** {datetime.now().strftime('%Y-%m-%d %H:%M')}  \n"
    
    # Dodaj na końcu
    if not content.rstrip().endswith('---'):
        content = content.rstrip() + "\n\n---\n"
    
    content = content.rstrip()[:-3].rstrip() + new_section
    
    # Zapisz
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    
    return True

# Main
print("╔════════════════════════════════════════════════════════════════╗")
print("║                                                                ║")
print("║        🔗 ŁĄCZENIE POJEDYNCZYCH PLIKÓW (ORPHANS)               ║")
print("║                                                                ║")
print("╚════════════════════════════════════════════════════════════════╝")
print()

print("🔍 Szukam orphans...")
orphans, all_files = find_orphans_detailed()

print(f"   Znaleziono: {len(orphans)} orphans\n")

if len(orphans) == 0:
    print("✅ Brak orphans - wszystkie pliki połączone!\n")
    exit(0)

print("🔗 Łączę orphans...\n")

linked = 0
for orphan in orphans[:200]:  # Max 200
    suggested = suggest_links_smart(orphan)
    
    if suggested:
        filepath = EWW_ROOT / orphan
        if add_links_to_orphan(filepath, suggested):
            print(f"  ✅ {orphan}")
            print(f"     → {', '.join([Path(s).stem for s in suggested])}")
            linked += 1

print(f"\n✅ Zakończono!\n")
print(f"📊 Statystyki:")
print(f"   • Połączonych: {linked}")
print(f"   • Pozostałych: {len(orphans) - linked}")
print(f"   • Pokrycie: {((len(all_files) - len(orphans) + linked) / len(all_files) * 100):.1f}%\n")

