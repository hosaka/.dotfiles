#!/usr/bin/env bash

# if not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# add local bin to the PATH
export PATH="$HOME/.local/bin:$PATH"

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# autocorrect typos in path names when using cd
shopt -s cdspell

# **/qux will enter ./foo/bar/baz/qux
shopt -s autocd

# if set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# increase bash history size
HISTSIZE=32768
HISTFILESIZE="${HISTSIZE}"
# don't put duplicate lines or lines starting with space in the history
HISTCONTROL="ignoreboth"

# default editor
export EDITOR="vim"

# avoid issues with gpg under wsl not recognising smartcards
GPG_TTY=$(tty)
export GPG_TTY

# make Python use UTF-8 encoding for output to stdin, stdout, and stderr
export PYTHONIOENCODING="UTF-8"

# don't clear the screen after quitting a manpage
export MANPAGER="less -X"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support
if [ -x /usr/bin/dircolors ]; then
  if test -r ~/.dircolors; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# enable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# alias definitions
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# keychain
if command -v keychain &>/dev/null; then
  eval "$(keychain --quiet --eval id_ed25519)"
fi

# starship prompt
if command -v starship &>/dev/null; then
  eval "$(starship init bash)"
fi

# cargo
if [ -f $HOME/.cargo/env ]; then
  . "$HOME/.cargo/env"
fi

# zoxide
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init bash)"
fi

# mise
if command -v ~/.local/bin/mise &>/dev/null; then
  eval "$(~/.local/bin/mise activate bash)"
  export PATH="$HOME/.local/share/mise/shims:$PATH"
fi

# foundrdy
if [ -d "$HOME/.foundry/bin" ]; then
  export PATH="$PATH:$HOME/.foundry/bin"
fi

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
