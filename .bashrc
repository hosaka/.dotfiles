#!/usr/bin/env bash

if [ -f ~/.bash_functions ]; then
  . ~/.bash_functions
fi

# add local bin to the PATH
onpath "$HOME/.local/bin"

# machine identifier for host specific profiles
MACHINE_PROFILE=$(hostname | tr "[:upper:]" "[:lower:]")

# shell options
# autocd - **/qux will enter ./foo/bar/baz/qux
# cdspell - autocorrect typos in path names when using cd
# checkwinsize - update the window size after each command, if necessary
# globstar - recursive globbing, echo **/*.txt
for option in autocd cdspell checkwwinsize globstar; do
  shopt -s "$option" 2>/dev/null
done
unset option

# disable shell history
# shopt -u -o history

# disable shell history file
unset HISTFILE
# increase in memory history size
HISTSIZE=32768
# ignore cmds starting with space, ignore duplicates and erase them
HISTCONTROL="ignoreboth:erasedups"

# make Python use UTF-8 encoding for output to stdin, stdout, and stderr
export PYTHONIOENCODING="UTF-8"

# disable less history file
export LESSHISTFILE=-

# enable color support
if [ -x /usr/bin/dircolors ]; then
  if [ -r ~/.dircolors ]; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi
fi

if on_wsl; then
  # avoid issues with gpg not recognising smartcards
  GPG_TTY=$(tty)
  export GPG_TTY
fi

# enable completion features
include /etc/bash_completion

# cargo
include ~/.cargo/env

# mise
if has mise; then
  MISE_ENV=$MACHINE_PROFILE
  if on_wsl; then
    MISE_ENV=$MISE_ENV,wsl
  fi
  export MISE_ENV
  eval "$(mise activate bash)"
  eval "$(mise hook-env -s bash)"
fi

# alias definitions (uses tools from cargo and mise)
include ~/.bash_aliases

# default editor
if has nvim; then
  EDITOR="nvim"
else
  EDITOR="vim"
fi
export EDITOR

# default manpager
if has bat; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
elif has nvim; then
  export MANPAGER="nvim +Man!"
fi

# keychain
if has keychain; then
  eval "$(keychain --quiet --nogui --eval)"
fi

# starship prompt
if has starship; then
  eval "$(starship init bash)"
fi

# atuin
if has atuin; then
  eval "$(atuin init bash --disable-up-arrow)"
fi

# zoxide
if has zoxide; then
  eval "$(zoxide init bash)"
fi

# broot
if has broot; then
  include ~/.config/broot/launcher/bash/br
fi

# bob
if has bob; then
  onpath "$HOME/.local/share/bob/nvim-bin"
fi

# fzf
if [[ -d ~/.fzf/ ]]; then
  if [[ ! "$PATH" == *"$HOME/.fzf/bin"* ]]; then
    onpath "$HOME/.fzf/bin"
  fi
fi

# just
if has just; then
  eval "$(just --completions bash)"
fi

# delta
if has delta; then
  export GIT_PAGER="delta"
  export DELTA_FEATURES="side-by-side line-numbers navigate"
  # todo: not sure how to add interactive.diffFilter = delta --color-only
fi

# watchexec
if has watchexec; then
  eval "$(watchexec --completions bash)"
fi

# load machine profiles
include "$HOME/.config/$MACHINE_PROFILE.profile"

# preexec and precmd functions for bash
include ~/.bash_preexec

export PATH
