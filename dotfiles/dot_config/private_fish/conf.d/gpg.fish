if has gpg
  function secret
    set filename $argv
    if not test -f $filename
      warning "provide a file to encrypt" >&2
      return 1
    end
    return 0
  end

  function reveal
    set filename $argv
    if not test -f $filename
      warning "provide a file to decrypt" >&2
      return 1
    end
    return 0
  end
end
