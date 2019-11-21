#!/bin/bash

# TODO: set pacman's Color option in /etc/pacman.conf

# Development
#
pacman -Syu make \
            git \
            cmake \
            zsh \
            qtcreator \
            gvim \
            perf

# Network
#
pacman -Syu nm-connection-editor \
            networkmanager \
            networkmanager-openconnect \
            networkmanager-openvpn \
            networkmanager-vpnc

# Security
#
pacman -Syu openssh \
            keepassxc

# LaTeX
#
pacman -Syu texlive-most \
            biber

# Fonts
#
pacman -Syu ttf-liberation \
            ttf-font-awesome \
            ttf-roboto \
            powerline-fonts

# KDE/Qt
#
pacman -Syu qt5ct \
            konsole \
            okular \
            dolphin \
            gwenview
 
# Printing
#
pacman -Syu cups

# Bluetooth
#
pacman -Syu bluez \
            bluez-utils

# Sway
#
pacman -Syu wl-clipboard \
            wofi \
            sway \
            light \
            lightdm

# Backup & Sync
#
pacman -Syu syncthing \
            borg \
            rclone \
            rsync

# PDF
#
pacman -Syu pdf2svg \
            pdfarranger

# CLI utils
#
pacman -Syu zip \
            unrar \
            jq \
            htop \
            youtube-dl \
            wget \
            pacman-contrib

# GUI apps
#
pacman -Syu mendeley \
            thunderbird \
            vlc \
            inkscape \
            gimp \
            libreoffice-still


# TODO: AUR packages
# TODO: install yay
#
#git clone https://aur.archlinux.org/yay.git
#cd yay
#makepkg -si

yay -S base-devel \
       polybar \
       skype


# TODO: install `firefox` addons: AddBlock, LastPass

# TODO: spack
# TODO: install oh-my-zsh, zsh spaceship, zsh autosuggestions
# TODO: vundle, YouCompleteMe, ctrlp

# TODO: services
