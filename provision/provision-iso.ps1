param(
    [string]$name
)

# NB the built directory should be a local disk; because, when using a
#    smb network share (e.g. the vagrant synced directory at c:\vagrant),
#    the build and the generated iso file fails in strange ways, e.g.:
#       File not found - BIN\INFO1.TXT
#       Missing operand.
Push-Location C:\tmp

# download and create the iso.
# NB unfortunately, somehow, the uup-dump batch scripts emits messages to
#    stdout/stderr outside of this file redirection. so we must also
#    capture the output from the host (the one calling vagrant up).
Write-Host "Creating the $name iso"
powershell c:\vagrant\uup-dump-get-windows-iso.ps1 $name
if ($LASTEXITCODE) {
    throw "failed with exit code $LASTEXITCODE"
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
