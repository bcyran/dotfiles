#!/usr/bin/env bash

pid=$(pgrep -x redshift)
readonly pid

icon_on=''
icon_off=''
hide_day='false'

redshift_print() {
    local output status temp period

    if [[ -n "${pid}" ]]; then
        status=$(LC_ALL=C redshift -p 2> /dev/null)
        temp=$(echo "${status}" | grep -oP '(?<=Color temperature: )\w+')
        period=$(echo "${status}" | grep -oP '(?<=Period: )\w+')

        if [[ "${hide_day}" == 'true' && "${period}" == 'Daytime' ]]; then
            output=''
        else
            output="${icon_on} ${temp}"
        fi
    else
        output="${icon_off} off"
    fi

    echo "${output# }"
}

redshift_toggle() {
    if [[ -n "${pid}" ]]; then
        killall -e redshift
    else
        redshift > /dev/null 2>&1 &
    fi
}

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --icon-on)
            shift
            icon_on=$1
            ;;
        --icon-off)
            shift
            icon_off=$1
            ;;
        --hide-day)
            hide_day='true'
            ;;
        *)
            break
            ;;
    esac
    shift
done
readonly icon_on icon_off hide_day

case "$1" in
    toggle)
        redshift_toggle
        ;;
    *)
        redshift_print
        ;;
esac
