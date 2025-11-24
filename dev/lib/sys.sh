#!/usr/bin/env bash
# File: lib/sys.sh
# Author: 
# Created: 
# Updated: 
# Description: bash
# Tags:
# bash
# script
# biblioteka shell: helpery systemowe
is_root() { [[ ${EUID:-$(id -u)} -eq 0 ]]; }
