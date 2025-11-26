#!/usr/bin/env bats
@test "repo root exists" {
  [ -d "./" ]
}
