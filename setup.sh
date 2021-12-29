#!/bin/bash

DOTS=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
CONF=${HOME}/.config

mkdir -p ${HOME}/.xkb/symbols

ln -sfn ${DOTS}/alacritty                    ${CONF}/alacritty
ln -sfn ${DOTS}/gdb                          ${CONF}/gdb
ln -sfn ${DOTS}/git                          ${CONF}/git
ln -sfn ${DOTS}/kanshi                       ${CONF}/kanshi
ln -sfn ${DOTS}/latex/latexmkrc.conf         ${HOME}/.latexmkrc
ln -sfn ${DOTS}/isync                        ${CONF}/isync
ln -sfn ${DOTS}/msmtp                        ${CONF}/msmtp
ln -sfn ${DOTS}/neomutt                      ${CONF}/neomutt
ln -sfn ${DOTS}/newsboat                     ${CONF}/newsboat
ln -sfn ${DOTS}/notmuch                      ${CONF}/notmuch
ln -sfn ${DOTS}/nvim                         ${CONF}/nvim
ln -sfn ${DOTS}/sway                         ${CONF}/sway
ln -sfn ${DOTS}/swaylock                     ${CONF}/swaylock
# TODO: syncthing
ln -sfn ${DOTS}/vim/vimrc                    ${HOME}/.vim/vimrc
ln -sfn ${DOTS}/waybar                       ${CONF}/waybar
ln -sfn ${DOTS}/wofi                         ${CONF}/wofi
ln -sfn ${DOTS}/xkb/us-german-umlaut         ${HOME}/.xkb/symbols/us-german-umlaut
ln -sfn ${DOTS}/zathura                      ${CONF}/zathura
ln -sfn ${DOTS}/zsh/zshrc                    ${HOME}/.zshrc

ln -sfn ${DOTS}/mimeapps.list                ${CONF}/mimeapps.list
ln -sfn ${DOTS}/xdg_applications             ${HOME}/.local/share/applications
ln -sfn ${DOTS}/wget                         ${CONF}/wget
ln -sfn ${DOTS}/foot                         ${CONF}/foot

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
