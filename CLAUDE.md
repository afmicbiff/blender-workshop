# Blender workshop

This repo is for building 3D items in Blender, with Python scripts and by hand in the Blender interface.
It runs in two places. Check which one you are in before doing anything else.

## On the user's Windows PC (Blender 5.2.3 LTS, real graphics card) — preferred
- Find Blender: `powershell -ExecutionPolicy Bypass -File scripts\windows\find-blender.ps1`
  (if it fails, ask the user for the path and set `BLENDER_EXE`).
- Run a script without the window:
  `powershell -ExecutionPolicy Bypass -File scripts\windows\run-blender.ps1 scripts\make_test_cube.py 50 3 3`
- Open the window: `powershell -ExecutionPolicy Bypass -File scripts\windows\open-blender.ps1 [models\file.blend]`
- Working in the interface by hand uses the Claude desktop app's computer use (Settings → Computer use).
  It drives the user's real screen: say what you are about to do, and do not touch apps other than Blender.
- Do not install another Blender on the PC.
- Renders can use the GPU: in Cycles, set Preferences → System → Cycles Render Devices (OptiX/CUDA/HIP)
  and Render Properties → Device → GPU Compute.

## In a Claude Code cloud session (Linux, Blender 4.0.2, no graphics card)
1. `sudo bash scripts/install-blender.sh` (the environment's setup script normally did this already).
2. To use the interface: `bash scripts/open-blender.sh [file.blend]`, then drive it with the `computer` tools
   (screenshot, click, type), if they are loaded. The user can watch the desktop live.
- Blender draws in software (Mesa llvmpipe): keep the viewport in Solid mode and render with Cycles on CPU.
- Numpad keys (e.g. Numpad . for Frame Selected) may not register on the desktop; use the View menu.

## Writing scripts (both places)
- Scripts must work in Blender 4.0 and 5.2. Use `scripts/blender_compat.py` for anything that differs:
  `export_stl()` picks `wm.stl_export` (4.1+) or `export_mesh.stl` (4.0) by version number.
  Do not test for operators with `hasattr(bpy.ops...)`: it is always true.
- Read script arguments with `script_args()` (everything after `--`).
- Model in millimeters for 3D printing: call `use_millimeters()`, so 1 Blender unit = 1 mm in exports.
- `import bpy` before `bmesh`.
- Run with `blender -b --python script.py -- args` (or `run-blender.ps1` on Windows).
- Save `.blend` sources in `models/` and exports (.stl, .3mf, .obj, .glb) in `exports/`.
- Commit and push finished work; a cloud container is temporary.
