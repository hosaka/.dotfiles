if has nvim
  function nvimnew -d 'open a new file in neovim from clipboard'
      nvim -c 'enew | put +'
  end
end
