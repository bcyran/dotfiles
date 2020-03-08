#!/usr/bin/env bash

pid=$(pgrep -x redshift)

redshift_print() {
    if [ "$pid" ]; then
        temp=$(redshift -p 2> /dev/null | grep Temp | cut -d ' ' -f 3)
        stat="$icon_on $temp"
    else
        stat="$icon_off off"
    fi

    echo "$stat"
}

redshift_toggle() {
    if [ "$pid" ]; then
        killall -e redshift
    else
        redshift > /dev/null 2>&1 &
    fi
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --icon-on)
            shift
            icon_on="$1"
            ;;
        --icon-off)
            shift
            icon_off="$1"
            ;;
        *)
            break
            ;;
    esac
    shift
done

case "$1" in
    toggle)
        redshift_toggle
        ;;
    *)
        redshift_print
        ;;
esac
