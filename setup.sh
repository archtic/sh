#!/bin/sh

# Aliases
alias pac='yes "" | sudo pacman --noconfirm -S'
alias aur='yes "" | paru --noconfirm -S'

# URLs
URL_PARU="https://aur.archlinux.org/paru.git"
URL_NVM="https://raw.github.com/nvm-sh/nvm/v0.39.1/install.sh"
URL_OMZ="https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
URL_DOTBARE="https://github.com/kazhala/dotbare.git"
PATH_DOTBARE="$HOME/.oh-my-zsh/custom/plugins/dotbare"

# Colors
CYAN="\e[36m"
RESET="\e[0m"

# Version number
V="v0.3" 

# Intro text
echo -e "\n\n${CYAN}A R C H ${RESET}T I C ${CYAN}$V${RESET}\n\n"

# Install necessary packages
sudo pacman -Syu
pac base-devel   # Build tools
pac iwd          # Wireless daemon
pac zsh          # Shell
pac xterm        # Fallback terminal emulator
pac alacritty    # Preferred terminal emulator
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
pac figlet       # Goof text

# Install Paru
git clone $URL_PARU
cd paru
yes "" | makepkg -si
cd ..
rm -rf ./paru

# Paru packages
paru -Syu
aur nerd-fonts-cascadia-code # Preferred font

# Other stuff
wget -qO- $URL_NVM | bash             # Node version manager
yes | sh -c "$(wget $URL_OMZ -O-)"    # Oh my zsh
git clone $URL_DOTBARE $PATH_DOTBARE  # OMZ plugin: Dotbare

# Finalize
fc-cache # Refresh fonts

# Done
echo ${CYAN}
figlet Done
echo ${RESET}