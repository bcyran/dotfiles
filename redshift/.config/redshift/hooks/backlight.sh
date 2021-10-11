#!/usr/bin/env bash

# Set backlight brightness according to redshift period

readonly brightness_day=100
readonly brightness_transition=90
readonly brightness_night=75
readonly backlight="$HOME/bin/backlight"

set_brightness() {
    "$backlight" set $1
}

if [ "$1" = period-changed ]; then
	case $3 in
		night)
			set_brightness $brightness_night ;;
		transition)
			set_brightness $brightness_transition ;;
		daytime)
			set_brightness $brightness_day ;;
	esac
fi
