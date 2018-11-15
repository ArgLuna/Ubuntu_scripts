echo ">>Start to setup vim"
echo ">>Updating..."
apt-get update || exit

echo ">>Check ~/.vim/bundle"
ls ~/.vim || (echo "directory not found" ; mkdir -v ~/.vim)
ls ~/.vim/bundle || (echo "directory not found" ; mkdir -v ~/.vim/bundle)

echo ">>Copy .vimrc"
cp ./vimrc ~/.vimrc -v

echo ">>Install Vundle and plugins"
echo ">>Plugin list:"
echo ">>** VundleVim/Vundle.vim"
echo ">>** ntpeters/vim-better-whitespace"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

echo ">>Finished!"
echo "Use the vim command to check vundle installation:"
echo ":h vundle"
