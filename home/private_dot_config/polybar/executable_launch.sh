#!/usr/bin/env bash

# Acquire mutex, exit if this script is already running.
# This is to prevent errors caused by running this script multiple times
# in rapid succession which happened often to me when using srandrd.
if ! mkdir /tmp/polybar-launch.lock 2> /dev/null; then
    exit 1
fi

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar > /dev/null; do sleep 1; done

# Launch bar for each monitor
while IFS= read -r line; do
    monitor=$(cut -d ':' -f 1 <<< "${line}")
    grep -q 'primary' <<< "${line}" && bar_name='primary' || bar_name='secondary'
    echo "Starting bar '${bar_name}' on monitor '${monitor}'"
    MONITOR=${monitor} polybar "${bar_name}" &
done < <(polybar -m)

echo 'Bars launched...'

# Free the mutex
rm -r /tmp/polybar-launch.lock
