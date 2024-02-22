FROM openresty/openresty:1.25.3.1-alpine
LABEL maintainer="Tech Thinker <https://techthinker.js.org>"

RUN	apk --update add --no-cache --virtual .gettext gettext

ADD delay-proxy/proxy.conf /etc/nginx/conf.d/proxy.tmpl

ENV LIMIT              0
ENV DELAY              0.0
ENV UPSTREAM           http://www.example.com
ENV RESOLVER           8.8.8.8

CMD /bin/ash -c " \
        envsubst '\${LIMIT} \${UPSTREAM} \${DELAY} \${RESOLVER}' \
                 < /etc/nginx/conf.d/proxy.tmpl > /etc/nginx/conf.d/default.conf \
        && nginx -g 'daemon off;'"