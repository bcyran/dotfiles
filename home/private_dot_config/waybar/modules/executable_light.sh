#!/usr/bin/env bash

readonly backlight="${HOME}/bin/backlight"

light_print() {
    while true; do
        ${backlight} get | cut -d "." -f 1
        inotifywait -e modify /sys/class/backlight/intel_backlight/brightness > /dev/null 2>&1
    done
}

case "$1" in
    dec)
        "${backlight}" down 10
        ;;
    inc)
        "${backlight}" up 10
        ;;
    *)
        light_print
        ;;
esac
