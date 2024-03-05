#!/usr/bin/env bash

# atuin
export ATUIN_SYNC_ADDRESS="https://atuin.hosaka.cc"

# avoid issues with gpg under wsl not recognising smartcards
GPG_TTY=$(tty)
export GPG_TTY
