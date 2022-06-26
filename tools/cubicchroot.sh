#!/bin/bash

################################
## Initialization
################################

## Setting variables

# If you are running this script after an installation, please change $CHROOT to your actual home directory
# If you're confused by that, replace '/etc/skel/' with the output of 'echo $HOME' (your home directory aka ~)
# Every proceeding env variable relies on this 'dependency' variable.
export CHROOTHOME="/etc/skel/"
export ROFICONFIG="$CHROOTHOME/.config/rofi/"
export POLYBARCONFIG="$CHROOTHOME/.config/polybar/"

################################
## Repo/Software Management
################################

## Initialization
sudo apt update && sudo apt upgrade -y

## Installation
# Terminal-group
sudo apt install git gh micro zsh fonts-hack-ttf libx11-dev libxft-dev libxinerama-dev python3 python3-pip bat exa entr fzf thefuck htop bmon cbonsai cmatrix ranger lolcat gnugo gnuchess mpd ncmpcpp meson cmake -y
# Deb-get
curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo -E bash -s install deb-get
# Pacstall
sudo bash -c "$(curl -fsSL https://git.io/JsADh || wget -q https://git.io/JsADh -O -)"
# Desktop-group
sudo apt install dunst xterm kitty picom polybar rofi feh sxhkd pulseaudio alsa alsa-utils network-manager thunar -y
# Mainline kernel management
sudo add-apt-repository ppa:cappelikan/ppa
sudo apt update
sudo apt install mainline -y

################################
## GitHub Code 
################################

## Initialization
mkdir $CHROOTHOME/src/
export SOURCEDIR="$CHROOTHOME/src/"

## oh-my-zsh and plugins
cd $SOURCEDIR
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
export ZSH_CUSTOM="$CHROOTHOME/.oh-my-zsh/custom/"
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
# required configs already present & handled below

## powerline-shell
cd $SOURCEDIR
git clone https://github.com/b-ryan/powerline-shell
cd powerline-shell
python setup.py install
# required configs already present & handled below

## Berrywm
cd $SOURCEDIR
git clone https://github.com/JLErvin/berry
cd berry
make
sudo make install
# required configs already present & handled below
# TODO: In /usr/share/xsessions, berry.desktop file as follows:
#[Desktop Entry]
#Encoding=UTF-8
#Name=berry
#Comment=berry - a small window manager
#Exec=berry
#Type=XSession

################################
## CONFIGS
################################

## Initialization
cd $SOURCEDIR/
git clone https://github.com/bonsailinux/bonsailinux.git
export CONFIGDIR="$CHROOTHOME/bonsailinux/configs/.config/"

## .zshrc
# Backup oh-my-zsh's config; To switch configs on the fly, use 'source $HOME/<desired .zshrc>'
# Alterantively, you could comment out the proceeding line to live life on the edge with no back up.
cp $CHROOTHOME/.zshrc $CHROOTHOME/.zshrc-prebonsai
# Don't panic, whether the above is commented or not, you're getting a new .zshrc in the next line.
rm $CHROOTHOME/.zshrc
cp $SOURCEDIR/bonsailinux/configs/.zshrc $CHROOTHOME/

## berry
mkdir -p $CHROOTHOME/.config/berry
export BERRYCONFIG="$CHROOTHOME/.config/berry/"
cp $CONFIGDIR/berry/autostart $BERRYCONFIG
cp $CONFIGDIR/berry/sxhkdrc $BERRYCONFIG

## dunst
mkdir -p $CHROOTHOME/.config/dunst
export DUNSTCONFIG="$CHROOTHOME/.config/dunst/"
cp $CONFIGDIR/dunst/dunstrc $DUNSTCONFIG

## kitty
mkdir -p $CHROOTHOME/.config/kitty
export KITTYCONFIG="$CHROOTHOME/.config/kitty/"
cp $CONFIGDIR/kitty/kitty.conf $KITTYCONFIG

## picom
mkdir -p $CHROOTHOME/.config/picom
export PICOMCONFIG="$CHROOTHOME/.config/picom/"
cp $CONFIGDIR/picom/picom.conf $PICOMCONFIG

## polybar


## powerline-shell
mkdir -p $CHROOTHOME/.config/powerline-shell/themes
export POWERLINECONFIG="$CHROOTHOME/.config/powerline-shell/"
cp $CONFIGDIR/powerline-shell/config.json $POWERLINECONFIG/
cp $CONFIGDIR/powerline-shell/themes/pine.py $POWERLINECONFIG/themes/

## rofi
