#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   chmod +x uninstall-antigravity.sh
#   ./uninstall-antigravity.sh

INSTALL_DIR="/opt/antigravity-ide"
DESKTOP_FILE="/usr/share/applications/antigravity-ide.desktop"
BIN_SYMLINK="/usr/local/bin/antigravity-ide"
BIN_ALIAS_SYMLINK="/usr/local/bin/antigravity"

echo "→ Requesting sudo permissions..."
sudo -v

echo "→ Removing Antigravity IDE files..."
if [[ -d "$INSTALL_DIR" ]]; then
    sudo rm -rf "$INSTALL_DIR"
    echo "  Removed $INSTALL_DIR"
fi

if [[ -f "$DESKTOP_FILE" ]]; then
    sudo rm -f "$DESKTOP_FILE"
    echo "  Removed $DESKTOP_FILE"
fi

if [[ -L "$BIN_SYMLINK" || -f "$BIN_SYMLINK" ]]; then
    sudo rm -f "$BIN_SYMLINK"
    echo "  Removed $BIN_SYMLINK"
fi

if [[ -L "$BIN_ALIAS_SYMLINK" || -f "$BIN_ALIAS_SYMLINK" ]]; then
    sudo rm -f "$BIN_ALIAS_SYMLINK"
    echo "  Removed $BIN_ALIAS_SYMLINK"
fi

if command -v update-desktop-database >/dev/null 2>&1; then
    sudo update-desktop-database /usr/share/applications 2>/dev/null || true
fi

echo ""
echo "✓ Antigravity IDE uninstalled successfully."

