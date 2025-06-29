FROM nginx:stable-alpine3.20
LABEL maintainer="Tech Thinker <https://techthinker.js.org>"

RUN apk add --no-cache autossh openssh-client bash

RUN mkdir -p /srv/ssh-key

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
