#!/bin/sh

# Aliases / variables
alias pac='yes "" | sudo pacman -S'
alias aur='yes "" | paru -S'
NVM_URL="https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh"
OMZ_URL="https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
V="v0.1" # Version number

# Intro text
echo -e "\n\n\u001b[36mA R C H\u001b[0m T I C \u001b[36m$V\u001b[0m\n\n"

# Install necessary packages
sudo pacman -Syu
pac base-devel   # Build tools
pac iwd          # Wireless daemon
pac zsh          # Shell
pac xterm        # Fallback terminal emulator
pac alacritty    # Preferred erminal emulator
pac herbstluftwm # Window manager
pac neovim       # Editor
pac fontconfig   # Custom font support
pac ttf-dejavu   # Fallback font
pac chromium     # Web browser
pac git          # Source control
pac lazygit      # Git terminal UI
pac feh          # Image viewer
pac scrot        # Screen capture
pac htop         # Process viewer
pac wget         # Fetcher

# Install Paru
git clone https://aur.archlinux.org/paru.git
cd paru
yes "" | makepkg -si
cd ..
rm -rf ./paru

# Paru packages
paru -Syu
aur nerd-fonts-cascadia-code # Preferred font
aur dotbare                  # Dotfile manager

wget -qO- $NVM_URL | bash             # Install NVM
yes "" | sh -c "$(wget $OMZ_URL -O-)" # Install OMZ

# Finalize
fc-cache # Refresh fonts
