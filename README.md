# Dotfiles

My dotfiles. Managed with [chezmoi](https://www.chezmoi.io/).

<details>
<summary>Previous Setup</summary>
I have previously used bare git repo with a work tree and my own bootstrap scripts. See the [last commit before the switch](65f7c44de8b03638395dd65d07c43a533098c76c).
</details>

## Install

To get a new machine setup, there are a few choices.

Get [chezmoi](https://www.chezmoi.io/) via a package manager and init the repo:
```bash
chezmoi init --apply ssh://git@git.hosaka.cc/hosaka/.dotfiles
```

Use a remote script from chezmoi:
```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply ssh://git@git.hosaka.cc/hosaka/.dotfiles
```

Use my remote install script:

```bash
curl https://hosaka.cc/sh/dotinstall | sh
```

## Use

Use `dot` alias to interact with the dotfiles repo, it is a direct alias to `chezmoi`.
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

It is also used as an intermediate step to install versioned tools from other package managers such as `cargo`, `go` and `npm`. It is worth to add a *GitHub Personal Access* Token to the environment so Mise will not be throttled when installing multiple tools at the same time, this can be done by placing a `.mise.toml` or `.mise.local.toml` in $HOME:
```toml
[env]
GITHUB_TOKEN = "github_pat_"
```

Some of the tools which can be installed with Mise are described below.

#### Atuin

Replaces shell history with a searchable database, see [docs.atuin.sh](https://docs.atuin.sh/). Install with `mise install atuin`.
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

