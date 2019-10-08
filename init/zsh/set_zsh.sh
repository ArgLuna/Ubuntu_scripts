#!/bin/bash
echo ">>Installing zsh..."
apt-get install -y zsh || exit

echo ">>Shell test"
which zsh || exit

echo ">>Installing oh-my-zsh..."
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo ">>Copy .zshrc"
cp ~/Ubuntu_scripts/init/zsh/zshrc ~/zshrc -v
cd ~/
echo "  export ZSH=\"`pwd`/.oh-my-zsh\"" > ~/.zshrc
cat ~/zshrc >> ~/.zshrc
rm ~/zshrc

echo ">>Set default shell..."
chsh -s `which zsh`

echo ">>Finish!"
