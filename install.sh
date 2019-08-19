# Install bash-git-prompt
rm -rf ~/.bash-git-prompt
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

# Install vim-plug for nvim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install silver searcher
sudo apt-get install silversearcher-ag

# Install fzf
rm -rf ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Copy Configs/Snippets
# Copy Configs over
cp configs/.bash_aliases ~/.bash_aliases
cp configs/.bashrc_loxx ~/.bashrc_loxx
cp configs/init.vim ~/.config/nvim/init.vim
cp configs/.vimrc ~/.vimrc

# Copy Vim snippets to correct location
cp -r snippets ~/.vim/snippets
