set BOLD "$(tput bold 2>/dev/null || printf '')"
set GREY "$(tput setaf 0 2>/dev/null || printf '')"
set UNDERLINE "$(tput smul 2>/dev/null || printf '')"
set RED "$(tput setaf 1 2>/dev/null || printf '')"
set GREEN "$(tput setaf 2 2>/dev/null || printf '')"
set YELLOW "$(tput setaf 3 2>/dev/null || printf '')"
set BLUE "$(tput setaf 4 2>/dev/null || printf '')"
set MAGENTA "$(tput setaf 5 2>/dev/null || printf '')"
set NO_COLOR "$(tput sgr0 2>/dev/null || printf '')"

function info
  # printf '%s\n' "$BOLD$BLUE >$NO_COLOR $argv"
  printf "$BOLD$BLUE%s $NO_COLOR%s\n" ">" "$argv"
end

function warning
  printf "$YELLOW%s %s$NO_COLOR\n" "!" "$argv"
end

function error
  printf "$RED%s %s$NO_COLOR\n" "x" "$argv"
  exit 1
end

function success
  printf '%s\n' "$BOLD$GREEN >$NO_COLOR $argv"
end

function header
  printf '%s\n' "$BOLD$MAGENTA >$NO_COLOR $argv"
end

function hush
  $argv >/dev/null 2>&1
end

function has
  hush type -t $argv
end

function need
  if not has $argv
    error "need '$argv' (command not found)"
  end
end

function ensure
  if not $argv
    error "command failed: $argv"
  end
end

function onpath
  if test -d "$argv"
    fish_add_path --path "$argv"
  end
end

function include
  if test -e "$argv"
    . "$argv"
  end
end

function which_sudo
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

function on_wsl
  test -n "$WSL_DISTRO_NAME"
end


