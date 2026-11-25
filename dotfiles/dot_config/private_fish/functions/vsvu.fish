if has vsv
  function vsvu -d 'vsv for user services'
    vsv --dir $XDG_CONFIG_HOME/service/ $argv
  end
end
