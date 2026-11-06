# Blender workshop

This repo is for building 3D items in Blender, both with Python scripts and by hand in the Blender interface.

## Setup at the start of each session
1. `sudo bash scripts/install-blender.sh` (skip if `blender --version` already works).
2. To use the interface: `bash scripts/open-blender.sh [file.blend]`, then drive it with the `computer` tools
   (screenshot, click, type). The user can watch the desktop live.

## Notes
- No graphics card: Blender draws in software (Mesa llvmpipe). Keep the viewport in Solid mode,
  avoid Rendered view while modeling, and render finals with Cycles on CPU at modest samples.
- Prefer Python scripts (`blender -b -P script.py`) for precise, measured parts; use the interface to
  inspect, adjust, and show the user.
- Save `.blend` sources in `models/` and exported files (.stl, .3mf, .obj, .glb) in `exports/`.
- The container is temporary: commit and push work before the session ends.
