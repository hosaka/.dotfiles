[doc('list recipes (default)')]
@help:
  just --list --no-aliases

[doc('list recipes with submodules')]
@list:
  just --list --no-aliases --list-submodules

[doc('edit recipes')]
@edit:
  just --edit

# yubikey management (`just yubi` for more, alias `y`)
mod yubi '~/.config/just/yubi'
@_y *args:
  just yubi {{ args }}
alias y := _y
