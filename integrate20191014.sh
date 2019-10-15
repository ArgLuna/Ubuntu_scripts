#!/bin/bash
echo ">>Start to setup vim"
echo ">>Updating..."
apt-get update || exit

# git global config
# git config --global user.email ian955246@gmail.com
# git config --global user.name ArgLuna
# git config --global core.autocrlf false

echo ">> installing vim..."
apt-get install -y vim || exit

echo ">>Installing powerline fonts"
apt-get install -y fonts-powerline || exit

echo ">>Check ~/.vim/bundle"
ls ~/.vim || (echo "directory not found" ; mkdir -v ~/.vim)
ls ~/.vim/bundle || (echo "directory not found" ; mkdir -v ~/.vim/bundle)

echo ">>Copy .vimrc"
cp ~/Ubuntu_scripts/init/vimrc ~/.vimrc -v || exit

echo ">>Install Vundle and plugins"
echo ">>Plugin list:"
echo ">>** VundleVim/Vundle.vim"
echo ">>** ntpeters/vim-better-whitespace"
echo ">>** vim-airline/vim-airline"
echo ">>** vim-airline/vim-airline-themes"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall || exit

echo ">>Finished (vim)!"
echo "Use the vim command to check vundle installation:"
echo ":h vundle"
echo "---------------------------------------------------------"
echo ">>Installing zsh..."
apt-get install -y zsh || exit

echo ">>Shell test"
which zsh || exit

echo ">>Installing oh-my-zsh..."
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -) --unattended" || (echo "oh-my-zsh installation failed." ; exit)

echo ">>Copy .zshrc"
cat /dev/null > ~/.zshrc
echo "  export ZSH=\"`pwd`/.oh-my-zsh\"" > ~/.zshrc
cat ~/Ubuntu_scripts/init/zsh/zshrc >> ~/.zshrc

echo ">>Set default shell..."
chsh -s `which zsh` || exit

echo ">>Finish (zsh)!"
echo "---------------------------------------------------------"
echo ">>Installing tmux..."
apt-get install -y tmux || exit

echo ">>Copy .tmux.conf"
cp ~/Ubuntu_scripts/init/tmux/tmux.conf ~/.tmux.conf -v || exit

echo ">>Finish (tmux)!"
echo "---------------------------------------------------------"
echo ">>Installing nmap..."
apt-get install -y nmap || exit
echo ">>Finish (nmap)!"
echo "---------------------------------------------------------"
echo ">>Installing curl..."
apt-get install -y curl || exit
echo ">>Finish (curl)!"
echo "---------------------------------------------------------"
echo ">>Installing gdb..."
apt-get install -y gdb || exit
echo ">>Finish (gdb)!"
echo "---------------------------------------------------------"
echo ">>Installing peda..."
git clone https://github.com/longld/peda.git ~/peda || exit
echo "source ~/peda/peda.py" >> ~/.gdbinit

git clone https://github.com/scwuaptx/Pwngdb ~/Pwngdb || exit
cp ~/Pwngdb/.gdbinit ~/
echo ">>Finish (peda)!"
echo "---------------------------------------------------------"
echo ">>Installing iPython3..."
apt-get install -y ipython3 || exit
echo ">>Finish (iPython3)!"
echo "---------------------------------------------------------"
echo ">>Installing python3-tk..."
apt-get install -y python3-tk || exit
echo ">>Finish (iPython3)!"
echo "---------------------------------------------------------"
echo ">>Installing pip3..."
apt-get install -y python3-pip || exit
echo ">>Finish (python3-pip)!"
echo "---------------------------------------------------------"
echo ">>Installing Scapy..."
pip3 install scapy || exit
echo ">>Finish (Scapy)!"

