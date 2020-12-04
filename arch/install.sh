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

# Create local folders
mkdir -p ~/code ~/build ~/downloads ~/bin ~/install ~/software

# Install official Arch packages
packages=(
  grub        # boot loader
  efibootmgr  # EFI boot manager

  sddm                  # display manager
  sway                  # window manager
  xorg-server-xwayland  # wayland xorg support
  kanshi                # monitors setup manager
  swaylock              # screen locker
  swayidle              # desktop dimming manager
  wl-clipboard          # clipboard
  rofi                  # app launcher
  grim                  # screenshot utility
  mako libnotify        # notifications
  #wev                   # debugging Wayland events

  # lscpu
  util-linux

  xdg-user-dirs

  at                    # schedule commands

  hexyl          # command line hex viewer

  base-devel     # basic tools: make, which, gcc, grep, sudo, sed, etc
  zsh            # shell
  gvim           # editor
  ninja          # alternative to make
  gdb            # debugger
  git            # version control management
  cmake          # build tool
  diff-so-fancy  # better diff
  clang openmp   # clang with opnemp support

  # monitoring
  perf
  htop
  glances

  networkmanager  # network manager
  nethogs         # net top tool
  mtr             # traceroute alternative

  gnupg  # encryption and signing tool
  pass   # password store
  lastpass-cli
  pwgen  # generate passwords from the command line

  # vpn
  networkmanager-openconnect
  networkmanager-openvpn
  networkmanager-vpnc

  openssh # ssh
  wget
  curl
  aria2
  youtube-dl
  newsboat
  rtv
  github-cli

  # latex
  texlive-bin
  texlive-core
  texlive-science
  biber

  # fonts
  ttf-liberation
  ttf-font-awesome
  ttf-roboto
  powerline-fonts

  # qt
  qt5-wayland
  qt5ct

  # python
  python-black # formatting
  python-numpy
  python-scipy
  python-pandas
  python-matplotlib
  python-seaborn
  ipython
  jupyter

  # chat
  weechat
  weechat-matrix

  neomutt # email client
  notmuch # index and search mail
  lynx    # view HTML email
  msmtp   # SMTP client
  isync   # sync IMAP and Maildir mailboxes
  abook   # address book for mutt

  bluez bluez-utils                 # bluetooth
  pulseaudio pulseaudio-bluetooth   # sound server
  pavucontrol                       # volume control
  light                             # brightness
  cups                              # printing

  borg          # backup
  syncthing     # sync continuously
  rclone        # sync to cloud storage
  rsync         # sync to remote

  neofetch                    # system info
  zip unzip unrar             # archives
  jq                          # json
  fzf the_silver_searcher fd  # search
  ncdu tree                   # files & folders
  pacman-contrib pacgraph     # arch
  man man-db man-pages        # man pages
  tldr                        # alternative to man pages
  pdf2svg                     # pdf to svg converter
  playerctl                   # media player controller


  firefox               # browser
  qutebrowser
  nm-connection-editor  # network manager GUI
  keepassxc             # password manager
  konsole               # terminal emulator
  zathura-pdf-mupdf     # pdf viewer
  xournalpp             # pdf editor
  pdfarranger           # pdf merge/split/arrange
  imv                   # image viewer
  vlc                   # media player
  thunderbird           # mail client
  libreoffice-still     # office suite
  inkscape              # vector graphics editor
  gimp                  # raster graphics editor

  # no longer used: texstudio gwenview okular dolphin feh
)
pacman --noconfirm --needed -S  ${packages[@]}

# Install yay
git clone https://aur.archlinux.org/yay.git
(cd yay; makepkg -si)

# AUR packages
aur_pkgs=(
  skypeforlinux-stable-bin
  mendeleydesktop
  zoom
  slack-desktop
  navi-bin
  gcalcli
  mutt-wizard-git
  direnv
  ripgrep-all
)
yay --noconfirm --needed -S ${aur_pkgs[@]}

# spack
git clone https://github.com/spack/spack.git ~/code

# dotfiles
git clone https://github.com/teonnik/dotfiles.git ~/code
~/code/dotfiles/setup.sh

# TODO: `firefox` addons: NoScript (?), LastPass, Bypass Paywalls, Adblock Plus


# ------------------------------
# vim

# install vim plugin manager
curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# install vim plugins
vim +PlugInstall +qall
# install YouCompleteMe
(cd ${HOME}/.vim/bundle/YouCompleteMe; python3 install.py --clangd-completer)
# install bulgarian phonetic
curl -fLo ${HOME}/.vim/keymap/bulgarian-phonetic.vim --create-dirs http://www.math.bas.bg/bantchev/vim/bulgarian-phonetic.vim

# ------------------------------
# zsh

# make zsh default shell
chsh -s $(which zsh)
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
# install zsh autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Services
systemctl enable sddm.service \
                 bluetooth.service \
                 org.cups.cupsd.service \
                 NetworkManager.service \
                 syncthing@teonnik.service \
                 atd.service

# Fix for `light` on Arch
usermod -aG video <your-user>

# TODO: xdg-user-dirs ?

# Reboot
exit
reboot
