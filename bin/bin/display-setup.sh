#!/bin/bash

DISCONNECTED_SETUP='xrandr --auto'
CONNECTED_SETUP='xrandr --output DP-1 --mode 1680x1050 --pos 1920x0 --rotate normal --output HDMI-1 --off --output eDP-1 --primary --mode 1920x1080 --pos 0x440 --rotate normal --output HDMI-2 --off'

STATUS=$(cat /sys/class/drm/card0-DP-1/status)

if [ "$STATUS" = 'connected' ]; then
	eval "$CONNECTED_SETUP"
	echo 'Connected setup'
else
	eval "$DISCONNECTED_SETUP"
	echo 'Disconnected setup'
fi

if [ ! -z "$1" ]; then
	feh --bg-scale "$1" 
fi
