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

# Install neovim
ins_neovim ()
{
    mkdir -p ~/.local/bin
    rm -f ~/.local/bin/nvim.appimange
    curl -LO -o ~/.local/bin/nvim.appimage https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x ~/.local/bin/nvim.appimage
}

# Copy Configs/Snippets
ins_configs ()
{
    cp .bash_aliases ~/.bash_aliases
    cp .bashrc_loxx ~/.bashrc_loxx
    echo "[ -f ~/.bashrc_loxx ] && source ~/.bashrc_loxx" >> ~/.bashrc
    cp -Trf .config ~/.config
}

if [ ! -f ~/.bash-git-prompt/gitprompt.sh ]; then
    echo -e "${GREEN}${MARK}${NC} Installing bash-git-prompt..."
    ins_bash_git_prmpt
    echo -e "${GREEN}${CHECK}${NC} bash-git-prompt installed!"
else
    echo -e "${GREEN}${CHECK}${NC} bash-git-prompt already installed!"
fi

if [ ! -f ~/.fzf.bash ]; then
    echo -e "${GREEN}${MARK}${NC} Installing fzf..."
    ins_fzf
    echo -e "${GREEN}${CHECK}${NC} fzf installed!"
else
    echo -e "${GREEN}${CHECK}${NC} fzf already installed!"
fi

if [ ! -f ~/src/kube-ps1/kube-ps1.sh ]; then
    echo -e "${GREEN}${MARK}${NC} Installing kube-ps1..."
    ins_kube_ps1
    echo -e "${GREEN}${CHECK}${NC} kube-ps1 installed!"
else
    echo -e "${GREEN}${CHECK}${NC} kube-ps1 already installed!"
fi

if [[ $(which nvim) ]]; then
    echo -e "${GREEN}${CHECK}${NC} neovim already installed!"
else
    echo -e "${GREEN}${MARK}${NC} Installing neovim..."
    ins_neovim
    echo -e "${GREEN}${CHECK}${NC} neovim installed!"
fi

if [[ $(which go) ]]; then
    echo -e "${GREEN}${CHECK}${NC} Golang already installed!"
else
    echo -e "${RED}${CROSS}${NC} Golang is not installed. See: https://golang.org/doc/install"
fi

echo -e "${GREEN}${MARK}${NC} Installing config files..."
ins_configs
echo -e "${GREEN}${CHECK}${NC} config files installed!"

