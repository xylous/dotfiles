#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi


### CUSTOM
# Export path to GTK2 config file
export GTK2_RC_FILES="~/.config/gtk-2.0/gtkrc-2.0"

# Disable keyboard repeat rate; that is, if you hold down a key, it won't be
# counted multiple times
xset r off

# Be easier on the eyes
exec redshift -t 4600:2300 -g 0.8 -m randr &

# feh for wallpaper + picom as compositer
WALLPAPER="${XDG_CONFIG_HOME}/i3/wallpaper.png"
exec feh --no-fehbg --bg-scale ${WALLPAPER} &
exec picom --config ${XDG_CONFIG_HOME}/picom.conf &

# Execute a custom script that reminds you to get up and exercise
[[ -f "$HOME/bin/takeabreak" ]] && exec "$HOME/bin/takeabreak" &

# Finally, execute the graphical environment
exec i3
