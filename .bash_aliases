#!/usr/bin/env bash

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'

# enable aliases to run with sudo
alias sudo='sudo '

if command -v eza &>/dev/null; then
  alias ls='eza'
  alias la='eza -a'
  alias ll='eza -l --group-directories-first'
  alias lla='eza -la --group-directories-first'
elif command -v lsd &>/dev/null; then
  alias ls='lsd'
  alias la='lsd -a'
  alias ll='lsd -lh --group-directories-first'
  alias lla='lsd -lah --group-directories-first'
else
  alias ls='ls --color=auto'
  alias la='ls -ah'
  alias ll='ls -lGh --group-directories-first'
  alias lla='ls -lGah --group-directories-first'
fi

# git
alias gs='git status'
alias gg='lazygit'

if command -v nvim &>/dev/null; then
  alias vim='nvim'
fi

# dotfiles management
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias dotgg='lazygit --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# enable tab completion for dot alias
if type __git_complete &>/dev/null; then
  __git_complete dot __git_main
fi

# create a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$_" || return
}
