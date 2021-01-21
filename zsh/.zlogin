# Autostart X.org at login on tty1
if [[ -z "${DISPLAY}" ]] && [[ "${XDG_VTNR}" -eq 1 ]]; then
  exec startx; exit
fi
