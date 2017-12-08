#!/bin/sh

ln -s ~/dotfiles/.conkyrc ~/.conkyrc 
ln -s ~/dotfiles/.emacs ~/.emacs
ln -s ~/dotfiles/.latexmkrc ~/.latexmkrc 
ln -s ~/dotfiles/.zshrc ~/.zshrc 

mkdir -p ~/.config/qtile
ln -s ~/dotfiles/qtile/config.py ~/.config/qtile/config.py
ln -s ~/dotfiles/qtile/autostart.sh ~/.config/qtile/autostart.sh

ln -s ~/dotfiles/termite/config ~/.config/termite/config

mkdir -p ~/Pictures/screenshot

mkdir -p ~/.config/i3
mkdir -p ~/.config/i3status
ln -s ~/dotfiles/i3/config ~/.config/i3/config
ln -s ~/dotfiles/i3status/config ~/.config/i3status/config

ln -s ~/dotfiles/rainbowstream/.rainbow_config.json ~/.rainbow_config.json
