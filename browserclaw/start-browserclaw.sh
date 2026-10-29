#!/bin/bash
set -eu

export HOME=/home/desktop
export USER=desktop
export DISPLAY=:1
export XAUTHORITY=/home/desktop/.Xauthority

# Wait for TigerVNC to create its X11 display
for i in $(seq 1 60); do
    if [ -S /tmp/.X11-unix/X1 ] && xset -display :1 q >/dev/null 2>&1; then
        break
    fi
    sleep 1
done

# Fail clearly if the display is still unavailable
xset -display :1 q >/dev/null 2>&1 || {
    echo "ERROR: VNC display :1 is unavailable or unauthorized"
    exit 1
}

# Start BrowserClaw with a D-Bus session
exec dbus-launch --exit-with-session /usr/bin/browserclaw --no-sandbox

