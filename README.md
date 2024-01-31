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

### Neovim
Added as a gitsubmodule, neovim config can be pulled in by running:
```bash
dot submodule update --init .config/nvim
```

### Atuin
Replaces shell history with a searchable database, see [docs.atuin.sh](https://docs.atuin.sh/). Shell history can be synced between different machines via a self hosted server (see `.config/atuin/config.toml`).

To setup a new machine (omit the password flag to enter it via a prompt):
```bash
atuin login -u <USERNAME> -p <PASSWORD> -k <KEY>
```

The encryption key can be obtained with `atuin key` on an existing machine.

### Adding new files
All files are ignored by default (see `.gitignore`). To add a new dotfile pass the `--force` flag to the git add command:
```bash
dot add -f .vimrc
```

All subsequent changes to this file will be tracked by git and it will appear in git status, git diff etc, an can be committed as usual. Alternatively use the `dotadd` alias to avoid having to pass the `-f` flag every time.

