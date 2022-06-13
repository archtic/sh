#!/bin/sh

# Aliases
alias e="echo -e"
alias pac='yes "" | sudo pacman --noconfirm --needed -S'
alias aur='yes "" | paru --noconfirm --needed -S'

# URLs
URL_PARU="https://aur.archlinux.org/paru.git"
URL_NVM="https://raw.github.com/nvm-sh/nvm/v0.39.1/install.sh"
URL_OMZ="https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
URL_DOTBARE="https://github.com/kazhala/dotbare.git"

PATH_NVM="$HOME/.nvm"
PATH_OMZ="$HOME/.oh-my-zsh"
PATH_DOTBARE="$HOME/.oh-my-zsh/custom/plugins/dotbare"

# Colors
RESET="\e[0m"
WHITE="${RESET}\e[37;1m"
CYAN="${RESET}\e[36;1m"

# Version number
V="0.10"

# Intro text
e "${RESET}"
e "${CYAN}     o      oooooooooo    oooooooo8 ooooo ooooo ${WHITE}ooooooooooo ooooo  oooooooo8"
e "${CYAN}    888      888    888 o888     88  888   888  ${WHITE}88  888  88  888 o888     88"
e "${CYAN}   8  88     888oooo88  888          888ooo888  ${WHITE}    888      888 888        "
e "${CYAN}  8oooo88    888  88o   888o     oo  888   888  ${WHITE}    888      888 888o     oo"
e "${CYAN}o88o  o888o o888o  88o8  888oooo88  o888o o888o ${WHITE}   o888o    o888o 888oooo88 "
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
if [ -z $(command -v paru) ]; then
    git clone $URL_PARU
    cd paru
    yes "" | makepkg -si
    cd ..
    rm -rf ./paru
else
    echo "SKIPPING: paru"
fi

# Paru packages
paru -Syu
aur nerd-fonts-cascadia-code # Preferred font

# Install nvm
if [ ! -e "$PATH_NVM" ]; then
    wget -qO- $URL_NVM | bash # Node version manager
else
    echo "SKIPPING: nvm"
fi

# Load nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install node (LTS)
nvm install --lts
nvm use --lts

# Install ohmyzsh
if [ ! -e "$PATH_OMZ" ]; then
    yes | sh -c "$(wget $URL_OMZ -O-)"
else
    echo "SKIPPING: ohmyzsh"
fi

# Install OMZ plugin: Dotbare
if [ ! -e "$PATH_DOTBARE" ]; then
    git clone $URL_DOTBARE $PATH_DOTBARE 
else
    echo "SKIPPING: dotbare"
fi

# Finalize
fc-cache # Refresh fonts

# Done
e "${CYAN}"
figlet Done !
e "${RESET}"
