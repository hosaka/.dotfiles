if has bat
  function help -d 'show --help colourized with bat'
    $argv --help 2>&1 | bat --plain --language=help
  end
end

