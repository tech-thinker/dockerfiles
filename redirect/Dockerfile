FROM nginx:stable-alpine3.20
LABEL maintainer="Tech Thinker <https://techthinker.js.org>"

ENV REDIRECT_URL 'https://hub.docker.com/r/techthinkerorg/redirect'

WORKDIR /app
# Copy the template for runtime substitution
COPY nginx.conf /app/nginx.conf
COPY entrypoint.sh /app/entrypoint.sh

RUN apk add --no-cache gettext
RUN chmod +x /app/entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["/app/entrypoint.sh"]
