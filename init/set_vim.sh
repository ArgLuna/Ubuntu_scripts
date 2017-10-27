echo Start to setup vim
echo copy .vimrc
cp ./vimrc ~/.vimrc
echo Enter ~/.vim/bundle
cd ~/.vim/bundle || exit

echo Install required packages for YCM
apt-get install -y build-essential cmake python-dev python3-dev clang

echo Install Vundle and plugins
git clone https://github.com/VundleVim/Vundle.vim.git
vim +PluginInstall +qall

echo Compile YCM and setup config
../YouCompleteMe/install.py --clang-completer
cp third_party/ycmd/examples/.ycm_extra_conf.py plugin/

echo Finished! Return to home directory
cd
