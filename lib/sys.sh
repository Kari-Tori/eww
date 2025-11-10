#!/usr/bin/env bash
# biblioteka shell: helpery systemowe
is_root() { [[ ${EUID:-$(id -u)} -eq 0 ]]; }
