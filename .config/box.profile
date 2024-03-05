#!/usr/bin/env bash

# atuin
export ATUIN_SYNC_ADDRESS="https://atuin.box.hosaka.cc"

# aliases
if has resticprofile; then
  alias rst='doas -u restic resticprofile'
fi
