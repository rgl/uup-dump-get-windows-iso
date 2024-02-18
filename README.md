# About

**WARNING the created enterprise edition iso ends up in a non working state so this repo is currently useless. if you known how to fix this, please reach out.**

This creates an iso file with the latest Windows available from the [Unified Update Platform (UUP)](https://docs.microsoft.com/en-us/windows/deployment/update/windows-update-overview).

This shrink wraps the [UUP dump](https://git.uupdump.net/uup-dump) project into a single command.

This must be executed in a Windows 2022 host.

This supports the following Windows Editions:

* `windows-11`: Windows 11 22631 (aka 23H2) Enterprise
* `windows-2022`: Windows Server 2022 20348 (aka 21H2) Standard

**NB** The Windows Server 2019 iso source files are not available in the Unified Update Platform (UUP) and cannot be downloaded by UUP dump.

## Usage

Get the latest Windows Server 2022 iso:

```bash
pwsh uup-dump-get-windows-iso.ps1 windows-2022
```

When everything works correctly, you'll have the iso in the `output` directory at, e.g., `output/windows-2022-20348.643.iso`.

## Reference

* [UUP dump home](https://uupdump.net)
* [UUP dump source code](https://git.uupdump.net/uup-dump)
* [Unified Update Platform (UUP)](https://docs.microsoft.com/en-us/windows/deployment/update/windows-update-overview)
