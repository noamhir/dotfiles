#!/bin/bash
set -e

echo "🚀 Starting dotfiles personalization..."

# BASHRC (Safe/Checked)
if ! grep -q "source ~/dotfiles/.bashrc" "$HOME/.bashrc"; then
    echo -e "\n# Added by dotfiles install.sh\n[ -f ~/dotfiles/.bashrc ] && source ~/dotfiles/.bashrc" >> "$HOME/.bashrc"
    echo "✅ Added source line to ~/.bashrc"
fi

sudo apt-get update
sudo apt-get install -y tmux

# Catching the failure to prevent the whole codespace build from crashing
npm install -g opencode-ai | bash || echo "⚠️ opencode.ai installation failed, but continuing build."
