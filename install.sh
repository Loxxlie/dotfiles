#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
CROSS='\u274c'
CHECK='\u2714'
MARK='\u2023'

# Install bash-git-prompt
ins_bash_git_prmpt ()
{
    rm -rf ~/.bash-git-prompt
    git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
}

# Install fzf
ins_fzf ()
{
    rm -rf ~/.fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
}

# Install kube-ps1
ins_kube_ps1 ()
{
    mkdir ~/src
    rm -rf ~/src/kube-ps1
    git clone https://github.com/jonmosco/kube-ps1.git ~/src/kube-ps1 --depth=1
}

ins_nvm_and_npm()
{
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm install --lts
}

ins_obsidian()
{
    mkdir -p ~/.local/bin
    rm -f ~/.local/bin/Obsidian-1.5.12.AppImage 
    rm -f ~/.local/bin/obsidian
    wget -O ~/.local/bin/Obsidian-1.5.12.AppImage https://github.com/obsidianmd/obsidian-releases/releases/download/v1.5.12/Obsidian-1.5.12.AppImage
    chmod u+x ~/.local/bin/Obsidian-1.5.12.AppImage
    ln -s ~/.local/bin/Obsidian-1.5.12.AppImage ~/.local/bin/obsidian
}

# Install neovim
ins_neovim ()
{
    mkdir -p ~/.local/bin
    rm -f ~/.local/bin/nvim.appimange
    rm -f ~/.local/bin/nvim
    curl -o ~/.local/bin/nvim.appimage -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x ~/.local/bin/nvim.appimage
    ln -s ~/.local/bin/nvim.appimage ~/.local/bin/nvim
}

# Copy Configs/Snippets
ins_configs ()
{
    cp .bash_aliases ~/.bash_aliases
    cp .bashrc_loxx ~/.bashrc_loxx
    echo "[ -f ~/.bashrc_loxx ] && source ~/.bashrc_loxx" >> ~/.bashrc
    cp -Rf .config ~/.config
}

if [ ! -f ~/.bash-git-prompt/gitprompt.sh ]; then
    echo -e "${GREEN}${MARK}${NC} Installing bash-git-prompt..."
    ins_bash_git_prmpt
    echo -e "${GREEN}${CHECK}${NC} bash-git-prompt has been installed!"
else
    echo -e "${GREEN}${CHECK}${NC} bash-git-prompt already installed!"
fi

if [ ! -f ~/.fzf.bash ]; then
    echo -e "${GREEN}${MARK}${NC} Installing fzf..."
    ins_fzf
    echo -e "${GREEN}${CHECK}${NC} fzf has been installed!"
else
    echo -e "${GREEN}${CHECK}${NC} fzf already installed!"
fi

# if [ ! -f ~/src/kube-ps1/kube-ps1.sh ]; then
#    echo -e "${GREEN}${MARK}${NC} Installing kube-ps1..."
#    ins_kube_ps1
#    echo -e "${GREEN}${CHECK}${NC} kube-ps1 installed!"
# else
#    echo -e "${GREEN}${CHECK}${NC} kube-ps1 already installed!"
# fi

if [[ $(which nvim) ]]; then
    echo -e "${GREEN}${CHECK}${NC} Neovim already installed!"
else
    echo -e "${GREEN}${MARK}${NC} Neovim is not installed..."
    ins_neovim
    echo -e "${GREEN}${CHECK}${NC} Neovim has been installed!"
fi

if [[ $(which go) ]]; then
    echo -e "${GREEN}${CHECK}${NC} Golang already installed!"
else
    echo -e "${GREEN}${MARK}${NC} Golang is not installed."

    # Install GVM
    echo -e "${GREEN}${MARK}${NC} Installing gvm..."
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
    source ~/.gvm/scripts/gvm

    # Install go1.4 from source (required to build go1.17.13)
    echo -e "${GREEN}${MARK}${NC} Building go1.4 to build later versions..."
    gvm install go1.4 -B
    gvm use go1.4
    export GOROOT_BOOTSTRAP=$GOROOT

    # Install go1.17.13 (required to install go1.21.0)
    echo -e "${GREEN}${MARK}${NC} Installing go1.17.13 to build later versions..."
    gvm install go1.17.13
    gvm use go1.17.13
    export GOROOT_BOOTSTRAP=$GOROOT

    # Install go1.21 (required to install go1.22.3)
    echo -e "${GREEN}${MARK}${NC} Installing go1.21 to build later versions..."
    gvm install go1.21
    gvm use go1.21
    export GOROOT_BOOTSTRAP=$GOROOT

    # Install go1.22.3
    echo -e "${GREEN}${MARK}${NC} Installing go1.22.3..."
    gvm install go1.22.3

    echo -e "${GREEN}${CHECK}${NC} Golang has been installed!"
fi

if [[ $(which npm) ]]; then
    echo -e "${GREEN}${CHECK}${NC} npm already installed!"
else
    ins_nvm_and_npm
    echo -e "${GREEN}${CHECK}${NC} nvm and npm have been installed!"
fi

if [[ $(which obsidian) ]]; then
    echo -e "${GREEN}${CHECK}${NC} obsidian already installed!"
else
    ins_obsidian
    echo -e "${GREEN}${CHECK}${NC} obsidian has been installed!"
fi

echo -e "${GREEN}${MARK}${NC} Installing config files..."
ins_configs
echo -e "${GREEN}${CHECK}${NC} config files installed!"

