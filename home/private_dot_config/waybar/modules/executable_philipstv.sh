#!/usr/bin/env bash

philipstv_print() {
    local status
    if ! status=$(philipstv power get 2> /dev/null); then
        echo ""
        return
    fi
    if [[ "${status}" != 'on' ]]; then
        echo ""
        return
    fi
    philipstv volume get 2> /dev/null
}

philipstv_print
