# navigation
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'

alias grep 'grep --color=auto'
alias fgrep 'fgrep --color=auto'
alias egrep 'egrep --color=auto'

# ls alternatives
if has eza
  alias ls 'eza'
  alias la 'eza -a'
  alias ll 'eza -l --group-directories-first'
  alias lla 'eza -la --group-directories-first'
  alias lst 'eza --tree --group-directories-first'
else if has lsd
  alias ls 'lsd'
  alias la 'lsd -a'
  alias ll 'lsd -lh --group-directories-first'
  alias lla 'lsd -lah --group-directories-first'
else
  alias ls 'ls --color=auto'
  alias la 'ls -ah'
  alias ll 'ls -lGh --group-directories-first'
  alias lla 'ls -lGah --group-directories-first'
end

if has nvim
  alias vimdiff='nvim -d'
end

# chezmoi (alias and complete wrapper)
if has chezmoi
  alias dot 'chezmoi'
  complete -c dot -w chezmoi
end

# git
if has git
  alias gco 'git checkout'
  alias gd 'git diff'
  alias gds 'git diff --staged'
  alias gl 'git l'
  alias glg 'git l --graph'
  alias gs 'git s'
  alias gst 'git status'
  alias gsw 'git switch'
end

if has lazygit
  alias gg 'lazygit'
end

# docker
if has docker
  alias dimg 'docker images'
  alias dpsa 'docker ps -a'
end

if has keychain
  alias keychain 'keychain --quiet'
end

# just
if has just
  alias j 'just --justfile=$HOME/.justfile'
end

# restic
if has resticproendle
  set SUDO $(which_sudo)
  alias rst '$SUDO -u restic resticprofile'
end

# rocketpool
if has rocketpool
  alias rp 'rocketpool'
end
