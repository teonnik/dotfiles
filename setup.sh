#!/bin/bash

DOTS=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

lndot() {
  ln -sfn ${DOTS}/${1} ${HOME}/${2:-${1}}
}

mkdir -p ${HOME}/bin
mkdir -p ${HOME}/.xkb/symbols
mkdir -p ${HOME}/.config
#mkdir -p ${HOME}/.local/share/applications

lndot .config/alacritty
lndot .config/foot
lndot .config/gdb
lndot .config/git
lndot .config/isync
lndot .config/kanshi
lndot .config/latexmk
lndot .config/msmtp
lndot .config/mimeapps.list
lndot .config/neomutt
lndot .config/newsboat
lndot .config/notmuch
lndot .config/nvim
lndot .config/sway
lndot .config/swaylock
lndot .config/waybar
lndot .config/wget
lndot .config/wofi
lndot .config/zathura

lndot .profile      .zprofile
lndot .profile      .bash_profile
lndot .stignore
lndot .vim/vimrc
lndot .zshrc

lndot .xkb/symbols/us-german-umlaut
lndot .local/share/applications

lndot bin/arch_install.sh
lndot bin/colorpicker
lndot bin/scr
lndot bin/scrmonitor
lndot bin/scrwindow
lndot bin/pack
lndot bin/unpack
lndot bin/steam

