{-# LANGUAGE ImportQualifiedPost #-}

module Custom.MyKeys where

import Custom.MyDecorations
import Custom.MyEasyMotion
import Custom.MyScratchpads
import Custom.MyWorkspaces
import Data.Map qualified as M
import Graphics.X11.ExtraTypes.XF86
import System.Exit
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.EasyMotion
import XMonad.Actions.PhysicalScreens
import XMonad.Actions.Search qualified as S
import XMonad.Actions.Submap qualified as SM
import XMonad.Actions.WithAll
import XMonad.Hooks.ManageDocks
import XMonad.Layout.BoringWindows
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation as WN
import XMonad.Prompt.ConfirmPrompt
import XMonad.Prompt.Man
import XMonad.Prompt.XMonad
import XMonad.StackSet qualified as W
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Actions.SpawnOn

myKeys :: [(String, X ())]
myKeys =
  [ -- Terminal
    ("M-<Return>", spawn "kitty"),
    -- Browser
    ("M-b", spawnOn "\xf269" "brave"),
    -- Files
    ("M-f", spawnOn "\xf07c" "kitty -e /usr/bin/ranger"),
    ("M-S-f", spawnOn "\xf07c" "Thunar"),
    -- Spotify
    ("M-s", spawnOn "\xf04c7" "spotify"),
    -- Discord
    ("M-d", spawnOn "\xf066f" "discord"),
    -- Rofi
    ("M-p", spawn "rofi -show drun"),
    ("M1-<Tab>", spawn "rofi -show window"),
    -- XPrompts
    ("M-S-m", manPrompt myPromptConfig),
    ("M-S-x", xmonadPrompt myPromptConfig),
    ("M-S-q", confirmPrompt myPromptConfig "exit" $ io exitSuccess),
    -- Flameshot
    ("<Print>", spawn "flameshot gui"),
    ("S-<Print>", spawn "flameshot full"),
    -- Scrot
    ("C-<Print>", spawn "scrot -q 100 ~/Images/%Y-%m-%d-%T.png"),
    -- Search commands (wait for next keypress)
    ("M-S-:", SM.submap $ searchEngineMap $ S.promptSearchBrowser myPromptConfig "brave"),
    -- NamedScratchpads
    ("M-t", namedScratchpadAction myScratchpads "quick commands"),
    ("M-C-g", namedScratchpadAction myScratchpads "glava"),
    -- Bluetooth
    {- ("<Page_Up>", spawn ("bluetoothctl connect " ++ mySpeakerMac)),
    ("<Home>", spawn ("bluetoothctl connect " ++ myXMMac)),
    ("<Page_Down>", spawn "bluetoothctl disconnect"), -}
    -- Close window(s)
    ("M-c", kill),
    ("M-S-c", killAll),
    -- Layouts
    ("M-<Space>", sendMessage NextLayout),
    ("M-C-<Space>", spawn "polybar-msg cmd toggle" >> sendMessage ToggleStruts),
    ("M-C-b", sendMessage $ Toggle NOBORDERS),
    -- Cycle workspaces
    ("M-<Down>", nextWS),
    ("M-<Up>", prevWS),
    ("M-S-<Down>", shiftToNext),
    ("M-S-<Up>", shiftToPrev),
    ("M-<Right>", nextScreen),
    ("M-<Left>", prevScreen),
    ("M-S-<Right>", shiftNextScreen),
    ("M-S-<Left>", shiftPrevScreen),
    ("M-S-z", toggleWS),
    ("M-S-l", shiftToNext >> nextWS),
    ("M-S-h", shiftToPrev >> prevWS),
    -- Focus
    ("M-<Tab>", windows W.focusDown),
    ("M-S-<Tab>", windows W.focusUp),
    ("M-k", focusUp),
    ("M-j", focusDown),
    ("M-m", focusMaster),
    ("M-S-<Return>", windows W.swapMaster),
    ("M-S-j", swapDown),
    ("M-S-k", swapUp),
    -- Resize
    ("M-h", sendMessage Shrink),
    ("M-l", sendMessage Expand),
    ("M-a", sendMessage MirrorShrink),
    ("M-z", sendMessage MirrorExpand),
    ("M-S-t", withFocused $ windows . W.sink),
    ("M-,", sendMessage (IncMasterN 1)),
    ("M-;", sendMessage (IncMasterN (-1))),
    -- XMonad
    ("M-q", spawn "xmonad --recompile; xmonad --restart"),
    -- Volume
    ("<XF86AudioRaiseVolume>", spawn "/bin/bash ~/.config/scripts/speakers-volume.sh up"),
    ("<XF86AudioLowerVolume>", spawn "/bin/bash ~/.config/scripts/speakers-volume.sh down"),
    ("<XF86AudioMute>", spawn "/bin/bash ~/.config/scripts/speakers-volume.sh mute"),
    ("S-<XF86AudioLowerVolume>", spawn "/bin/bash ~/.config/scripts/mic-volume.sh dec"),
    ("S-<XF86AudioRaiseVolume>", spawn "/bin/bash ~/.config/scripts/mic-volume.sh inc"),
    ("S-<XF86AudioMute>", spawn "/bin/bash ~/.config/scripts/mic-volume.sh mute"),
    ("<XF86MonBrightnessUp>", spawn "/bin/bash ~/.config/scripts/brightness.sh up"),
    ("<XF86MonBrightnessDown>", spawn "/bin/bash ~/.config/scripts/brightness.sh down"),
    ("M-S-b", spawn "~/.local/bin/betterlockscreen -l"),
    -- Spacing
    ("M-C-S-k", incScreenSpacing 5),
    ("M-C-S-j", decScreenSpacing 5),
    ("M-C-S-l", incWindowSpacing 5),
    ("M-C-S-h", decWindowSpacing 5),
    -- Easy Motion
    ("M-g", selectWindow emConf >>= (`whenJust` windows . W.focusWindow)),
    ("M-x", selectWindow emConf >>= (`whenJust` killWindow)),
    -- Sublayout Navigation
    ("M-C-h", sendMessage $ pullGroup WN.L),
    ("M-C-l", sendMessage $ pullGroup WN.R),
    ("M-C-k", sendMessage $ pullGroup WN.U),
    ("M-C-j", sendMessage $ pullGroup WN.D),
    ("M-C-u", withFocused (sendMessage . UnMerge)),
    ("M-C-S-u", withFocused (sendMessage . UnMergeAll)),
    ("M-C-S-m", withFocused (sendMessage . MergeAll)),
    ("M-C-.", onGroup W.focusUp'),
    ("M-C-,", onGroup W.focusDown')
  ]

myAdditionalKeys conf@XConfig {XMonad.modMask = modm} =
  M.fromList $
    -- Reset the layouts on the current workspace to default
    [((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)]
      ++ [ ((m .|. mod4Mask, k), windows $ f i)
           | (i, k) <- zip myWorkspaces [xK_ampersand, xK_eacute, xK_quotedbl, xK_apostrophe, xK_parenleft, xK_minus, xK_egrave, xK_underscore, xK_ccedilla],
             (f, m) <-
               [ (W.greedyView, 0),
                 (W.shift, controlMask),
                 (\i -> W.greedyView i . W.shift i, shiftMask)
               ]
         ]
      ++ [ ((mod4Mask .|. mask, key), f sc)
           | (key, sc) <- zip [xK_w, xK_e, xK_r] [0 ..],
             (f, mask) <- [(viewScreen def, 0), (sendToScreen def, shiftMask)]
         ]

searchEngineMap method =
  M.fromList
    [ ((0, xK_a), method $ S.searchEngine "archwiki" "http://wiki.archlinux.org/index.php/Special:Search?search="),
      ((0, xK_g), method S.google),
      ((0, xK_h), method S.hoogle),
      ((0, xK_i), method S.imdb),
      ((0, xK_p), method S.aur),
      ((0, xK_s), method $ S.searchEngine "stackoverflow" "https://stackoverflow.com/search?q="),
      ((0, xK_w), method S.wikipedia),
      ((0, xK_y), method S.youtube)
    ]
