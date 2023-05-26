#!/usr/bin/env bash

pid=$(pgrep -x wlsunset)
readonly pid

sunset_print() {
    if [[ -n "${pid}" ]]; then
        echo "{\"text\": \"on\", \"alt\": \"on\"}"
    else
        echo "{\"text\": \"off\", \"alt\": \"off\"}"
    fi
}

sunset_toggle() {
    if [[ -n "${pid}" ]]; then
        kill "${pid}"
    else
        sunset >/dev/null 2>&1 &
    fi
}

case "$1" in
    toggle)
        sunset_toggle
        ;;
    *)
        sunset_print
        ;;
esac
