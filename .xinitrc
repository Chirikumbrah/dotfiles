#!/bin/sh

# init keyring
gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh &

# export keyring
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK

# set QT platform theme engine
export QT_QPA_PLATFORMTHEME="qt5ct"

### AUTOSTART ###

# Set up monitor and set background
~/.scripts/system/xrandr.sh &

# Setup autostart
~/.scripts/system/autostart.sh &

# start dwm
# exec "$HOME/.scripts/system/sbar.sh" &
exec dwmblocks &
exec dbus-run-session dwm

