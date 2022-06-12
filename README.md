# Archtic: Shell scripts

## `setup.sh`
### Installs packages and config files.

Currently, this script is meant to be ran after `archinstall` and a reboot. Ideally, this script would also `curl` an `archinstall` config and run through the full install process, first thing after you boot the install disk.

**Run using `curl`:**
```
curl -o- https://raw.githubusercontent.com/archtic/sh/main/setup.sh | sh
```