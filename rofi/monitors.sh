chosen=$(echo -e "Home\nWork" | rofi -dmenu -i -theme Monokai)

if [[ $chosen = "Home" ]]; then
  swaymsg output eDP-1 disable
  swaymsg output HDMI-A-1 resolution 1920x1080 position 0,0
elif [[ $chosen = "Work" ]]; then
  swaymsg output eDP-1 disable
  swaymsg output HDMI-A-1 resolution 1920x1080 position 0,0
fi
