#!/bin/bash
cd
src="`pwd`/Ubuntu_scripts"
if [ ! -e "$src" ]
then
	echo "$src not found."
	echo "Installation terminated."
	exit
fi

echo "Setting timezone to Asia/Taipei"
sudo timedatectl set-timezone Asia/Taipei
timedatectl

echo ">>Updating..."
sudo apt-get update || exit

# git global config
# git config --global user.email ian955246@gmail.com
# git config --global user.name ArgLuna
# git config --global core.autocrlf false

echo ">> installing vim..."
sudo apt-get install -y vim || exit

echo ">>Installing powerline fonts"
sudo apt-get install -y fonts-powerline || exit

echo ">>Check ~/.vim/bundle"
if [ -e ".vim" ]
then
	echo ".vim found."
else
	echo ".vim not found"
	mkdir -v .vim
fi

if [ -e ".vim/bundle" ]
then
    echo ".vim/bundle found."
else
    echo ".vim/bundle not found"
    mkdir -v .vim/bundle
fi

echo ">>Copy .vimrc"
cp "$src/init/vimrc" .vimrc -v || exit

echo ">>Getting Vundle..."
if [ -e ".vim/bundle/Vundle.vim" ]
then
	echo ".vim/bundle/Vundle.vim found. Updating..."
	cd .vim/bundle/Vundle.vim
	git pull
	cd
else
	echo "Downloading Vundle..."
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

echo ">>Install Vundle and plugins"
echo ">>Plugin list:"
echo ">>** VundleVim/Vundle.vim"
echo ">>** ntpeters/vim-better-whitespace"
echo ">>** vim-airline/vim-airline"
echo ">>** vim-airline/vim-airline-themes"
#git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall || exit

echo ">>Finished (vim)!"
echo "Use the vim command to check vundle installation:"
echo ":h vundle"
echo "---------------------------------------------------------"
echo ">>Installing zsh..."
sudo apt-get install -y zsh || exit

if [ ! -e ".oh-my-zsh" ]
then
	echo ">>Installing oh-my-zsh..."
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -) --unattended" || (echo "oh-my-zsh installation failed." ; exit)
fi

echo ">>Copy .zshrc"
cd
echo "  export ZSH=\"`pwd`/.oh-my-zsh\"" > .zshrc
cat "$src/init/zsh/zshrc" >> .zshrc

echo ">>Finish (zsh)!"
echo "---------------------------------------------------------"
echo ">>Installing tmux..."
sudo apt-get install -y tmux || exit

echo ">>Copy .tmux.conf"
cp "$src/init/tmux/tmux.conf" .tmux.conf -v || exit

echo ">>Finish (tmux)!"
echo "---------------------------------------------------------"
echo ">>Installing nmap..."
sudo apt-get install -y nmap || exit
echo ">>Finish (nmap)!"
echo "---------------------------------------------------------"
echo ">>Installing curl..."
sudo apt-get install -y curl || exit
echo ">>Finish (curl)!"
echo "---------------------------------------------------------"
echo ">>Installing gdb..."
sudo apt-get install -y gdb || exit
echo ">>Finish (gdb)!"
echo "---------------------------------------------------------"
echo ">>Installing peda..."
if [ -e peda ]
then
	echo "Updating peda..."
	cd peda
	git pull || exit
	cd
else
	echo "Installing peda..."
	git clone https://github.com/longld/peda.git ~/peda || exit
	echo "source ~/peda/peda.py" >> ~/.gdbinit
fi

if [ -e Pwngdb ]
then
	echo "Updating Pwngdb..."
    cd Pwngdb
    git pull || exit
    cd
else
	 echo "Installing Pwngdb..."
	git clone https://github.com/scwuaptx/Pwngdb ~/Pwngdb || exit
	cp ~/Pwngdb/.gdbinit ~/
fi

echo ">>Finish (peda)!"
echo "---------------------------------------------------------"
echo ">>Installing iPython3..."
sudo apt-get install -y ipython3 || exit
echo ">>Finish (iPython3)!"
echo "---------------------------------------------------------"
echo ">>Installing python3-tk..."
sudo apt-get install -y python3-tk || exit
echo ">>Finish (iPython3)!"
echo "---------------------------------------------------------"
echo ">>Installing pip3..."
sudo apt-get install -y python3-pip || exit
echo ">>Finish (python3-pip)!"
echo "---------------------------------------------------------"
echo ">>Installing Scapy..."
pip3 install scapy || exit
echo ">>Finish (Scapy)!"
echo "---------------------------------------------------------"
echo ">>Installing cscope..."
apt-get install -y cscope || exit
echo ">>Finish (cscope)!"
echo "---------------------------------------------------------"
echo ">>Set default shell..."
chsh -s `which zsh` || exit
sudo chsh -s `which zsh` || exit
echo ">>Finish!"
