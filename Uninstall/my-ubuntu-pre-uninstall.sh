#!/bin/bash
set -e

echo "📦 Backing up GNOME Shell environment and settings..."

BACKUP_DIR=~/gnome-backup
mkdir -p "$BACKUP_DIR"

# Export enabled GNOME extensions
echo "📄 Saving list of enabled extensions..."
gnome-extensions list --enabled > "$BACKUP_DIR/gnome-extensions.txt"

# Export GNOME extension settings
echo "⚙️ Backing up extension settings (dconf)..."
dconf dump /org/gnome/shell/extensions/ > "$BACKUP_DIR/gnome-extensions-settings.dconf"

# Backup personal dotfiles
echo "📝 Backing up dotfiles (.zshrc, .gitconfig)..."
cp ~/.gitconfig "$BACKUP_DIR/" 2>/dev/null || echo "⚠️ Some dotfiles not found"

echo "✅ All backups saved to $BACKUP_DIR"

