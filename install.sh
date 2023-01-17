#!/bin/bash
# https://qiita.com/harmegiddo/items/0daac48c0f58596a52f1

cd /tmp

# ホームディレクトリを英語名にする
LANG=C xdg-user-dirs-gtk-update

sudo apt update
sudo apt -y upgrade

sudo apt -y install language-pack-ja
sudo update-locale LANG=ja_JP.UTF8

sudo apt -y install build-essential curl file wget

# Ubuntu Japanese
wget https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -P /etc/apt/trusted.gpg.d/
wget https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -P /etc/apt/trusted.gpg.d/
wget https://www.ubuntulinux.jp/sources.list.d/jammy.list -O /etc/apt/sources.list.d/ubuntu-ja.list
sudo apt update && apt install -y ubuntu-defaults-ja

# CapsLock -> Ctrl
setxkbmap -option "ctrl:nocaps"
sudo update-initramfs -u

# software-properties-common
sudo apt install -y software-properties-common

# flatpak
sudo apt install -y flatpak

# gdebi
sudo apt install -y gdebi

# chrome-gnome-shell
sudo apt -y install chrome-gnome-shell

# HOMEBREW
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
export PATH=/usr/local/bin:$PATH >> ~/.bash_profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" >> ~/.bash_profile
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
brew bundle

## config file

$(mkdir -p ~/.config)

# VIM
ln -nfs ~/dotfiles/vim ~/.vim
ln -nfs ~/dotfiles/vim/rc/vimrc ~/.vimrc
ln -nfs ~/dotfiles/vim/rc/gvimrc ~/.gvimrc
ln -nfs ~/dotfiles/vim ~/.config/nvim
ln -nfs ~/dotfiles/vim/rc/vimrc ~/.config/nvim/init.vim
ln -nfs ~/dotfiles/cspell ~/.config/cspell
ln -nfs ~/dotfiles/vim/denops_translate ~/.config/denops_translate
sudo apt install -y xclip xsel


# ZSH
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
$(ln -nfs ~/dotfiles/zsh/rc/zshrc ~/.zshrc)
$(ln -nfs ~/dotfiles/zsh/p10.zsh ~/.p10k.zsh)
sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)

# FISH
# curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
# $(ln -nfs ~/dotfiles/fish/rc/fishrc ~/.config/fish/config.fish)

# logiopts
# cf.) https://github.com/PixlOne/logiops
sudo ln -nfs ~/dotfiles/logid/logid.cfg /etc/logid.cfg


# git config
git config --global user.name 'Yusuke Ohi'
git config --global user.email "${EMAIL:-y.ohi@diamondhead.tech}"

# refind
sudo apt install -y refind
sudo refind-mkdefault

# ROOTLESS DOCKER
# curl -fsSL https://get.docker.com/rootless | sh
dockerd-rootless-setuptool.sh install
export PATH=/home/${USER}/bin:${PATH}
export PATH=${PATH}:/sbin
export DOCKER_HOST=unix:///run/user/1000/docker.sock
cat <<EOF | sudo sh -x
apt-get install -y uidmap
EOF
systemctl --user start docker.service
sudo loginctl enable-linger ${USER}
mkdir -p ~/.docker/cli-plugins
ln -sfn $(brew --prefix)/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose

# gnome shell
sudo apt install -y chrome-gnome-shell
sudo apt install -y gnome-tweaks

# for system monitor
sudo apt install -y gir1.2-gtop-2.0 gir1.2-nm-1.0 gir1.2-clutter-1.0

# terminator
sudo add-apt-repository -y ppa:mattrose/terminator
sudo apt update && sudo apt install -y terminator

# TablePlus
wget -qO - https://deb.tableplus.com/apt.tableplus.com.gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/tableplus-archive.gpg
sudo add-apt-repository -y "deb [arch=amd64] https://deb.tableplus.com/debian/22 tableplus main"
sudo apt update
sudo apt install -y tableplus

# tilix
sudo apt install -y tilix
dconf load /com/gexperts/Tilix/ < tilix/tilix.dconf

# GoogleChrome
sudo apt install -y google-chrome-stable google-chrome-beta

# KChangeGrind
sudo apt install -y kcachegrind

# pgadmin
curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
sudo apt install -y pgadmin4-desktop

# remmina
sudo apt-add-repository -y ppa:remmina-ppa-team/remmina-next
sudo apt update
sudo apt install -y remmina remmina-plugin-rdp remmina-plugin-secret

# blueman
sudo apt install -y blueman

# copyq
sudo add-apt-repository -y ppa:hluk/copyq
sudo apt update
sudo apt install -y copyq

# mattermost
curl -o- https://deb.packages.mattermost.com/setup-repo.sh | sudo bash
sudo apt install -y mattermost-desktop

# appimageluncher
sudo add-apt-repository -y ppa:appimagelauncher-team/stable
sudo apt update
sudo apt install -y appimagelauncher

# meld
sudo apt install -y meld

# extension-manager
sudo apt install -y gnome-shell-extension-manager

# conky
# cf.) https://www.kwonline.org/memo2/2020/11/04/ubuntu-20_04-install-conky/
sudo apt install -y conky-all

# synaptic
sudo apt install -y synaptic apt-xapian-index
update-apt-xapian-index -vf

## deb package
# dbeaver
wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
sudo gdebi -n dbeaver-ce_latest_amd64.deb

# mysqlworkbench
wget https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community_8.0.31-1ubuntu22.04_amd64.deb
sudo gdebi -n mysql-workbench-community_8.0.31-1ubuntu22.04_amd64.deb

# insomnia 2020.3.3
wget https://github.com/Kong/insomnia/releases/download/core%402020.3.3/Insomnia.Core-2020.3.3.deb
sudo gdebi -n Insomnia.Core-2020.3.3.deb

# wps-office
wget https://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/11664/wps-office_11.1.0.11664.XA_amd64.deb
sudo gdebi -n wps-office_11.1.0.11664.XA_amd64.deb

## flatpak package

# bottles TODO
# flatpak install flathub.com.usebottles.bottles

# discord TODO
# wget https://discord.com/api/download?platform=linux&format=deb

# postman TODO
# cf.) https://learning.postman.com/docs/getting-started/installation-and-updates/#installing-postman-on-linux
# wget https://www.postman.com/downloads/

# slack TODO

# rocketchat TODO

# chrome-remote-desktop TODO

# arctype TODO

# bitwarden TODO

# amazonworkspace TODO

# gyazo TODO




## appimage package

# beekeperstudio TODO
# wget https://github.com/beekeeper-studio/ultimate-releases/releases/download/v3.8.8/Beekeeper-Studio-Ultimate-3.8.8.AppImage




# -- extensions
# bluetooth battery indicator
# bluetooth quick connect
# frippy move clock
# switch workspaces on active monitor
# system-monitor-next
# teaks-syste-menu
# user-themes


# howdy
sudo add-apt-repository -y ppa:boltgolt/howdy
sudo apt update
sudo apt install -y howdy
sudo howdy add

# MAINLINE
sudo add-apt-repository -y ppa:cappelikan/ppa
sudo apt update && sudo apt install -y mainline

# Generete SSH Key
ssh-keygen -t ed25519 -C "${EMAIL:-y.ohi@diamondhead.tech}"
