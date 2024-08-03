FROM ubuntu/squid:edge
LABEL maintainer="Tech Thinker <https://techthinker.js.org>"

COPY squid.conf /etc/squid/squid.conf
COPY squid-default.conf /etc/squid/squid-default.conf
RUN apt-get update && apt-get install -y apache2-utils

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3128

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
