#!/bin/bash

# STOP ON ERROR
set -e

echo "🚀 Starting dotfiles personalization..."

# 1. IDENTIFY DIRECTORY
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 2. ENSURE SYMLINK TO DOTFILES
# We keep this so your custom scripts and templates are always at ~/dotfiles
ln -sfn "$DOTFILES_DIR" "$HOME/dotfiles"

# 3. SAFE CONFIG LINKING
echo "🔗 Configuring .bashrc..."

# We source your custom bashrc so you get your aliases without breaking 
# the Codespaces default setup.
if ! grep -q "source ~/dotfiles/.bashrc" "$HOME/.bashrc"; then
    echo -e "\n# Added by dotfiles install.sh\nsource ~/dotfiles/.bashrc" >> "$HOME/.bashrc"
    echo "✅ Added source line to ~/.bashrc"
fi

# Link specific global configs
ln -sf "$DOTFILES_DIR/gemini.md" "$HOME/gemini.md"

# 4. REFRESH PATH
# Ensure npm-installed globals and local bins are immediately available
export PATH="$PATH:$(npm config get prefix)/bin"

echo "✅ Personalization complete. Your environment is ready."
