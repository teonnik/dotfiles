#!/bin/bash

# ------------------------------
# Pre-Installation

# Update the system clock
timedatectl set-ntp true

# TODO: partition the disks
# TODO: format the partitions
# TODO: edit mirrorlist

# Install base packages
pacstrap /mnt base linux linux-firmware

# Generate an fstab file
genfstab -U /mnt >> /mnt/etc/fstab


# ------------------------------
# Installation

# change root
arch-chroot /mnt

# Time zone
ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime
hwclock --systohc

# Localization TODO

# Root password
passwd

# Add a user
useradd -m teonnik

# Set pacman's Color option
sed -i '/Color/s/^#//g' /etc/pacman.conf 

# Install official Arch packages
packages=(

  # boot loader
  grub

  # display manager
  sddm

  # sway window manager
  sway swaylock swayidle wl-clipboard xorg-server-xwayland rofi grim kanshi

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
  zip unzip unrar jq tree wget curl base-devel

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

# TODO: Install AUR packages
# TODO: install yay
#git clone https://aur.archlinux.org/yay.git
#cd yay
#makepkg -si

#yay -S polybar \
#       skype \
#       mendeleydesktop

# TODO: konsole : trim trailing white spaces

# Custom
#
# TODO: spack
# TODO: setup dotfiles
# TODO: `firefox` addons: NoScript, LastPass


# ------------------------------
# vim

# install vim plugin manager
curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# install vim plugins
vim +PlugInstall +qall
# install YouCompleteMe
(cd ${HOME}/.vim/bundle/YouCompleteMe; python3 install.py --clangd-completer)


# ------------------------------
# zsh

# make zsh default shell
chsh -s $(which zsh)
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# install zsh spaceship
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
# install zsh autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Services
systemctl enable sddm.service \
                 bluetooth.service \
                 org.cups.cupsd.service \
                 NetworkManager.service \
                 syncthing@teonnik.service

# TODO: xdg-user-dirs ?

# Reboot
exit
reboot
