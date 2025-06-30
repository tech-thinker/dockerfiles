#!/bin/bash
set -e

# Required env vars with defaults
LOCAL_ADDR=${LOCAL_ADDR:-localhost}
LOCAL_PORT=${LOCAL_PORT:-22}
REMOTE_HOST=${REMOTE_HOST:?Please set REMOTE_HOST}
REMOTE_ADDR=${REMOTE_ADDR:-0.0.0.0}
REMOTE_PORT=${REMOTE_PORT:-22}
SSH_USER=${SSH_USER:?Please set SSH_USER}
FORWARD_TYPE=${FORWARD_TYPE:-R} # R = remote forward, L = local forward

SSH_KEY_PATH="/root/.ssh/id_rsa"
KNOWN_HOSTS_PATH="/root/.ssh/known_hosts"
AUTOSSH_GATETIME=0
AUTOSSH_POLL=10

# Create .ssh directory if it doesn't exist
mkdir -p /root/.ssh

# Copy the SSH key
if [ -f /srv/ssh-key/id_rsa ]; then
  cat /srv/ssh-key/id_rsa > "$SSH_KEY_PATH"
  chmod 600 "$SSH_KEY_PATH"
else
  echo "❌ SSH private key not found at /srv/ssh-key/id_rsa"
  exit 1
fi

# Copy known_hosts if it exists
if [ -f /srv/ssh-key/known_hosts ]; then
  cp /srv/ssh-key/known_hosts "$KNOWN_HOSTS_PATH"
  echo "✅ Using known_hosts from $KNOWN_HOSTS_PATH"
  STRICT_OPTS="-o StrictHostKeyChecking=yes -o UserKnownHostsFile=$KNOWN_HOSTS_PATH"
else
  echo "⚠️ No known_hosts file found. Disabling host key checking (TESTING ONLY)."
  STRICT_OPTS="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
fi

# Common SSH options
EXTRA_OPTS="-o Compression=no -o TCPKeepAlive=yes"
SSH_OPTS="$EXTRA_OPTS -o ServerAliveInterval=30 -o ServerAliveCountMax=3 -o IdentityFile=$SSH_KEY_PATH $STRICT_OPTS"

# Build tunnel command
if [ "$FORWARD_TYPE" = "R" ]; then
  # Remote port forwarding
  TUNNEL_OPTS="-R ${REMOTE_ADDR}:${REMOTE_PORT}:${LOCAL_ADDR}:${LOCAL_PORT}"
elif [ "$FORWARD_TYPE" = "L" ]; then
  # Local port forwarding
  TUNNEL_OPTS="-L ${LOCAL_ADDR}:${LOCAL_PORT}:${REMOTE_HOST}:${REMOTE_PORT}"
else
  echo "❌ Invalid FORWARD_TYPE: $FORWARD_TYPE (use 'R' or 'L')"
  exit 1
fi

# Final autossh command
CMD="autossh -M 0 -N $SSH_OPTS $TUNNEL_OPTS ${SSH_USER}@${REMOTE_HOST}"
echo "🚀 Starting autossh: $CMD"

exec $CMD
