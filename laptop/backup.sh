#!/bin/sh

mkdir -p etc/nixos

mkdir -p home/geff/
mkdir -p home/geff/.config

cp /etc/nixos/configuration.nix etc/nixos/

cp /home/geff/.vimrc home/geff/
cp /home/geff/.zshrc home/geff/
cp /home/geff/.config/alacritty.yml home/geff/.config/

cp -r /home/geff/.config/i3 home/geff/.config/
cp -r /home/geff/.config/polybar home/geff/.config/
cp -r /home/geff/.config/keepassxc home/geff/.config/

cp -r /home/geff/.vim home/geff/
cp -r /home/geff/.wallpapers home/geff/

git add .
git commit -m "chore: laptop backup on $(date)"
git push
