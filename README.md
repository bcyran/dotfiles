# Dotfiles
Personal setup for i3wm, vim, zsh, tmux and more. I use it with [i3-gnome](https://github.com/jcstr/i3-gnome).

![Setup screenshot](readme-image.png)

## Usage
These dotfiles are managed using [GNU stow](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/) so you should have it installed.

Start by cloning this repo to your home directory:

    git clone https://github.com/bcyran/dotfiles.git ~/.dotfiles

`cd` to this directory and use `stow` to symlink specific configs, for example:

    cd ~/.dotfiles
    stow zsh
    stow nvim

## Configs explanation
* `bash` - just `.bashrc` file, can be out of date as I currently use zsh
* `bin` - some scripts
* `compton` - config
* `dunst` - config and script to set firefox window as urgent on notifications
* `git` - mainly aliases, don't forget to change email and name!
* `i3` - config for i3wm
* `i3status` - config file and custom redshift module
* `nvim` - `init.vim` and `ftplugin` for neovim
* `oomox` - theme file
* `polybar` - config file, launching script, and some custom modules
* `redshift` - just redshift config file
* `rofi` - config file
* `services` - systemd `.service` files
* `shell` - `.aliases` and `.env` files, common for both bash and zsh configs
* `tmux` - tmux conf and terminfo file fixing some problem I dont even remember
* `urxvt` - URxvt color scheme and other settings
* `vim` - config for vim symlinked from `nvim`; I keep it just in case and I'm not even sure it will work because I currently use only neovim
* `zsh` - `.zshrc`, antibody and plugins configs
