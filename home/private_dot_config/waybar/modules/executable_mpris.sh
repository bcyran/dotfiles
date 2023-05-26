#!/usr/bin/env bash

mpris_print() {
    local status metadata artist title

    status=$(playerctl status 2> /dev/null)

    if [[ "${status}" != 'Playing' && "${status}" != 'Paused' ]]; then
        return
    fi

    # Avoid "No player could handle this command..." message
    metadata=$(playerctl metadata)
    artist=$(echo "${metadata}" | grep "xesam:artist" | tr -s ' ' | cut -d ' ' -f 3-)
    title=$(echo "${metadata}" | grep "xesam:title" | tr -s ' ' | cut -d ' ' -f 3-)

    if [[ -n "${artist}" && -n "${title}" ]]; then
        echo "{\"text\": \"${artist} — ${title}\",\"alt\": \"${status@L}\"}"
    fi
}

mpris_print
