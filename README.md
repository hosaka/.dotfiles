# Dotfiles
My dotfiles.

## Install
To get a new machine setup, we can either:

Use a bare repo with a [worktree](https://git-scm.com/docs/git-worktree):
```bash
cd ~
git clone --bare https://github.com/hosaka/.dotfiles.git $HOME/.dotfiles
alias dot="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
dot checkout
```

Or clone directly into `$HOME`:
```bash
cd ~
git init
git remote add origin https://github.com/hosaka/.dotfiles.git
git fetch
git checkout -f main
```

## Use
All files are ignored by default (see `.gitignore`). To add a new dotfile pass the `--force` flag to the git add command:
```bash
git add -f .vimrc
```
All subsequent changes to this file will be tracked by git and it will appear in git status, git diff etc, an can be committed as usual.
