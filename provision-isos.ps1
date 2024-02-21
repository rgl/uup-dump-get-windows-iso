Set-StrictMode -Version Latest
$ProgressPreference = 'SilentlyContinue'
$ErrorActionPreference = 'Stop'
trap {
    Write-Host "ERROR: $_"
    ($_.ScriptStackTrace -split '\r?\n') -replace '^(.*)$','ERROR: $1' | Write-Host
    ($_.Exception.ToString() -split '\r?\n') -replace '^(.*)$','ERROR EXCEPTION: $1' | Write-Host
    Exit 1
}

# NB the built directory should be a local disk; because, when using a
#    smb network share (e.g. the vagrant synced directory at c:\vagrant),
#    the build and the generated iso file fails in strange ways, e.g.:
#       File not found - BIN\INFO1.TXT
#       Missing operand.
Push-Location C:\tmp

@(
    'windows-11'
    'windows-2022'
) | ForEach-Object {
    pwsh uup-dump-get-windows-iso.ps1 $_
    if ($LASTEXITCODE) {
        throw "failed with exit code $LASTEXITCODE"
    }
}

# copy the resulting files to the host.
$outputPath = 'c:\vagrant\output'
if (!(Test-Path $outputPath)) {
    New-Item -ItemType Directory -Force $outputPath | Out-Null
}
@(
    "output\$name.iso.*"
    "output\$name.iso"
) | Get-ChildItem | ForEach-Object {
    Write-Host "Copying $(Split-Path -Leaf $_) to $outputPath"
    Copy-Item -Force $_ $outputPath
}

Pop-Location
