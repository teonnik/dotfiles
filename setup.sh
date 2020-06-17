#!/bin/bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

ln -sf $script_dir/git/gitconfig                ~/.gitconfig
ln -sf $script_dir/git/gitignore_global         ~/.gitignore_global
ln -sf $script_dir/vim/vim.conf                 ~/.vimrc
ln -sf $script_dir/zsh/zshrc                    ~/.zshrc

mkdir -p ~/.config/sway
ln -sf $script_dir/sway/config                  ~/.config/sway/config

mkdir -p ~/.config/kanshi
ln -sf $script_dir/kanshi/config                ~/.config/kanshi/config

mkdir -p ~/.config/waybar
ln -sf $script_dir/waybar/config.json           ~/.config/waybar/config
ln -sf $script_dir/waybar/style.css             ~/.config/waybar/style.css
mkdir -p ~/.config/waybar/modules
ln -sf $script_dir/waybar/modules/kblayout      ~/.config/waybar/modules/kblayout

ln -sf $script_dir/xdg/xdg.conf                 ~/.config/user-dirs.dirs
ln -sf $script_dir/gdb.conf                     ~/.gdbinit
ln -sf $script_dir/latexmkrc.conf               ~/.latexmkrc

#mkdir -p ~/.config/i3
#ln -sf $script_dir/i3.conf                      ~/.config/i3/config

#mkdir -p ~/.config/polybar
#ln -sf $script_dir/polybar/config.ini           ~/.config/polybar/config
#ln -sf $script_dir/polybar/launch.sh            ~/.config/polybar/launch.sh

#mkdir -p ~/.spack
#ln -sf $script_dir/spack/packages.yaml          ~/.spack/packages.yaml
