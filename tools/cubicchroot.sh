#!/bin/bash

################################
## Initialization
################################

## Setting variables

# If you are running this script after an installation, please change $CHROOT to your actual home directory
# If you're confused by that, replace '/etc/skel/' with the output of 'echo $HOME' (your home directory aka ~)
# Every proceeding env variable relies on this 'dependency' variable.
export CHROOTHOME="/etc/skel/"
export ZSH_CUSTOM="$CHROOTHOME/.oh-my-zsh/custom/"

export DUNSTCONFIG="$CHROOTHOME/.config/dunst/"
export KITTYCONFIG="$CHROOTHOME/.config/kitty/"
export PICOMCONFIG="$CHROOTHOME/.config/picom/"

export ROFICONFIG="$CHROOTHOME/.config/rofi/"
export POLYBARCONFIG="$CHROOTHOME/.config/polybar/"

################################
## Apt repositories
################################

## Initialization
sudo apt update && sudo apt upgrade -y

## Installation
sudo apt install git gh micro zsh fonts-hack-ttf libx11-dev libxft-dev libxinerama-dev python3 python3-pip
#kitty being moved to github grab for the latest and greatest features

################################
## GitHub Code 
################################

## Initialization
mkdir $CHROOTHOME/src/
export SOURCEDIR="$CHROOTHOME/src/"

## Berrywm
cd $SOURCEDIR
git clone https://github.com/JLErvin/berry
cd berry
make
sudo make install
# required configs already present & handled below

## oh-my-zsh and plugins
cd $SOURCEDIR
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
# required configs already present & handled below

## powerline-shell
cd $SOURCEDIR
git clone https://github.com/b-ryan/powerline-shell
cd powerline-shell
python setup.py install
# required configs already present & handled below

################################
## CONFIGS
################################

## Initialization
cd $SOURCEDIR/
git clone https://github.com/bonsailinux/bonsailinux.git

## .zshrc
# Backup oh-my-zsh's config; To switch configs on the fly, use 'source $HOME/<desired .zshrc>'
# Alterantively, you could comment out the proceeding line to live life on the edge with no back up.
cp $CHROOTHOME/.zshrc $CHROOTHOME/.zshrc-prebonsai
# Don't panic, whether the above is commented or not, you're getting a new .zshrc in the next line.
rm $CHROOTHOME/.zshrc
cp $SOURCEDIR/bonsailinux/configs/.zshrc $CHROOTHOME/

## powerline-shell
mkdir -p $CHROOTHOME/.config/powerline-shell/themes
export POWERLINECONFIG="$CHROOTHOME/.config/powerline-shell/"
cp $SOURCEDIR/bonsailinux/configs/.config/powerline-shell/config.json $POWERLINECONFIG/
cp $SOURCEDIR/bonsailinux/configs/.config/powerline-shell/themes/pine.py $POWERLINECONFIG/themes/

## berry
mkdir -p $CHROOTHOME/.config/berry
export BERRYCONFIG="$CHROOTHOME/.config/berry/"
cp $SOURCEDIR/bonsailinux/configs/.config/berry/autostart $BERRYCONFIG
cp $SOURCEDIR/bonsailinux/configs/.config/berry/sxhkdrc $BERRYCONFIG
