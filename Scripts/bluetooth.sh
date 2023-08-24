#!/bin/sh


bluetoothctl agent on >> /dev/null
bluetoothctl power on >> /dev/null
result=$(bluetoothctl devices | cut -d\  -f2- | rofi -dmenu -theme $HOME/.config/rofi/themes/appsmenu.rasi | awk '{print $1}')
notify-send "$(bluetoothctl connect $result)"
