[doc('list recipes (default)')]
@help:
  just --list --no-aliases

[doc('list recipes with submodules')]
@list:
  just --list --no-aliases --list-submodules

[doc('show a recipe (args can be `recipe` or `mod::recipe`)'), no-exit-message]
@show +args:
  just --show {{ args }}

[doc('edit recipes')]
@edit:
  just --edit

# yubikey management (`just yubi` for more, alias `y`)
mod yubi '~/.config/just/yubi'
[private]
@y *args:
  just yubi {{ args }}

# git shortcuts (`just git` for more, alias `g`)
mod git '~/.config/just/git'
[private]
@g *args:
  just git {{ args }}

# box management (`just box` for more, alias `b`)
mod box '~/.config/just/box'
[private]
@b *args:
  just box {{ args }}
