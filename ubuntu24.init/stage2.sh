#!/bin/bash

source init.conf.sh

customize_vim() {
    printf "---------------------------------------------------------\n"
    printf ">>Installing powerline fonts\n"
    sudo apt-get install -y fonts-powerline || exit

	mkdir -v -p ~/.vim/bundle

    printf ">>Copy .vimrc\n"
    cp "./vimrc" ~/.vimrc -v || exit

    printf ">>Getting Vundle...\n"
    if [[ -e "~/.vim/bundle/Vundle.vim" ]] ; then
        printf "~/.vim/bundle/Vundle.vim found. Updating...\n"
		git -C ~/.vim/bundle/Vundle.vim pull
    else
        printf "Downloading Vundle...\n"
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi

    printf ">>Install Vundle and plugins\n"
    printf ">>Plugin list:\n"
    printf ">>** VundleVim/Vundle.vim\n"
    printf ">>** ntpeters/vim-better-whitespace\n"
    printf ">>** vim-airline/vim-airline\n"
    printf ">>** vim-airline/vim-airline-themes\n"
    #git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall || exit

    printf ">>Finished (vim)!\n"
    printf "Use the vim command to check vundle installation:\n"
    printf ":h vundle\n"
    printf "---------------------------------------------------------\n"
}

customize_zsh() {
    printf "---------------------------------------------------------\n"
    printf ">>Installing zsh...\n"
    sudo apt-get install -y zsh || exit

    if [[ ! -e ".oh-my-zsh" ]] ; then
        printf ">>Installing oh-my-zsh...\n"
        sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -) --unattended" || (printf "oh-my-zsh installation failed." ; exit)
    fi

    printf ">>Copy .zshrc\n"
	cp ./zshrc ~/.zshrc

    printf ">>Finish (zsh)!\n"
    printf "---------------------------------------------------------\n"
}

install_pkgs

disable_auto_update

customize_vim

customize_zsh

set_default_shell

set_timezone
