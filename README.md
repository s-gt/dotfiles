# dotfiles

Personal zsh, tmux, and Vim configuration for Ubuntu 22.04 or later, including WSL.
Managed with [mise dotfiles](https://mise.jdx.dev/dotfiles.html).

## Tools

| Tool | Role | Installation in this setup | Configuration |
| --- | --- | --- | --- |
| zsh | Shell: runs commands and provides history and completion | apt via `mise bootstrap` | [`.zshrc`](.zshrc) |
| Starship | Shell prompt: displays context such as the current directory and Git status | Official installer via the bootstrap task; skipped if already on PATH | Initialized at the end of [`.zshrc`](.zshrc); default appearance |
| tmux | Terminal multiplexer: manages persistent sessions, windows, and panes | apt via `mise bootstrap` | [`.tmux.conf`](.tmux.conf) |
| Vim | Text editor | apt via `mise bootstrap` | [`.vimrc`](.vimrc) |
| mise | Setup manager: installs packages, deploys dotfiles, and runs the bootstrap task | Install before setup | [`mise.toml`](mise.toml) |

Starship works with several shells; this setup uses it to render zsh's prompt.
Zsh handles command execution, history, and completion. Tmux can run a zsh shell
in each pane. Your terminal application and its Nerd Font are configured separately.

When adding a tool, update this table and its declaration in `mise.toml`.
Use `[bootstrap.packages]` for OS packages and `[dotfiles]` for configuration
files. The bootstrap task handles the official Starship installer; keep any
additional installation steps safe to run again.

## Setup

Install [mise](https://mise.jdx.dev/getting-started.html) 2026.9.11 or later.
Enable a Nerd Font in your terminal, as described in the
[Starship prerequisites](https://starship.rs/guide/#prerequisites).
Then run these commands from this repository:

```sh
mise trust ./mise.toml
mise bootstrap --dry-run
mise bootstrap
mise dot status
```

This installs zsh, tmux, Vim, and curl with apt and symlinks `.zshrc`, `.tmux.conf`,
and `.vimrc` into your home directory. The standard
[bootstrap task](https://mise.jdx.dev/bootstrap.html#what-goes-where) then installs
Starship with its [official installer](https://starship.rs/guide/#step-1-install-starship)
(`curl -sS https://starship.rs/install.sh | sh`) if it is not on PATH.
An existing Starship installation is kept. Installation may require confirmation
and sudo. The dry run does not execute the installer.
To replace conflicting dotfiles during setup, use `mise bootstrap --force-dotfiles`.
Choose zsh as your login shell with `chsh -s /usr/bin/zsh`.
The included `.zshrc` already contains the official zsh initialization line,
`eval "$(starship init zsh)"`.

## Applying dotfiles

If the applications are already installed, use the official
[preview, apply, and status workflow](https://mise.jdx.dev/dotfiles.html#start-with-one-managed-file):

```sh
mise dot apply --dry-run
mise dot apply
mise dot status
```

If existing files conflict and you want to replace them with this repository's
configuration, use [force apply](https://mise.jdx.dev/dotfiles.html#conflicts):

```sh
mise dot apply --force --dry-run
mise dot apply --force
mise dot status
```

This applies `~/.zshrc`, `~/.tmux.conf`, and `~/.vimrc`.
Replacing existing files does not merge their personal settings.
`mise dot apply` does not run the Starship installation task; use `mise bootstrap`
for the complete setup.

## Settings

Edit `.zshrc`, `.tmux.conf`, or `.vimrc` in this repository. Start a new shell
or reload the relevant application to pick up changes.
Use `exec zsh` for the current shell, `tmux source-file ~/.tmux.conf` for a
running tmux server, and restart Vim.

Keep machine-specific tools and environment variables in
`~/.config/mise/config.toml`. Project-specific settings belong in each
project's `mise.toml`.

After changing the file mappings in `mise.toml`, preview and apply them:

```sh
mise dot diff
mise dot apply
```
