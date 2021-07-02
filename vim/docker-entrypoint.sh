#!/bin/bash

mkdir ~/.config
$(ln -nfs /vim ~/.config/nvim)
$(ln -nfs /vim/rc/vimrc ~/.config/nvim/init.vim)

exec ${@}




