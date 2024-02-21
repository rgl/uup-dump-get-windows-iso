# About

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
powershell uup-dump-get-windows-iso.ps1 windows-2022
```

When everything works correctly, you'll have the iso in the `output` directory at, e.g., `output/windows-2022.iso`.

## Vagrant Usage

Install the base [Windows 2022 box](https://github.com/rgl/windows-vagrant).

Review the Windows ISO files that are going to the created in the [Vagrantfile file](Vagrantfile).

Create the Windows ISO files using a vagrant managed VM:

```bash
./build.sh create-vm
./build.sh create-iso windows-2022
./build.sh create-iso windows-11
./build.sh destroy-vm
```

When everything works correctly, you'll have the following files in the `output`
directory, e.g., for the `windows-2022` ISO:

* `windows-2022.iso`: the ISO file.
* `windows-2022.iso.json`: the ISO metadata.
* `windows-2022.iso.sha256.txt`: the ISO file SHA256 checksum.
* `windows-2022.iso.log`: the ISO creation log.

The ISO metadata is a JSON document alike:

```json
{
    "name": "windows-2022",
    "title": "Feature update to Microsoft server operating system, version 21H2 (20348.2322)",
    "build": "20348.2322",
    "checksum": "468f8ecdf2272e71c4dc0094d6379b60e5321bef15a01333dbf9508ae4d53a68",
    "images": [
        {
            "index": 1,
            "name": "Windows Server 2022 Standard (Desktop Experience)",
            "version": "10.0.20348.2322"
        }
    ],
    "uupDump": {
        "downloadPackageUrl": "https://uupdump.net/get.php?edition=ServerStandard&pack=en-us&id=854d29b2-edbc-4959-a3e2-8a61f0900a7c",
        "id": "854d29b2-edbc-4959-a3e2-8a61f0900a7c",
        "downloadUrl": "https://uupdump.net/download.php?edition=ServerStandard&pack=en-us&id=854d29b2-edbc-4959-a3e2-8a61f0900a7c",
        "apiUrl": "https://api.uupdump.net/get.php?lang=en-us&edition=ServerStandard&id=854d29b2-edbc-4959-a3e2-8a61f0900a7c"
    }
}
```

## Related Tools

* [Rufus](https://github.com/pbatard/rufus)
* [Fido](https://github.com/pbatard/Fido)
* [windows-evaluation-isos-scraper](https://github.com/rgl/windows-evaluation-isos-scraper)

## Reference

* [UUP dump home](https://uupdump.net)
* [UUP dump source code](https://git.uupdump.net/uup-dump)
* [Unified Update Platform (UUP)](https://docs.microsoft.com/en-us/windows/deployment/update/windows-update-overview)
