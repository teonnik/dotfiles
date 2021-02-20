#!/bin/bash

DOTS=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
CONF=${HOME}/.config

ln -sf ${DOTS}/alacritty                    ${CONF}/alacritty

ln -sf ${DOTS}/gdb/gdb.conf                 ${HOME}/.gdbinit

ln -sf ${DOTS}/git/gitconfig                ${HOME}/.gitconfig
ln -sf ${DOTS}/git/gitignore_global         ${HOME}/.gitignore_global

ln -sf ${DOTS}/kanshi                       ${CONF}/kanshi

ln -sf ${DOTS}/latex/latexmkrc.conf         ${HOME}/.latexmkrc

ln -sf ${DOTS}/mbsyncrc                     ${HOME}/.mbsyncrc

ln -sf ${DOTS}/msmtprc                      ${HOME}/.msmtprc

ln -sf ${DOTS}/neomutt                      ${CONF}/neomutt

mkdir -p ${HOME}/.newsboat
ln -sf ${DOTS}/newsboat/urls                ${HOME}/.newsboat/urls
ln -sf ${DOTS}/newsboat/config              ${HOME}/.newsboat/config

#ln -sf ${DOTS}/rofi/power.sh                ${HOME}/bin/power.sh

ln -sf ${DOTS}/sway                         ${CONF}/sway
ln -sf ${DOTS}/sway/run                     ${HOME}/bin/sway-run

ln -sf ${DOTS}/swaylock                     ${CONF}/swaylock

# TODO: syncthing

ln -sf ${DOTS}/user-dirs.dirs               ${CONF}/user-dirs.dirs

ln -sf ${DOTS}/vim/vim.conf                 ${HOME}/.vimrc

ln -sf ${DOTS}/waybar                       ${CONF}/waybar

ln -sf ${DOTS}/wofi                         ${CONF}/wofi

mkdir -p ${HOME}/.xkb/symbols
ln -sf ${DOTS}/xkb/us-german-umlaut         ${HOME}/.xkb/symbols/us-german-umlaut

ln -sf ${DOTS}/zathura                      ${CONF}/zathura

ln -sf ${DOTS}/zsh/zshrc                    ${HOME}/.zshrc
ln -sf ${DOTS}/zsh/profile                  ${HOME}/.zprofile
