# Antigravity IDE Installer for Linux

[English](README.md) | [简体中文](README.zh-CN.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Install Antigravity IDE on Linux from an archive you already downloaded. This installer deploys the app to `/opt`, configures its Chromium sandbox when present, and adds both a desktop launcher and terminal commands. A companion script removes the installation.

## Get started

Requirements: Linux, Bash, `tar`, `sudo`, and a downloaded Antigravity IDE archive.

```bash
git clone https://github.com/blizzardwj/install-agy-ide.git
cd install-agy-ide
chmod +x install-antigravity.sh uninstall-antigravity.sh
./install-antigravity.sh ~/Downloads/"Antigravity IDE.tar.gz"
```

The installer requests your `sudo` password to install files under `/opt`, register the desktop entry, and create commands in `/usr/local/bin`. It replaces any existing installation in `/opt/antigravity-ide`.

## Launch Antigravity IDE

After installation, launch it from your desktop application's menu or run either command:

```bash
antigravity .
antigravity-ide /path/to/project
```

## Uninstall

Run the included uninstaller from the repository directory:

```bash
./uninstall-antigravity.sh
```

It removes the installed application, desktop entry, and installer-managed terminal commands.

## License

This project is released under the [MIT License](LICENSE).

