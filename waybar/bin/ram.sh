#!/bin/zsh

read total used free shared buff cache available < <(free -m | awk '/^Mem:/ {print $2, $3, $4, $5, $6, $7, $7}')
percent=$((100 * (total - available) / total))
used_mb=$((total - available))

icon=""
tooltip="RAM usage: ${percent}%% (${used_mb}MiB / ${total}MiB)"

printf '{"text": "%s %d%%", "tooltip": "%s"}\n' "$icon" "$percent" "$tooltip"

