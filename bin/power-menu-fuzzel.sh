#!/bin/bash

chosen=$({
    printf 'Lock\0icon\x1fsystem-lock-screen,system-lock-screen-symbolic\n'
    printf 'Shutdown\0icon\x1fsystem-shutdown,system-shutdown-symbolic\n'
    printf 'Reboot\0icon\x1fsystem-reboot,system-reboot-symbolic\n'
    printf 'Suspend\0icon\x1fsystem-suspend,weather-clear-night-symbolic\n'
    printf 'Logout\0icon\x1fsystem-log-out,system-log-out-symbolic\n'
} | fuzzel --dmenu --prompt "Power  ")

case "$chosen" in
    Lock)     swaylock ;;
    Shutdown) systemctl poweroff ;;
    Reboot)   systemctl reboot ;;
    Suspend)  systemctl suspend ;;
    Logout)   hyprctl dispatch exit ;;
esac
