#!/usr/bin/env python3
"""
Skrypt zapewniający, że każdy folder ma plik .md o nazwie folderu.

Każdy plik folderu.md:
- Zawiera index wszystkich plików w folderze
- Jest połączony ze wszystkimi plikami w folderze
- Ma tag #folder_note
- Ma backlinki do wszystkich plików w folderze
- Ma backlink do folderu nadrzędnego
"""

import os
import re
from pathlib import Path
from datetime import datetime
from typing import List, Set, Dict

# Katalog główny projektu
EWW_ROOT = Path(__file__).resolve().parent.parent.parent

# Katalogi do pominięcia
EXCLUDE_DIRS = {
    '.git', 'node_modules', '__pycache__', '.venv', 'venv',
    '.pytest_cache', '.mypy_cache', 'dist', 'build',
    '.obsidian', '.github', '.vscode', '.space', '.vale'
}

# Pliki do pominięcia w indeksie
EXCLUDE_FILES = {
    '.DS_Store', 'Thumbs.db', '.gitkeep'
}


def should_skip_dir(dir_path: Path) -> bool:
    """Sprawdza czy katalog powinien być pominięty."""
    # Pomiń ukryte katalogi (zaczynające się od .)
    if dir_path.name.startswith('.') and dir_path.name not in {'.github'}:
        return True

    # Pomiń katalogi z listy wykluczeń
    if dir_path.name in EXCLUDE_DIRS:
        return True

    return False


def get_all_folders() -> List[Path]:
    """Znajduje wszystkie foldery w projekcie (poza wykluczeniami)."""
    folders = []

    for root, dirs, files in os.walk(EWW_ROOT):
        # Usuń katalogi do wykluczenia z przeszukiwania
        dirs[:] = [d for d in dirs if d not in EXCLUDE_DIRS]

        current_path = Path(root)

        # Pomiń katalog główny
        if current_path == EWW_ROOT:
            continue

        # Pomiń ukryte katalogi
        if should_skip_dir(current_path):
            continue

        folders.append(current_path)

    return sorted(folders)


def get_folder_files(folder_path: Path) -> List[Path]:
    """
    Pobiera listę plików markdown w folderze (bez podfolderów).
    Sortuje według typu i nazwy.
    """
    files = []
    folder_note_name = folder_path.name + '.md'

    try:
        for item in folder_path.iterdir():
            if item.is_file() and item.suffix == '.md':
                # Pomiń plik folderu.md
                if item.name == folder_note_name:
                    continue
                # Pomiń pliki do wykluczenia
                if item.name in EXCLUDE_FILES:
                    continue
                files.append(item)
    except PermissionError:
        pass

    # Sortuj: INDEX, README, potem alfabetycznie
    def sort_key(p: Path):
        name = p.stem.upper()
        if name == 'INDEX':
            return (0, name)
        elif name == 'README':
            return (1, name)
        else:
            return (2, name)

    return sorted(files, key=sort_key)


def get_folder_subdirs(folder_path: Path) -> List[Path]:
    """Pobiera listę podfolderów w folderze."""
    subdirs = []

    try:
        for item in folder_path.iterdir():
            if item.is_dir() and not should_skip_dir(item):
                subdirs.append(item)
    except PermissionError:
        pass

    return sorted(subdirs)


def get_parent_folder_note(folder_path: Path) -> str:
    """Zwraca nazwę pliku folderu nadrzędnego."""
    parent = folder_path.parent

    if parent == EWW_ROOT:
        return 'INDEX'

    return parent.name


def create_folder_note_content(folder_path: Path, files: List[Path], subdirs: List[Path]) -> str:
    """
    Tworzy zawartość pliku folderu.md.
    """
    folder_name = folder_path.name
    rel_path = folder_path.relative_to(EWW_ROOT)

    # Nagłówek z frontmatter
    content = []
    content.append("---")
    content.append(f"created: {datetime.now().strftime('%Y-%m-%dT%H:%M:%SZ')}")
    content.append(f"modified: {datetime.now().strftime('%Y-%m-%dT%H:%M:%SZ')}")
    content.append("tags:")
    content.append("  - #folder_note")
    content.append(f"title: \"{folder_name}\"")
    content.append("---")
    content.append("")
    content.append(f"# {folder_name}")
    content.append("")
    content.append(f"Notatka folderu dla `{rel_path}`")
    content.append("")

    # Sekcja z podfolderami (jeśli istnieją)
    if subdirs:
        content.append("## 📁 Podfoldery")
        content.append("")
        for subdir in subdirs:
            # Link do pliku folderu w podfolderze
            subdir_note = subdir.name
            content.append(f"- [[{subdir_note}]]")
        content.append("")

    # Index plików
    if files:
        content.append("## 📄 Pliki w tym folderze")
        content.append("")
        for file in files:
            file_stem = file.stem
            content.append(f"- [[{file_stem}]]")
        content.append("")
    else:
        content.append("## 📄 Pliki w tym folderze")
        content.append("")
        content.append("*Brak plików markdown w tym folderze.*")
        content.append("")

    # Backlinki
    content.append("## 🔗 Backlinki")
    content.append("")

    # Backlink do folderu nadrzędnego
    parent_note = get_parent_folder_note(folder_path)
    backlinks = [parent_note]

    # Backlinki do wszystkich plików w folderze
    for file in files:
        backlinks.append(file.stem)

    # Usuń duplikaty zachowując kolejność
    seen = set()
    unique_backlinks = []
    for bl in backlinks:
        if bl not in seen:
            seen.add(bl)
            unique_backlinks.append(bl)

    for bl in unique_backlinks:
        content.append(f"- [[{bl}]]")
    content.append("")

    return "\n".join(content)


def update_folder_note(folder_path: Path) -> bool:
    """
    Tworzy lub aktualizuje plik folderu.md.

    Returns:
        bool: True jeśli plik został utworzony/zaktualizowany
    """
    folder_note_path = folder_path / f"{folder_path.name}.md"

    # Pobierz pliki i podfoldery
    files = get_folder_files(folder_path)
    subdirs = get_folder_subdirs(folder_path)

    # Generuj zawartość
    new_content = create_folder_note_content(folder_path, files, subdirs)

    # Sprawdź czy plik istnieje
    if folder_note_path.exists():
        try:
            old_content = folder_note_path.read_text(encoding='utf-8')

            # Zaktualizuj tylko modified date jeśli treść się zmienia
            if old_content != new_content:
                # Zachowaj oryginalną datę created jeśli istnieje
                created_match = re.search(r'^created:\s*(.+)$', old_content, re.MULTILINE)
                if created_match:
                    new_content = re.sub(
                        r'^created:\s*.+$',
                        f'created: {created_match.group(1)}',
                        new_content,
                        count=1,
                        flags=re.MULTILINE
                    )

                folder_note_path.write_text(new_content, encoding='utf-8')
                return True
            else:
                return False
        except Exception as e:
            print(f"⚠️  Błąd przy aktualizacji {folder_note_path}: {e}")
            return False
    else:
        # Utwórz nowy plik
        try:
            folder_note_path.write_text(new_content, encoding='utf-8')
            return True
        except Exception as e:
            print(f"⚠️  Błąd przy tworzeniu {folder_note_path}: {e}")
            return False


def main():
    """Główna funkcja skryptu."""
    print("🔍 Szukam folderów...")
    folders = get_all_folders()
    print(f"📁 Znaleziono {len(folders)} folderów")

    stats = {
        'total': 0,
        'created': 0,
        'updated': 0,
        'unchanged': 0,
        'errors': 0
    }

    print("\n🔧 Sprawdzanie i aktualizacja folder notes...")
    for folder_path in folders:
        stats['total'] += 1
        rel_path = folder_path.relative_to(EWW_ROOT)
        folder_note_path = folder_path / f"{folder_path.name}.md"

        existed_before = folder_note_path.exists()

        if update_folder_note(folder_path):
            if not existed_before:
                stats['created'] += 1
                print(f"✅ Utworzono: {rel_path}/{folder_path.name}.md")
            else:
                stats['updated'] += 1
                print(f"🔄 Zaktualizowano: {rel_path}/{folder_path.name}.md")
        else:
            stats['unchanged'] += 1

    # Podsumowanie
    print("\n" + "="*60)
    print("📈 PODSUMOWANIE")
    print("="*60)
    print(f"Wszystkie foldery:        {stats['total']}")
    print(f"Utworzono nowych:         {stats['created']}")
    print(f"Zaktualizowano:           {stats['updated']}")
    print(f"Bez zmian:                {stats['unchanged']}")
    print(f"Błędy:                    {stats['errors']}")
    print("="*60)

    if stats['created'] > 0 or stats['updated'] > 0:
        total_changes = stats['created'] + stats['updated']
        print(f"\n✅ Zmodyfikowano {total_changes} plików folder notes!")
    else:
        print("\n✅ Wszystkie folder notes są aktualne!")


if __name__ == '__main__':
    main()
