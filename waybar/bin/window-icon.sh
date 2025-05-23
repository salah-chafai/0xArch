#!/bin/zsh

activewindow=$(hyprctl activewindow | grep -oP 'class: \K\S+')

echo "{\"class\":\"$activewindow\"}"
