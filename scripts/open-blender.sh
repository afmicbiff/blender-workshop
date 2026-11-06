#!/bin/bash
# Starts the cloud desktop (if needed) and opens Blender on it.
# Optional argument: a .blend file to open (copied into the desktop's home).
set -euo pipefail
/opt/cu-desktop/cu-desktop start >/dev/null
HOME_DIR=$(/opt/cu-desktop/cu-desktop status | python3 -c 'import json,sys; print(json.load(sys.stdin)["home"])')
ARGS=()
if [ $# -gt 0 ]; then
  cp "$1" "$HOME_DIR/"
  ARGS=("$HOME_DIR/$(basename "$1")")
fi
/opt/cu-desktop/cu-desktop run --wait Blender --timeout 120 \
  --env LIBGL_ALWAYS_SOFTWARE=1 blender "${ARGS[@]}"
