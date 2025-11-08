#!/usr/bin/env bats

INIT_SCRIPT="${BATS_TEST_DIRNAME}/../init-eww.sh"

@test "interactive shell sets EWW_INIT_OK to 1" {
  run bash -ic "( . \"$INIT_SCRIPT\"; printf '%s' \"\\\$EWW_INIT_OK\" ) 2>/dev/null"
  [ "$status" -eq 0 ]
  last=$(printf '%s
' "$output" | tail -n1)
  [ "$last" = "1" ]
}

@test "sourcing sets default EWW_ROOT when not provided" {
  run bash -ic "( . \"$INIT_SCRIPT\"; printf '%s' \"\\\$EWW_ROOT\" ) 2>/dev/null"
  [ "$status" -eq 0 ]
  last=$(printf '%s
' "$output" | tail -n1)
  [ "$last" = "/git/eww" ]
}

@test "EWW_CD_ROOT=1 causes cd to EWW_ROOT if directory exists" {
  tmpdir="$(mktemp -d)"
  # ensure path exists and test from a different pwd
  run bash -ic "( mkdir -p $tmpdir; cd /; EWW_ROOT=$tmpdir EWW_CD_ROOT=1 . $INIT_SCRIPT; printf '%s' \"\$PWD\" ) 2>/dev/null"
  [ "$status" -eq 0 ]
  last=$(printf '%s
' "$output" | tail -n1)
  [ "$last" = "$tmpdir" ]
}
