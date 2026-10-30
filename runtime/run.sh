#!/bin/sh
# Hardened run: read-only root, no capabilities, bounded memory/pids/logs, restarts on a failed health check.
set -eu
APP_DIR="${APP_DIR:?set APP_DIR to the folder holding the Burrito .exe}"
DATA_DIR="${DATA_DIR:?set DATA_DIR to a persistent folder for FDB, Bao and the Wine prefix}"
podman rm -f bao-bolt >/dev/null 2>&1 || true
exec podman run -d --name bao-bolt \
  --init --read-only --read-only-tmpfs=false \
  --tmpfs /tmp:rw,noexec,nosuid,size=256m --tmpfs /run:rw,noexec,nosuid,size=16m \
  --cap-drop=ALL --security-opt=no-new-privileges \
  --memory=6g --memory-swap=6g --pids-limit=512 --cpus=4 \
  --restart=always --health-on-failure=restart --stop-timeout=60 \
  --log-driver=k8s-file --log-opt max-size=10mb \
  --network=host \
  -v "$APP_DIR":/opt/app:ro,Z -v "$DATA_DIR":/data:rw,Z \
  localhost/bao-bolt-runtime:dev
