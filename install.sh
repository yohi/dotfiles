#!/bin/bash

# ホームディレクトリを英語名にする
LANG=C xdg-user-dirs-gtk-updat

sudo apt update
sudo apt -y upgrade

sudo apt -y install language-pack-ja
sudo update-locale LANG=ja_JP.UTF8

# HOMEBREW
sudo apt -y install build-essential curl file git
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> /home/y_ohi/.profile
# eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
brew bundle


sudo apt -y install chrome-gnome-shell

$(mkdir -p ~/.config)

# VIM
$(ln -nfs ~/dotfiles/vim ~/.vim)
$(ln -nfs ~/dotfiles/vim/rc/vimrc ~/.vimrc)
$(ln -nfs ~/dotfiles/vim/rc/gvimrc ~/.gvimrc)
$(ln -nfs ~/dotfiles/vim ~/.config/nvim)
$(ln -nfs ~/dotfiles/vim/rc/vimrc ~/.config/nvim/init.vim)
$(ln -nfs ~/dotfiles/cspell ~/.config/cspell)

# ZSH
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
$(ln -nfs ~/dotfiles/zsh/rc/zshrc ~/.zshrc)
$(ln -nfs ~/dotfiles/zsh/p10.zsh ~/.p10k.zsh)
sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)

# FISH
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
$(ln -nfs ~/dotfiles/fish/rc/fishrc ~/.config/fish/config.fish)

# MAINLINE
sudo add-apt-repository -y ppa:cappelikan/ppa
sudo apt update && sudo apt install -y mainline
sudo mainline --install-latest

# refind
sudo apt install -y refind
sudo refind-mkdefault

# ROOTLESS DOCKER
curl -fsSL https://get.docker.com/rootless | sh
export PATH=/home/${USER}/bin:${PATH}
export PATH=${PATH}:/sbin
export DOCKER_HOST=unix:///run/user/1000/docker.sock
cat <<EOF | sudo sh -x
apt-get install -y uidmap
EOF
systemctl --user start docker.service
sudo loginctl enable-linger ${USER}

# git config
git config --global user.name 'Yusuke Ohi'
git config --global user.email "${EMAIL:-yohi@diamondhead.tech}"

# gnome shell
sudo apt install -y chrome-gnome-shell
sudo apt install -y gnome-tweaks

# for system monitor
sudo apt install -y gir1.2-gtop-2.0 gir1.2-nm-1.0 gir1.2-clutter-1.0

# terminator
sudo add-apt-repository -y ppa:mattrose/terminator
sudo apt update && sudo apt install -y terminator

# postman
sudo snap install -y postman

# TablePlus
wget -O - -q http://deb.tableplus.com/apt.tableplus.com.gpg.key | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://deb.tableplus.com/debian tableplus main"
sudo apt update && sudo apt install -y tableplus

# howdy
sudo add-apt-repository -y ppa:boltgolt/howdy
sudo apt update
sudo apt install -y howdy
sudo howdy add

# Ubuntu Japanese
wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- | sudo apt-key add -
wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- | sudo apt-key add -
# sudo wget https://www.ubuntulinux.jp/sources.list.d/focal.list -O /etc/apt/sources.list.d/ubuntu-ja.list # 20.04
# sudo wget https://www.ubuntulinux.jp/sources.list.d/impish.list -O /etc/apt/sources.list.d/ubuntu-ja.list # 21.10
sudo wget https://www.ubuntulinux.jp/sources.list.d/jammy.list -O /etc/apt/sources.list.d/ubuntu-ja.list # 22.04
sudo apt update && sudo apt upgrade -y && sudo apt install -y ubuntu-defaults-ja

# CapsLock -> Ctrl
setxkbmap -option "ctrl:nocaps"
sudo update-initramfs -u

# tilix
sudo apt install tilix
dconf load /com/gexperts/Tilix/ < tilix/tilix.dconf

# GoogleChrome
sudo apt install google-chrome-stable google-chrome-beta

# KChangeGrind
sudo apt install kcachegrind

# pgadmin
sudo curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add
sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
sudo apt install pgadmin4-desktop

# remmina
sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
sudo apt update
sudo apt install remmina remmina-plugin-rdp remmina-plugin-secret

# https://qiita.com/harmegiddo/items/0daac48c0f58596a52f1




# apt install libmariadb-dev
