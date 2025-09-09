PKGS=(

slack-desktop
pandoc-bin
wdisplays  # GUI for managing sway monitors similar to `arandr`
libtree
pacgraph
lazydocker-bin   # docker management TUI
xkb-switch
simplescreenrecorder # moved to AUR from official

) # PKGS

yay -Syu --noconfirm --needed "${PKGS[@]}"
