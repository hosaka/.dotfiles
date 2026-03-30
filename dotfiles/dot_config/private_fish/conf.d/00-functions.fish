set BOLD "$(tput bold 2>/dev/null || printf '')"
set GREY "$(tput setaf 0 2>/dev/null || printf '')"
set UNDERLINE "$(tput smul 2>/dev/null || printf '')"
set RED "$(tput setaf 1 2>/dev/null || printf '')"
set GREEN "$(tput setaf 2 2>/dev/null || printf '')"
set YELLOW "$(tput setaf 3 2>/dev/null || printf '')"
set BLUE "$(tput setaf 4 2>/dev/null || printf '')"
set MAGENTA "$(tput setaf 5 2>/dev/null || printf '')"
set NO_COLOR "$(tput sgr0 2>/dev/null || printf '')"

function info -d 'print an info message'
  printf "$BOLD$BLUE%s $NO_COLOR%s\n" ">" "$argv"
end

function warning -d 'print a warning message'
  printf "$YELLOW%s %s$NO_COLOR\n" "!" "$argv"
end

function error -d 'print an error message and exit'
  printf "$RED%s %s$NO_COLOR\n" "x" "$argv"
  exit 1
end

function success -d 'print a success message'
  printf '%s\n' "$BOLD$GREEN >$NO_COLOR $argv"
end

function header -d 'print a header message'
  printf '%s\n' "$BOLD$MAGENTA >$NO_COLOR $argv"
end

function hush -d 'redirect stdin and stdout to null'
  $argv >/dev/null 2>&1
end

function has -d 'check if a given command exists'
  hush type -t $argv
end

function need -d 'require a command to exist'
  if not has $argv
    error "need '$argv' (command not found)"
  end
end

function ensure -d 'ensure a command to succeed'
  if not $argv
    error "command failed: $argv"
  end
end

function onpath -d 'add an item to PATH ignoring duplicates'
  if test -d "$argv"
    fish_add_path --path "$argv"
  end
end

function include -d 'source a fish shell script'
  if test -e "$argv"
    . "$argv"
  end
end

function which_sudo -d 'determine which sudo executable is available'
  if test $(id -u) -eq 0
    return
  else if has sudo
    echo sudo
  else if has doas && [ -f /etc/doas.conf ]
    echo doas
  else
    echo su
  end
end

function on_wsl -d 'determine shell is running in WSL context'
  test -n "$WSL_DISTRO_NAME"
end

