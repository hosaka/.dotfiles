# disable shell history
set -g fish_history ""
set -g fish_greeting

# make Python use UTF-8 encoding for output to stdin, stdout, and stderr
set -gx PYTHONIOENCODING "UTF-8"
# disable REPL history file (~/.python_history)
set -gx PYTHON_HISTORY /dev/null
# disable less history file (~/.lesshst)
set -gx LESSHISTFILE -

# XDG Base Directory
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"
set -gx XDG_DOWNLOAD_DIR "$HOME/Downloads"
set -gx XDG_DOCUMENTS_DIR "$HOME/Documents"
set -gx XDG_MUSIC_DIR "$HOME/Music"
set -gx XDG_PICTURES_DIR "$HOME/Pictures"
set -gx XDG_VIDEOS_DIR "$HOME/Videos"

onpath "$HOME/.local/bin"
onpath "$HOME/.cargo/bin"

# default editor
if has nvim
  set -gx EDITOR "nvim"
end

# default manpager
if has bat
  set -gx MANPAGER "batman"
end

if on_wsl
  # avoid issues with gpg not recognising smartcards
  set -gx GPG_TTY $(tty)
end

