# vim: set filetype=sh :

PKGS=(

skypeforlinux-stable-bin
slack-desktop
pandoc-bin
wdisplays  # GUI for managing sway monitors similar to `arandr`
vcal       # view .ics and calendar files
libtree
cmake-format
pacgraph
asp                         # utility to retrieve PKGBUILD files
lazydocker-bin   # docker management TUI
xkb-switch
simplescreenrecorder # moved to AUR from official
mullvad-vpn-bin

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

yay -Syu --noconfirm --needed "${PKGS[@]}"
