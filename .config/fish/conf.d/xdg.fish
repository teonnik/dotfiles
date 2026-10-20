# vim: filetype=fish
#
# Keep programs out of $HOME: the XDG base directories, and the programs
# that can be pointed at them. Found with xdg-ninja
# (github.com/b3nj5m1n/xdg-ninja); re-run it to see what is left.
#
# Moving a variable here does not move existing data: move the old directory
# to the new path once, or the program starts over (logins, keys, history).

set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state

# config
set -gx DOCKER_CONFIG $XDG_CONFIG_HOME/docker
# CUPS reads $XDG_CONFIG_HOME/cups by itself, no variable needed.

# data
set -gx ANDROID_USER_HOME $XDG_DATA_HOME/android     # adb keys
set -gx AZURE_CONFIG_DIR $XDG_DATA_HOME/azure        # az login
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx GNUPGHOME $XDG_DATA_HOME/gnupg
set -gx GOPATH $XDG_DATA_HOME/go
set -gx PASSWORD_STORE_DIR $XDG_DATA_HOME/password-store
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup

# state
set -gx HISTFILE $XDG_STATE_HOME/bash/history        # bash started from fish

# cache
set -gx CUDA_CACHE_PATH $XDG_CACHE_HOME/nv           # CUDA JIT cache
set -gx NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm
set -gx PYTHONPYCACHEPREFIX $XDG_CACHE_HOME/python
set -gx TEXMFVAR $XDG_CACHE_HOME/texlive/texmf-var
