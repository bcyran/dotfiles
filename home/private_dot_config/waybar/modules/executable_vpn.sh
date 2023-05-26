#!/usr/bin/env bash

vpn_print() {
    local status
    status=$(vpn status)

    if [[ "${status}" == 'on' ]]; then
        echo "{\"text\": \"on\", \"alt\": \"on\"}"
    else
        echo "{\"text\": \"off\", \"alt\": \"off\"}"
    fi
}

vpn_print
