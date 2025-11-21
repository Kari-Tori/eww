#!/usr/bin/env bats

@test "prints help" {
  run ./script.sh -h
  [ "$status" -eq 0 ]
  [[ "$output" =~ Usage: ]]
}

@test "dry-run does not fail" {
  run ./script.sh -n
  [ "$status" -eq 0 ]
}
