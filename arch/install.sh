#!/bin/bash

# ------------------------------
# Pre-Installation

# Update the system clock
timedatectl set-ntp true

# Use `fdisk /dev/sdx` to partition the disk
#
# /dev/sdx1 : partition for booting
# - size: 512M
# - type: EFI System
#
# /dev/sdx2 : Arch OS partition
# - size: remaining
# - type: Linux Filesystem

# Format the partitions
#
# mkfs.fat -F32 /dev/sdx1
# mkfs.ext4 /dev/sdx2

# Mount partitions:
#
# mount /dev/sdx2 /mnt
# mkdir /mnt/boot
# mount /dev/sdx1 /mnt/boot

# TODO: edit mirrorlist

# Install base packages
packages=(
  linux           # linux kernel and modules
  linux-firmware  # firmware files

  base         # bundle: bash, file, grep, gzip, iproute2, pacman, sed, shadow, systemd, tar, util-linux
  util-linux   # bundle: chsh, cal, column, fdisk, hwclock, kill, lsblk, lscpu, mkfs, mount, su, umount
  base-devel   # bundle: autoconf, automake, binutils, make, which, gcc, sudo, pkgconf

  grub        # boot loader
  efibootmgr  # EFI boot manager

  sddm                  # display manager
  sway                  # window manager
  xorg-server-xwayland  # wayland xorg support
  kanshi                # monitors setup manager
  swaylock              # screen locker
  swayidle              # desktop dimming manager
  wl-clipboard          # clipboard
  wofi                  # app launcher
  grim                  # screenshot utility
  mako libnotify        # notifications
  waybar                # bar
  #wev                   # debugging Wayland events

  lsof                  # list open files

  alacritty             # terminal emulator
  xdg-user-dirs         # user directory manager
  at                    # schedule commands
  hexyl                 # command line hex viewer

  zsh            # shell
  gvim           # editor
  ninja          # alternative to make
  gdb            # debugger
  git            # version control management
  cmake          # build tool
  diff-so-fancy  # better diff
  clang          # compiler
  openmp         # clang's opnemp support

  # monitoring
  perf
  htop
  glances

  networkmanager  # network manager
  nethogs         # net top tool
  mtr             # traceroute alternative

  gnupg        # encryption and signing tool
  pass         # password store
  lastpass-cli # LastPass CLI password store
  pwgen        # generate passwords from the command line

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
  python-parse # the reverse of `format()`, like scanf() in `C`
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
  w3m     # view HTML email
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
  ncdu                        # disk: du alternative
  tree                        # files & folders
  pacman-contrib pacgraph     # arch
  asp                         # utility to retrieve PKGBUILD files
  man man-db man-pages        # man pages
  tldr                        # alternative to man pages
  pdf2svg                     # pdf to svg converter
  playerctl                   # media player controller


  firefox               # browser
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

  # no longer used: texstudio gwenview okular dolphin feh qutebrowser rofi
)
#pacman --noconfirm --needed -S  ${packages[@]}
pacstrap /mnt ${packages[@]}

# Generate the fstab file
genfstab -U /mnt >> /mnt/etc/fstab



# ------------------------------
# Post install

# Change root
arch-chroot /mnt

# Time zone
ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime
hwclock --systohc

# Localization
sed -i '/en_US.UTF-8 UTF-8/s/^#//g' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# Network
echo "teonnik" >> /etc/hostname
echo "127.0.1.1 teonnik.localdomain teonnik" >> /etc/hosts

# Bootloader
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Set pacman's Color option
sed -i '/Color/s/^#//g' /etc/pacman.conf

# Services
systemctl enable sddm.service \
                 NetworkManager.service \
                 bluetooth.service \
                 syncthing@teonnik.service \
                 atd.service
#                org.cups.cupsd.service

# Root password
passwd

# Add a user
useradd -m -a -G wheel,video -s /usr/bin/zsh teonnik
passwd teonnik
# TODO: edit /etc/sudoers to allow for the wheel group

# AUR package manager
git clone https://aur.archlinux.org/yay.git
(cd yay; makepkg -si)

# AUR packages
aur_pkgs=(
  skypeforlinux-stable-bin
  #mendeleydesktop
  slack-desktop
  #zoom
  direnv
  gcalcli
  ripgrep-all
  navi-bin
  procs-bin       # ps replacement
  stdman
  rusty-man
)
yay --noconfirm --needed -S ${aur_pkgs[@]}




# ------------------------------
# Local install

# Create local folders
mkdir -p ~/code ~/build ~/downloads ~/bin ~/install ~/software

# spack
git clone https://github.com/spack/spack.git ~/code

# dotfiles
git clone https://github.com/teonnik/dotfiles.git ~/code
~/code/dotfiles/setup.sh

# `firefox` addons: LastPass, Bypass Paywalls, AdBlocker Ultimate

# ssh keys
ssh-keygen -t ed25519 -C "teodor.nikolov22@gmail.com"

# install vim plugin manager
curl -fLo ${HOME}/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install vim plugins
vim +PlugInstall +qall

# install YouCompleteMe
(cd ${HOME}/.vim/bundle/YouCompleteMe; python3 install.py --clangd-completer)

# install bulgarian phonetic
curl -fLo ${HOME}/.vim/keymap/bulgarian-phonetic.vim --create-dirs http://www.math.bas.bg/bantchev/vim/bulgarian-phonetic.vim

# make zsh default shell : FIXME: doesn't work ??
#chsh -s $(which zsh)

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install powerlevel10k: `p10k configure`
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# install zsh autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# TODO: xdg-user-dirs ?
