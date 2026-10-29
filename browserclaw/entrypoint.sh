#!/bin/bash
set -Eeuo pipefail

: "${VNC_PASSWORD:?Set VNC_PASSWORD when starting the container}"

# Prepare TigerVNC's current configuration directory.
install -d -o desktop -g desktop -m 700 \
    /home/desktop/.config/tigervnc

# Migrate an existing password file if one is present.
if [ -f /home/desktop/.vnc/passwd ] &&
   [ ! -f /home/desktop/.config/tigervnc/passwd ]; then
    install -o desktop -g desktop -m 600 \
        /home/desktop/.vnc/passwd \
        /home/desktop/.config/tigervnc/passwd
fi

# Create a new password file if it doesn't already exist.
if [ ! -f /home/desktop/.config/tigervnc/passwd ]; then
    printf '%s\n' "$VNC_PASSWORD" |
        tigervncpasswd -f > /home/desktop/.config/tigervnc/passwd
fi

chown desktop:desktop /home/desktop/.config/tigervnc/passwd
chmod 600 /home/desktop/.config/tigervnc/passwd
chown -R desktop:desktop /home/desktop/.config

# Allow TigerVNC to migrate legacy configuration when possible.
if [ -d /home/desktop/.vnc ]; then
    chown -R desktop:desktop /home/desktop/.vnc
    rmdir /home/desktop/.vnc 2>/dev/null || true
fi

exec /usr/bin/supervisord -n \
    -c /etc/supervisor/conf.d/supervisord.conf

