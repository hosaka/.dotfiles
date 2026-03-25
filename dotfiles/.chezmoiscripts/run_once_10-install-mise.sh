#!/usr/bin/env bash

set -eu

if [ -f ~/.bash_functions ]; then
  . ~/.bash_functions
fi

if has mise; then
  info "mise is installed"
  exit 0
fi

curl https://mise.run | sh
