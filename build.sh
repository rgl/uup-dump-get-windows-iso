#!/bin/bash
set -euo pipefail

function destroy-vm {
    vagrant destroy -f
}

function create-vm {
    destroy-vm
    vagrant up --no-destroy-on-error
}

function create-iso {
    iso_name="$1"
    log_name="output/$iso_name.iso"

    install -d "$(dirname "$log_name")"

    vagrant winrm \
        --elevated \
        --command "PowerShell c:/vagrant/provision/ps.ps1 provision-iso.ps1 $iso_name" \
        builder \
        2>&1 | tee "$log_name.raw.log"
}

case "$1" in
  create-vm)
    create-vm
    ;;
  destroy-vm)
    destroy-vm
    ;;
  create-iso)
    create-iso "$2"
    ;;
  *)
    echo $"Usage: $0 {create-vm|destroy-vm|create-iso}"
    exit 1
    ;;
esac
