#!/bin/bash
# Squid OCI image entrypoint

# This entrypoint aims to forward the squid logs to stdout to assist users of
# common container related tooling (e.g., kubernetes, docker-compose, etc) to
# access the service logs.

# Moreover, it invokes the squid binary, leaving all the desired parameters to
# be provided by the "command" passed to the spawned container. If no command
# is provided by the user, the default behavior (as per the CMD statement in
# the Dockerfile) will be to use Ubuntu's default configuration [1] and run
# squid with the "-NYC" options to mimic the behavior of the Ubuntu provided
# systemd unit.

# [1] The default configuration is changed in the Dockerfile to allow local
# network connections. See the Dockerfile for further information.

# Create squid password

AUTH_REQUIRED=${AUTH_REQUIRED:-false}
if [ ! $AUTH_REQUIRED = "true" ]; then
    rm /etc/squid/squid.conf
    mv /etc/squid/squid-default.conf /etc/squid/squid.conf
else
    rm /etc/squid/squid-default.conf
    if [ -f /etc/squid/htpasswd ]; then
        rm -rf /etc/squid/htpasswd
    fi
    htpasswd -bc /etc/squid/htpasswd ${USERNAME} ${PASSWORD}
fi

SSL_VERIFY=${SSL_VERIFY:-true}
case "$SSL_VERIFY" in
    true)
        ;;
    false)
        if ! grep -q '^# sslproxy_flags DONT_VERIFY_PEER$' /etc/squid/squid.conf; then
            echo "SSL_VERIFY=false was set, but the Squid config has no SSL verification setting to disable." >&2
            exit 1
        fi
        sed -i 's/^# sslproxy_flags DONT_VERIFY_PEER$/sslproxy_flags DONT_VERIFY_PEER/' /etc/squid/squid.conf
        ;;
    *)
        echo "SSL_VERIFY must be 'true' or 'false' (got '$SSL_VERIFY')." >&2
        exit 1
        ;;
esac

# re-create snakeoil self-signed certificate removed in the build process
if [ ! -f /etc/ssl/private/ssl-cert-snakeoil.key ]; then
    /usr/sbin/make-ssl-cert generate-default-snakeoil --force-overwrite > /dev/null 2>&1
fi

tail -F /var/log/squid/access.log 2>/dev/null &
tail -F /var/log/squid/error.log 2>/dev/null &
tail -F /var/log/squid/store.log 2>/dev/null &
tail -F /var/log/squid/cache.log 2>/dev/null &
# create missing cache directories and exit
/usr/sbin/squid -Nz
/usr/sbin/squid "$@"
while true; do sleep 10; done
