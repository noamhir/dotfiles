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

# --- OpenCode Configuration Provisioning ---
mkdir -p ~/.config/opencode

cat <<EOF > ~/.config/opencode/opencode.json
{
  "\$schema": "https://opencode.ai/config.json",
  "plugin": [
    "@morphllm/opencode-morph-plugin",
    "@tarquinen/opencode-dcp",
    "@pranjalmandavkar/opencode-notifier"
  ],
  "permission": {
    "bash": "allow"
  }
}
EOF
echo "✅ opencode.json provisioned. Model selection left to UI defaults."
# --- OpenCode Grill Me Skill Setup ---
if command -v npm &> /dev/null; then
    echo "Installing OpenCode Grill Me skill..."
    # Installs the skill globally for the user
    npx skills@latest add mattpocock/skills --skill grill-me -g
    
    # Verify local skill directory exists for template consistency
    mkdir -p .opencode/skills/grill-me
    
    echo "Grill Me skill ready. Use '/grill-me' in Plan Mode to start."
else
    echo "Warning: npm not found. Could not install Grill Me skill."
fi
echo "✅ Personalization complete. Your environment is ready."
