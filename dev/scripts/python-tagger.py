#!/usr/bin/env python3
"""
AI Tagger - Automatyczne tagowanie plików MD
"""
import os
import re
from pathlib import Path
from collections import Counter

REPO = Path("/home/jakubc/git/eww")
TAGS_FILE = REPO / "var" / "all-tags.txt"

# Mapa tagów na podstawie kontekstu
TAG_RULES = {
    # User
    "jakubc": lambda f, c: "/usr/jakubc" in str(f),
    "karinam": lambda f, c: "/usr/karinam" in str(f),
    
    # Kategoria
    "core": lambda f, c: "/core" in str(f),
    "business": lambda f, c: "/business" in str(f),
    "config": lambda f, c: "/config" in str(f),
    "docs": lambda f, c: "/docs" in str(f),
    "infra": lambda f, c: "/infra" in str(f),
    "scripts": lambda f, c: "/scripts" in str(f),
    "tools": lambda f, c: "/tools" in str(f),
    
    # Projekt
    "star-wars": lambda f, c: bool(re.search(r"star.wars|anakin|vader", c, re.I)),
    "recycling": lambda f, c: bool(re.search(r"recycl|recykling", c, re.I)),
    "lego": lambda f, c: bool(re.search(r"lego|klocki", c, re.I)),
    "avocado": lambda f, c: bool(re.search(r"avocado|awokado", c, re.I)),
    
    # Typ
    "setup": lambda f, c: bool(re.search(r"setup|install|konfigur", c, re.I)),
    "guide": lambda f, c: bool(re.search(r"guide|tutorial|how.to", c, re.I)),
    "script": lambda f, c: bool(re.search(r"script|bash|#!/", c, re.I)),
    "index": lambda f, c: f.stem in ["index", "INDEX"],
    
    # Tech
    "docker": lambda f, c: bool(re.search(r"docker|container", c, re.I)),
    "git": lambda f, c: bool(re.search(r"git|github|commit", c, re.I)),
    "obsidian": lambda f, c: bool(re.search(r"obsidian|vault|graph", c, re.I)),
    "python": lambda f, c: bool(re.search(r"python|\.py", c, re.I)),
    "bash": lambda f, c: bool(re.search(r"bash|shell", c, re.I)),
}

def generate_tags(file_path):
    """Generuj 7 tagów dla pliku"""
    try:
        content = file_path.read_text(encoding='utf-8')[:2000].lower()
    except:
        content = ""
    
    tags = []
    
    # Zastosuj reguły
    for tag, rule in TAG_RULES.items():
        if rule(file_path, content):
            tags.append(f"#{tag}")
            if len(tags) >= 7:
                break
    
    # Zawsze dodaj #eww jeśli mało tagów
    if len(tags) < 7 and "#eww" not in tags:
        tags.append("#eww")
    
    # Wypełnij do 7
    while len(tags) < 7:
        tags.append("#general")
    
    return tags[:7]

def strip_old_tags(content):
    """Usuń stare tagi z frontmatter"""
    lines = content.split('\n')
    
    if not lines or lines[0] != '---':
        return content
    
    # Znajdź drugi ---
    try:
        end_fm = lines[1:].index('---') + 1
    except ValueError:
        return content
    
    # Usuń sekcję tags
    new_lines = [lines[0]]  # pierwsz ---
    i = 1
    skip_tags = False
    
    while i <= end_fm:
        line = lines[i]
        
        if line.startswith('tags:'):
            skip_tags = True
            i += 1
            continue
        
        if skip_tags and line.startswith('  -'):
            i += 1
            continue
        
        if skip_tags and not line.startswith(' '):
            skip_tags = False
        
        new_lines.append(line)
        i += 1
    
    # Reszta pliku
    new_lines.extend(lines[end_fm+1:])
    
    return '\n'.join(new_lines)

def add_tags(content, tags):
    """Dodaj tagi do frontmatter"""
    lines = content.split('\n')
    
    # Bez frontmatter - stwórz
    if not lines or lines[0] != '---':
        fm = ['---', 'tags:'] + [f'  - {tag}' for tag in tags] + ['---', '']
        return '\n'.join(fm + lines)
    
    # Z frontmatter - wstaw tagi
    try:
        end_fm = lines[1:].index('---') + 1
    except ValueError:
        end_fm = 1
    
    new_content = [
        lines[0],  # ---
        'tags:'
    ] + [f'  - {tag}' for tag in tags] + lines[1:end_fm+1] + lines[end_fm+1:]
    
    return '\n'.join(new_content)

def process_file(file_path):
    """Przetwórz pojedynczy plik"""
    try:
        # Czytaj
        content = file_path.read_text(encoding='utf-8')
        
        # Generuj tagi
        tags = generate_tags(file_path)
        
        # Usuń stare + dodaj nowe
        content = strip_old_tags(content)
        content = add_tags(content, tags)
        
        # Zapisz
        file_path.write_text(content, encoding='utf-8')
        
        return tags
    except Exception as e:
        print(f"ERROR: {file_path}: {e}")
        return []

def main():
    print("╔═══════════════════════════════════╗")
    print("║      PYTHON AI TAGGER v3.0        ║")
    print("╚═══════════════════════════════════╝")
    print()
    
    # Znajdź pliki
    files = list(REPO.glob("**/*.md"))
    files = [f for f in files if not any(x in str(f) for x in ['.git', 'archive', '.obsidian', 'node_modules'])]
    files.sort()
    
    total = len(files)
    print(f"📁 Znaleziono: {total} plików")
    print()
    
    # Przetwarzaj
    all_tags = []
    for i, file in enumerate(files, 1):
        tags = process_file(file)
        all_tags.extend(tags)
        
        # Progress co 20
        if i % 20 == 0:
            percent = i * 100 // total
            print(f"\r[{percent:3d}%] {i}/{total}", end='', flush=True)
    
    print(f"\r[100%] {total}/{total}")
    print()
    
    # Zapisz tagi
    REPO.joinpath("var").mkdir(exist_ok=True)
    TAGS_FILE.write_text('\n'.join(all_tags), encoding='utf-8')
    
    # Stats
    counter = Counter(all_tags)
    unique = len(counter)
    
    print("╔═══════════════════════════════════╗")
    print("║            ✓ GOTOWE!              ║")
    print("╚═══════════════════════════════════╝")
    print()
    print(f"📊 Statystyki:")
    print(f"   Plików: {total}")
    print(f"   Unikalnych tagów: {unique}")
    print()
    print(f"🏆 Top 15 tagów:")
    for i, (tag, count) in enumerate(counter.most_common(15), 1):
        print(f"   {i:2d}. {tag:20s} ({count:3d} użyć)")

if __name__ == "__main__":
    main()
