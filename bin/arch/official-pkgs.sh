# vim: set filetype=sh :

PKGS=(

linux           # linux kernel and modules
linux-firmware  # firmware files

base         # bundle: bash, file, grep, gzip, iproute2, pacman, sed, shadow, systemd, tar, util-linux
util-linux   # bundle: chsh, cal, column, fdisk, hwclock, kill, lsblk, lscpu, mkfs, mount, su, umount
base-devel   # bundle: autoconf, automake, binutils, make, which, gcc, sudo, pkgconf

binsider     # Elf binary analysis

reflector   # Arch mirror list manager script for pacman
pacutils    # Provides `paclog`

#grub        # boot loader
#os-prober   # detect other OS
efibootmgr  # EFI boot manager
#gptfdisk    # cgdisk TUI partitioner

# --- sway setup
sway                  # window manager
swaylock              # screen locker
swayidle              # desktop dimming manager
swaybg                # wallpapers
xorg-server-xwayland  # wayland xorg support
wlr-randr             # monitor configuration tool
kanshi                # dynamic monitor setup on hotplug
wl-clipboard          # clipboard
wofi                  # app launcher
grim                  # screenshot utility
swappy                # screenshot editting tool
slurp                 # select region on screen
mako libnotify        # notifications
#wev                   # debugging Wayland events
xdg-desktop-portal-wlr # screen sharing
wf-recorder            # screen recording
foot                   # terminal emulator for Wayland
waybar                 # bar
wlsunset               # day/night gamma adjustments (redshift)
nwg-look               # gtk 3 theme configuration tool


# --- i3 setup
i3-wm
xorg-server
alacritty              # terminal emulator for i3
rofi                   # app launcher for i3
xorg-xinit             # X session launcher - startx (no login manager)
xorg-xkill             # kill unresponsive X windows
xorg-setxkbmap         # keyboard layout
xclip                  # clipboard utility
i3lock
scrot maim             # screenshots
dunst                  # notification daemon
arandr
redshift
i3status-rust          # bar

ly                    # login manager

lsof                  # list open files
xdg-utils             # provides default applications (xdg-open, xdg-mime, ...)
handlr-regex          # new alternative to xdg-open
xdg-user-dirs
# gendesk             # utility to generate .desktop files

at                    # schedule commands
hexyl                 # command line hex viewer
nnn                   # fast terminal file manager

# smart cards (electronic identification)
pcsclite              # PC/SC smart card daemon serving as middleware between apps and smart cards
ccid                  # generic driver for smart cards (CCID protocol - USB standard)
opensc
yubikey-manager       # YubiKey management (pcscd.service)

zsh            # shell
gvim vi        # editor
neovim
ninja          # alternative to make
gdb            # debugger
direnv         # env per folder
bat            # modern alternative to cat/less
git            # version control management
lazygit        # git TUI
k9s            # Kubernetes TUI
cmake          # build tool
#diff-so-fancy  # better diff
git-delta      # better diff
clang          # compiler
lldb           # debugger
openmp         # clang's opnemp support
bear           # LSP database generator for e.g. Makefile - compile_commands.json
# renameutils    # mv with $EDITOR - qmv
bloaty         # Size profiler for binaries

# monitoring
perf
htop
glances

neofetch                    # system info
onefetch                    # git repo info

inetutils       # provides `hostname`
nethogs         # net top tool
mtr             # traceroute alternative
speedtest-cli   # measure internet speed

gnupg        # encryption and signing tool
age
pass         # password store
#passage
minisign     # verify digital signatures
lastpass-cli # LastPass CLI password store
pwgen        # generate passwords from the command line

# internet
networkmanager         # network manager
network-manager-applet # network manager GUI (includes nm-connection-editor)
# vpn
networkmanager-openconnect # cisco anyconnect vpn
#networkmanager-openvpn
#networkmanager-vpnc

openssh # ssh
wget
curl
#aria2
yt-dlp # active fork of youtube-dl
newsboat
github-cli

# latex
texlive-bin
texlive-core
texlive-science
texlive-latexextra
texlive-fontsextra # needed for CV
biber
texlab

# bash
bash-language-server

# lua
lua-language-server
stylua

# rust
rust-analyzer

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
python-black # formatting
python-parse # the reverse of `format()`, like scanf() in `C`
python-numpy
python-scipy
python-pandas
python-matplotlib
python-seaborn
python-dotenv
python-lsp-server # LSP
ipython

# ai
nodejs # copilot dependency

# chat
#weechat weechat-matrix
signal-desktop

# email
neomutt # email client
notmuch # index and search mail
w3m     # view HTML email
msmtp   # SMTP client
isync   # sync IMAP and Maildir mailboxes
khal    # calendar and events

# sound server & bluetooth
pipewire-pulse
pipewire-alsa
wireplumber
bluez
bluez-utils
blueman     # bluetooth applet
#pulseaudio-bluetooth

pavucontrol                       # volume control
pulsemixer                        # TUI for PulseAudio
brightnessctl                     # brightness

# printing
cups-pdf
avahi     # printer discovery
nss-mdns  # printer discovery
foomatic-db-engine
foomatic-db
# hplip    # more printers

translate-shell  # language translation in the terminal

borg          # backup
syncthing     # sync continuously
rclone        # sync to cloud storage
rsync         # sync to remote


zip unzip unrar             # archives
jq                          # json
fzf the_silver_searcher fd  # search
ncdu                        # disk: du alternative
tree                        # files & folders
pacman-contrib              # arch
man man-db man-pages        # man pages
tldr                        # alternative to man pages
playerctl                   # media player controller
the_silver_searcher         # alternative to grep
ripgrep                     # alternative to grep

# pdf
pdf2svg               # pdf to svg converter
zathura-pdf-mupdf     # pdf viewer
xournalpp             # pdf editor
pdfarranger           # pdf merge/split/arrange
ripgrep-all           # pdf grep
#okular

# browser
chromium
#firefox
#qutebrowser

# image viewer
swayimg
viu          # in terminal
imagemagick  # convert tool: png/jpg -> pdf
#gwenview
#feh
imv

docker
docker-buildx

vlc                    # media player
mpv
libreoffice-still     # office suite
gimp                  # raster graphics editor
qbittorrent           # torrent client
#keepassxc             # password manager
#thunderbird           # mail client
#inkscape              # vector graphics editor

# no longer used: texstudio dolphin konsole sddm

) # PKGS

pacman -Syu --needed --noconfirm "${PKGS[@]}"
