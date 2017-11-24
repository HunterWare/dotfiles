# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# brew install
brew install htop ssh-copy-id xtitle mosh
brew install vim --with-override-system-vi --with-python3 --with-luajit
brew install colordiff ripgrep vim cscope neovim sift fzf xz stow global telnet highlight mas the_silver_searcher

# Setup neovim
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim

# Install dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.vim/dein
rm installer.sh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
./install.sh

# Install powerlevel9k
git clone https://github.com/hunterware/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# Stow
git clone https://github.com/HunterWare/dotfiles .dotfiles
cd .dotfiles
stow vim emacs zsh

# Add objc to highlight
# edit /usr/local/etc/highlight/filetypes.conf
# Add:  { Lang="objc", Extensions={"m"} },

# Update iTerm selection background
# 93a1a1 -> 004656

# Fix solarized theme
patch -p1 ~/.emacs.d/elpa/color-theme-solarized-20171024.825/solarized-definitions.el < solarized-definitions.el.diff
