#!/usr/bin/env bash
# Based on: https://life-prog.com/tech/a-simple-wifi-menu-with-rofi-on-i3/

rofi_cmd="rofi -no-lazy-grab -dmenu -i -p Wi-Fi -markup-rows -config ~/.config/rofi/wifimenu.rasi"
active_indicator=" (<i>active</i>)"

notify-send -t 2000 "Scanning Wi-Fi networks..."

readarray -t networks < <(nmcli -g SSID device wifi)
readarray -t connections < <(nmcli -g NAME connection)
active="$(nmcli -t -f name connection show --active)"

for (( i = 0; i < ${#networks[@]}; i++ )); do
    if [[ "${networks[${i}]}" = "${active}" ]]; then
        networks[i]+=${active_indicator}
        break
    fi
done

choice=$(printf '%s\n' "${networks[@]}" | ${rofi_cmd})
choice="${choice%"${active_indicator}"}"

if [[ -z "${choice}" ]]; then
    exit 1
elif [[ "${choice}" = "${active}" ]]; then
    nmcli connection down id "${choice}"
    echo "here"
else
    connection_exists=false
    for connection in "${connections[@]}"; do
        if [[ "${connection}" = "${choice}" ]]; then connection_exists=true; fi
    done

    if [[ "${connection_exists}" = true ]]; then
        nmcli connection up id "${choice}"
    else
        nmcli device wifi connect "${choice}"
    fi
fi
