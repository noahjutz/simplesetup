#!/bin/sh

function log() {
  echo
  echo "==> $1"
  echo
}

log "request root privileges"
sudo log "Thank you!"

log "restore dotfiles"
dotfiles_url=https://github.com/noahjutz/newdotfiles
git clone --bare $dotfiles_url $HOME/.cfg
git --git-dir=$HOME/.cfg/ --work-tree=$HOME checkout -f

log "restore gnome backup"
backup_path=$HOME/.cfg_files/gnome_settings_backup
dconf load / < $backup_path

log "rankmirrors"
sudo rankmirrors -f

log "update & upgrade"
sudo pacman -Syyu

log "install packages"
to_install="fish neovim"
sudo pacman -S --noconfirm $to_install

log "uninstall bloat"
to_remove="gedit totem file-roller gnome-calculator gparted kvantum-qt5 gnome-system-log zsh"
sudo pacman -Rcns --noconfirm $to_remove

log "uninstall orphans"
sudo pacman -R --noconfirm $(pacman -Qdtq)

log "set shell"
sudo chsh -s /usr/bin/fish noah

