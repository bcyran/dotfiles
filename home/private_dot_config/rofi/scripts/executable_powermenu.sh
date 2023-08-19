#!/usr/bin/env bash

locker='lock -f'

opts=(Lock Logout Poweroff Suspend Hibernate Reboot)

cmd="rofi -no-lazy-grab -dmenu -i -p System -config ~/.config/rofi/powermenu.rasi"

choice=$(printf '%s\n' "${opts[@]}" | ${cmd})
case "${choice}" in
    Lock) ${locker} ;;
    Logout) hyprctl dispatch exit ;;
    Poweroff) systemctl -i poweroff ;;
    Suspend) ${locker} && systemctl suspend ;;
    Reboot) systemctl reboot ;;
    Hibernate) ${locker} && systemctl hibernate ;;
esac
