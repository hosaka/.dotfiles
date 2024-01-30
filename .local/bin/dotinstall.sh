#!/bin/sh
set -eu

# install with `curl https://dot.hosaka.cc/dotinstall.sh | sh`

hush() {
  "$@" >/dev/null 2>&1
}

has() {
  hush command -v "$@"
}

say() {
  printf "dot: %s\n" "$1"
}

err() {
  say "$1" >&2
  exit 1
}

need() {
  if ! has "$1"; then
    err "need '$1' (command not found)"
  fi
}

ensure() {
  if ! "$@"; then
    err "command failed: $*"
  fi
}

dot() {
  git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"
}

install() {
  need git

  say "installing to ~/.dotfiles"

  git clone --bare https://code.hosaka.cc/hosaka/.dotfiles.git "$HOME/.dotfiles"

  if ! dot checkout; then
    : # todo: offer to backup files or clobber
    # ensure dot checkout
  fi

  say "installed successfully to ~/.dotfiles"
}

post_install() {
  case "${SHELL:-}" in
  */bash)
    say "re-run your shell or source .bashrc to activate "
    say ""
    ;;
  *) ;;
  esac
  say "use \`dot\` command (git alias) to manage dotfiles"
  say "use \`dotstrap\` to install common tools, see \`dotstrap --help\` to get started"
}

install
post_install
