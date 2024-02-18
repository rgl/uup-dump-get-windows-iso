Set-StrictMode -Version Latest
$ProgressPreference = 'SilentlyContinue'
$ErrorActionPreference = 'Stop'
trap {
    Write-Host "ERROR: $_"
    ($_.ScriptStackTrace -split '\r?\n') -replace '^(.*)$','ERROR: $1' | Write-Host
    ($_.Exception.ToString() -split '\r?\n') -replace '^(.*)$','ERROR EXCEPTION: $1' | Write-Host
    Exit 1
}

Push-Location C:\vagrant

@(
    'windows-11'
    'windows-2022'
) | ForEach-Object {
    pwsh uup-dump-get-windows-iso.ps1 $_
    if ($LASTEXITCODE) {
        throw "failed with exit code $LASTEXITCODE"
    }
}

Pop-Location
