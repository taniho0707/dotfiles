#!/bin/sh
feh --bg-scale ~/Pictures/Wallpaper/pc_1366_768.jpg &
nm-applet &
xscreensaver-command -no-splash &
xautolock -time 5 -locker 'xscreensaver-command -lock' &
compton -c -I 0.15 -O 0.2 &
xss-lock -- xscreensaver-command -lock &
pulseaudio --start
