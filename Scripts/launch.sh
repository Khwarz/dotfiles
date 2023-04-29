#!/bin/sh
killall pulseaudio
killall dunst

nitrogen --restore

pulseaudio --start

setxkbmap -option compose:ralt

dunst &

$HOME/.config/polybar/launch.sh

exec bspwm
