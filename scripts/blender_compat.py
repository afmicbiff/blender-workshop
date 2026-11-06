"""Helpers that work the same in Blender 4.0 (cloud) and 5.2 LTS (Windows PC)."""
import sys
import bpy


def script_args():
    """Arguments given after `--` on the Blender command line."""
    return sys.argv[sys.argv.index("--") + 1:] if "--" in sys.argv else []


def use_millimeters():
    """Make 1 Blender unit = 1 mm, so exported STL/3MF numbers are millimeters."""
    units = bpy.context.scene.unit_settings
    units.system = "METRIC"
    units.length_unit = "MILLIMETERS"
    units.scale_length = 0.001


def export_stl(filepath, selected_only=True):
    """Export STL with whichever exporter this Blender version has."""
    if bpy.app.version >= (4, 1, 0):  # new exporter: Blender 4.1 and newer, including 5.x
        bpy.ops.wm.stl_export(filepath=filepath, export_selected_objects=selected_only)
    else:  # Blender 4.0 and older
        bpy.ops.export_mesh.stl(filepath=filepath, use_selection=selected_only)
