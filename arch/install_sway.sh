#!/bin/bash

# TODO: set pacman's Color option in /etc/pacman.conf

# Other: ??
#
# alsa-utils 
# b43-fwcutter

packages=(

  # sway
  sway swaylock swayidle wl-clipboard xorg-server-xwayland rofi lightdm

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
  sudo openssh keepassxc 

  # latex
  texlive-most biber 

  # fonts
  ttf-liberation ttf-font-awesome ttf-roboto powerline-fonts

  # kde / qt
  qt5ct konsole okular dolphin gwenview

  # printing
  cups

  # bluetooth
  bluez bluez-utils

  # audio
  pulseaudio pulseaudio-bluetooth

  # brightness
  light

  # backup & sync
  syncthing borg rclone rsync

  # pdf
  pdf2svg pdfarranger

  # utils
  zip unzip unrar jq  tree

  # arch
  pacman-contrib pacgraph

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
#
#git clone https://aur.archlinux.org/yay.git
#cd yay
#makepkg -si

yay -S base-devel \
       polybar \
       skype \
       mendeleydesktop 


# TODO: install `firefox` addons: AddBlock, LastPass

# TODO: spack
# TODO: install oh-my-zsh, zsh spaceship, zsh autosuggestions
# TODO: vundle, YouCompleteMe, ctrlp

# TODO: services
