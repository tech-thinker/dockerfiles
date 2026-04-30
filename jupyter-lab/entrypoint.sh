#!/bin/bash
set -e

PORT=${PORT:-3000}
ROOT_DIR=${ROOT_DIR:-/app}

if [ -n "$JUPYTER_PASSWORD" ]; then
  echo "Setting Jupyter password..."

  HASHED_PASSWORD=$(python3 - <<EOF
from jupyter_server.auth import passwd
print(passwd("${JUPYTER_PASSWORD}"))
EOF
)

  exec jupyter lab \
    --ip=0.0.0.0 \
    --port=${PORT} \
    --no-browser \
    --allow-root \
    --ServerApp.password="${HASHED_PASSWORD}" \
    --ServerApp.token="" \
    --ServerApp.root_dir=${ROOT_DIR}

else
  echo "No password provided, disabling auth..."

  exec jupyter lab \
    --ip=0.0.0.0 \
    --port=${PORT} \
    --no-browser \
    --allow-root \
    --ServerApp.token="" \
    --ServerApp.password="" \
    --ServerApp.root_dir=${ROOT_DIR}
fi
