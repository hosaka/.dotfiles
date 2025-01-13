[doc('list recipes (default)')]
@help:
  just --list

[doc('list recipes with submodules')]
@list:
  just --list --list-submodules

[doc('edit recipes')]
@edit:
  just --edit

# yubikey management (`just yubi` for more)
mod yubi '~/.config/just/yubi'
