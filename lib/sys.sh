#!/usr/bin/env bash
# shell lib: sys helpers
is_root(){ [[ ${EUID:-$(id -u)} -eq 0 ]]; }
