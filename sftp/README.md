# SFTP with Docker Compose

This project sets up a secure SFTP server using Docker Compose. It utilizes the `techthinkerorg/sftp` Docker image to provide SFTP functionality with user management.

## Prerequisites

*   Docker
*   Docker Compose

## Getting Started

1.  **Create `docker-compose.yaml`:**

    ```yaml
    version: "3.8"
    services:
      sftp:
        image: techthinkerorg/sftp:v1.0.0
        container_name: sftp
        restart: always
        ports:
          - 22000:22
        volumes:
          - sftp-data:/home/myuser/upload
        environment:
          SFTP_USER: myuser
          SFTP_PASSWORD: mypassword
          SFTP_DIR: upload
    volumes:
      sftp-data:
        driver: local
        driver_opts:
          type: none
          device: /srv/sftp-data
          o: bind

    ```

2.  **Run:**

    *   Edit the `users.conf` file.  Each line represents a user in the format: `username:password:uid:gid`.  Example:

        ```
        docker compose up -d
        # or
        docker-compose up -d
        ```
