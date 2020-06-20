#!/usr/bin/env bash

updates_print() {
    if ! local updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
        local updates_arch=0
    fi

    if ! local updates_aur=$(yay -Qum 2> /dev/null | wc -l); then
        local updates_aur=0
    fi

    local updates=$(("$updates_arch" + "$updates_aur"))

    if [ "$updates" -gt 0 ]; then
        echo "$updates"
    fi
}

updates_print
