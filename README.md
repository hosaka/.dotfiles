# Dotfiles
My dotfiles.

## Install
To get a new machine setup, there are a few choices.

Use a bare repo with a [worktree](https://git-scm.com/docs/git-worktree):

```bash
git clone --bare https://github.com/hosaka/.dotfiles.git $HOME/.dotfiles
alias dot="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
dot checkout -f
```

Clone directly into `$HOME`:

```bash
cd ~
git init
git remote add origin https://github.com/hosaka/.dotfiles.git
git fetch
git checkout -f main
```

Use a remote install script:
```bash
curl https://hosaka.cc/sh/dotinstall | sh
```

## Use
Use `dot` alias to interact with the dotfiles repo, it is a direct alias to `git`.
Use `dotstrap` to install common tools. See `dotstrap --help` for more help.

### Adding new files
All files are ignored by default (see `.gitignore`). To add a new dotfile pass the `--force` flag to the git add command:

```bash
dot add -f .vimrc
```

All subsequent changes to this file will be tracked by git and it will appear in git status, git diff etc, an can be committed as usual. Alternatively use the `dotadd` alias to avoid having to pass the `-f` flag every time.

