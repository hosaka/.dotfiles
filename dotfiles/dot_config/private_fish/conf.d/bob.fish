if has bob
  onpath "$HOME/.local/share/bob/nvim-bin"
  # this helps neovide to find the right executable
  set -gx NEOVIM_BIN "$HOME/.local/share/bob/nvim-bin/nvim"
end
