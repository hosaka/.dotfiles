#!/bin/sh
set -eu

# install with `curl -Ls https://sh.hosaka.cc/dotinstall.sh | sh`

hush() {
  "$@" >/dev/null 2>&1
}

has() {
  hush command -v "$@"
}

say() {
  printf "dot: %s\n" "$1"
}

ask() {
  printf "dot: %s (y/N): " "$1"
  read -r answer
  case "$answer" in
  [yY] | [yY][eE][sS])
    true
    ;;
  *)
    false
    ;;
  esac
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
    if ask "overwrite dotfiles that already exist? (otherwise stash them)"; then
      dot checkout --force
    else
      # files not present will appear as deleted and staged
      # restore them to unstaged and "un-delete" out .gitignore
      dot restore --staged .
      dot restore --worktree .gitignore

      # only modified files will be saved in git stash
      for file in $(dot diff --name-only --diff-filter=M); do
        dot stash push --message "dot: backup $file" "$file"
      done

      dot restore .
    fi
  fi

  say "installed successfully to ~/.dotfiles"
}

post_install() {
  case "${SHELL:-}" in
  */bash)
    say "re-run your shell or source .bashrc to activate"
    say ""
    ;;
  *) ;;
  esac
  say "use \`dot\` command (git alias) to manage dotfiles"
  say "use \`dot add -f\` command to add new dotfiles"
  say "use \`dot stash list\` to show files backed up during the install"
  say "use \`dotstrap\` to install common tools, see \`dotstrap --help\` to get started"
}

install
post_install
