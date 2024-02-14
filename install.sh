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

# Copy Configs/Snippets
ins_configs ()
{
    cp .bash_aliases ~/.bash_aliases
    cp .bashrc_loxx ~/.bashrc_loxx
    cp -r .config ~/.config
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

if [[ $(which go) ]]; then
    echo -e "${GREEN}${CHECK}${NC} Golang already installed!"
else
    echo -e "${RED}${CROSS}${NC} Golang is not installed. See: https://golang.org/doc/install"
fi

if [[ $(which nvim) ]]; then
    echo -e "${GREEN}${CHECK}${NC} neovim already installed!"
else
    echo -e "${RED}${CROSS}${NC} neovim is not installed. See: https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-source"
fi

echo -e "${GREEN}${MARK}${NC} Installing config files..."
ins_configs
echo -e "${GREEN}${CHECK}${NC} config files installed!"

