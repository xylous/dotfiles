# Set custom path for xinitrc
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
export XAUTHORITY="${XDG_CONFIG_HOME}/X11/Xauthority"

# Autostart X.org at login on tty1
if [[ -z "${DISPLAY}" ]] && [[ "${XDG_VTNR}" -eq 1 ]]; then
  exec startx "${XDG_CONFIG_HOME}/X11/xinitrc" --; exit
fi
