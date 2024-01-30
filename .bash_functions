#!/usr/bin/env bash

BOLD="$(tput bold 2>/dev/null || printf '')"
GREY="$(tput setaf 0 2>/dev/null || printf '')"
UNDERLINE="$(tput smul 2>/dev/null || printf '')"
RED="$(tput setaf 1 2>/dev/null || printf '')"
GREEN="$(tput setaf 2 2>/dev/null || printf '')"
YELLOW="$(tput setaf 3 2>/dev/null || printf '')"
BLUE="$(tput setaf 4 2>/dev/null || printf '')"
MAGENTA="$(tput setaf 5 2>/dev/null || printf '')"
NO_COLOR="$(tput sgr0 2>/dev/null || printf '')"

info() {
  printf '%s\n' "${BOLD}${GREY}>${NO_COLOR} $*"
}

warn() {
  printf '%s\n' "${YELLOW}! $*${NO_COLOR}"
}

error() {
  printf '%s\n' "${RED}x $*${NO_COLOR}" >&2
  exit 1
}

hush() {
  "$@" >/dev/null 2>&1
}

has() {
  hush type -t "$@"
}

need() {
  if ! has "$1"; then
    error "need '$1' (command not found)"
  fi
}

ensure() {
  if ! "$@"; then
    error "command failed: $*"
  fi
}

# add to path if not already present
onpath() {
  if [ -d "$1" ]; then
    case ":${PATH:=$1}:" in
    *:"$1":*) ;;
    *) PATH="$1:$PATH" ;;
    esac
  fi
}

# source if exists
include() {
  if [ -e "$*" ]; then
    . "$*"
  fi
}

# create a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$_" || return
}

# go up until a file or dir is found
function cdu() {
  local start=$PWD
  local target=${*:-.git}
  while ! (test -f "$target" || test -d "$target"); do
    cd ..
    if [ "$PWD" = "/" ]; then
      warn "nothing found" >&2
      cd "$start" || return 1
      pwd
      return 1
    fi
  done
  pwd
  return 0
}
