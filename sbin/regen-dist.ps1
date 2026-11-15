<#
.SYNOPSIS
    Regenerate the standalone distribution archives for this model.

.DESCRIPTION
    Builds, from the same cached file list:
        dist\washington-overdose-model-standalone.zip
        dist\washington-overdose-model-standalone.tar.gz   (skipped if tar.exe is not available)
    plus identical copies under the legacy names dist\seattle-overdose-model-standalone.*,
    so old download links keep working (the model was renamed from seattle_overdose_model.html).

    The file list is every file at the model root except hidden files, OS/editor junk
    and previously built archives. Subfolders (sbin\, dist\) are never included.

    Zip tool: 7-Zip (7z) if it is on PATH, otherwise the built-in Compress-Archive.

    Run from anywhere (the script finds the model root, one level above sbin\):
        sbin\regen-dist.ps1
    If script execution is blocked, run once in that window:
        Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

.EXAMPLE
    sbin\regen-dist.ps1
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$modelRoot = Split-Path -Parent $scriptDir
Set-Location $modelRoot

$name = 'washington-overdose-model-standalone'
$legacyName = 'seattle-overdose-model-standalone'   # old archive name; kept as a copy for old links
# seattle_overdose_model.html is a small redirect stub to washington_overdose_model.html (old links/bookmarks).
$required = @('washington_overdose_model.html', 'seattle_overdose_model.html', 'chart.umd.min.js', 'math-utils.js', 'overdose-data.js',
              'time2doubleequations-dark.gif', 'Washington_Overdose_death_2018-25.gif',
              'LICENSE.txt', 'README.md')

Write-Host "==> Working from model root: $modelRoot" -ForegroundColor Cyan

foreach ($f in $required) {
    if (-not (Test-Path -LiteralPath $f -PathType Leaf)) { throw "Required file missing: $f" }
}

# One pass, cached.
$junk = @('Thumbs.db', 'desktop.ini')
$files = @(Get-ChildItem -File |
    Where-Object {
        -not $_.Name.StartsWith('.') -and
        ($junk -notcontains $_.Name) -and
        ($_.Name -notmatch '\.(zip|tar\.gz|tgz|bak|swp|tmp)$') -and
        (-not $_.Name.EndsWith('~'))
    } |
    Sort-Object Name |
    Select-Object -ExpandProperty Name)

Write-Host "Files that will be included in the distribution:"
$files | ForEach-Object { "  $_" }
Write-Host ""

if (-not (Test-Path dist)) { New-Item -ItemType Directory -Path dist | Out-Null }
$zipPath = Join-Path 'dist' "$name.zip"
$tgzPath = Join-Path 'dist' "$name.tar.gz"
$legacyZip = Join-Path 'dist' "$legacyName.zip"
$legacyTgz = Join-Path 'dist' "$legacyName.tar.gz"
# Start fresh: 7z "add" would otherwise update an existing archive and keep stale entries.
Remove-Item -LiteralPath $zipPath, $tgzPath, $legacyZip, $legacyTgz -ErrorAction SilentlyContinue

Write-Host "==> Building $zipPath" -ForegroundColor Green
if (Get-Command 7z -ErrorAction SilentlyContinue) {
    & 7z a -tzip -mx=9 $zipPath $files | Out-Null
    if ($LASTEXITCODE -ne 0) { throw "7z failed with exit code $LASTEXITCODE" }
    Write-Host "    (zip built with 7z)"
} else {
    Compress-Archive -LiteralPath $files -DestinationPath $zipPath -CompressionLevel Optimal -Force
    Write-Host "    (7z not on PATH; zip built with Compress-Archive)"
}

if (Get-Command tar -ErrorAction SilentlyContinue) {
    Write-Host "==> Building $tgzPath" -ForegroundColor Green
    & tar -czf $tgzPath $files
    if ($LASTEXITCODE -ne 0) { throw "tar failed with exit code $LASTEXITCODE" }
} else {
    Write-Host "  (tar.exe not found; skipping the .tar.gz - the .zip is the main download)" -ForegroundColor Yellow
}

Write-Host "==> Copying to legacy names ($legacyName.*) so old download links keep working" -ForegroundColor Green
Copy-Item -LiteralPath $zipPath -Destination $legacyZip -Force
if (Test-Path -LiteralPath $tgzPath) { Copy-Item -LiteralPath $tgzPath -Destination $legacyTgz -Force }

Write-Host ""
Write-Host "==> Done:" -ForegroundColor Cyan
Get-Item $zipPath, $tgzPath, $legacyZip, $legacyTgz -ErrorAction SilentlyContinue | Format-Table Name, Length -AutoSize
Write-Host "Remember:"
Write-Host "  - The archives are in dist\ and are git-ignored; commit only the source files."
Write-Host "  - Re-run this script whenever you change any file at the model root."
Write-Host "  - chart.umd.min.js, math-utils.js, overdose-data.js and the images must stay next to the .html."
