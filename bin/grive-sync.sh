#!/bin/bash

mkdir -p "$HOME/.tmp"
PIDFILE="$HOME/.tmp/grive-sync.pid"

if [ -e "${PIDFILE}" ] && (ps -u $(whoami) -opid= |
                           grep -P "^\s*$(cat ${PIDFILE})$" &> /dev/null); then
  echo "Already running."
  exit 99
fi

cd "/home/bazyli/Inne/Google Drive"
grive -V > "$HOME/.tmp/grive-sync.log" 2>&1 &

echo $! > "${PIDFILE}"
chmod 644 "${PIDFILE}"

exit 0