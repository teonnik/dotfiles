#!/bin/bash

# Show a power menu using wofi
chosen=$(echo -e " Lock\n Shutdown\n Reboot\n Suspend\n Logout" | wofi --dmenu --prompt "Power Menu" --style ~/.config/wofi/style.css)

case "$chosen" in
    " Lock")
        swaylock
        ;;
    " Shutdown")
        systemctl poweroff
        ;;
    " Reboot")
        systemctl reboot
        ;;
    " Suspend")
        systemctl suspend
        ;;
    " Logout")
        hyprctl dispatch exit
        ;;
    *)
        exit 0
        ;;
esac
