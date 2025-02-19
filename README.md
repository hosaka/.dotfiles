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

<details>
<summary>Using Windows/PowerShell</summary>

```bash
git clone --bare https://github.com/hosaka/.dotfiles.git $HOME/.dotfiles
function dot { git --git-dir=$HOME/.dotfiles --work-tree=$HOME $Args }
dot checkout -f
```

</details>

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

### Rustup

Rust toolchain can be installed with `dotstrap rustup`.

### Mise

A tool for managing development environments and tooling, see [mise.jdx.dev](https://mise.jdx.dev/).
In addition to a global config, per-machine config can be added (based on the `hostname`).
See [.config/mise/](.config/mise) for examples.

Bootstrap it with `dotstrap mise`. To view a list of tools and install them use:

```bash
mise list
mise install tool # or tool@version
```

It is also used as an intermediate step to install versioned tools from other package managers such as `cargo`, `go` and `npm`.
Some of the tools which can be installed with Mise are described below.

#### Atuin

Replaces shell history with a searchable database, see [docs.atuin.sh](https://docs.atuin.sh/). Install with `mise install "cargo:atuin"`.
Shell history can be synced between different machines via a self hosted server (see `.config/atuin/config.toml`).

To setup a new machine (omit the password flag to enter it via a prompt):

```bash
atuin login -u <USERNAME> -p <PASSWORD> -k <KEY>
```

The encryption key can be obtained with `atuin key` on an existing machine.

#### Bob

A version manager for Neovim. Install with `mise install "cargo:bob"`, To use/install a version:

```bash
bob use nightly
```

To update an existing version:

```bash
bob update nightly
```

### Neovim

Added as a gitsubmodule, neovim config can be pulled in by running:

```bash
dot submodule update --init .config/nvim
```

## Add

All files are ignored by default (see `.gitignore`). To add a new dotfile pass the `--force/-f` flag to the git add command:

```bash
dot add -f .vimrc
```

All subsequent changes to this file will be tracked by git and it will appear in git status, git diff etc, an can be committed as usual.
Alternatively use the `dotadd` alias to avoid having to pass the `-f` flag every time.

# TODO
- [ ] Add profile config and instructions for Windows/PowerShell
