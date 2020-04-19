#!/bin/bash

# ------------------------------
# Pre-Installation


# Update the system clock
#
timedatectl set-ntp true

# TODO: partition the disks
# TODO: format the partitions

# TODO: edit mirrorlist

# Install base packages
#
pacstrap /mnt base linux linux-firmware

# Generate an fstab file
#
genfstab -U /mnt >> /mnt/etc/fstab


# ------------------------------
# Installation

# Change root
#
arch-chroot /mnt

# Time zone
#
ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime
hwclock --systohc

# Localization TODO
#

# Root password
#
passwd

# Add a user
#
useradd -m teonnik

# Installs sway and plasma
#
# TODO: set pacman's Color option in /etc/pacman.conf
# TODO: `firefox` addons: AddBlock, LastPass, Saka key, bypass-paywall-firefox
# TODO: oh-my-zsh, zsh spaceship, zsh autosuggestions
packages=(

  # boot loader
  grub

  # display manager
  sddm

  # sway window manager
  sway swaylock swayidle wl-clipboard xorg-server-xwayland rofi grim

  # dev tools
  make gdb git mercurial cmake zsh gvim qtcreator clang openmp

  # dev libraries
  boost gperftools hwloc

  # notifications
  mako libnotify

  # performance
  perf htop

  # network
  nm-connection-editor networkmanager

  # vpn
  networkmanager-openconnect networkmanager-openvpn networkmanager-vpnc

  # web
  firefox youtube-dl wget

  # security
  su sudo openssh keepassxc

  # latex
  texlive-most biber

  # fonts
  ttf-liberation ttf-font-awesome ttf-roboto powerline-fonts

  # kde / qt
  plasma-desktop qt5ct konsole okular dolphin gwenview qt5-wayland

  # printing
  cups

  # bluetooth
  bluez bluez-utils

  # audio
  pulseaudio pulseaudio-bluetooth pavucontrol

  # brightness
  light

  # backup & sync
  syncthing borg rclone rsync

  # pdf
  pdf2svg pdfarranger xournalpp

  # utils
  zip unzip unrar jq tree

  # arch
  pacman-contrib pacgraph

  # docs
  man-db man-pages

  # images
  inkscape gimp

  # office
  thunderbird libreoffice-still

  # video
  vlc playerctl

)

pacman --noconfirm --needed -S  ${packages[@]}

# TODO: AUR packages
# TODO: install yay

#git clone https://aur.archlinux.org/yay.git
#cd yay
#makepkg -si

yay -S base-devel \
       polybar \
       skype \
       mendeleydesktop

# TODO: konsole : trim trailing white spaces

# Custom
#
# TODO: spack
# TODO: setup dotfiles

# install vim plugin manager
curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# install vim plugins
vim +PlugInstall +qall
# install YouCompleteMe
(cd ${HOME}/.vim/bundle/YouCompleteMe; python3 install.py --clangd-completer)

# Services
#
systemctl enable sddm.service \
                 bluetooth.service \
                 org.cups.cupsd.service \
                 NetworkManager.service \
                 syncthing@teonnik.service

# TODO: xdg-user-dirs ?

# Reboot
#
exit
reboot
