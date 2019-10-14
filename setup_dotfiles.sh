#!/bin/bash

# get the dir of the current script
script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

ln -s $script_dir/gdb.conf ~/.gdbinit
ln -s $script_dir/tmux.conf ~/.tmux.conf
ln -s $script_dir/vim/vim.conf  ~/.vimrc
ln -s $script_dir/vim/bulgarian-phonetic.vim ~/.vim/keymap/bulgarian-phonetic.vim
ln -s $script_dir/zsh.conf ~/.zshrc
ln -s $script_dir/git.conf ~/.gitconfig
ln -s $script_dir/latexmkrc.conf ~/.latexmkrc
ln -s $script_dir/i3.conf ~/.config/i3/config
ln -s $script_dir/kde/wm.conf ~/.config/plasma-workspace/env/wm.sh 
ln -s $script_dir/kde_shortcuts.conf ~/.config/kglobalshortcutsrc  
ln -s $script_dir/kwin.conf ~/.config/kwinrc
ln -s $script_dir/polybar/config.ini ~/.config/polybar/config
ln -s $script_dir/polybar/launch.sh ~/.config/polybar/launch.sh 
ln -s $script_dir/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
ln -s $script_dir/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
ln -s $script_dir/compton/compton.conf ~/.config/compton.conf: 
