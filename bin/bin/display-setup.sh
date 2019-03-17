#!/bin/bash

# Outputs
internal="eDP-1"
external="DP-1"

# Output's settings
internal_res="1920x1080"
external_res="1680x1050"
internal_pos="0x440"
external_pos="1920x0"

# Compose xrandr commands
single_setup="xrandr \
			--output $internal --mode $internal_res \
			--output $external --off"
dual_setup="xrandr \
			--output $internal --primary --mode $internal_res --pos $internal_pos \
			--output $external --mode $external_res --pos $external_pos --scale-from $external_res"
presentation_setup="xrandr \
			--output $internal --primary --mode $internal_res \
			--output $external --auto --same-as $internal --scale-from $internal_res"
auto_setup="xrandr \
			--auto"
reset_setup="xrandr \
			-s 0"

# Check if external monitor is connected
ext_status="$(cat /sys/class/drm/card0-$external/status)"

# Exit if there's no first argument
if [ -z "$1" ]; then
	echo "No mode specified, exiting."
	exit 1
fi

# Set according to chosen mode
case "$1" in
	"single")
		eval "$single_setup"
		echo "Manually setting single monitor mode."
		;;
	"dual")
		eval "$dual_setup"
		echo "Manually setting dual monitor mode."
		;;
	"presentation")
		eval "$presentation_setup"
		echo "Manually setting presentation mode."
		;;
	"detect")
		if [ "$ext_status" = "connected" ]; then
			eval "$dual_setup"
			echo "External monitor detected. Setting dual monitor mode."
		else
			eval "$single_setup"
			echo "No external monitor detected. Setting signle monitor mode."
		fi
		;;
	"auto")
		eval "$auto_setup"
		echo "Running xrandr auto setup."
		;;
	"reset")
		eval "$reset_setup"
		echo "Resetting settings to xrandr defaults."
		;;
	*)
		echo "Unrecognized mode, exiting."
		exit 1
		;;
esac

# If second argument is specified set wallpaper
if [ ! -z "$2" ]; then
	feh --bg-scale "$2" 
	echo "Setting wallpaper to $2."
fi
