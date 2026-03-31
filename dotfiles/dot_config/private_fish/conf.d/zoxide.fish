if status is-interactive; and has zoxide
  function __lazy_zoxide
    functions -e __lazy_zoxide z zi
    # only runs once
    zoxide init fish | source
  end
  function z -d 'zoxide (lazy)'
    __lazy_zoxide
    __zoxide_z $argv
  end
  function zi -d 'zoxide interactive (lazy)'
    __lazy_zoxide
    __zoxide_zi $argv
  end
end
