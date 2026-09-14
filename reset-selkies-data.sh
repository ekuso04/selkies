#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

echo "Stopping the Selkies container..."
docker compose down

echo "Removing the persistent user data volume..."
docker volume rm -f selkies_selkies-home >/dev/null 2>&1 || true

echo "Starting the Selkies container again..."
docker compose up -d desktop

echo "Reset complete: the stored user data volume has been cleared and the desktop has been restarted."
