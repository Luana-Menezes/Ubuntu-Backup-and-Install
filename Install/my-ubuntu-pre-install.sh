#!/bin/bash
set -e

CONFIG_FILE="$(dirname "$0")/.my-ubuntu-config"
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "Arquivo de configuração .my-ubuntu-config não encontrado."
    exit 1
fi

echo "🔧 Starting Ubuntu Gnome setup... 🔧"

# Installs
echo "📥 Update and upgrade the system"
sudo apt update && sudo apt upgrade -y

echo "📥 Install apt packages"
sudo apt install -y \
    build-essential \
    curl \
    wget \
    git \
    zip \
    ranger \
    zsh \
    gnome-tweak-tool \
    gnome-shell-extension-manager
    pipx

echo "📥 Install snap packages"
sudo snap install discord
sudo snap install telegram-desktop 
sudo snap install spotify
sudo snap install onlyoffice-desktopeditors
sudo snap install cura-slicer

echo "📥 Install deb packages"	
echo "📥 Install VSCode"
wget "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -O ~/Downloads/vscode.deb
sudo apt install -y ~/Downloads/vscode.deb

echo "📥 Install Docker"
curl -fsSL https://get.docker.com | sudo sh
sudo usermod -aG docker $USER

echo "📥 Install Chrome"
wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -O ~/Downloads/chrome.deb
sudo apt -y install ~/Downloads/chrome.deb

echo "📥 Install Zoom"
wget "https://zoom.us/client/latest/zoom_amd64.deb" -O ~/Downloads/zoom_amd64.deb
sudo apt install ~/Downloads/zoom_amd64.deb

# GNOME Extensions
echo "🧩 Reinstalling GNOME extensions..."

pipx install gnome-extensions-cli
export PATH="$HOME/.local/bin:$PATH"

EXT_FILE="$(dirname "$0")/gnome-extensions.txt"

if [ -f "$EXT_FILE" ]; then
    echo "📦 Installing extensions from $EXT_FILE"
    xargs -a "$EXT_FILE" -n1 gnome-extensions-cli install
else
    echo "⚠️ Extension list file '$EXT_FILE' not found. Skipping extension reinstall."
fi

# Git Configs
echo "⚙️ Git config"
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"

ssh-keygen -t ed25519 -C "$EMAIL"
echo "Git SSH Public Key:"
cat ~/.ssh/id_ed25519.pub

echo "🔧 Finished Ubuntu setup successfully 🔧"

