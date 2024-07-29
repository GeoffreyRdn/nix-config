#!/bin/sh

mkdir -p etc/nixos
mkdir -p home/geoffrey

cp /etc/nixos/configuration.nix etc/nixos/

cp /home/geoffrey/.vimrc home/geoffrey/.vimrc
cp /home/geoffrey/.zshrc home/geoffrey/.zshrc

cp -r /home/geoffrey/.config home/geoffrey/.config/
cp -r /home/geoffrey/.vim home/geoffrey/.vim/
cp -r /home/geoffrey/.wallpapers home/geoffrey/.wallpapers/

git add .
git commit -m "chore: backup on $(date)"
git push
