#!/usr/bin/env bash

# only add a path if it exists and not already in path
add_path() {
  if [ -d "$1" ]; then
    case ":${PATH:=$1}:" in
      *:"$1":*) ;;
      *) PATH="$1:$PATH" ;;
    esac
  fi
}

# add local bin to the PATH
add_path "$HOME/.local/bin"

# machine identifier for host specific profiles
MACHINE_PROFILE=$(hostname | tr "[:upper:]" "[:lower:]")

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

# cargo
if [ -f ~/.cargo/env ]; then
  . ~/.cargo/env
fi

# mise
if command -v mise &>/dev/null; then
  MISE_ENV=$MACHINE_PROFILE
  export MISE_ENV

  eval "$(mise activate bash)"
  eval "$(mise activate --shims)"
fi

# alias definitions (relies on cargo and mise)
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

# zoxide
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init bash)"
fi

# broot
if command -v broot &>/dev/null; then
  if [ -e ~/.config/broot/luncher/bash/br ]; then
    . ~/.config/broot/launcher/bash/br
  fi
fi

# bob
if command -v bob &>/dev/null; then
  add_path "$HOME/.local/share/bob/nvim-bin"
fi

# load machine profiles
if [ -e ~/.config/"$MACHINE_PROFILE".profile ]; then
  . ~/.config/"$MACHINE_PROFILE".profile
fi

export PATH
