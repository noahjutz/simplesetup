#!/bin/sh

# Request sudo
echo "Requesting root privileges."
sudo echo "Thank you!"

# Restore dotfiles
dotfiles_url=https://github.com/noahjutz/newdotfiles
git clone --bare $dotfiles_url $HOME/.cfg
git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout -f

# Restore gnome backup
backup_path=$HOME/.cfg_files/gnome_settings_backup
dconf load / < $backup_path

sudo rankmirrors -f
sudo pacman -Syyu

# Install packages
sudo pacman -S --noconfirm $(cat to_install.txt)

# Uninstall bloat
sudo pacman -Rns --noconfirm $(cat to_remove.txt)

# Set shell
sudo chsh -s /usr/bin/fish noah
