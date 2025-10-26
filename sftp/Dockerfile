FROM alpine:3.22.2
LABEL maintainer="Tech Thinker <https://techthinker.js.org>"

RUN apk update && \
    apk add openssh-server bash envsubst shadow gettext

RUN ssh-keygen -A

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ADD sshd_config.conf /sshd_config.conf

ENTRYPOINT ["/entrypoint.sh"]
