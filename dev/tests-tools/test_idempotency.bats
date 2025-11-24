#!/usr/bin/env bats
@test "init-eww.sh is idempotent placeholder" {
  run bash ./init-eww.sh
  [ "$status" -eq 0 ]
  run bash ./init-eww.sh
  [ "$status" -eq 0 ]
}
