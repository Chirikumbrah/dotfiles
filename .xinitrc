#!/bin/sh

# init keyring
eval "$(gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)"

# export keyring
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK

# set QT platform theme engine
export QT_QPA_PLATFORMTHEME="qt5ct"

### AUTOSTART ###

# Set up monitor and set background
~/.scripts/system/xrandr.sh &

# Setup autostart
~/.scripts/system/autostart.sh &

# Lunch dbus-launch, this is important for some app
# if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
#     eval "$(dbus-launch --sh-syntax --exit-with-session)"
# fi

# start dwm
# exec "$HOME/.scripts/system/sbar.sh" &
exec dwmblocks &
exec dbus-run-session dwm

# start awesome
# exec dbus-launch --sh-syntax --exit-with-session awesome
