#!/bin/bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

mkdir -p ~/.vim/keymap
mkdir -p ~/.config/i3
mkdir -p ~/.config/polybar
mkdir -p ~/.config/waybar
mkdir -p ~/.config/waybar/modules
mkdir -p ~/.config/sway


ln -sf $script_dir/gdb.conf                     ~/.gdbinit
ln -sf $script_dir/zsh/zshrc                    ~/.zshrc
ln -sf $script_dir/git.conf                     ~/.gitconfig
ln -sf $script_dir/latexmkrc.conf               ~/.latexmkrc
ln -sf $script_dir/vim/vim.conf                 ~/.vimrc
ln -sf $script_dir/vim/bulgarian-phonetic.vim   ~/.vim/keymap/bulgarian-phonetic.vim

ln -sf $script_dir/i3.conf                      ~/.config/i3/config
ln -sf $script_dir/polybar/config.ini           ~/.config/polybar/config
ln -sf $script_dir/polybar/launch.sh            ~/.config/polybar/launch.sh 

ln -sf $script_dir/sway/config                  ~/.config/sway/config
ln -sf $script_dir/waybar/config.json           ~/.config/waybar/config
ln -sf $script_dir/waybar/style.css             ~/.config/waybar/style.css
ln -sf $script_dir/waybar/modules/kblayout      ~/.config/waybar/modules/kblayout

