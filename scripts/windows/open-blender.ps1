# Opens Blender's window, optionally with a .blend file.
#   powershell -ExecutionPolicy Bypass -File scripts\windows\open-blender.ps1 [models\file.blend]
param([string]$File)
$ErrorActionPreference = 'Stop'

$blender = & (Join-Path $PSScriptRoot 'find-blender.ps1')
if ($File) {
    $path = (Resolve-Path -LiteralPath $File).Path
    Start-Process -FilePath $blender -ArgumentList "`"$path`""
} else {
    Start-Process -FilePath $blender
}
Write-Output "Opened $blender"
