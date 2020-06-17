#!/bin/bash

# get the dir of the current script
DOTS=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
CONF=${HOME}/.config

ln -sf ${DOTS}/git/gitconfig                ${HOME}/.gitconfig
ln -sf ${DOTS}/git/gitignore_global         ${HOME}/.gitignore_global
ln -sf ${DOTS}/vim/vim.conf                 ${HOME}/.vimrc
ln -sf ${DOTS}/zsh/zshrc                    ${HOME}/.zshrc

ln -sf ${DOTS}/xdg/xdg.conf                 ${CONF}/user-dirs.dirs
ln -sf ${DOTS}/gdb/gdb.conf                 ${HOME}/.gdbinit
ln -sf ${DOTS}/latex/latexmkrc.conf         ${HOME}/.latexmkrc

mkdir -p ${CONF}/sway
ln -sf ${DOTS}/sway/config                  ${CONF}/sway/config

mkdir -p ${CONF}/kanshi
ln -sf ${DOTS}/kanshi/config                ${CONF}/kanshi/config

mkdir -p ${CONF}/waybar
mkdir -p ${CONF}/waybar/modules
ln -sf ${DOTS}/waybar/config.json           ${CONF}/waybar/config
ln -sf ${DOTS}/waybar/style.css             ${CONF}/waybar/style.css
ln -sf ${DOTS}/waybar/modules/kblayout      ${CONF}/waybar/modules/kblayout

#mkdir -p ${HOME}/.spack
#ln -sf ${DOTS}/spack/packages.yaml          ${HOME}/.spack/packages.yaml

#mkdir -p ${CONF}/i3
#ln -sf ${DOTS}/i3/i3.conf                   ${CONF}/i3/config

#mkdir -p ${CONF}/polybar
#ln -sf ${DOTS}/polybar/config.ini           ${CONF}/polybar/config
#ln -sf ${DOTS}/polybar/launch.sh            ${CONF}/polybar/launch.sh
