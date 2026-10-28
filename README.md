# Antigravity IDE Installer for Linux

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

这是一个用于在 Linux 系统上一键安装和配置 **Antigravity IDE** 的自动化脚本。

Antigravity IDE 的 Linux 版本通常以 `.tar.gz` 压缩包形式分发。本工具会自动完成解压、系统目录部署、修复 `chrome-sandbox` 权限、创建桌面快捷方式（含应用图标）以及添加终端快捷命令。

---

## ✨ 特性 (Features)

- **一键安装**：自动解压并部署到 `/opt/antigravity-ide`。
- **沙箱权限修复**：自动配置 `chrome-sandbox` 的 root 所有权及 `4755` (setuid) 权限，确保 Chromium/Electron 核心正常启动。
- **桌面快捷方式**：自动在 `/usr/share/applications` 下生成 `antigravity-ide.desktop`，并在应用菜单中正确显示图标。
- **终端命令集成**：在 `/usr/local/bin` 创建 `antigravity` 和 `antigravity-ide` 软链接，方便直接在终端通过 `antigravity .` 打开项目。
- **智能兼容**：自动识别解压后的目录结构，包含前置参数校验与 sudo 权限检查。
- **提供卸载脚本**：附带 `uninstall-antigravity.sh`，可一键干净卸载。

---

## 📋 系统要求 (Prerequisites)

- **系统**：Linux (x86_64 / arm64)
- **依赖**：`bash`、`tar`、`sudo`
- **安装包**：已下载的 Antigravity IDE 压缩包（如 `Antigravity IDE.tar.gz`）

---

## 🚀 安装步骤 (Installation)

### 1. 克隆本仓库

```bash
git clone https://github.com/<your-username>/install-agy-ide.git
cd install-agy-ide
```

### 2. 赋予脚本执行权限

```bash
chmod +x install-antigravity.sh uninstall-antigravity.sh
```

### 3. 执行安装

传入你下载的 Antigravity IDE 压缩包路径即可：

```bash
./install-antigravity.sh ~/Downloads/"Antigravity IDE.tar.gz"
```

> **说明**：脚本执行过程中如提示输入密码，请输入当前用户的 sudo 密码以完成系统目录部署。

---

## 💡 使用方法 (Usage)

### 1. 从桌面启动
打开系统应用程序菜单（Application Launcher / Dash），搜索 **Antigravity IDE** 点击启动，或将其固定到收藏夹 / Dock。

### 2. 从终端启动
安装完成后，可在任意终端目录直接运行：

```bash
# 在当前目录打开 Antigravity IDE
antigravity .

# 或者
antigravity-ide /path/to/project
```

---

## 🗑️ 卸载 (Uninstallation)

如果需要卸载 Antigravity IDE，只需运行卸载脚本：

```bash
./uninstall-antigravity.sh
```

该脚本将自动清理：
- `/opt/antigravity-ide` 目录
- `/usr/share/applications/antigravity-ide.desktop`
- `/usr/local/bin/antigravity` 及 `/usr/local/bin/antigravity-ide`

---

## 📄 开源许可 (License)

本项目采用 [MIT License](LICENSE) 授权。

