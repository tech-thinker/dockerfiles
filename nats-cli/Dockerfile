FROM golang:1.16 as builder
LABEL maintainer="Tech Thinker <https://techthinker.js.org>"

RUN apt-get update && \
  apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent

ENV APP_VERSION 0.0.22

RUN mkdir /nats
RUN mkdir /src
WORKDIR /nats
RUN curl -L https://github.com/nats-io/natscli/archive/refs/tags/${APP_VERSION}.tar.gz -o nats-cli.tar.gz
RUN tar -xvf nats-cli.tar.gz
WORKDIR /nats/natscli-${APP_VERSION}
RUN go mod tidy
WORKDIR /nats/natscli-${APP_VERSION}/nats
RUN go build -o nats
RUN cp nats /src/nats

# Runner Stage
FROM alpine:edge
LABEL maintainer="Tech Thinker <https://techthinker.js.org>"
RUN apk add --no-cache libc6-compat
RUN apk add --no-cache tzdata
RUN mkdir /app
WORKDIR /app
COPY --from=builder /src/nats /bin/nats
RUN chmod +x /bin/nats

ARG NATS_SERVER_URL=host.docker.internal
ARG NATS_SERVER_PORT=4222
ARG NATS_SERVER_IDENTIFIER=local
ARG NATS_PUBLISH_SUBJECT=local.subject.ping
ARG NATS_PUBLISH_MESSAGE=ping