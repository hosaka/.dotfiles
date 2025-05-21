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
  alias lst='eza --tree'
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

if has bat; then
  # colorize --help messages
  help() {
    "$@" --help 2>&1 | bat --plain --language=help
  }
fi

if has rg; then
  if has delta; then
    # highlight ripgrep output
    rgd() {
      rg --json --context 2 "$@" | delta
    }
  fi
fi

if has nvim; then
  alias vimdiff='nvim -d'
fi

# dotfiles management and tab completion as git alias
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias dotadd='dot add -f'
if has __git_complete; then
  __git_complete dot __git_main
fi

# git
alias gco='git checkout'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git l'
alias glg='git l --graph'
alias gs='git s'
alias gst='git status'
alias gsw='git switch'

if has lazygit; then
  alias gg='lazygit'
  alias dotgg='lazygit  --git-dir=$HOME/.dotfiles --work-tree=$HOME'
fi

# docker
alias dimg='docker images'
alias dpsa='docker ps -a'

if has keychain; then
  alias keychain='keychain --quiet'
fi
