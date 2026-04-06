FROM nginx:stable-alpine3.20
LABEL maintainer="Tech Thinker <https://techthinker.js.org>"

ARG TARGETARCH
ARG VERSION=latest

RUN apk add --no-cache libsqlite3-0 tzdata iputils-ping

RUN mkdir -p /app /etc/telepath
WORKDIR /app

RUN case "$TARGETARCH" in \
    "amd64")  FILE=telepath-linux-amd64 ;; \
    "arm64")  FILE=telepath-linux-arm64 ;; \
    "arm")    FILE=telepath-linux-arm ;; \
    *) echo "Unsupported arch: $TARGETARCH" && exit 1 ;; \
    esac && \
    echo "Downloading $FILE" && \
    curl -L -o telepath https://github.com/tech-thinker/telepath/releases/download/${VERSION}/${FILE} && \
    chmod +x telepath

ENTRYPOINT ["/app/telepath"]
CMD ["--path=/etc/telepath/config.json"]
