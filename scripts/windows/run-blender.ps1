# Runs a Python script in Blender without opening its window (uses the graphics card for renders).
#   powershell -ExecutionPolicy Bypass -File scripts\windows\run-blender.ps1 scripts\make_test_cube.py 50 3 3
#   powershell -ExecutionPolicy Bypass -File scripts\windows\run-blender.ps1 my_script.py -Blend models\x.blend
# Everything after the script path is passed to the script (read it with blender_compat.script_args()).
param(
    [Parameter(Mandatory = $true, Position = 0)][string]$Script,
    [string]$Blend,
    [Parameter(ValueFromRemainingArguments = $true)][string[]]$ScriptArgs
)
$ErrorActionPreference = 'Stop'

$blender = & (Join-Path $PSScriptRoot 'find-blender.ps1')
$arguments = @('--background')
if ($Blend) { $arguments += (Resolve-Path -LiteralPath $Blend).Path }
$arguments += @('--python-exit-code', '1', '--python', (Resolve-Path -LiteralPath $Script).Path, '--')
if ($ScriptArgs) { $arguments += $ScriptArgs }

& $blender @arguments
exit $LASTEXITCODE
