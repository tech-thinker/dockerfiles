# Flutter Web

This is flutter web docker image, this can be used to develop and build flutter web application.

## Create new project
1. Create project directory and go inside that directory.
```sh
mkdir example_project
cd example_project
```
2. Create `Dockerfile.dev`
```
FROM techthinkerorg/flutter-web:3.19.3
LABEL maintainer="Asif Mohammad Mollah"
# As per your timezone
ENV TZ=UTC

RUN mkdir app
WORKDIR /app
COPY ./entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
```
3. Create `entrypoint.sh``
```sh
#!/bin/bash

# Check if pubspec.yaml exists
if [ ! -f "pubspec.yaml" ]; then
      echo "No project found. Creating a new Flutter project..."
        flutter create --platforms=web .
fi
flutter --version
flutter pub upgrade
echo "Starting server...."
flutter run -d web-server --web-port=5000 --web-hostname=0.0.0.0
```
4. Create temp docker image
```sh
docker build -t flutter-web:3.19.3 -f Dockerfile.dev .
```

5. Create project
```
docker run --rm -v .:/app -it flutter-web:3.19.3 sh -c "flutter create --platforms=web ."
```

## Setup development
1. Create `docker-compose.yml`
```yaml
version: '3'

services:
  flutter:
    container_name: flutter_web
    build:
      context: .
      dockerfile: Dockerfile.dev
    ports:
      - "5000:5000"
      - "57790:57790"
    volumes:
      - .:/app
```
2. Run `docker-compose up`