# Webtop VPS Custom (Ubuntu XFCE + SSH + Tmate)

[![Docker Publish to GHCR](https://github.com/ayoub55555555/webtop-vps-custom/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/ayoub55555555/webtop-vps-custom/actions/workflows/docker-publish.yml)

A custom Docker image based on `linuxserver/webtop:ubuntu-xfce` with pre-installed SSH and Tmate for instant remote access.

## Features
- **Ubuntu XFCE Desktop**: Full desktop environment in your browser.
- **SSH Server**: Access your container via traditional SSH.
- **Tmate Support**: Instant SSH session without port forwarding.
- **Auto-Publish**: Built and pushed to GHCR automatically.

## Quick Start with Docker Compose
```yaml
version: "3"
services:
  webtop:
    image: ghcr.io/ayoub55555555/webtop-vps-custom:main
    container_name: webtop-vps
    privileged: true
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
    volumes:
      - /path/to/data:/config
    ports:
      - 3000:3000
      - 2222:22
    restart: unless-stopped
```

## How to Connect
1. **Web UI**: Access via `http://localhost:3000`.
2. **SSH**: `ssh root@localhost -p 2222` (Password: `root`).
3. **Tmate**: Check the file `tmate_connection.txt` on your desktop inside the container for a direct SSH link.

## Security Note
Default password is set to `root`. Please change it by modifying the Dockerfile or running `passwd` inside the container.
