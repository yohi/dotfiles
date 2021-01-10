#!/bin/bash

# ホームディレクトリを英語名にする
#LANG=C xdg-user-dirs-gtk-updat

sudo apt update
sudo apt -y upgrade

sudo apt -y install language-pack-ja
sudo update-locale LANG=ja_JP.UTF8

sudo apt install build-essential curl file git
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> /home/y_ohi/.profile
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
brew bundle

sudo apt install chrome-gnome-shell

$(mkdir -p ~/.config)

# VIM
pip3 install pynvim
$(ln -nfs ~/dotfiles/vim ~/.vim)
$(ln -nfs ~/dotfiles/vim/rc/vimrc ~/.vimrc)
$(ln -nfs ~/dotfiles/vim/rc/gvimrc ~/.gvimrc)


$(ln -nfs ~/dotfiles/vim ~/.config/nvim)
$(ln -nfs ~/dotfiles/vim/rc/vimrc ~/.config/nvim/init.vim)

# ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
$(ln -nfs ~/dotfiles/zsh/rc/zshrc ~/.zshrc)

# FISH
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
$(ln -nfs ~/dotfiles/fish/rc/fishrc ~/.config/fish/config.fish)

# MAINLINE
sudo add-apt-repository -y ppa:cappelikan/ppa
sudo apt update
sudo apt install -y mainline

sudo mainline --install-latest

sudo apt install refind
sudo refind-mkdefault

curl -fsSL https://get.docker.com/rootless | sh
export PATH=/home/testuser/bin:$PATH
export PATH=$PATH:/sbin
export DOCKER_HOST=unix:///run/user/1001/docker.sock
cat <<EOF | sudo sh -x
apt-get install -y uidmap
EOF
systemctl --user start docker.service
sudo loginctl enable-linger y_ohi   # TODO USERNAME

git config --global user.name 'Yusuke Ohi'
git config --global user.email 'yohi@diamondhead.tech'
