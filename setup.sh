#!/bin/sh

# Aliases
alias e="printf"
alias pac='yes "" | sudo pacman --noconfirm --needed -S'
alias aur='yes "" | paru --noconfirm --needed -S'

# URLs
U_PARU="https://aur.archlinux.org/paru.git"
U_NVM="https://raw.github.com/nvm-sh/nvm/v0.39.1/install.sh"
U_OMZ="https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh"

U_ZSH_DOTBARE="https://github.com/kazhala/dotbare.git"
U_ZSH_FZF_TAB="https://github.com/Aloxaf/fzf-tab.git"
U_ZSH_AUTOSUGGESTIONS="https://github.com/zsh-users/zsh-autosuggestions.git"
U_ZSH_SYNTAX_HIGHLIGHTING="https://github.com/zsh-users/zsh-syntax-highlighting.git"

U_VIM_PLUG="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
U_BITWARDEN="https://vault.bitwarden.com/download/?app=desktop&platform=linux"
U_NNN_PLUGINS="https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs"

P_BIN="$HOME/bin"
P_NVM="$HOME/.nvm"
P_OMZ="$HOME/.oh-my-zsh"
P_OMZ_PLUGINS="$P_OMZ/custom/plugins"
P_VIM_PLUG="$HOME/.local/share/nvim/site/autoload/plug.vim"
P_DOTBARE="$HOME/.cfg"
P_NNN_PLUGINS="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/plugins"

# Colors
RESET="\e[0m"
WHITE="${RESET}\e[37;1m"
CYAN="${RESET}\e[36;1m"
YELLOW="${RESET}\e[33;1m"

# Version number
V="0.17"

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

omz_plugin () {
    if [ ! -e "${P_OMZ_PLUGINS}/${1}" ]; then
        git clone $2 $P_OMZ_PLUGINS/$1
    else
        skipping $1
    fi
}

# Intro text
e "\n"
e "${CYAN}     o      oooooooooo    oooooooo8 ooooo ooooo ${WHITE}ooooooooooo ooooo  oooooooo8"
e "${CYAN}    888      888    888 o888     88  888   888  ${WHITE}88  888  88  888 o888     88"
e "${CYAN}   8  88     888oooo88  888          888ooo888  ${WHITE}    888      888 888        "
e "${CYAN}  8oooo88    888  88o   888o     oo  888   888  ${WHITE}    888      888 888o     oo"
e "${CYAN}o88o  o888o o888o  88o8  888oooo88  o888o o888o ${WHITE}   o888o    o888o 888oooo88 "
e "${RESET}Version $V"

################################################################################

section "official packages"

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
pac man          # Manual page viewer
pac tldr         # Simplified manual viewer
pac glow         # Terminal markdown viewer
pac nnn          # Terminal file browser
pac tmux         # Terminal multiplexer
pac xorg-xinput  # Input device configuration tool

################################################################################

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

################################################################################

section "aur packages"

# AUR packages
paru -Syu
aur nerd-fonts-cascadia-code # Preferred font
aur autotiling

################################################################################

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

################################################################################

section "ohmyzsh"

# Install ohmyzsh
if [ ! -e "$P_OMZ" ]; then
    yes | sh -c "$(wget $U_OMZ -O-)"
else
    skipping "ohmyzsh"
fi

omz_plugin "dotbare" "$U_ZSH_DOTBARE"
omz_plugin "fzf-tab" "$U_ZSH_FZF_TAB"
omz_plugin "zsh-autosuggestions" "$U_ZSH_AUTOSUGGESTIONS"
omz_plugin "zsh-syntax-highlighting" "$U_ZSH_SYNTAX_HIGHLIGHTING"

################################################################################

section "neovim"

# Install vim-plug (for neovim)
if [ ! -e "$P_VIM_PLUG" ]; then
    curl -fLo "${P_VIM_PLUG} --create-dirs ${U_VIM_PLUG}"
else
    skipping "vim-plug"
fi

################################################################################

section "appimages"

mkdir -p "$P_BIN"

# AppImage: Bitwarden
if [ ! -e "${P_BIN}/bitwarden.AppImage" ]; then
    wget -O "${P_BIN}/bitwarden.AppImage" $U_BITWARDEN
else
    skipping "dotbare"
fi

chmod +x "${P_BIN}/bitwarden"

################################################################################

section "nnn"

# Install NNN plugins
if [ ! -e "$P_NNN_PLUGINS" ]; then
    curl -Ls $U_NNN_PLUGINS | sh
else
    skipping "dotbare"
fi

################################################################################

section "dotfiles"

if [ ! -e "$P_DOTBARE" ]; then
    dotbare finit -u https://github.com/archtic/dot.git
else
    skipping "dotbare"
fi

# Finalize
fc-cache # Refresh fonts
section "done !"
