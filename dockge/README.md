# Dockge

It will allow you to run your code in a Docker container, and then access it from your local machine.

## Installation
- Create `docker-compose.yml`
```sh
version: "3.8"
services:
  dockge:
    image: techthinkerorg/dockge:v1
    restart: unless-stopped
    ports:
      - 10001:5001
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./data:/app/data
      - ./.docker/:/root/.docker
      - /srv/dockge-stacks:/opt/stacks
    environment:
      # Tell Dockge where to find the stacks
      - DOCKGE_STACKS_DIR=/opt/stacks
```
- Run `docker-compose up`
```sh
docker-compose up -d
```
