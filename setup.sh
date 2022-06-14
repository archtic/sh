#!/bin/sh

# Aliases
alias e="printf"
alias pac='yes "" | sudo pacman --noconfirm --needed -S'
alias aur='yes "" | paru --noconfirm --needed -S'

# URLs
U_PARU="https://aur.archlinux.org/paru.git"
U_NVM="https://raw.github.com/nvm-sh/nvm/v0.39.1/install.sh"
U_OMZ="https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
U_DOTBARE="https://github.com/kazhala/dotbare.git"
U_FZF_TAB="https://github.com/Aloxaf/fzf-tab.git"
U_VIM_PLUG="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
U_BITWARDEN="https://vault.bitwarden.com/download/?app=desktop&platform=linux"

P_BIN="$HOME/bin"
P_NVM="$HOME/.nvm"
P_OMZ="$HOME/.oh-my-zsh"
P_OMZ_PLUGINS="$P_OMZ/custom/plugins"
P_VIM_PLUG="$HOME/.local/share/nvim/site/autoload/plug.vim"

# Colors
RESET="\e[0m"
WHITE="${RESET}\e[37;1m"
CYAN="${RESET}\e[36;1m"
YELLOW="${RESET}\e[33;1m"

# Version number
V="0.14"

# Helper functions
section () {
    e "\n${RESET}Now installing...${CYAN}\n"
    figlet $1
    e "${RESET}"
    sleep 1
}

skipping () {
    e "${YELLOW}SKIPPING: $1 ${RESET}\n"
    sleep 1
}

# Intro text
e "\n"
e "${CYAN}     o      oooooooooo    oooooooo8 ooooo ooooo ${WHITE}ooooooooooo ooooo  oooooooo8"
e "${CYAN}    888      888    888 o888     88  888   888  ${WHITE}88  888  88  888 o888     88"
e "${CYAN}   8  88     888oooo88  888          888ooo888  ${WHITE}    888      888 888        "
e "${CYAN}  8oooo88    888  88o   888o     oo  888   888  ${WHITE}    888      888 888o     oo"
e "${CYAN}o88o  o888o o888o  88o8  888oooo88  o888o o888o ${WHITE}   o888o    o888o 888oooo88 "
e "${RESET}Version $V"

section "official packages"

# Install necessary packages
sudo pacman -Syu
pac base-devel   # Build tools
pac iwd          # Wireless daemon
pac zsh          # Shell
pac xterm        # Fallback terminal emulator
pac alacritty    # Preferred terminal emulator
pac i3-gaps      # Window manager
pac polybar      # Status bar
pac neovim       # Editor
pac fontconfig   # Custom font support
pac ttf-dejavu   # Fallback font
pac firefox      # Web browser
pac git          # Source control
pac lazygit      # Git terminal UI
pac feh          # Image viewer
pac scrot        # Screen capture
pac htop         # Process viewer
pac wget         # Fetcher
pac figlet       # Goof text
pac zoxide       # cd alternative
pac bat          # cat alternative
pac fzf          # Fuzzy finder
pac tree         # Recursive directory tree
pac fuse         # Required for AppImages

section "paru"

# Install Paru
if [ -z $(command -v paru) ]; then
    git clone $U_PARU
    cd paru
    yes "" | makepkg -si
    cd ..
    rm -rf ./paru
else
    skipping "paru"
fi

section "aur packages"

# AUR packages
paru -Syu
aur nerd-fonts-cascadia-code # Preferred font

section "nvm + node"

# Install nvm
if [ ! -e "$P_NVM" ]; then
    wget -qO- $U_NVM | bash # Node version manager
else
    skipping "nvm"
fi

# Load nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install node (LTS)
nvm install --lts
nvm use --lts

section "ohmyzsh"

# Install ohmyzsh
if [ ! -e "$P_OMZ" ]; then
    yes | sh -c "$(wget $U_OMZ -O-)"
else
    skipping "ohmyzsh"
fi

# Install OMZ plugin: Dotbare
if [ ! -e "${P_OMZ_PLUGINS}/dotbare" ]; then
    git clone $U_DOTBARE $P_OMZ_PLUGINS
else
    skipping "dotbare"
fi

# Install OMZ plugin: fzf-tab
if [ ! -e "${P_OMZ_PLUGINS}/fzf-tab" ]; then
    git clone $U_DOTBARE $P_OMZ_PLUGINS
else
    skipping "dotbare"
fi

section "neovim"

# Install vim-plug (for neovim)
if [ ! -e "$P_VIM_PLUG" ]; then
    curl -fLo "${P_VIM_PLUG} --create-dirs ${U_VIM_PLUG}"
else
    skipping "vim-plug"
fi

section "appimages"

mkdir -p "$P_BIN"

# AppImage: Bitwarden
if [ ! -e "${P_BIN}/bitwarden.AppImage" ]; then
    wget -O "${P_BIN}/bitwarden.AppImage" $U_BITWARDEN
else
    skipping "dotbare"
fi

chmod +x "${P_BIN}/bitwarden"


# Install dotfiles
section "dotfiles"

printf '\nDo you want to download and install dotfiles? [y/n] '
read answer

if [ "$answer" != "${answer#[Yy]}" ]; then
    echo "Not implemented"
else
    skipping "dotfiles"
fi

# Finalize
fc-cache # Refresh fonts
section "done !"
