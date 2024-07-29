#!/bin/sh

mkdir -p etc/nixos

mkdir -p home/geoffrey
mkdir -p home/geoffrey/.config

cp /etc/nixos/configuration.nix etc/nixos/

cp /home/geoffrey/.vimrc home/geoffrey/
cp /home/geoffrey/.zshrc home/geoffrey/
cp /home/geoffrey/.config/alacritty.toml home/geoffrey/.config/

cp -r /home/geoffrey/.config/i3 home/geoffrey/.config
cp -r /home/geoffrey/.config/polybar home/geoffrey/.config
cp -r /home/geoffrey/.config/keepassxc home/geoffrey/.config

cp -r /home/geoffrey/.vim home/geoffrey/
cp -r /home/geoffrey/.wallpapers home/geoffrey/

git add .
git commit -m "chore: desktop backup on $(date)"
git push
