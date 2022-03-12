#!/usr/bin/env bash

mpris_print() {
    local status=$(playerctl status 2>/dev/null)

    if [ "$status" == "Playing" ]; then
        local icon="$icon_playing"
    elif [ "$status" == "Paused" ]; then
        local icon="$icon_paused"
    else
        return
    fi

    # Avoid "No player could handle this command..." message
    local metadata=$(playerctl metadata)
    local artist=$(echo "$metadata" | grep "xesam:artist" | tr -s ' ' | cut -d ' ' -f 3-)
    local title=$(echo "$metadata" | grep "xesam:title" | tr -s ' ' | cut -d ' ' -f 3-)

    if [ -n "$artist" ] && [ -n "$title" ]; then
        echo "$icon $artist — $title"
    fi
}

while [ "$#" -gt 0 ]; do
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
