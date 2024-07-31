FROM debian:bullseye
LABEL maintainer="Tech Thinker <https://techthinker.js.org>"

# Install git, supervisor, VNC, & X11 packages
RUN set -ex; \
    apt-get update; \
    apt-get install -y \
      bash \
      fluxbox \
      git \
      net-tools \
      novnc \
      supervisor \
      x11vnc \
      xterm \
      xvfb

# Setup demo environment variables
ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=768 \
    RUN_XTERM=yes \
    RUN_FLUXBOX=yes

RUN ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html
RUN mkdir -p /app
RUN mkdir -p /app/conf.d
COPY ./conf.d/fluxbox.conf /app/conf.d/fluxbox.conf
COPY ./conf.d/websockify.conf /app/conf.d/websockify.conf
COPY ./conf.d/x11vnc.conf /app/conf.d/x11vnc.conf
COPY ./conf.d/xvfb.conf /app/conf.d/xvfb.conf
COPY ./supervisord.conf /app/supervisord.conf
COPY ./bootstrap.sh /app/bootstrap.sh
RUN chmod +x /app/bootstrap.sh
CMD ["/app/bootstrap.sh"]
EXPOSE 6080
