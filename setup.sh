#!/bin/sh

# Aliases
alias e="echo -e"
alias pac='yes "" | sudo pacman --noconfirm -S'
alias aur='yes "" | paru --noconfirm -S'

# URLs
URL_PARU="https://aur.archlinux.org/paru.git"
URL_NVM="https://raw.github.com/nvm-sh/nvm/v0.39.1/install.sh"
URL_OMZ="https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
URL_DOTBARE="https://github.com/kazhala/dotbare.git"
PATH_DOTBARE="$HOME/.oh-my-zsh/custom/plugins/dotbare"

# Colors
RESET="\e[0m"
WHITE="${RESET}\e[37;1m"
CYAN_L="${RESET}\e[36m\e[2m" # Dim (low)
CYAN_H="${RESET}\e[36;1m" # Bright (high)

# Version number
V="0.6"

# Intro text
e "${RESET}"
e "${CYAN_H}     o      oooooooooo    oooooooo8 ooooo ooooo ${WHITE}ooooooooooo ooooo  oooooooo8"
e "${CYAN_L}    888      888    888 o888     88  888   888  ${WHITE}88  888  88  888 o888     88"
e "${CYAN_H}   8  88     888oooo88  888          888ooo888  ${WHITE}    888      888 888        "
e "${CYAN_L}  8oooo88    888  88o   888o     oo  888   888  ${WHITE}    888      888 888o     oo"
e "${CYAN_H}o88o  o888o o888o  88o8  888oooo88  o888o o888o ${WHITE}   o888o    o888o 888oooo88 "
e "${RESET}Version $V"

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
e "${CYAN_H}"
figlet Done !
e "${RESET}"
