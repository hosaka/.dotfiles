#!/usr/bin/env bash

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# enable aliases to run with sudo
alias sudo='sudo '

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ls alternatives
if has eza; then
  alias ls='eza'
  alias la='eza -a'
  alias ll='eza -l --group-directories-first'
  alias lla='eza -la --group-directories-first'
elif has lsd; then
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

# dotfiles management and tab completion as git alias
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias dotadd='dot add -f'
if has __git_complete; then
  __git_complete dot __git_main
fi

# git
alias gco='git checkout'
alias gl='git l'
alias glg='git l --graph'
alias gs='git s'
alias gst='git status'
alias gsw='git switch'

if has lazygit; then
  alias gg='lazygit'
  alias dotgg='lazygit  --git-dir=$HOME/.dotfiles --work-tree=$HOME'
fi

if has keychain; then
  alias keychain='keychain --quiet'
fi
