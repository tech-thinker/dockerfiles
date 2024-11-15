#!/bin/sh
sed -i "s|\${REDIRECT_URL}|$REDIRECT_URL|g" nginx.conf
cp nginx.conf /etc/nginx/conf.d/default.conf
nginx -g 'daemon off;'
