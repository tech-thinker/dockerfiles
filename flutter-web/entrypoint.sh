#!/bin/bash

# Check if pubspec.yaml exists
if [ ! -f "pubspec.yaml" ]; then
      echo "No project found. Creating a new Flutter project..."
        flutter create --platforms=web .
fi
flutter --version
flutter pub upgrade
echo "Starting server...."
flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0