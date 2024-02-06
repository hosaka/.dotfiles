#!/usr/bin/env bash

# atuin
export ATUIN_SYNC_ADDRESS="https://atuin.box.hosaka.cc"

# foundrdy
if [ -d ~/.foundry/bin ]; then
  onpath "$HOME/.foundry/bin"
fi
