#!/bin/bash
# Create new user from system prompts
read -p "Enter username: " SFTP_USER
read -s -p "Enter password: " SFTP_PASSWORD
echo

# Create user if not exists
if ! id "$SFTP_USER" &>/dev/null; then
    useradd -m -s /sbin/nologin "$SFTP_USER"
fi

# Set password for user
echo "$SFTP_USER:$SFTP_PASSWORD" | chpasswd

# Prepare directories
SFTP_HOME="/home/$SFTP_USER"
SFTP_DIR="sftp"
SFTP_PATH="/home/$SFTP_USER/$SFTP_DIR"
mkdir -p "$SFTP_HOME" "$SFTP_PATH"
chown root:root "$SFTP_HOME"
chmod 755 "$SFTP_HOME"
export SFTP_USER SFTP_HOME SFTP_PATH
envsubst < /tools/default.conf > /etc/ssh/sshd_config.d/$SFTP_USER.conf

echo "User $SFTP_USER created successfully."
