#!/bin/sh

get_brightness() {
 brightnessctl g | cut -d ' ' -f 1
}

case $1 in 
  "up")
    brightnessctl s 1%+ /dev/null
    brightness=$(get_brightness)
    dunstify -i '/usr/share/icons/Papirus-Dark/symbolic/status/display-brightness-high-symbolic.svg' -r 5555 -t 1800 -u normal "    $(($brightness*100/120000))%"
    ;;

  "down")
    brightnessctl s 1%- > /dev/null
    brightness=$(get_brightness)
    dunstify -i '/usr/share/icons/Papirus-Dark/symbolic/status/display-brightness-high-symbolic.svg' -r 5555 -t 1800 -u normal "    $(($brightness*100/120000))%"
    ;;
esac
