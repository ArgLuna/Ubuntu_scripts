echo ">>Start to setup vim"
echo ">>Updating..."
apt-get update || exit
echo ">>Copy .vimrc"
cp ./vimrc ~/.vimrc -v
echo ">>Enter ~/.vim/bundle"
cd ~/.vim/bundle || exit

echo ">>Install required packages for YCM"
apt-get install -y build-essential cmake python-dev python3-dev clang

echo ">>Install Vundle and plugins"
echo ">>Plugin list:"
echo ">>** VundleVim/Vundle.vim"
echo ">>** Valloric/YouCompleteMe"
echo ">>** ntpeters/vim-better-whitespace"
git clone https://github.com/VundleVim/Vundle.vim.git
vim +PluginInstall +qall

echo ">>Compile YCM and setup config"
cd ~/.vim/bundle/YouCompleteMe
YCM_CORES=1 ./install.py --clang-completer
cp third_party/ycmd/examples/.ycm_extra_conf.py plugin/

echo ">>Finished! Return to home directory"
cd
