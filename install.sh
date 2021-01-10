#!/bin/bash

# ホームディレクトリを英語名にする
LANG=C xdg-user-dirs-gtk-updat

sudo apt update
sudo apt -y upgrade

sudo apt -y install language-pack-ja
sudo update-locale LANG=ja_JP.UTF8

sudo apt install build-essential curl file git
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle

sudo apt install chrome-gnome-shell

$(mkdir -p ~/.config)

# VIM
$(ln -nfs ~/dotfiles/vim ~/.vim)
$(ln -nfs ~/dotfiles/vim/rc/vimrc ~/.vimrc)
$(ln -nfs ~/dotfiles/vim/rc/gvimrc ~/.gvimrc)

$(ln -nfs ~/dotfiles/vim ~/.config/nvim)
$(ln -nfs ~/dotfiles/vim/rc/vimrc ~/.config/nvim/init.vim)

# ZSH
$(ln -nfs ~/dotfiles/zsh/rc/zshrc ~/.zshrc)

# FISH
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
$(ln -nfs ~/dotfiles/fish/rc/fishrc ~/.config/fish/config.fish)

# MAINLINE
sudo add-apt-repository -y ppa:cappelikan/ppa
sudo apt update
sudo apt install -y mainline

sudo mainline --install-latest
