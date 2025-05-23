#!/bin/zsh

battery_device=$(upower -e | grep battery || echo "")
[ -z "$battery_device" ] && exit 0

capacity=$(upower -i "$battery_device" | grep -i percentage | awk '{print $2}' | tr -d '%' || echo "0")
battery_status=$(upower -i "$battery_device" | grep -i state | awk '{print $2}' || echo "unknown")
time_remaining=$(upower -i "$battery_device" | grep -i "time to" | awk '{print $4" "$5}' || echo "")

if [ "$battery_status" = "charging" ]; then
    if [ "$capacity" -gt 90 ]; then
        icon="󰂅"
    elif [ "$capacity" -gt 80 ]; then
        icon="󰂋"
    elif [ "$capacity" -gt 70 ]; then
        icon="󰂊"
    elif [ "$capacity" -gt 60 ]; then
        icon="󰢞"
    elif [ "$capacity" -gt 50 ]; then
        icon="󰂉"
    elif [ "$capacity" -gt 40 ]; then
        icon="󰢝"
    elif [ "$capacity" -gt 30 ]; then
        icon="󰂈"
    elif [ "$capacity" -gt 20 ]; then
        icon="󰂇"
    elif [ "$capacity" -gt 10 ]; then
        icon="󰂆"
    else
        icon="󰢜"
    fi
else
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
fi

class="normal"
[ "$battery_status" = "charging" ] && class="charging"
[ "$capacity" -le 30 ] && [ "$battery_status" != "charging" ] && class="critical"

tooltip="Battery: $capacity%"
[ -n "$time_remaining" ] && tooltip="$tooltip ($time_remaining)"
[ "$battery_status" != "unknown" ] && tooltip="$tooltip - $battery_status"

echo "{\"text\":\"$icon $capacity%\",\"tooltip\":\"$tooltip\",\"class\":\"$class\"}"
