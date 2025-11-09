#!/usr/bin/env bats

INIT_SCRIPT="${BATS_TEST_DIRNAME}/../../init-eww.sh"

@test "interactive shell sets EWW_INIT_OK to 1" {
  run bash -ic ". \"$INIT_SCRIPT\"; printf 'VAR_EWW_INIT_OK:%s\n' \"\$EWW_INIT_OK\""
  [ "$status" -eq 0 ]
  last=$(printf '%s\n' "$output" | grep -E 'VAR_EWW_INIT_OK:' | tail -n1 | cut -d: -f2-)
  [ "$last" = "1" ]
}

@test "sourcing sets default EWW_ROOT when not provided" {
  run bash -ic ". \"$INIT_SCRIPT\"; printf 'VAR_EWW_ROOT:%s\n' \"\$EWW_ROOT\""
  [ "$status" -eq 0 ]
  last=$(printf '%s\n' "$output" | grep -E 'VAR_EWW_ROOT:' | tail -n1 | cut -d: -f2-)
  [ "$last" = "/git/eww" ]
}

@test "EWW_CD_ROOT=1 causes cd to EWW_ROOT if directory exists" {
  tmpdir="$(mktemp -d)"
  run bash -ic "mkdir -p $tmpdir; cd /; EWW_ROOT=$tmpdir EWW_CD_ROOT=1 . \"$INIT_SCRIPT\"; printf 'VAR_PWD:%s\n' \"\$PWD\""
  [ "$status" -eq 0 ]
  last=$(printf '%s\n' "$output" | grep -E 'VAR_PWD:' | tail -n1 | cut -d: -f2-)
  [ "$last" = "$tmpdir" ]
}
