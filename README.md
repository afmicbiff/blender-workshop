# Blender workshop

Builds 3D items with Blender, using Claude Code.

## Files
- `scripts/make_test_cube.py` — example: a cube with rounded edges, saved as `.blend` and exported to STL in mm.
- `scripts/blender_compat.py` — helpers that work in Blender 4.0 and 5.2 (STL export, millimeters, script arguments).
- `scripts/windows/` — find, open and run your installed Blender on Windows.
- `scripts/install-blender.sh`, `scripts/open-blender.sh` — install and open Blender in a Claude Code cloud session.
- `.mcp.json` — connects the cloud desktop's screen-control tool in cloud sessions.
- `models/` holds `.blend` files; `exports/` holds STL/3MF/OBJ/GLB exports.

## On Windows
From the repo folder in PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File scripts\windows\find-blender.ps1
powershell -ExecutionPolicy Bypass -File scripts\windows\run-blender.ps1 scripts\make_test_cube.py 50 3 3
powershell -ExecutionPolicy Bypass -File scripts\windows\open-blender.ps1 models\test-cube-50mm.blend
```

The second command makes a 50 mm cube with 3 mm, 3-segment rounded edges. If Blender isn't found,
set its path first: `$env:BLENDER_EXE = 'C:\Program Files\Blender Foundation\Blender 5.2\blender.exe'`.
