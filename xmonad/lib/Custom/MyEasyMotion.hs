module Custom.MyEasyMotion where

import Custom.MyCatppuccin
import XMonad.Actions.EasyMotion
import XMonad (xK_Escape)

emConf :: EasyMotionConfig
emConf =
  def
    { txtCol = catFlamingo,
      bgCol = catCrust,
      borderCol = catCrust,
      cancelKey = xK_Escape,
      emFont = "FiraCode Nerd Font-60",
      overlayF = textSize,
      borderPx = 30
    }
