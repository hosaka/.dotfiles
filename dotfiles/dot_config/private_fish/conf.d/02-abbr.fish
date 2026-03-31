if not status is-interactive
  exit
end

abbr -a md 'mkdir -p'

if has docker
  abbr -a dimg 'docker images'
  abbr -a dpsa 'docker ps -a'
  abbr -a dipr 'docker image prune'
end

if has lazygit
  abbr -a gg 'lazygit'
end

if has zellij
  abbr -a zel 'zellij'
end

if has rocketpool
  abbr -a rp 'rocketpool'
end
