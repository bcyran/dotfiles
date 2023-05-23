#!/bin/bash

CONFIG_DEFAULT="${HOME}/.config/waybar/config-default.json"
CONFIG_MULTI="${HOME}/.config/waybar/config-multi.json"
CONFIG_COMMON="${HOME}/.config/waybar/common.json"
STYLE="${HOME}/.config/waybar/style.css"

trap "killall waybar" EXIT

num_monitors=$(hyprctl monitors | grep -c Monitor)

effective_config=${CONFIG_DEFAULT}
if [[ ${num_monitors} -gt 1 ]]; then
  effective_config=${CONFIG_MULTI}
fi

killall waybar

while true; do
    waybar --config "${effective_config}" &
    inotifywait -e modify "${CONFIG_DEFAULT}" "${CONFIG_MULTI}" "${CONFIG_COMMON}" "${STYLE}"
    killall waybar
done
