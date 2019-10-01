#!/usr/bin/env bash

# Without this both bars start on secondary monitor, WTF?
sleep 1

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch primary bar
polybar primary &

# Launch secondary bar if second monitor is plugged in
if [ "$(polybar -m | grep -w DP-1)" ]; then
    polybar secondary &
fi

echo "Bars launched..."
