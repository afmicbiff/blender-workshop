"""Build a cube with rounded edges, save it as .blend and export an STL.

Run:  blender -b --python scripts/make_test_cube.py -- [size_mm] [bevel_mm] [segments]
Defaults: a 50 mm cube with 3 mm, 3-segment rounded edges.
Writes models/test-cube-<size>mm.blend and exports/test-cube-<size>mm.stl.
"""
import os
import sys

import bpy  # before bmesh, so it also works as the pip `bpy` module
import bmesh

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from blender_compat import export_stl, script_args, use_millimeters

args = script_args()
size = float(args[0]) if len(args) > 0 else 50.0
bevel = float(args[1]) if len(args) > 1 else 3.0
segments = int(args[2]) if len(args) > 2 else 3

repo = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
name = f"test-cube-{size:g}mm"

bpy.ops.wm.read_factory_settings(use_empty=True)
use_millimeters()

mesh = bpy.data.meshes.new(name)
bm = bmesh.new()
bmesh.ops.create_cube(bm, size=size)
bmesh.ops.bevel(bm, geom=list(bm.edges) + list(bm.verts), offset=bevel,
                segments=segments, profile=0.5, affect="EDGES")
bmesh.ops.translate(bm, vec=(0, 0, size / 2), verts=bm.verts)  # sit on the grid
bm.to_mesh(mesh)
bm.free()

obj = bpy.data.objects.new(name, mesh)
bpy.context.scene.collection.objects.link(obj)
bpy.context.view_layer.objects.active = obj
obj.select_set(True)

os.makedirs(os.path.join(repo, "models"), exist_ok=True)
os.makedirs(os.path.join(repo, "exports"), exist_ok=True)
blend_path = os.path.join(repo, "models", name + ".blend")
stl_path = os.path.join(repo, "exports", name + ".stl")
bpy.ops.wm.save_as_mainfile(filepath=blend_path)
export_stl(stl_path)

print(f"Blender {bpy.app.version_string}: {name} "
      f"{tuple(round(d, 3) for d in obj.dimensions)} mm, {len(mesh.vertices)} vertices")
print("Saved", blend_path)
print("Exported", stl_path)
