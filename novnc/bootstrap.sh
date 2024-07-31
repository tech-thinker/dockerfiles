#!/bin/bash
set -ex

RUN_FLUXBOX=${RUN_FLUXBOX:-yes}
RUN_XTERM=${RUN_XTERM:-yes}
LOGIN_REQUIRED=${LOGIN_REQUIRED:-no}

case $RUN_FLUXBOX in
  false|no|n|0)
    rm -f /app/conf.d/fluxbox.conf
    ;;
esac

case $RUN_XTERM in
  false|no|n|0)
    rm -f /app/conf.d/xterm.conf
    ;;
esac

X11VNC_PASSWORD=${X11VNC_PASSWORD:-password}
x11vnc -storepasswd ${X11VNC_PASSWORD} /etc/vncpasswd
chmod 600 /etc/vncpasswd

case $LOGIN_REQUIRED in
  true|yes|y|1)
    rm -f /app/conf.d/x11vnc.conf
    ;;
  false|no|n|0)
    rm -f /app/conf.d/x11vnc-login.conf
    ;;
esac

exec supervisord -c /app/supervisord.conf
