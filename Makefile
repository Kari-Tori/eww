SHELL := bash
PREFIX ?= /usr/local
BINDIR := $(PREFIX)/bin

all:
	@true

install:
	install -d "$(DESTDIR)$(BINDIR)"
	install -m 755 scripts/eww-index.sh "$(DESTDIR)$(BINDIR)/eww-index"
	install -m 755 scripts/eww-init.sh  "$(DESTDIR)$(BINDIR)/eww-init"

uninstall:
	rm -f "$(DESTDIR)$(BINDIR)/eww-index" "$(DESTDIR)$(BINDIR)/eww-init"

.PHONY: all install uninstall
