#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar > /dev/null; do sleep 1; done

# Launch primary bar
MONITOR=eDP1 polybar primary &

# Launch secondary bar if second monitor is plugged in
if [ "$(polybar -m | grep -w DP1)" ]; then
    MONITOR=DP1 polybar secondary &
fi

echo "Bars launched..."
