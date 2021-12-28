# XDG base directories : https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# XDG user directories : https://wiki.archlinux.org/title/XDG_user_directories
export XDG_DESKTOP_DIR="$HOME/desktop"
export XDG_DOWNLOAD_DIR="$HOME/downloads"
export XDG_TEMPLATES_DIR="$HOME/templates"
export XDG_PUBLICSHARE_DIR="$HOME/public"
export XDG_DOCUMENTS_DIR="$HOME/documents"
export XDG_MUSIC_DIR="$HOME/music"
export XDG_PICTURES_DIR="$HOME/pics"
export XDG_VIDEOS_DIR="$HOME/videos"

# software
#export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/notmuch-config"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
#export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export WEECHAT_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/weechat"
export MBSYNCRC="${XDG_CONFIG_HOME:-$HOME/.config}/mbsync/config"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
#export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

# languages
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"

#export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
#export TERM=foot # this is set in foot's config

# sway fixes
export MOZ_ENABLE_WAYLAND=1           # force firefox to use wayland (ff 75+)
export MOZ_WAYLAND_USE_VAAPI=1        # firefox enable hw video decoding
export QT_QPA_PLATFORMTHEME=qt5ct     # QT apps theme
export _JAVA_AWT_WM_NONREPARENTING=1  # Fixes issues on jetbrains ides

export XDG_SESSION_TYPE=wayland       # ??
#export XDG_CURRENT_DESKTOP=sway

eval `ssh-agent`

# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
  exec /usr/bin/sway
fi

