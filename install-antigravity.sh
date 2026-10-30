#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   chmod +x install-antigravity.sh
#   ./install-antigravity.sh <path-to-Antigravity-IDE.tar.gz>

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <path-to-Antigravity-IDE.tar.gz>" >&2
    exit 1
fi

PACKAGE_INPUT="$1"

if [[ ! -f "$PACKAGE_INPUT" ]]; then
    echo "Error: File '$PACKAGE_INPUT' not found." >&2
    exit 1
fi

PACKAGE="$(realpath "$PACKAGE_INPUT")"
INSTALL_DIR="/opt/antigravity-ide"
DESKTOP_FILE="/usr/share/applications/antigravity-ide.desktop"
BIN_SYMLINK="/usr/local/bin/antigravity-ide"
BIN_ALIAS_SYMLINK="/usr/local/bin/antigravity"

# Check sudo privileges early
echo "→ Requesting sudo permissions..."
sudo -v

WORKDIR="$(mktemp -d)"
trap 'rm -rf "$WORKDIR"' EXIT

echo "→ Extracting $(basename "$PACKAGE") ..."
tar -xf "$PACKAGE" -C "$WORKDIR"

# Detect extracted directory
SOURCE_DIR=""
if [[ -d "$WORKDIR/Antigravity IDE" ]]; then
    SOURCE_DIR="$WORKDIR/Antigravity IDE"
else
    # Find the first top-level directory in the extracted archive
    FIRST_DIR="$(find "$WORKDIR" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
    if [[ -n "$FIRST_DIR" && -d "$FIRST_DIR" ]]; then
        SOURCE_DIR="$FIRST_DIR"
    fi
fi

if [[ -z "$SOURCE_DIR" || ! -d "$SOURCE_DIR" ]]; then
    echo "Error: Failed to find valid extracted directory in $WORKDIR" >&2
    exit 1
fi

echo "→ Removing old installation at $INSTALL_DIR (if any) ..."
if [[ -d "$INSTALL_DIR" ]]; then
    sudo rm -rf "$INSTALL_DIR"
fi

echo "→ Installing to $INSTALL_DIR ..."
sudo mv "$SOURCE_DIR" "$INSTALL_DIR"

# Set proper ownership and permissions
sudo chown -R root:root "$INSTALL_DIR"
sudo chmod -R u=rwX,go=rX "$INSTALL_DIR"

# Fix chrome-sandbox permissions if present
if [[ -f "$INSTALL_DIR/chrome-sandbox" ]]; then
    echo "→ Configuring chrome-sandbox setuid root ..."
    sudo chown root:root "$INSTALL_DIR/chrome-sandbox"
    sudo chmod 4755 "$INSTALL_DIR/chrome-sandbox"
fi

# Detect the launcher binary (used by both CLI symlinks and desktop entry)
IDE_BIN=""
if [[ -f "$INSTALL_DIR/bin/antigravity-ide" ]]; then
    IDE_BIN="$INSTALL_DIR/bin/antigravity-ide"
elif [[ -f "$INSTALL_DIR/antigravity-ide" ]]; then
    IDE_BIN="$INSTALL_DIR/antigravity-ide"
else
    echo "Error: antigravity-ide executable not found in $INSTALL_DIR" >&2
    exit 1
fi

# Create CLI symlinks
echo "→ Creating CLI command symlinks in /usr/local/bin ..."
sudo ln -sf "$IDE_BIN" "$BIN_SYMLINK"
sudo ln -sf "$IDE_BIN" "$BIN_ALIAS_SYMLINK"

# Create desktop entry
echo "→ Creating Desktop application entry ..."
ICON_PATH="$INSTALL_DIR/resources/app/resources/linux/code.png"
if [[ ! -f "$ICON_PATH" ]]; then
    FOUND_ICON="$(find "$INSTALL_DIR" -name "*.png" 2>/dev/null | head -n 1 || true)"
    if [[ -n "$FOUND_ICON" ]]; then
        ICON_PATH="$FOUND_ICON"
    fi
fi

sudo tee "$DESKTOP_FILE" > /dev/null <<EOF
[Desktop Entry]
Name=Antigravity IDE
Comment=Antigravity IDE
GenericName=Text Editor
Exec=$IDE_BIN %F
Icon=$ICON_PATH
Type=Application
StartupNotify=true
StartupWMClass=antigravity-ide
Categories=Development;IDE;
MimeType=text/plain;inode/directory;
EOF

sudo chmod 644 "$DESKTOP_FILE"

# Update desktop database if tool exists
if command -v update-desktop-database >/dev/null 2>&1; then
    sudo update-desktop-database /usr/share/applications 2>/dev/null || true
fi

echo ""
echo "✓ Antigravity IDE installed successfully!"
echo "  • Installation path: $INSTALL_DIR"
echo "  • CLI commands:      antigravity, antigravity-ide"
echo "  • Desktop shortcut:  $DESKTOP_FILE"

