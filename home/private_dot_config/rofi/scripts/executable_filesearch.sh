#!/usr/bin/env bash

format='<b>{/}</b>\n{}\t'
opts="$(fd -L -t f -c never -x printf "${format}")"

cmd="rofi -no-lazy-grab -dmenu -i -p Files -sep \t -markup-rows -config ~/.config/rofi/filesearch.rasi"

choice=$(${cmd} <<< "${opts}")

if [[ -n "${choice}" ]]; then
    path=$(tail -n 1 <<< "${choice}")
    gio open "${path}"
fi
