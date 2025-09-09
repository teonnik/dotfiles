PKGS=(
# --- i3 setup
i3-wm
xorg-server
alacritty              # terminal emulator for i3
rofi                   # app launcher for i3
xorg-xinit             # X session launcher - startx (no login manager)
xorg-xkill             # kill unresponsive X windows
xorg-setxkbmap         # keyboard layout
xclip                  # clipboard utility
i3lock
scrot maim             # screenshots
# dunst                  # notification daemon - conflicts with `mako`
arandr
redshift
i3status-rust          # bar

) # PKGS

# pacman -Syu --needed --noconfirm "${PKGS[@]}"
pacman -Rns "${PKGS[@]}"
