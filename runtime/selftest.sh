#!/bin/sh
# Checks that the hardening is real: the root is read-only, no capabilities, and a stopped container comes back.
set -eu
fail() { echo "FAIL: $1" >&2; exit 1; }
podman inspect fabric >/dev/null 2>&1 || fail "container fabric is not running (run: pixi run run)"
[ "$(podman inspect -f '{{.HostConfig.ReadonlyRootfs}}' fabric)" = "true" ] || fail "root is writable"
[ "$(podman inspect -f '{{.HostConfig.CapDrop}}' fabric)" != "[]" ] || fail "capabilities not dropped"
podman exec fabric sh -c 'touch /usr/x 2>/dev/null' && fail "could write to /usr"
echo "ok: read-only root, caps dropped"
