#!/usr/bin/env bash

icon_playing=''
icon_paused=''

mpris_print() {
    local status icon metadata artist title

    status=$(playerctl status 2> /dev/null)

    if [[ "${status}" == 'Playing' ]]; then
        icon=${icon_playing}
    elif [[ "${status}" == 'Paused' ]]; then
        icon=${icon_paused}
    else
        return
    fi

    # Avoid "No player could handle this command..." message
    metadata=$(playerctl metadata)
    artist=$(echo "${metadata}" | grep "xesam:artist" | tr -s ' ' | cut -d ' ' -f 3-)
    title=$(echo "${metadata}" | grep "xesam:title" | tr -s ' ' | cut -d ' ' -f 3-)

    if [[ -n "${artist}" && -n "${title}" ]]; then
        echo "${icon} ${artist:0:25} — ${title:0:25}"
    fi
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --icon-playing)
            shift
            icon_playing=$1
            ;;
        --icon-paused)
            shift
            icon_paused=$1
            ;;
        *)
            break
            ;;
    esac
    shift
done
readonly icon_playing icon_paused

mpris_print
