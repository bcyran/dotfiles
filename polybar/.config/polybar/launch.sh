#!/usr/bin/env bash

# Acquire mutex, exit if this script is already running.
# This is to prevent errors caused by running this script multiple times
# in rapid succession which happened often to me when using srandrd.
if ! mkdir /tmp/polybar-launch.lock 2> /dev/null; then exit 1; fi

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar > /dev/null; do sleep 1; done

# Gather connections info
monitors="$(polybar -m)"
edp_conn="$(grep -w -c eDP1 <<< $monitors)"
hdmi_conn="$(grep -w -c HDMI1 <<< $monitors)"

# Launch proper combination of bars
if [[ $edp_conn == 1 && $hdmi_conn == 0 ]]; then
    MONITOR=eDP1 polybar primary &
elif [[ $edp_conn == 1 && $hdmi_conn == 1 ]]; then
    MONITOR=HDMI1 polybar primary &
    MONITOR=eDP1 polybar secondary &
else
    MONITOR=HDMI1 polybar primary &
fi

echo "Bars launched..."

# Free the mutex
rm -r /tmp/polybar-launch.lock
