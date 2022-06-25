#!/bin/bash

## Apt repositories
sudo apt install git gh micro kitty zsh

## GitHub Code
mkdir src/
cd src
# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
