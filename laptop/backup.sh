#!/bin/sh

mkdir -p etc/nixos

mkdir -p home/geff/
mkdir -p home/geff/.config

cp /etc/nixos/configuration.nix etc/nixos/

cp /home/geff/.vimrc home/geff/.vimrc
cp /home/geff/.zshrc home/geff/.zshrc
cp /home/geff/.config/alacritty.yml home/geff/.config/alacritty.yml

cp -r /home/geff/.config/i3 home/geff/.config/i3
cp -r /home/geff/.config/polybar home/geff/.config/polybar
cp -r /home/geff/.config/keepassxc home/geff/.config/keepassxc

cp -r /home/geff/.vim home/geff/.vim/
cp -r /home/geff/.wallpapers home/geff/.wallpapers/

git add .
git commit -m "chore: laptop backup on $(date)"
git push
