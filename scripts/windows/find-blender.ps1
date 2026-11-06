# Prints the full path of blender.exe, newest version first.
# Override by setting the BLENDER_EXE environment variable to the exact path.
$ErrorActionPreference = 'Stop'

if ($env:BLENDER_EXE -and (Test-Path -LiteralPath $env:BLENDER_EXE)) {
    return $env:BLENDER_EXE
}

# Installer versions: C:\Program Files\Blender Foundation\Blender 5.2\blender.exe
$foundation = Join-Path $env:ProgramFiles 'Blender Foundation'
if (Test-Path -LiteralPath $foundation) {
    $found = Get-ChildItem -LiteralPath $foundation -Directory |
        Where-Object { Test-Path -LiteralPath (Join-Path $_.FullName 'blender.exe') } |
        Sort-Object -Descending -Property @{ Expression = {
            $v = $_.Name -replace '^[^\d]*', ''
            try { [version]$v } catch { [version]'0.0' }
        } } |
        Select-Object -First 1
    if ($found) { return (Join-Path $found.FullName 'blender.exe') }
}

# Steam version
$steam = Join-Path ${env:ProgramFiles(x86)} 'Steam\steamapps\common\Blender\blender.exe'
if (Test-Path -LiteralPath $steam) { return $steam }

# On PATH, including the Microsoft Store version's "blender" alias
$cmd = Get-Command blender.exe -ErrorAction SilentlyContinue
if ($cmd) { return $cmd.Source }

throw "blender.exe not found. Set BLENDER_EXE to its full path, for example:`n" +
      "  `$env:BLENDER_EXE = 'C:\Program Files\Blender Foundation\Blender 5.2\blender.exe'"
