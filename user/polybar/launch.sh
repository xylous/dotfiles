#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait for other instances to terminate
while pgrep -x polybar >/dev/null; do
    sleep 1;
done

# Launch
polybar i3bar &
