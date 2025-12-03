#!/usr/bin/env python3
"""
Skrypt zapewniający, że każdy plik markdown ma conajmniej 3 backlinki.

Skrypt:
1. Skanuje wszystkie pliki .md w repozytorium
2. Sprawdza sekcję Backlinks w każdym pliku
3. Dodaje backlinki do plików, które mają mniej niż 3
4. Wykorzystuje strukturę katalogów do ustalania sensownych backlinków
"""

import os
import re
from pathlib import Path
from typing import List, Set, Tuple

# Katalog główny projektu
EWW_ROOT = Path(__file__).resolve().parent.parent.parent

# Katalogi do pominięcia
EXCLUDE_DIRS = {
    '.git', 'node_modules', '__pycache__', '.venv', 'venv',
    'archive'  # Pomijamy archiwum
}

# Minimalna liczba backlinków
MIN_BACKLINKS = 3

# Kluczowe pliki, które zawsze powinny być w backlinkach
KEY_FILES = ['INDEX', 'README', 'EWW-MAP']


def find_all_md_files() -> List[Path]:
    """Znajduje wszystkie pliki markdown w projekcie (poza wykluczeniami)."""
    md_files = []

    for root, dirs, files in os.walk(EWW_ROOT):
        # Usuń katalogi do wykluczenia z przeszukiwania
        dirs[:] = [d for d in dirs if d not in EXCLUDE_DIRS]

        for file in files:
            if file.endswith('.md'):
                md_files.append(Path(root) / file)

    return sorted(md_files)


def get_file_backlinks(file_path: Path) -> Tuple[List[str], bool]:
    """
    Pobiera listę backlinków z pliku.

    Returns:
        Tuple[List[str], bool]: (lista backlinków, czy sekcja istnieje)
    """
    try:
        content = file_path.read_text(encoding='utf-8')
    except Exception as e:
        print(f"⚠️  Nie można odczytać {file_path}: {e}")
        return [], False

    # Szukaj sekcji Backlinks
    backlinks_pattern = r'##\s+🔗\s+Backlinks?\s*\n((?:^-\s+\[\[.+?\]\]\s*\n)*)'
    match = re.search(backlinks_pattern, content, re.MULTILINE)

    if not match:
        return [], False

    # Wyciągnij backlinki
    backlinks_section = match.group(1)
    backlinks = re.findall(r'\[\[(.+?)\]\]', backlinks_section)

    return backlinks, True


def get_suggested_backlinks(file_path: Path) -> List[str]:
    """
    Sugeruje backlinki na podstawie struktury katalogów i nazwy pliku.
    """
    suggestions = []
    rel_path = file_path.relative_to(EWW_ROOT)
    parts = rel_path.parts

    # Zawsze dodaj INDEX jako bazowy backlink
    if file_path.stem != 'INDEX':
        suggestions.append('INDEX')

    # Dodaj README z katalogu nadrzędnego
    if len(parts) > 1 and file_path.stem != 'README':
        parent_readme = file_path.parent / 'README.md'
        if parent_readme.exists():
            suggestions.append('README')

    # Dodaj INDEX z katalogu nadrzędnego jeśli istnieje
    if len(parts) > 1 and file_path.stem != 'INDEX':
        parent_index = file_path.parent / 'INDEX.md'
        if parent_index.exists():
            suggestions.append('INDEX')

    # Dla plików w podkatalogach, dodaj główny plik katalogu
    if len(parts) > 1:
        dir_name = parts[0]
        main_file = EWW_ROOT / dir_name / f'{dir_name}.md'
        if main_file.exists() and main_file != file_path:
            suggestions.append(dir_name)

    # Dodaj specyficzne backlinki w zależności od katalogu
    if 'ops' in parts:
        suggestions.append('ops')
        if len(parts) > 1 and parts[1] != file_path.stem:
            suggestions.append(parts[1])

    if 'dev' in parts:
        suggestions.append('dev')

    if 'docs' in parts:
        suggestions.append('docs')

    if 'usr' in parts:
        suggestions.append('usr')

    # Usuń duplikaty zachowując kolejność
    seen = set()
    unique_suggestions = []
    for s in suggestions:
        if s not in seen:
            seen.add(s)
            unique_suggestions.append(s)

    return unique_suggestions


def add_backlinks_to_file(file_path: Path, backlinks: List[str]) -> bool:
    """
    Dodaje sekcję Backlinks do pliku lub aktualizuje istniejącą.

    Returns:
        bool: True jeśli plik został zmodyfikowany
    """
    try:
        content = file_path.read_text(encoding='utf-8')
    except Exception as e:
        print(f"⚠️  Nie można odczytać {file_path}: {e}")
        return False

    # Sprawdź czy sekcja Backlinks już istnieje
    backlinks_pattern = r'##\s+🔗\s+Backlinks?\s*\n((?:^-\s+\[\[.+?\]\]\s*\n)*)'
    match = re.search(backlinks_pattern, content, re.MULTILINE)

    # Formatuj backlinki
    backlinks_text = "\n".join(f"- [[{bl}]]" for bl in backlinks)
    new_section = f"\n## 🔗 Backlinks\n\n{backlinks_text}\n"

    if match:
        # Aktualizuj istniejącą sekcję
        new_content = content[:match.start()] + new_section + content[match.end():]
    else:
        # Dodaj nową sekcję na końcu
        new_content = content.rstrip() + "\n" + new_section

    try:
        file_path.write_text(new_content, encoding='utf-8')
        return True
    except Exception as e:
        print(f"⚠️  Nie można zapisać {file_path}: {e}")
        return False


def main():
    """Główna funkcja skryptu."""
    print("🔍 Szukam plików markdown...")
    md_files = find_all_md_files()
    print(f"📄 Znaleziono {len(md_files)} plików markdown")

    files_to_update = []
    stats = {
        'total': 0,
        'has_backlinks': 0,
        'no_backlinks': 0,
        'insufficient': 0,
        'updated': 0,
        'errors': 0
    }

    # Analiza plików
    print("\n📊 Analiza plików...")
    for file_path in md_files:
        stats['total'] += 1
        backlinks, has_section = get_file_backlinks(file_path)

        rel_path = file_path.relative_to(EWW_ROOT)

        if not has_section:
            stats['no_backlinks'] += 1
            print(f"❌ Brak sekcji: {rel_path}")
            files_to_update.append((file_path, []))
        elif len(backlinks) < MIN_BACKLINKS:
            stats['insufficient'] += 1
            print(f"⚠️  Za mało backlinków ({len(backlinks)}/3): {rel_path}")
            files_to_update.append((file_path, backlinks))
        else:
            stats['has_backlinks'] += 1

    # Aktualizacja plików
    if files_to_update:
        print(f"\n🔧 Aktualizacja {len(files_to_update)} plików...")

        for file_path, existing_backlinks in files_to_update:
            rel_path = file_path.relative_to(EWW_ROOT)

            # Pobierz sugerowane backlinki
            suggested = get_suggested_backlinks(file_path)

            # Połącz istniejące i sugerowane, usuń duplikaty
            all_backlinks = list(existing_backlinks)
            for bl in suggested:
                if bl not in all_backlinks:
                    all_backlinks.append(bl)

            # Upewnij się, że mamy conajmniej 3
            if len(all_backlinks) < MIN_BACKLINKS:
                # Dodaj kluczowe pliki jeśli brakuje
                for key_file in KEY_FILES:
                    if key_file not in all_backlinks and file_path.stem != key_file:
                        all_backlinks.append(key_file)
                        if len(all_backlinks) >= MIN_BACKLINKS:
                            break

            # Ogranicz do rozsądnej liczby (max 10)
            all_backlinks = all_backlinks[:10]

            if add_backlinks_to_file(file_path, all_backlinks):
                stats['updated'] += 1
                print(f"✅ Zaktualizowano: {rel_path} ({len(all_backlinks)} backlinków)")
            else:
                stats['errors'] += 1

    # Podsumowanie
    print("\n" + "="*60)
    print("📈 PODSUMOWANIE")
    print("="*60)
    print(f"Wszystkie pliki:          {stats['total']}")
    print(f"Z wystarczającą liczbą:   {stats['has_backlinks']}")
    print(f"Bez sekcji Backlinks:     {stats['no_backlinks']}")
    print(f"Za mało backlinków:       {stats['insufficient']}")
    print(f"Zaktualizowane:           {stats['updated']}")
    print(f"Błędy:                    {stats['errors']}")
    print("="*60)

    if stats['updated'] > 0:
        print(f"\n✅ Zaktualizowano {stats['updated']} plików!")
    else:
        print("\n✅ Wszystkie pliki mają odpowiednią liczbę backlinków!")


if __name__ == '__main__':
    main()
