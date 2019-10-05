#!/usr/bin/env bash

opts=(Lock Logout Poweroff Suspend Hibernate Reboot)

cmd="rofi -no-lazy-grab -dmenu -i -p System -config ~/.config/rofi/powermenu"

choice=$(printf '%s\n' "${opts[@]}" | $cmd)
case "$choice" in
    Lock) xautolock -locknow ;;
    Logout) i3-msg exit ;;
    Poweroff) systemctl -i poweroff ;;
    Suspend) xautolock -locknow && systemctl suspend ;;
    Reboot) systemctl reboot ;;
    Hibernate) xautolock -locknow && systemctl hibernate ;;
esac
