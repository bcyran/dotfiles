#!/usr/bin/env bash

mpris_print() {
    status=$(playerctl status 2>/dev/null)

    if [ "$status" == "Playing" ]; then
        icon="$icon_playing"
    elif [ "$status" == "Paused" ]; then
        icon="$icon_paused"
    else
        return
    fi

    artist=$(playerctl metadata artist)
    title=$(playerctl metadata title)

    echo "$icon $artist — $title"
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --icon-playing)
            shift
            icon_playing="$1"
            ;;
        --icon-paused)
            shift
            icon_paused="$1"
            ;;
        *)
            break
            ;;
    esac
    shift
done

mpris_print
