# Ubuntu_scripts/init

Set up general enviroment.
This md is a simple note.

# Vim
*  Check installation
```
   Execute in vim
    :h vundle
```

*  Install new plugin
```
1. Add new line to .vimrc, between call vundle#begin() and call vundle#end().
    New line example: Plugin 'vim-airline/vim-airline'
2. Execute in vim
    :PluginInstall
   or in command line
    vim +PluginInstall +qall
```

*  Remove plugin
```
1. Remove Plugin xxxxxxxx in .vimrc.
2. Execute in vim
    :PluginClean
```

More detail:
https://github.com/VundleVim/Vundle.vim/blob/v0.10.2/doc/vundle.txt

*  Tab operations
```
:tabe <filename> (open <filename> in new tab)
<g><t> :tabn (next tab)
<g><T> :tabp (previous tab)
<num><t> :tabm <num> (switch to tab <num>)
```

*  Buffer operations
```
:bn (next buffer)
:bp (previous buffer)
:bd (close current buffer)
```
