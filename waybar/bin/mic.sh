#!/bin/zsh

step=5
device=""
action=""
show_status=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --device)
      device="$2"
      shift 2
      ;;
    --action)
      action="$2"
      shift 2
      ;;
    --status)
      show_status=1
      shift
      ;;
    *)
      shift
      ;;
  esac
done

[[ "$device" != "input" ]] && exit 1

source=$(pactl get-default-source)
source_name=$(pactl get-source-volume "$source" | head -n1 | cut -d'/' -f3 | sed 's/[[:space:]]*$//')

current_volume=$(pactl get-source-volume "$source" | grep -oP '\d+(?=%)' | head -n1)

if [[ -n "$action" ]]; then
  case "$action" in
    toggle)
      pactl set-source-mute "$source" toggle
      ;;
    increase)
      if (( current_volume + step <= 100 )); then
        pactl set-source-volume "$source" +${step}%
      else
        pactl set-source-volume "$source" 100%
      fi
      ;;
    decrease)
      if (( current_volume - step >= 0 )); then
        pactl set-source-volume "$source" -${step}%
      else
        pactl set-source-volume "$source" 0%
      fi
      ;;
  esac
  show_status=1
fi

if [[ $show_status -eq 1 ]]; then
  muted=$(pactl get-source-mute "$source" | awk '{print $2}')
  volume=$(pactl get-source-volume "$source" | grep -oP '\d+%' | head -n1)

  if [[ "$muted" == "yes" ]]; then
    echo "{\"text\":\" $volume\",\"tooltip\":\"$source_name\"}"
  else
    echo "{\"text\":\" $volume\",\"tooltip\":\"$source_name\"}"
  fi
fi
