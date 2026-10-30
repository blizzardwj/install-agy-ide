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

REMOVED=0

# Only remove a CLI link if it is a symlink created by the installer
remove_cli_link() {
    local link="$1"
    if [[ -L "$link" ]]; then
        local target
        target="$(readlink "$link")"
        if [[ "$target" == "$INSTALL_DIR/"* ]]; then
            sudo rm -f "$link"
            echo "  Removed $link"
            REMOVED=$((REMOVED + 1))
        else
            echo "  Skipped $link (points to $target, not managed by this installer)"
        fi
    elif [[ -e "$link" ]]; then
        echo "  Skipped $link (not a symlink, not managed by this installer)"
    fi
}

echo "→ Removing Antigravity IDE files..."
if [[ -d "$INSTALL_DIR" ]]; then
    sudo rm -rf "$INSTALL_DIR"
    echo "  Removed $INSTALL_DIR"
    REMOVED=$((REMOVED + 1))
fi

if [[ -f "$DESKTOP_FILE" ]]; then
    sudo rm -f "$DESKTOP_FILE"
    echo "  Removed $DESKTOP_FILE"
    REMOVED=$((REMOVED + 1))
fi

remove_cli_link "$BIN_SYMLINK"
remove_cli_link "$BIN_ALIAS_SYMLINK"

if command -v update-desktop-database >/dev/null 2>&1; then
    sudo update-desktop-database /usr/share/applications 2>/dev/null || true
fi

echo ""
if [[ $REMOVED -eq 0 ]]; then
    echo "✓ Nothing to remove: Antigravity IDE does not appear to be installed."
else
    echo "✓ Antigravity IDE uninstalled successfully."
fi

