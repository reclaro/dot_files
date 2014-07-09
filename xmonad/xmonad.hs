import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
xmproc <- spawnPipe "/usr/bin/xmobar /home/andrea/.xmobarrc"
xmonad $ defaultConfig
    { manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts $ layoutHook defaultConfig
    , focusedBorderColor = "red" --"#268bd2"
    , workspaces = ["1:misc","2:irc","3:nova","4:tripleo","5:heat","6:reviews","7:web","8","9"]
    , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                       , ppTitle = xmobarColor "#2aa198" "". shorten 60
                       }
    } `additionalKeys`
    [ ((mod4Mask , xK_l), spawn "gnome-screensaver-command --lock")] --mod4mask is the windows key
