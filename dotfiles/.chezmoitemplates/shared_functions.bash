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
  printf '%s\n' "${BOLD}${BLUE}>${NO_COLOR} $*"
}

warning() {
  printf '%s\n' "${YELLOW}! $*${NO_COLOR}"
}

error() {
  printf '%s\n' "${RED}x $*${NO_COLOR}" >&2
  exit 1
}

success() {
  printf '%s\n' "${BOLD}${GREEN}>${NO_COLOR} $*"
}

header() {
  printf '%s\n' "${BOLD}${MAGENTA}>${NO_COLOR} $*"
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
    # shellcheck disable=SC1090 # arbitrary include
    . "$*"
  fi
}

# find available sudo executable
which_sudo() {
  if [ "$(id -u)" = "0" ]; then
    return
  elif has sudo; then
    echo sudo
  elif has doas && [ -f /etc/doas.conf ]; then
    echo doas
  else
    echo su
  fi
}

on_wsl() {
  test -n "${WSL_DISTRO_NAME}"
}
