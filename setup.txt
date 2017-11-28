########## OSX
# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# brew install
brew install htop ssh-copy-id xtitle mosh
brew install vim --with-override-system-vi --with-python3 --with-luajit
brew install colordiff ripgrep vim cscope neovim sift fzf xz stow global telnet highlight mas the_silver_searcher
sudo pip3 install neovim

########## EL7
# EPEL
sudo yum install epel-release
# emacs repo
URL=https://copr.fedorainfracloud.org/coprs/outman/emacs/repo/epel-7/outman-emacs-epel-7.repo
curl -# -m 8 $URL -o /etc/yum.repos.d/emacs.repo
yum update emacs-nox
# Packages
sudo yum install colordiff cscope neovim stow global highlight the_silver_searcher emacs-nox ctags
sudo yum install python2-pip pythong34-devel python34-pip
sudo pip3 install typing neovim

# Setup neovim
mkdir .vim
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim

# Install dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.vim/dein
rm installer.sh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
./install.sh
rm install.sh

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
