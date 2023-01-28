module Custom.MyStartupApps where

import XMonad
import XMonad.Util.SpawnOnce

myStartupHook :: X ()
myStartupHook = do
  spawn "feh --bg-scale /usr/share/wallpapers/stains_of_purple.jpg"
  spawn "~/.config/scripts/feh-blur.sh -s; ~/.config/scripts/feh-blur.sh -d"
  spawnOnce "xmodmap ~/.Xmodmap"
  spawnOnce "dunst &"
  spawnOnce "nm-applet"
  spawn "killall picom; picom -b -f"
  spawnOnce "easyeffects --gapplication-service &"
