SHELL := /usr/bin/env bash

.PHONY: fmt lint test ansible-lint all
fmt:
	shfmt -w -i 2 -bn -ci .
lint:
	shellcheck -x script.sh
	bash -n script.sh
	yamllint -c tools/yamllint.yml ansible molecule || true
	ansible-lint ansible || true
test:
	bats -r test
ansible-lint:
	ansible-lint ansible
all: fmt lint test
