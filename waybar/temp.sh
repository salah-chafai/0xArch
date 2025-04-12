#!/bin/zsh

temp=$(cat /sys/class/thermal/thermal_zone0/temp)
temp=$((temp / 1000))

if [ "$temp" -lt 40 ]; then
	icon=""
elif [ "$temp" -lt 70 ]; then
	icon=""
else
	icon=""
fi

echo "$icon $temp°C"
