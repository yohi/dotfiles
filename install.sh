#!/bin/bash
$(mkdir -p ~/.config)

# VIM
$(ln -nfs ~/dotfiles/vim ~/.vim)
$(ln -nfs ~/dotfiles/vim/rc/vimrc ~/.vimrc)
$(ln -nfs ~/dotfiles/vim/rc/gvimrc ~/.gvimrc)

$(ln -nfs ~/dotfiles/vim ~/.config/nvim)
$(ln -nfs ~/dotfiles/vim/rc/vimrc ~/.config/nvim/init.vim)

rm -rf ~/.yarn/
curl -sL install-node.now.sh/lts | /bin/bash

# ZSH
$(ln -nfs ~/dotfiles/zsh/rc/zshrc ~/.zshrc)

# FISH
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
$(ln -nfs ~/dotfiles/fish/rc/fishrc ~/.config/fish/config.fish)
