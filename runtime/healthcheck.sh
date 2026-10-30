#!/bin/sh
# Healthy only when FDB and Bao both accept connections and the Burrito process is alive.
pgrep -f "$(basename "$APP_EXE")" >/dev/null || exit 1
nc -z 127.0.0.1 "$FDB_PORT" || exit 1
nc -z 127.0.0.1 "$BAO_PORT" || exit 1
