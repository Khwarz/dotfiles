#!/bin/sh
killall pulseaudio
killall dunst

pulseaudio --start

nitrogen --restore

setxkbmap -option compose:ralt

dunst &

$HOME/.config/polybar/launch.sh

exec bspwm
