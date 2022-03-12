#!/usr/bin/env bash

icon_on=''
icon_off=''

vpn_print() {
    local output status temp period
    status="$(vpn status)"

    if [[ "${status}" == "on" ]]; then
        output="${icon_on} ${status}"
    else
        output="${icon_off} ${status}"
    fi

    echo "${output# }"
}

while [[ "$#" -gt 0 ]]; do
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
readonly icon_on icon_off

vpn_print
