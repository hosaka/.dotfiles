function cdu -d 'go up until a file or dir is found'
  set start $PWD
  set -q $argv[1]; or set target ".git"

  while not begin
    test -f "$target" || test -d "$target"
  end
    builtin cd ..
    if test $PWD = "/"
      warning "nothing found" >&2
      builtin cd "$start" || return 1
      info "$PWD"
      return 1
    end
  end

  info "$PWD"
  return 0
end
