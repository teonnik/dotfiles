#!/bin/bash

chosen=$(echo -e "Logout\nShutdown\nReboot\nSuspend\nHibernate\nSuspend-then-hibernate" | rofi -dmenu -i -theme Monokai)

if [[ $chosen = "Logout" ]]; then
	swaymsg exit
elif [[ $chosen = "Shutdown" ]]; then
	systemctl poweroff
elif [[ $chosen = "Reboot" ]]; then
	systemctl reboot
elif [[ $chosen = "Suspend" ]]; then
	systemctl suspend
elif [[ $chosen = "Hibernate" ]]; then
	systemctl hibernate
elif [[ $chosen = "Suspend-then-hibernate" ]]; then
	systemctl suspend-then-hibernate
fi
