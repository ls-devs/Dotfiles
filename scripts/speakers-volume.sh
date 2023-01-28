#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
  pamixer --get-volume
}

function is_mute {
  pamixer --get-mute
}

function send_notification {
    volume=`get_volume`
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    # Send the notification
    ICON="/usr/share/icons/Papirus-Dark/24x24/actions"
    if [ $(($volume)) -le 40 ]; then
      ICON="$ICON/audio-volume-low.svg"
    elif [ $(($volume)) -ge 40 ]  && [ $(($volume)) -le 75 ]; then
      ICON="$ICON/audio-volume-medium.svg"
    elif [ $(($volume)) -ge 75 ] && [ $(($volume)) -le 100 ]; then
      ICON="$ICON/audio-volume-high.svg"
    elif [[ $(($volume)) -ge 100 ]]; then
      ICON="/usr/share/icons/Papirus-Dark/symbolic/status/audio-volume-overamplified-symbolic.svg"
    fi
    dunstify  -i "$ICON" -t 800 -r 2593 -u normal "    $volume%"
}

case $1 in
    up)
      pamixer --unmute > /dev/null
      pactl set-sink-volume @DEFAULT_SINK@ +1% > /dev/null
      send_notification
	;;
    down)
      pamixer --unmute > /dev/null
      pactl set-sink-volume @DEFAULT_SINK@ -1% > /dev/null
      send_notification
	;;
    mute)
      pamixer --toggle-mute > /dev/null
	if is_mute ; then
	    dunstify -i "/usr/share/icons/Papirus-Dark/24x24/actions/audio-volume-muted.svg" -t 800 -r 2593 -u normal "Muted"
	else
	    send_notification
	fi
	;;
esac
