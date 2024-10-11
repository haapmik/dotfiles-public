# My dotfiles

<a href="https://github.com/twpayne/chezmoi">![setup with chezmoi](https://img.shields.io/badge/setup%20with-chezmoi-teal)</a>

This is a public copy of my dotfiles configurations. It is provided "as-is" and will always be a work-in-progress. It utilizes [chezmoi](https://www.chezmoi.io/) to store and manage the state of my personal setup. You are welcome to explore, use it as an example, or gain inspiration for your own configuration. 

**Use at Your Own Risk**: Any use of the configurations and scripts in this repository is at your own risk. I cannot guarantee that they will work in your environment or will not cause any issues.

## Neovim

My daily driver for code editing is [Neovim](https://neovim.io) with various plugins.

- [Kanagawa](https://github.com/rebelot/kanagawa.nvim) as the colorscheme
- `.config/nvim` all my configuration
- `.config/nvim/lua/config/lang` language specific definitions
    - these are used to define linting, lsp, formatting and other configurations per language basis

## Shell

I use color themes that tries to conform with [Snazzy](https://github.com/sindresorhus/hyper-snazzy) for my shell.

### Zsh

I use [Zsh shell](https://zsh.sourceforge.io/) with [Zi](https://wiki.zshell.dev/) to automate the installation and updates of plugins and CLI tools. Zi is based on the zinit plugin manager originally created by [Zdharma](https://github.com/zdharma).

- `.zshrc` main configuration file
- `.zshenv` environment variables
- `.config/starship.toml` is for the [starship](https://starship.rs/) prompt
    - I try to emulate [pure](https://github.com/sindresorhus/pure) with my prompt definitions, but I might switch back to pure.

### tmux

[Tmux](https://github.com/tmux/tmux) is used as a terminal multiplexer, which allows me to work on a multiple things at the same time.

- `.config/tmux/tmux.conf` main configuration file
- `.config/tmux/plugins.conf` plugins related configuration
- `.config/tmux/theme.sh` theme related definitions


## Systemd

[Systemd](https://systemd.io/) is used to automate certain tasks or to run background services. 

My systemd units are located in the `.config/systemd/user` folder. To enable these units, please follow instructions shown below. Replace the `$SYSTEMD_UNIT` with the unit you want to use.

```sh
# Reload local user's systemd instance to read 
# the changes in the local user's systemd definitions
systemctl --user daemon-reload

# Start the systemd unit for the current user
systemctl --user start "$SYSTEMD_UNIT"

# Enable the systemd unit to be ran even after system reboot
systemctl --user enable "$SYSTEMD_UNIT"
```
