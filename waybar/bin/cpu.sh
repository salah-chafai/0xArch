#!/bin/zsh

read cpu a b c d rest < /proc/stat
prev_idle=$d
prev_total=$((a + b + c + d))

sleep 0.1

read cpu a b c d rest < /proc/stat
idle=$d
total=$((a + b + c + d))

diff_idle=$((idle - prev_idle))
diff_total=$((total - prev_total))
usage=$((100 * (diff_total - diff_idle) / diff_total))

icon=""
tooltip="CPU usage: ${usage}%%"

printf '{"text": "%s %d%%", "tooltip": "%s"}\n' "$icon" "$usage" "$tooltip"

