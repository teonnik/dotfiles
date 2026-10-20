# vim: filetype=fish
#
# Keep programs out of $HOME: point the ones that support it at the XDG
# directories. Found with xdg-ninja (github.com/b3nj5m1n/xdg-ninja); re-run it
# to see what is left. Loads after env.fish, which sets XDG_*.
#
# Moving a variable here does not move existing data: move the old directory
# to the new path once, or the program starts over (logins, keys, history).

set -gx ANDROID_USER_HOME $XDG_DATA_HOME/android     # adb keys
set -gx AZURE_CONFIG_DIR $XDG_DATA_HOME/azure        # az login
set -gx CUDA_CACHE_PATH $XDG_CACHE_HOME/nv           # CUDA JIT cache
set -gx NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm
set -gx TEXMFVAR $XDG_CACHE_HOME/texlive/texmf-var
set -gx HISTFILE $XDG_STATE_HOME/bash/history        # bash started from fish
# CUPS reads $XDG_CONFIG_HOME/cups by itself, no variable needed.
