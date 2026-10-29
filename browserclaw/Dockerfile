FROM debian:trixie-slim

LABEL maintainer="Tech Thinker <https://techthinker.js.org>"

ENV DEBIAN_FRONTEND=noninteractive \
    USER=desktop \
    HOME=/home/desktop \
    DISPLAY=:1 \
    VNC_PORT=5901 \
    VNC_RESOLUTION=1280x800 \
    VNC_DEPTH=24

# Install desktop, VNC, Nginx, Supervisor, and BrowserOS dependencies.
RUN apt-get update && apt-get install -y --no-install-recommends \
    xfce4-session \
    xfwm4 \
    xfce4-panel \
    xfdesktop4 \
    xfce4-terminal \
    thunar \
    dbus-x11 \
    tigervnc-standalone-server \
    tigervnc-tools \
    xauth \
    x11-xserver-utils \
    ca-certificates \
    sudo \
    procps \
    nano \
    curl \
    wget \
    less \
    fonts-dejavu-core \
    libnss3 \
    libnspr4 \
    libasound2t64 \
    libgbm1 \
    nginx \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# Download and install BrowserOS, allowing APT to resolve package dependencies.
RUN curl -fL https://cdn.browseros.com/download/BrowserOS_neo.deb \
        -o /tmp/browser.deb \
    && apt-get update \
    && apt-get install -y /tmp/browser.deb \
    && rm -f /tmp/browser.deb \
    && rm -rf /var/lib/apt/lists/*

# Create the desktop user.
RUN useradd -m -s /bin/bash desktop \
    && echo 'desktop ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/desktop \
    && chmod 0440 /etc/sudoers.d/desktop \
    && mkdir -p /home/desktop/.config/tigervnc \
    && chown -R desktop:desktop /home/desktop

RUN set -eux; \
    mkdir -p \
      /usr/share/applications \
      /home/desktop/.config \
      /home/desktop/.local/share/applications; \
    printf '%s\n' \
      '[Desktop Entry]' \
      'Version=1.0' \
      'Type=Application' \
      'Name=BrowserClaw' \
      'Comment=BrowserClaw Browser' \
      'Exec=/usr/bin/browserclaw --no-sandbox %U' \
      'Icon=web-browser' \
      'Terminal=false' \
      'Categories=Network;WebBrowser;' \
      'StartupNotify=true' \
      'MimeType=text/html;x-scheme-handler/http;x-scheme-handler/https;' \
      > /usr/share/applications/browserclaw.desktop; \
    printf '%s\n' \
      '[Default Applications]' \
      'text/html=browserclaw.desktop' \
      'x-scheme-handler/http=browserclaw.desktop' \
      'x-scheme-handler/https=browserclaw.desktop' \
      > /home/desktop/.config/mimeapps.list; \
    cp /usr/share/applications/browserclaw.desktop \
      /home/desktop/.local/share/applications/browserclaw.desktop; \
    chown -R desktop:desktop /home/desktop/.config /home/desktop/.local

# BrowserClaw launcher and Nginx configuration.
COPY start-browserclaw.sh /usr/local/bin/start-browserclaw.sh
RUN chmod +x /usr/local/bin/start-browserclaw.sh \
    && rm -f /etc/nginx/sites-enabled/default

COPY browserclaw /etc/nginx/sites-enabled/browserclaw
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Container entrypoint.
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /home/desktop

EXPOSE 5901

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

