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

    function filter_log {
        # filter out superfulous lines/blocks from the logs.
        #
        # this will filter out all lines that have a percentage number (they represend
        # some kind of progress bar, which is not useful to detect errors).
        #
        # this will also filter out the following blocks:
        #   Exception calling "Read" with "3" argument(s): "Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection."
        #   At line:100 char:11
        #   +       if ($fs.Read($bytes, 0, $fs.Length) -gt 0) {
        #   +           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        #       + CategoryInfo          : NotSpecified: (:) [], MethodInvocationException
        #       + FullyQualifiedErrorId : ArgumentException
        # NB this block seems to be an unknown artifact generated by the vagrant
        #    remote use of powershell.
        perl -pe 's/\r\n/\n/' "$log_name.raw.log" \
            | perl -pe 's/^ +builder: //' \
            | perl -ne 'print unless /\d+(\.\d+)?%/' \
            | perl -ne 'print unless / 0B\/0B/' \
            | perl -ne 'print unless (/^Exception calling "Read" with "3" argument\(s\): "Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection\."/ ... / FullyQualifiedErrorId : ArgumentException/)' \
            | perl -00 -pe 's/\s*\n+/\n/' \
            >"$log_name.log"
    }

    trap filter_log EXIT

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
