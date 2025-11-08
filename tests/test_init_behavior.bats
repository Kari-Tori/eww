#!/usr/bin/env bats

INIT_SCRIPT="${BATS_TEST_DIRNAME}/../init-eww.sh"

@test "non-interactive shell does not set EWW_INIT_OK" {
  run bash -c ". \"$INIT_SCRIPT\" >/dev/null 2>&1; printf '%s' \"\\\$EWW_INIT_OK\""
  [ "$status" -eq 0 ]
  [ -z "$output" ]
}

@test "interactive shell sets EWW_INIT_OK to 1" {
  run bash -ic ". \"$INIT_SCRIPT\" >/dev/null 2>&1; printf '%s' \"\\\$EWW_INIT_OK\""
  [ "$status" -eq 0 ]
  [ "$output" = "1" ]
}

@test "sourcing sets default EWW_ROOT when not provided" {
  run bash -ic ". \"$INIT_SCRIPT\" >/dev/null 2>&1; printf '%s' \"\\\$EWW_ROOT\""
  [ "$status" -eq 0 ]
  [ "$output" = "/git/eww" ]
}

@test "EWW_CD_ROOT=1 causes cd to EWW_ROOT if directory exists" {
  tmpdir="$(mktemp -d)"
  # ensure path exists and test from a different pwd
  run bash -ic "mkdir -p $tmpdir; cd /; EWW_ROOT=$tmpdir EWW_CD_ROOT=1 . $INIT_SCRIPT >/dev/null 2>&1; printf '%s' \"\$PWD\""
  [ "$status" -eq 0 ]
  [ "$output" = "$tmpdir" ]
}
