FROM alpine:3.22.2
LABEL maintainer="Tech Thinker <https://techthinker.js.org>"

RUN apk update && \
    apk add openssh-server bash envsubst shadow gettext

RUN ssh-keygen -A

RUN mkdir -p /tools

ADD entrypoint.sh /tools/entrypoint.sh
ADD sftp-create-user.sh /tools/sftp-create-user.sh
RUN chmod +x /tools/entrypoint.sh
RUN chmod +x /tools/sftp-create-user.sh
ADD sshd_config.conf /tools/sshd_config.conf
ADD default.conf /tools/default.conf

ENTRYPOINT ["/tools/entrypoint.sh"]
