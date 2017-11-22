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

