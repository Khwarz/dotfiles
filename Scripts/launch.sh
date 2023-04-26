#!/bin/sh
killall pulseaudio

nitrogen --restore

pulseaudio --start

setxkbmap -option compose:ralt

$HOME/.config/polybar/launch.sh

exec bspwm
