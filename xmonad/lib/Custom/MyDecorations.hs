module Custom.MyDecorations where

import Custom.MyCatppuccin
import XMonad qualified
import XMonad.Layout.ShowWName
import XMonad.Layout.Tabbed
import XMonad.Prompt

myBorderWidth :: XMonad.Dimension
myBorderWidth = 3

myNormalBorderColor :: String
myNormalBorderColor = catMantle

myFocusedBorderColor :: String
myFocusedBorderColor = catMauve

myPromptConfig :: XPConfig
myPromptConfig =
  def
    { bgColor = catBase,
      fgColor = catLavender,
      bgHLight = catLavender,
      fgHLight = catBase,
      historySize = 0,
      position = Top,
      borderColor = catBase,
      promptBorderWidth = 0,
      defaultText = "",
      alwaysHighlight = True,
      height = 55,
      font = "xft:FiraCode Nerd Font:style=Regular:size=12",
      autoComplete = Nothing,
      showCompletionOnTab = False
    }

myShowWNameConfig :: SWNConfig
myShowWNameConfig =
  def
    { swn_font = "xft:Ubuntu Nerd Font Medium:size=60",
      swn_color = catFlamingo,
      swn_bgcolor = catBase,
      swn_fade = 0.8
    }

myTabConfig :: Theme
myTabConfig =
  def
    { activeColor = catMauve,
      inactiveColor = catBase,
      urgentColor = catRed,
      activeBorderColor = catBase,
      inactiveBorderColor = catBase,
      urgentBorderColor = catRed,
      activeTextColor = catBase,
      inactiveTextColor = catFlamingo,
      urgentTextColor = catBase,
      fontName = "xft:FiraCode Nerd Font:size=12"
    }
