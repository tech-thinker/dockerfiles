# NoVNC
Its a noVNC server that can allow you to share any gui docker or system app through it.

# Version

- v1.0.0 is no password required to login over vnc
- v2.0.0 is required password to login, default password is "password"

# Docker-Compose
```yml
version: '2'
services:
  ide:
    image: psharkey/intellij:latest
#    image: psharkey/netbeans-8.1:latest
    environment:
      - DISPLAY=novnc:0.0
    depends_on:
      - novnc
    networks:
      - x11
  novnc:
    image: techthinkerorg/novnc:v1.0.0
    environment:
      # Adjust to your screen size
      - DISPLAY_WIDTH=1280
      - DISPLAY_HEIGHT=720
      - RUN_XTERM=no
      # Default password is "password"
      # Default login required value is "no"
      - LOGIN_REQUIRED=yes
      - X11VNC_PASSWORD=password
    ports:
      - "6080:6080"
    networks:
      - x11
networks:
  x11:
```

