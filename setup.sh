#!/bin/sh

# Variables
NVM_URL = "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh"
OMZ_URL="https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
V="v0.1" # Version number

# Intro text
echo -e "\n\n\u001b[36mA R C H\u001b[0m T I C \u001b[36m$V\u001b[0m\n\n"

# Install necessary packages
yes | sudo pacman -Syu \
    base-devel   \ # Build tools
    iwd          \ # Wireless daemon
    zsh          \ # Shell
    xterm        \ # Fallback terminal emulator
    alacritty    \ # Preferred erminal emulator
    herbstluftwm \ # Window manager
    neovim       \ # Editor
    fontconfig   \ # Custom font support
    ttf-dejavu   \ # Fallback font
    chromium     \ # Web browser
    git          \ # Source control
    lazygit      \ # Git terminal UI
    feh          \ # Image viewer
    scrot        \ # Screen capture
    htop         \ # Process viewer
    wget         \ # Fetcher
/

# Install Paru
git clone https://aur.archlinux.org/paru.git
cd paru
yes | makepkg -si
cd ..
rm -rf ./paru

# Paru packages
paru -Syu \
    nerd-fonts-cascadia-code \ # Preferred font
    dotbare                  \ # Dotfile manager

/

wget -qO- $NVM_URL | bash             # Install NVM
yes | sh -c "$(wget $OMZ_URL -O-)"    # Install OMZ

# Finalize
fc-cache                               # Refresh fonts