SHELL := /bin/bash
PROJECT ?=

.PHONY: mkdocs-setup systemd-reload

mkdocs-setup:
	@test -n "$(PROJECT)" || (echo "Ustaw PROJECT=/ścieżka/do/MkDocs" >&2; exit 2)
	@mkdir -p $$HOME/.config/systemd/user
	@install -m0644 TEMPLATES/systemd/mkdocs-serve.service $$HOME/.config/systemd/user/
	@install -m0644 TEMPLATES/systemd/mkdocs-prod.service  $$HOME/.config/systemd/user/
	@sed -i "s|/REPLACE/PROJECT|$(PROJECT)|" $$HOME/.config/systemd/user/mkdocs-serve.service
	@sed -i "s|/REPLACE/PROJECT|$(PROJECT)|" $$HOME/.config/systemd/user/mkdocs-prod.service
	@systemctl --user daemon-reload
	@systemctl --user enable --now mkdocs-serve.service
	@echo "MkDocs dev: http://127.0.0.1:8000"

systemd-reload:
	@systemctl --user daemon-reload
