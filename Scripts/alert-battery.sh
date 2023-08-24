#!/usr/bin/bash


threshold=15

level=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

if [ "${status}" = Discharging -a "${level}" -lt ${threshold} ];
then
    notify-send -t 300000 "Charge your battery. It's ${level}%"
fi

echo $a $b

