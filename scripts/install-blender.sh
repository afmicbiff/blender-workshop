#!/bin/bash
# Installs Blender (GUI) from Ubuntu's packages. Safe to run more than once.
set -euo pipefail
if command -v blender >/dev/null; then
  blender --version | head -1
  exit 0
fi
apt-get update -qq
DEBIAN_FRONTEND=noninteractive apt-get install -y -qq blender
blender --version | head -1
