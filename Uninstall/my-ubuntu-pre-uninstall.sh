#!/bin/bash
set -e

echo "📦 Backing up GNOME Shell environment, settings, and VSCode extensions..."

BACKUP_DIR=~/gnome-backup
mkdir -p "$BACKUP_DIR"

echo "📄 Saving list of gnome enabled extensions..."
gnome-extensions list --enabled > "$BACKUP_DIR/gnome-extensions.txt"

echo "⚙️ Backing up gnome extension settings (dconf)..."
dconf dump /org/gnome/shell/extensions/ > "$BACKUP_DIR/gnome-extensions-settings.dconf"

echo "📄 Backing up dotfiles (.zshrc, .gitconfig)..."
cp ~/.gitconfig "$BACKUP_DIR/" 2>/dev/null || echo "⚠️ Some dotfiles not found"

echo "📄 Exporting VS Code extensions list..."
if code --list-extensions > "$BACKUP_DIR/vscode-extensions.txt"; then
	echo "VS Code extensions saved to $BACKUP_DIR/vscode-extensions.txt"
else
	echo "⚠️ Could not export VS Code extensions using code command"
fi

echo "✅ All backups saved to $BACKUP_DIR"

