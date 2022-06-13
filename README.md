# Archtic: Shell scripts

## `setup.sh`

Run this script as your main user after `archinstall` completes and you've rebooted.
```
curl -Lo- https://raw.github.com/archtic/sh/main/setup.sh | sh
```
Installs the following:
```
* Official packages
    * base-devel                # Build tools
    * iwd                       # Wireless daemon
    * zsh                       # Shell
    * xterm                     # Fallback terminal emulator
    * alacritty                 # Preferred terminal emulator
    * herbstluftwm              # Window manager
    * neovim                    # Editor
    * fontconfig                # Custom font support
    * ttf-dejavu                # Fallback font
    * chromium                  # Web browser
    * git                       # Source control
    * lazygit                   # Git terminal UI
    * feh                       # Image viewer
    * scrot                     # Screen capture
    * htop                      # Process viewer
    * wget                      # Fetcher
    * figlet                    # Goof text
    * zoxide                    # cd alternative
    * bat                       # cat alternative
    * fzf                       # Fuzzy finder
    * tree                      # Recursive directory tree

* Paru                          # AUR helper
    * nerd-fonts-cascadia-code  # Preferred font

* OhMyZsh                       # ZSH plugin framework
    * dotbare                   # Dotfile manager

* nvm                           # Node version manager
    * node                      # Node.js javascript env, LTS
```