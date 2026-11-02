# Antigravity IDE Linux 安装工具

[简体中文](README.zh-CN.md) | [English](README.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

使用已下载的安装包，在 Linux 上安装 Antigravity IDE。本工具会将应用部署到 `/opt`，在安装包中存在 Chromium 沙箱程序时配置其权限，并创建桌面启动器和终端命令。项目还提供了配套的卸载脚本。

## 快速开始

运行环境：Linux、Bash、`tar`、`sudo`，以及已下载的 Antigravity IDE 安装包。

```bash
git clone https://github.com/blizzardwj/install-agy-ide.git
cd install-agy-ide
chmod +x install-antigravity.sh uninstall-antigravity.sh
./install-antigravity.sh ~/Downloads/"Antigravity IDE.tar.gz"
```

安装程序会请求 `sudo` 权限，以便将文件安装到 `/opt`、创建桌面启动项，并在 `/usr/local/bin` 中创建终端命令。如果 `/opt/antigravity-ide` 中已有安装，安装程序会将其替换。

## 启动 Antigravity IDE

安装完成后，可从桌面应用菜单启动，也可以运行以下任一命令：

```bash
antigravity .
antigravity-ide /path/to/project
```

## 卸载

在仓库目录中运行附带的卸载脚本：

```bash
./uninstall-antigravity.sh
```

脚本会移除已安装的应用、桌面启动项，以及由安装程序创建的终端命令。

## 许可证

本项目采用 [MIT 许可证](LICENSE)。