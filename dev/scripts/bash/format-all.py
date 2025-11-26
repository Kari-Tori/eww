#!/usr/bin/env python3
"""
Masowe formatowanie plików Markdown - dodanie frontmatter
"""
import os
import re
from datetime import datetime
from pathlib import Path

EWW_ROOT = Path('/home/jakubc/git/eww')

# Katalogi do pominięcia
SKIP_DIRS = {'.git', 'archive', '.obsidian', '.vscode', 'node_modules', 
             '.space', '.vale', '.continue', '.githooks', 'imported-vault',
             '.stfolder', '.makemd'}

def get_category(filepath):
    """Określ kategorię na podstawie ścieżki"""
    path_str = str(filepath)
    if '/business/' in path_str:
        return 'business', ['business', 'operacje', 'finanse']
    elif '/dev/' in path_str:
        return 'development', ['development', 'code', 'infrastructure']
    elif '/docs/' in path_str:
        return 'documentation', ['docs', 'knowledge', 'wiki']
    elif '/usr/' in path_str:
        return 'personal', ['personal', 'workspace', 'notes']
    elif '/core/' in path_str:
        return 'core', ['system', 'config', 'core']
    else:
        return 'general', ['general', 'eww']

def add_frontmatter(filepath):
    """Dodaj frontmatter do pliku"""
    try:
        # Sprawdź czy już ma frontmatter
        with open(filepath, 'r', encoding='utf-8') as f:
            first_line = f.readline().strip()
            if first_line == '---':
                return False  # Już ma frontmatter
        
        # Wczytaj treść
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Generuj frontmatter
        filename = filepath.stem
        category, tags = get_category(filepath)
        
        # Dodaj specjalne tagi
        if 'Dashboard' in filename or 'dashboard' in filename:
            tags.append('dashboard')
        if 'SOP' in filename or 'sop' in filename:
            tags.append('sop')
        if 'README' in filename or 'INDEX' in filename:
            tags.append('index')
        
        # Ogranicz do 7 tagów
        tags = tags[:7]
        
        # Formatuj tagi
        tags_yaml = '\n'.join(f'  - {tag}' for tag in tags)
        
        frontmatter = f"""---
title: "{filename.replace('_', ' ')}"
category: {category}
tags:
{tags_yaml}
created: {datetime.now().strftime('%Y-%m-%d')}
updated: {datetime.now().strftime('%Y-%m-%d')}
author: EWW Team
cssclasses:
  - eww-doc
---

"""
        
        # Zapisz z frontmatter
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(frontmatter)
            f.write(content)
        
        return True
    
    except Exception as e:
        print(f"  ❌ Błąd: {filepath}: {e}")
        return False

def main():
    print("🚀 Formatowanie plików Markdown...")
    print(f"📁 Katalog: {EWW_ROOT}")
    print()
    
    updated = 0
    skipped = 0
    errors = 0
    
    for root, dirs, files in os.walk(EWW_ROOT):
        # Usuń pomijane katalogi
        dirs[:] = [d for d in dirs if d not in SKIP_DIRS]
        
        for filename in files:
            if not filename.endswith('.md'):
                continue
            
            filepath = Path(root) / filename
            relpath = filepath.relative_to(EWW_ROOT)
            
            result = add_frontmatter(filepath)
            
            if result:
                print(f"  ✨ {relpath}")
                updated += 1
                
                if updated % 20 == 0:
                    print(f"     📊 Progress: {updated} zaktualizowano")
            elif result is False:
                skipped += 1
            else:
                errors += 1
    
    print()
    print("✅ Zakończono:")
    print(f"   • Zaktualizowano: {updated}")
    print(f"   • Pominięto:      {skipped} (już mają frontmatter)")
    print(f"   • Błędy:          {errors}")

if __name__ == '__main__':
    main()
