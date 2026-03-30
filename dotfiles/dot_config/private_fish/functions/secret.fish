if has gpg
  function secret -a filename -d 'encrypt a file using gpg'
    if not test -f $filename
      warning "provide a file to encrypt" >&2
      return 1
    end
    set output "$filename.enc"
    gpg --armor --symmetric --output "$output" "$filename"
    return 0
  end

  function reveal -a filename -d 'decrypt a file using gpg'
    if not test -f $filename
      warning "provide a file to decrypt" >&2
      return 1
    end
    set output $(basename "$filename" ".enc")
    gpg --decrypt --output "$output" "$filename"
    return 0
  end
end
