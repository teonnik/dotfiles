#!/bin/bash

DOTS=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
CONF=${HOME}/.config

mkdir -p ${HOME}/.newsboat
mkdir -p ${HOME}/.xkb/symbols

ln -sfn ${DOTS}/alacritty                    ${CONF}/alacritty
ln -sfn ${DOTS}/gdb/gdb.conf                 ${HOME}/.gdbinit
ln -sfn ${DOTS}/git/gitconfig                ${HOME}/.gitconfig
ln -sfn ${DOTS}/git/gitignore_global         ${HOME}/.gitignore_global
ln -sfn ${DOTS}/kanshi                       ${CONF}/kanshi
ln -sfn ${DOTS}/latex/latexmkrc.conf         ${HOME}/.latexmkrc
ln -sfn ${DOTS}/mbsyncrc                     ${HOME}/.mbsyncrc
ln -sfn ${DOTS}/msmtprc                      ${HOME}/.msmtprc
ln -sfn ${DOTS}/neomutt                      ${CONF}/neomutt
ln -sfn ${DOTS}/newsboat/urls                ${HOME}/.newsboat/urls
ln -sfn ${DOTS}/newsboat/config              ${HOME}/.newsboat/config
ln -sfn ${DOTS}/nvim                         ${CONF}/nvim
ln -sfn ${DOTS}/sway                         ${CONF}/sway
ln -sfn ${DOTS}/swaylock                     ${CONF}/swaylock
# TODO: syncthing
ln -sfn ${DOTS}/vim/vim.conf                 ${HOME}/.vimrc
ln -sfn ${DOTS}/waybar                       ${CONF}/waybar
ln -sfn ${DOTS}/wofi                         ${CONF}/wofi
ln -sfn ${DOTS}/xkb/us-german-umlaut         ${HOME}/.xkb/symbols/us-german-umlaut
ln -sfn ${DOTS}/zathura                      ${CONF}/zathura
ln -sfn ${DOTS}/zsh/zshrc                    ${HOME}/.zshrc

ln -sfn ${DOTS}/mimeapps.list                ${CONF}/mimeapps.list
ln -sfn ${DOTS}/xdg_applications             ${HOME}/.local/share/applications
ln -sfn ${DOTS}/wget                         ${CONF}/wget

ln -sfn ${DOTS}/profile                      ${HOME}/.zprofile
ln -sfn ${DOTS}/profile                      ${HOME}/.bash_profile

# -- bin
ln -sfn ${DOTS}/bin/colorpicker              ${HOME}/bin/colorpicker
ln -sfn ${DOTS}/bin/scr                      ${HOME}/bin/scr
ln -sfn ${DOTS}/bin/scrmonitor               ${HOME}/bin/scrmonitor
ln -sfn ${DOTS}/bin/scrwindow                ${HOME}/bin/scrwindow
ln -sfn ${DOTS}/bin/slack                    ${HOME}/bin/slack
ln -sfn ${DOTS}/bin/pack                     ${HOME}/bin/pack
ln -sfn ${DOTS}/bin/unpack                   ${HOME}/bin/unpack
