# Archtic: Shell scripts

## `setup.sh`

Run this script as your main user after `archinstall` completes and you've rebooted.
```
curl -Lo- https://raw.github.com/archtic/sh/main/setup.sh | sh
```
Installs the following:

* Paru
    * nerd-fonts-cascadia-code
* OhMyZsh
    * dotbare
* Official packages
    * base-devel
    * iwd
    * zsh
    * xterm
    * alacritty
    * herbstluftwm
    * neovim
    * fontconfig
    * ttf-dejavu
    * chromium
    * git
    * lazygit
    * feh
    * scrot
    * htop
    * wget
    * figlet

