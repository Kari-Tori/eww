#!/usr/bin/env bats
INIT_SCRIPT="${BATS_TEST_DIRNAME}/../../../../projects/init/init-eww.sh"

@test "init-eww.sh is idempotent placeholder" {
  run bash "$INIT_SCRIPT"
  [ "$status" -eq 0 ]
  run bash "$INIT_SCRIPT"
  [ "$status" -eq 0 ]
}
