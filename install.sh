#!/bin/bash
$(ln -nfs ~/dotfiles/vim ~/.vim)
$(ln -nfs ~/dotfiles/vim/rc/vimrc ~/.vimrc)
$(ln -nfs ~/dotfiles/vim/rc/gvimrc ~/.gvimrc)

$(mkdir -p ~/.config/nvim)
$(ln -nfs ~/dotfiles/vim/rc/vimrc ~/.config/nvim/init.vim)
