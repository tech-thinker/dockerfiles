#!/bin/bash
set -e

# Required env vars
SFTP_USER=${SFTP_USER:?Please set SFTP_USER}
SFTP_PASSWORD=${SFTP_PASSWORD:?Please set SFTP_PASSWORD}
SFTP_DIR=${DIR:-upload}
SFTP_HOME="/home/$SFTP_USER"
SFTP_PATH="/home/$SFTP_USER/$SFTP_DIR"

# Replace variables in sshd_config
envsubst < /sshd_config.conf > /etc/ssh/sshd_config

# Create user if not exists
if ! id "$SFTP_USER" &>/dev/null; then
    echo "Creating user: $SFTP_USER"
    useradd -m -d "$SFTP_HOME" -s /sbin/nologin "$SFTP_USER"
fi

# Set password
echo "$SFTP_USER:$SFTP_PASSWORD" | chpasswd

# Prepare directories
mkdir -p "$SFTP_HOME" "$SFTP_PATH"
chown root:root "$SFTP_HOME"
chmod 755 "$SFTP_HOME"

chown "$SFTP_USER":"$SFTP_USER" "$SFTP_PATH"
chmod 700 "$SFTP_PATH"

# Generate host keys if missing
if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    ssh-keygen -A
fi

# Make /run/sshd for Alpine
mkdir -p /run/sshd
chmod 755 /run/sshd

echo "Starting SSH daemon..."
exec /usr/sbin/sshd -D -f /etc/ssh/sshd_config
