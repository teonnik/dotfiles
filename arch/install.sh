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
ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime  # FIXME
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
# TODO: vundle, YouCompleteMe, ctrlp
# TODO: oh-my-zsh, zsh spaceship, zsh autosuggestions
packages=(

  # boot loader
  grub

  # display manager
  lightdm-gtk-greeter lightdm

  # sway window manager
  sway swaylock swayidle wl-clipboard xorg-server-xwayland rofi grim

  # development
  make gdb git mercurial cmake zsh gvim qtcreator

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
  plasma-desktop qt5ct konsole okular dolphin gwenview qt5-wayland krdc

  # printing
  cups

  # bluetooth
  bluez bluez-utils

  # audio
  pulseaudio pulseaudio-bluetooth pavucontrol

  # brightness
  light

  # backup & sync
  syncthing-gtk syncthing borg rclone rsync

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

# Services
#
systemctl enable lightdm.service \
                 bluetooth.service \
                 org.cups.cupsd.service \
                 NetworkManager.service \
                 syncthing@teonnik.service

# TODO: xdg-user-dirs ?

# Reboot
#
exit
reboot
