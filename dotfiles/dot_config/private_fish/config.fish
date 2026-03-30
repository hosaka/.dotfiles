# disable shell history
set -x fish_private_mode "plz"

if status is-interactive
  function fish_greeting
  end
end

# make Python use UTF-8 encoding for output to stdin, stdout, and stderr
set -gx PYTHONIOENCODING "UTF-8"
# disable REPL history file (~/.python_history)
set -gx PYTHON_HISTORY /dev/null
# disable less history file (~/.lesshst)
set -gx LESSHISTFILE -

onpath "$HOME/.local/bin"

if on_wsl
  # avoid issues with gpg not recognising smartcards
  set -gx GPG_TTY $(tty)
end

# default editor
if has nvim
  set -gx EDITOR "nvim"
end

# default manpager
if has bat
  set -gx MANPAGER "batman"
end
