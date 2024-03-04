# vim: set filetype=sh :

PKGS=(

skypeforlinux-stable-bin
slack-desktop
bloaty
pandoc-bin
wlsunset   # blue light filter for night reading
vcal       # view .ics and calendar files
libtree
cmake-format
pacgraph
asp                         # utility to retrieve PKGBUILD files
lazydocker-bin   # docker management TUI

#navi-bin
#gcalcli
#mullvad-vpn-cli
#zoom
#stdman
#rusty-man
#tuir          # fork of rtv
#procs-bin     # ps replacement
#mendeleydesktop
#yambar     # alternative to waybar
#wl-color-picker # HEX of color under the cursor

) # PKGS

yay -Syu --nonconfirm --needed "${PKGS[@]}"
