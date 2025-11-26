#!/usr/bin/env python3
"""
Dodaje backlinki i źródła do wszystkich plików MD
"""
import os
import re
from pathlib import Path
from collections import defaultdict

EWW_ROOT = Path.cwd()

# Foldery do pominięcia
SKIP_DIRS = {
    '.git', '.github', '.githooks', '.obsidian', '.vscode', 
    '.continue', '.vale', '.space', '.makemd', 'archive', 
    'node_modules', 'plugins', 'themes', 'icons', 'snippets'
}

def extract_wikilinks(content):
    """Wyciąga wszystkie wikilinki z pliku"""
    # Pattern: [[link]] lub [[link|alias]]
    pattern = r'\[\[([^\]|]+)(?:\|[^\]]+)?\]\]'
    return set(re.findall(pattern, content))

def find_all_md_files():
    """Znajdź wszystkie pliki MD"""
    md_files = {}
    
    for root, dirs, files in os.walk(EWW_ROOT):
        dirs[:] = [d for d in dirs if d not in SKIP_DIRS and not d.startswith('.')]
        
        for file in files:
            if file.endswith('.md'):
                filepath = Path(root) / file
                # Klucz to nazwa pliku bez .md
                key = file[:-3]
                md_files[key] = filepath
                
                # Dodaj też z pełną ścieżką relatywną
                rel_path = filepath.relative_to(EWW_ROOT)
                md_files[str(rel_path)[:-3]] = filepath
    
    return md_files

def build_backlinks_map(md_files):
    """Zbuduj mapę backlinków (kto linkuje do kogo)"""
    backlinks = defaultdict(set)
    outlinks = defaultdict(set)
    
    print("🔍 Skanowanie linków...")
    
    for name, filepath in md_files.items():
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Wyciągnij linki
            links = extract_wikilinks(content)
            
            for link in links:
                # Znajdź docelowy plik
                target = None
                
                # Próbuj różne kombinacje
                if link in md_files:
                    target = md_files[link]
                elif link.split('/')[-1] in md_files:
                    target = md_files[link.split('/')[-1]]
                
                if target:
                    # Backlink: target <- filepath
                    backlinks[str(target.relative_to(EWW_ROOT))].add(str(filepath.relative_to(EWW_ROOT)))
                    # Outlink: filepath -> target
                    outlinks[str(filepath.relative_to(EWW_ROOT))].add(str(target.relative_to(EWW_ROOT)))
        
        except Exception as e:
            continue
    
    return dict(backlinks), dict(outlinks)

def update_file_with_links(filepath, backlinks_list, outlinks_list):
    """Zaktualizuj plik - dodaj sekcję z backlinkami i źródłami"""
    
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
    except:
        return False
    
    # Sprawdź czy ma frontmatter
    if not content.startswith('---'):
        return False
    
    # Usuń stare sekcje backlinków/źródeł jeśli są
    content = re.sub(r'\n## 🔗 Backlinki.*?(?=\n## |\n---\n|\Z)', '', content, flags=re.DOTALL)
    content = re.sub(r'\n## 📎 Źródła.*?(?=\n## |\n---\n|\Z)', '', content, flags=re.DOTALL)
    
    # Dodaj nową sekcję przed końcową stopką
    new_section = "\n\n---\n\n"
    
    # Backlinki
    if backlinks_list:
        new_section += "## 🔗 Backlinki\n\n"
        new_section += "*Pliki linkujące do tego dokumentu:*\n\n"
        for bl in sorted(backlinks_list)[:10]:  # Max 10
            bl_name = Path(bl).stem
            new_section += f"- [[{bl[:-3]}|{bl_name}]]\n"
        
        if len(backlinks_list) > 10:
            new_section += f"\n*...i {len(backlinks_list) - 10} więcej*\n"
    
    # Źródła (outlinki)
    if outlinks_list:
        new_section += "\n## 📎 Źródła i powiązania\n\n"
        new_section += "*Dokumenty powiązane:*\n\n"
        for ol in sorted(outlinks_list)[:10]:  # Max 10
            ol_name = Path(ol).stem
            new_section += f"- [[{ol[:-3]}|{ol_name}]]\n"
        
        if len(outlinks_list) > 10:
            new_section += f"\n*...i {len(outlinks_list) - 10} więcej*\n"
    
    # Metadata w stopce
    new_section += f"\n---\n\n"
    new_section += f"**Backlinków:** {len(backlinks_list)}  \n"
    new_section += f"**Linków wychodzących:** {len(outlinks_list)}  \n"
    new_section += f"**Zaktualizowano:** {Path(filepath).stat().st_mtime}  \n"
    
    # Znajdź miejsce na wstawienie (przed końcową stopką lub na końcu)
    if content.rstrip().endswith('---'):
        # Usuń końcową stopkę i dodaj nową
        content = content.rstrip()[:-3].rstrip()
    
    content += new_section
    
    # Zapisz
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    
    return True

# Main
print("╔════════════════════════════════════════════════════════════════╗")
print("║                                                                ║")
print("║        🔗 DODAWANIE BACKLINKÓW I ŹRÓDEŁ                        ║")
print("║                                                                ║")
print("╚════════════════════════════════════════════════════════════════╝")
print()

# Znajdź wszystkie pliki
print("📁 Szukam plików MD...")
md_files = find_all_md_files()
print(f"   Znaleziono: {len(md_files)} plików\n")

# Zbuduj mapę linków
backlinks_map, outlinks_map = build_backlinks_map(md_files)
print(f"   Znaleziono {len(backlinks_map)} plików z backlinkami\n")

# Aktualizuj pliki
print("✏️  Aktualizuję pliki...\n")

updated = 0
skipped = 0

for name, filepath in list(md_files.items())[:500]:  # Max 500 pierwszych
    rel_path = str(filepath.relative_to(EWW_ROOT))
    
    backlinks_list = list(backlinks_map.get(rel_path, []))
    outlinks_list = list(outlinks_map.get(rel_path, []))
    
    if not backlinks_list and not outlinks_list:
        skipped += 1
        continue
    
    if update_file_with_links(filepath, backlinks_list, outlinks_list):
        print(f"  ✅ {rel_path} ({len(backlinks_list)} ← | {len(outlinks_list)} →)")
        updated += 1
    else:
        skipped += 1

print(f"\n✅ Zakończono!\n")
print(f"📊 Statystyki:")
print(f"   • Zaktualizowanych: {updated}")
print(f"   • Pominiętych:      {skipped}")

