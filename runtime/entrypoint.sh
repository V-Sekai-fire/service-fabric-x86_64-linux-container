#!/bin/sh
# Runs the Windows Burrito under Proton. The Burrito's BEAM supervises the FDB and secrets servers.
set -eu
[ -f "$APP_EXE" ] || { echo "missing $APP_EXE (mount the Burrito at /opt/app)" >&2; exit 78; }
# No GPU needed: a virtual X server keeps Wine happy for console programs.
Xvfb :99 -screen 0 640x480x16 -nolisten tcp &
export DISPLAY=:99
exec python3 /opt/umu/umu-run "$APP_EXE"
