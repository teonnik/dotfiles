# vim: filetype=fish
#
# The environment, in one place. Runs for every fish, interactive or not, and
# before config.fish. ly starts the session through `fish --login`, so
# Hyprland and every GUI app inherit what is set here. Nothing else reads it:
# keep variables for the compositor and toolkits in hypr/hyprland.lua, and
# secrets out of here (per-project .envrc instead).
#
# LANG is not set here: it comes from /etc/locale.conf.

# Prepends, skipping directories already present, so a nested fish or a
# second login pass doesn't repeat them.
fish_add_path --path $HOME/bin $HOME/.local/bin

set -gx EDITOR nvim
set -gx VISUAL nvim   # sudoedit, crontab -e and others check VISUAL first
set -gx PAGER less

# XDG directories and the programs moved into them: conf.d/xdg.fish

# cmake
set -gx CMAKE_EXPORT_COMPILE_COMMANDS ON

# fzf
set -gx FZF_DEFAULT_COMMAND "rg --files --hidden --glob '!.git'"

# less
set -gx LESS '-R -F -i -M --use-color --incsearch --mouse'
set -gx LESSHISTFILE - # no history file

# man
set -gx MANPAGER 'less -R --use-color -Dd+r -Du+b'
set -gx MANROFFOPT '-P -c'

# ssh-agent is socket-activated by a systemd user unit
set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
