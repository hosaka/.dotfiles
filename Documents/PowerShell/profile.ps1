function dot { git --git-dir=$HOME/.dotfiles --work-tree=$HOME $Args }
function dotadd { dot add -f $Args }
