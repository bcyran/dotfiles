#!/usr/bin/env bash

# Acquire mutex, exit if this script is already running.
# This is to prevent errors caused by running this script multiple times
# in rapid succession which happened often to me when using srandrd.
if ! mkdir /tmp/polybar-launch.lock 2> /dev/null; then exit 1; fi

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar > /dev/null; do sleep 1; done

if [ "$(polybar -m | grep -w DP1-2)" ]; then
    # work configuration (3 monitors)
    MONITOR="DP1-2" polybar primary &
    MONITOR="DP2" polybar secondary &
    MONITOR="DP1-1" polybar secondary &
else
    if [ "$(polybar -m | grep -w DP1)" ]; then
        MONITOR="DP1" polybar primary &
        MONITOR="eDP1" polybar secondary &
    else
        # mobile configuration (only built-in)
        MONITOR="eDP1" polybar primary &
    fi
fi

echo "Bars launched..."

# Free the mutex
rm -r /tmp/polybar-launch.lock
