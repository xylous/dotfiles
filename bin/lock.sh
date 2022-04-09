#!/usr/bin/sh

# Use i3lock to lock the computer; pass any arguments to it

IMAGE=/tmp/lock.png
scrot --silent ${IMAGE}

# imagemagick tricks
convert ${IMAGE} -scale 10% -scale 1000% ${IMAGE}

# Tell spotify to stop
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 \
    org.mpris.MediaPlayer2.Player.Stop &>/dev/null

# Finally, lock the screen
i3lock $@ -i ${IMAGE}

# And clean up
rm -f ${IMAGE}
