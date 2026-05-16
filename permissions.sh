#!/usr/bin/env bash
# Add current user to docker group (run once per machine).
set -euo pipefail

if ! getent group docker >/dev/null; then
  sudo groupadd docker
fi
sudo usermod -aG docker "${USER}"
echo "Added ${USER} to group docker. Log out and back in (or: newgrp docker)."
