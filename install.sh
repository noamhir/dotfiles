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
curl -fsSL https://opencode.ai/install | bash
