# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# brew install
brew install htop ssh-copy-id xtitle mosh
brew install vim --with-override-system-vi --with-python3 --with-luajit
brew install colordiff ripgrep vim cscope neovim sift fzf xz stow global telnet highlight mas the_silver_searcher

# dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.vim/dein
rm installer.sh

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
./install.sh
# powerlevel9k
git clone https://github.com/hunterware/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

git clone https://github.com/HunterWare/dotfiles .dotfiles
cd .dotfiles

ln -s ~/.vim ~/.config/nvim

