#!/bin/zsh

battery_device=$(upower -e | grep battery)
capacity=$(upower -i "$battery_device" | grep -i percentage | awk '{print $2}' | tr -d '%')
battery_status=$(upower -i "$battery_device" | grep -i state | awk '{print $2}')

if [ "$capacity" -gt 90 ]; then
    icon="󰁹"
elif [ "$capacity" -gt 80 ]; then
    icon="󰂂"
elif [ "$capacity" -gt 70 ]; then
    icon="󰂀"
elif [ "$capacity" -gt 60 ]; then
    icon="󰁿"
elif [ "$capacity" -gt 50 ]; then
    icon="󰁾"
elif [ "$capacity" -gt 40 ]; then
    icon="󰁽"
elif [ "$capacity" -gt 30 ]; then
    icon="󰁼"
elif [ "$capacity" -gt 20 ]; then
    icon="󰁻"
elif [ "$capacity" -gt 10 ]; then
    icon="󰁺"
else
    icon="󰂎"
fi

if [ "$battery_status" = "charging" ]; then
    icon="⚡$icon"
fi

echo "$icon $capacity%"
