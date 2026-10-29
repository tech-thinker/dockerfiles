# BrowserClaw — Browser Automation with MCP in Docker

Run BrowserClaw in a Docker container with a graphical XFCE desktop, remote VNC access, and Model Context Protocol (MCP) integration for AI agents.

## Features

- BrowserClaw running in Docker.
- Remote graphical desktop through VNC.
- MCP endpoint for compatible AI agents.
- Configurable desktop resolution and color depth.
- Docker Compose and Docker CLI deployment.

## Requirements

- Docker Engine and Docker Compose v2, or a compatible Docker environment.
- A VNC client, such as [TigerVNC Viewer](https://tigervnc.org/).
- An AI agent that supports MCP over HTTP.

## 1. Installation

### Option A: Docker Compose

Create a project directory:

```bash
mkdir browserclaw
cd browserclaw
```

Create `compose.yaml`:

```yaml
services:
  browserclaw:
    image: techthinkerorg/browserclaw:v0.51.2
    container_name: browserclaw
    restart: always

    extra_hosts:
      - "host.docker.internal:host-gateway"

    ports:
      - "9210:9210"
      - "5901:5901"

    environment:
      VNC_PASSWORD: "${VNC_PASSWORD}"
      VNC_RESOLUTION: "1280x800"
      VNC_DEPTH: "24"
```

Create a `.env` file in the same directory:

```dotenv
VNC_PASSWORD=change-this-password
```

Replace the example password with your own password. Do not commit `.env` to version control.

Start BrowserClaw:

```bash
docker compose pull
docker compose up -d
```

Check the container status and logs:

```bash
docker compose ps
docker compose logs -f browserclaw
```

### Option B: Docker CLI

Pull the image:

```bash
docker pull techthinkerorg/browserclaw:v0.51.2
```

Run the container:

```bash
docker run -d \
  --name browserclaw \
  --restart always \
  --add-host host.docker.internal:host-gateway \
  -p 9210:9210 \
  -p 5901:5901 \
  -e VNC_PASSWORD='change-this-password' \
  -e VNC_RESOLUTION=1280x800 \
  -e VNC_DEPTH=24 \
  techthinkerorg/browserclaw:v0.51.2
```

Check the logs:

```bash
docker logs -f browserclaw
```

To stop or restart the container:

```bash
docker stop browserclaw
docker start browserclaw
```

## 2. Connect to the VNC Desktop

Once the container is running, open your VNC client and connect to the Docker host.

| Setting | Value |
|---|---|
| Host | Docker host IP address |
| Port | `5901` |
| Password | Value configured in `VNC_PASSWORD` |
| Default resolution | `1280x800` |
| Color depth | `24` |

If Docker is running on your local computer, connect to:

```text
127.0.0.1:5901
```

If Docker is running on a remote server, use that server's IP address and port `5901`.

### Complete the initial BrowserClaw setup

After connecting through VNC:

1. Wait for the XFCE desktop to load.
2. Open BrowserClaw from the application menu.
3. Complete the initial browser setup wizard.
4. Configure any required browser settings and permissions.
5. Open a website to verify that navigation works.
6. Open BrowserClaw's MCP settings and verify that the MCP server is enabled.

## 3. Connect AI Agents Through MCP

BrowserClaw exposes its MCP endpoint on **port `9210`**.

The published endpoint is:

```text
http://localhost:9210
```

For a remote Docker host, replace `localhost` with the server's IP address or hostname:

```text
http://YOUR_SERVER_IP:9210
```

Use the exact MCP URL and transport shown in BrowserClaw's MCP settings. If the application displays a path such as `/mcp`, include that path in the client configuration.

### Connect an AI agent running on the Docker host

For an MCP client that supports remote HTTP MCP servers, a typical configuration is:

```json
{
  "mcpServers": {
    "browserclaw": {
      "url": "http://127.0.0.1:9210"
    }
  }
}
```

If BrowserClaw shows a different endpoint path, update the URL accordingly. Check your AI agent's documentation for its exact configuration format and supported MCP transport.

After configuring the MCP server:

1. Save the agent configuration.
2. Restart or reload your AI agent.
3. Confirm that BrowserClaw's MCP tools are available.
4. Ask the agent to perform a simple browser task to verify the integration.

### Connect an AI agent running in another container

If the AI agent runs in Docker, place both services on the same Docker network.

The AI agent can then connect using the BrowserClaw container name:

```text
http://browserclaw:9210
```

Use the MCP endpoint path displayed by BrowserClaw if required.

## 4. Configuration

| Variable | Default | Description |
|---|---|---|
| `VNC_PASSWORD` | Required | Password used for VNC authentication |
| `VNC_RESOLUTION` | `1280x800` | Virtual desktop resolution |
| `VNC_DEPTH` | `24` | Display color depth |

Example configuration:

```yaml
environment:
  VNC_PASSWORD: "${VNC_PASSWORD}"
  VNC_RESOLUTION: "1600x900"
  VNC_DEPTH: "24"
```

The container exposes these host ports:

| Port | Purpose |
|---|---|
| `5901` | VNC remote desktop |
| `9210` | BrowserClaw MCP endpoint |

## 5. Troubleshooting

### Check container status

```bash
docker ps
docker logs --tail 200 browserclaw
```

### Check listening ports

```bash
docker exec browserclaw ss -lntp
```

Confirm that the VNC and MCP services are listening on their expected ports.

### Cannot connect through VNC

- Verify that the container is running.
- Confirm that port `5901` is published.
- Check the VNC password.
- Ensure the host firewall permits access from your client.

### AI agent cannot connect to MCP

- Confirm that the MCP service is enabled in BrowserClaw.
- Verify the exact endpoint URL and transport in BrowserClaw's MCP settings.
- Ensure port `9210` is published and reachable.
- If the AI agent runs in another container, verify that both containers share a Docker network.
- Check the container logs for startup or backend errors.

## Security

- Use a strong VNC password.
- Do not commit `.env` files containing passwords.
- Restrict VNC and MCP access to trusted networks.
- Use a private VPN, SSH tunnel, or secured reverse proxy for remote access.
- Avoid exposing browser debugging interfaces publicly.

## License

GNU Affero General Public License v3.0

