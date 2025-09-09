# vim: set filetype=sh :

PKGS=(

linux           # linux kernel and modules
linux-firmware  # firmware files

base         # bundle: bash, file, grep, gzip, iproute2, pacman, sed, shadow, systemd, tar, util-linux
util-linux   # bundle: chsh, cal, column, fdisk, hwclock, kill, lsblk, lscpu, mkfs, mount, su, umount
base-devel   # bundle: autoconf, automake, binutils, make, which, gcc, sudo, pkgconf

reflector       # Arch mirror list manager script for pacman
expac           # alpm database extraction tool
pacman-contrib  # Provides `pactree`

#grub        # boot loader
#os-prober   # detect other OS
efibootmgr  # EFI boot manager
#gptfdisk    # cgdisk TUI partitioner

systemd-tui

# login manager
ly

# sway
sway                  # window manager
swaylock              # screen locker
swayidle              # desktop dimming manager
swaybg                # wallpapers
xdg-desktop-portal-wlr # screen sharing

kanshi                # dynamic monitor setup on hotplug
xorg-server-xwayland  # wayland xorg support
wlr-randr             # monitor configuration tool
wl-clipboard          # clipboard
wofi                  # app launcher
grim                  # screenshot utility
swappy                # screenshot editting tool
slurp                 # select region on screen
mako libnotify        # notifications
#wev                   # debugging Wayland events
wf-recorder            # screen recording
foot                   # terminal emulator for Wayland
waybar                 # bar
wlsunset               # day/night gamma adjustments (redshift)
nwg-look               # gtk 3 theme configuration tool


# hyprland
hyprland
hyprpaper             # wallpapers
hyprpicker            # color picker
xdg-desktop-portal-hyprland


# XDG
xdg-utils             # provides default applications (xdg-open, xdg-mime, ...)

at                    # schedule commands
hexyl                 # command line hex viewer

# smart cards (electronic identification)
pcsclite              # PC/SC smart card daemon serving as middleware between apps and smart cards
ccid                  # generic driver for smart cards (CCID protocol - USB standard)
opensc
yubikey-manager       # YubiKey management (pcscd.service)

# git
git            # version control management
git-delta      # better diff
lazygit        # git TUI

# pager
bat            # modern alternative to cat/less
less


# shell
zsh

# editor
gvim vi
neovim

# build tools
ninja          # alternative to make
cmake          # build tool

# debuggers
gdb            # debugger
lldb           # debugger

# compilers
clang openmp

direnv         # env per folder
k9s            # Kubernetes TUI
bear           # LSP database generator for e.g. Makefile - compile_commands.json
bloaty         # Size profiler for binaries
binsider     # Elf binary analysis

# perf
perf
htop
btop

# system overview
fastfetch                   # maintained alternative to `neofetch`
onefetch                    # git repo info

# network tools
inetutils       # provides `hostname`
nethogs         # net top tool
mtr             # traceroute alternative
speedtest-cli   # measure internet speed

# passwords
gnupg        # encryption and signing tool
pass         # password store
minisign     # verify digital signatures
pwgen        # generate passwords from the command line

# internet
networkmanager         # network manager
network-manager-applet # network manager GUI (includes nm-connection-editor)

# vpn
networkmanager-openconnect # cisco anyconnect vpn

openssh # ssh
wget
curl

# youtube video/audio downloader
yt-dlp

# rss feed
newsboat

# latex
#
# - Use "native" installation instead - https://wiki.archlinux.org/title/TeX_Live
#
biber
texlab

# bash
bash-language-server

# lua
lua-language-server
stylua

# rust
rust-analyzer

# go
go

# fonts
ttf-liberation
ttf-font-awesome
ttf-roboto
powerline-fonts
noto-fonts
ttf-firacode-nerd

# qt
qt5-wayland
qt5ct

# python
uv           # fast `pip` alternative
ruff         # linter
python-black # formatting
python-parse # the reverse of `format()`, like scanf() in `C`
python-numpy
python-scipy
python-pandas
python-matplotlib
python-seaborn
python-dotenv
python-lsp-server # LSP
python-pytest
ipython

# ai
nodejs # copilot dependency

# chat
signal-desktop

# email
# neomutt # email client
# notmuch # index and search mail
# w3m     # view HTML email
# msmtp   # SMTP client
# isync   # sync IMAP and Maildir mailboxes
# khal    # calendar and events

# sound
pipewire-pulse
pipewire-alsa
wireplumber
pavucontrol                       # volume control
pulsemixer                        # TUI for PulseAudio

# bluetooth
bluez
bluez-utils
blueman     # bluetooth applet

# screen
brightnessctl                     # brightness

# printing
cups-pdf
avahi     # service discovery using mDNS/DNS-SD
nss-mdns  # `.local` hostnames resolution based on mDNS

translate-shell  # language translation in the terminal

borg          # backup
syncthing     # sync continuously
rsync         # sync to remote

# docs
man                         # man pages
tldr                        # alternative to man pages

# search & list files
fd                          # alternative to `find`
ripgrep                     # alternative to grep
fzf                         # fuzzy finder
tree
yazi                        # file manager
lsof                        # list open files

jq                          # json
zip unzip unrar             # archives
ncdu                        # disk: du alternative
playerctl                   # media player controller

# pdf
pdf2svg               # pdf to svg converter
zathura-pdf-mupdf     # pdf viewer
xournalpp             # pdf editor
pdfarranger           # pdf merge/split/arrange
ripgrep-all           # pdf grep

# browser
chromium
firefox

# image viewer
imv
viu          # terminal image viewer
imagemagick  # convert tool: png/jpg -> pdf

# containers
docker
docker-buildx

vlc                    # media player
mpv
libreoffice-still     # office suite
gimp                  # raster graphics editor
qbittorrent           # torrent client

) # PKGS

pacman -Syu --needed --noconfirm "${PKGS[@]}"
