#!/bin/zsh

usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null || echo 0)
icon=""
tooltip="GPU usage: ${usage}%%"

printf '{"text": "%s %s%%", "tooltip": "%s"}\n' "$icon" "$usage" "$tooltip"

