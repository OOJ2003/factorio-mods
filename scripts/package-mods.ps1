[CmdletBinding()]
param(
    [string[]] $Mod,
    [switch] $Clean
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$repoRoot = Split-Path -Parent $PSScriptRoot
$sourceRoot = Join-Path $repoRoot "src"
$distRoot = Join-Path $repoRoot "dist"
$stagingRoot = Join-Path $repoRoot "temp\package"

if (-not (Test-Path -LiteralPath $sourceRoot -PathType Container)) {
    throw "Source directory not found: $sourceRoot"
}

New-Item -ItemType Directory -Path $distRoot -Force | Out-Null

if ($Clean) {
    Get-ChildItem -LiteralPath $distRoot -Filter "*.zip" -File |
        Remove-Item -Force
}

$modDirectories = @(
    Get-ChildItem -LiteralPath $sourceRoot -Directory |
        Where-Object { Test-Path -LiteralPath (Join-Path $_.FullName "info.json") }
)

if ($null -ne $Mod -and $Mod.Count -gt 0) {
    $requested = @{}
    foreach ($name in $Mod) {
        $requested[$name] = $true
    }

    $modDirectories = @($modDirectories | Where-Object { $requested.ContainsKey($_.Name) })
    $selectedNames = @($modDirectories | ForEach-Object { $_.Name })
    $missing = @($Mod | Where-Object { $_ -notin $selectedNames })
    if ($missing.Count -gt 0) {
        throw "Mod source directory not found: $($missing -join ', ')"
    }
}

if ($modDirectories.Count -eq 0) {
    throw "No mods with info.json found in $sourceRoot"
}

if (Test-Path -LiteralPath $stagingRoot) {
    Remove-Item -LiteralPath $stagingRoot -Recurse -Force
}
New-Item -ItemType Directory -Path $stagingRoot -Force | Out-Null

try {
    foreach ($modDirectory in $modDirectories) {
        $infoPath = Join-Path $modDirectory.FullName "info.json"
        try {
            $info = Get-Content -LiteralPath $infoPath -Raw | ConvertFrom-Json
        }
        catch {
            throw "Invalid info.json at $infoPath`: $($_.Exception.Message)"
        }

        if ([string]::IsNullOrWhiteSpace($info.name) -or
            [string]::IsNullOrWhiteSpace($info.version)) {
            throw "info.json must contain non-empty name and version fields: $infoPath"
        }

        $packageName = "$($info.name)_$($info.version)"
        if ($packageName.IndexOfAny([System.IO.Path]::GetInvalidFileNameChars()) -ge 0) {
            throw "Invalid package name derived from info.json: $packageName"
        }

        $packageRoot = Join-Path $stagingRoot $packageName
        $archivePath = Join-Path $distRoot "$packageName.zip"

        New-Item -ItemType Directory -Path $packageRoot -Force | Out-Null
        Get-ChildItem -LiteralPath $modDirectory.FullName -Force |
            Copy-Item -Destination $packageRoot -Recurse -Force

        Get-ChildItem -LiteralPath $packageRoot -Recurse -Force -File |
            Where-Object { $_.Name -like "*Zone.Identifier" } |
            Remove-Item -Force

        if (Test-Path -LiteralPath $archivePath) {
            Remove-Item -LiteralPath $archivePath -Force
        }

        Compress-Archive -LiteralPath $packageRoot -DestinationPath $archivePath -CompressionLevel Optimal
        Write-Host "Packed $($modDirectory.Name) -> $archivePath"
    }
}
finally {
    if (Test-Path -LiteralPath $stagingRoot) {
        Remove-Item -LiteralPath $stagingRoot -Recurse -Force
    }
}
