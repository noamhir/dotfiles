#!/bin/bash

# 1. STOP ON ERROR: If any command fails, the script stops immediately so you can see why.
set -e

echo "🚀 Starting dotfiles installation..."

# 2. IDENTIFY DIRECTORY: Codespaces clones this repo to a specific path. 
# We find that path so we can link your files correctly.
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 3. ENSURE SYMLINK: Make sure ~/dotfiles always points to this directory.
# This ensures your .bashrc functions (like make-portable) can find your templates.
ln -sfn "$DOTFILES_DIR" "$HOME/dotfiles"

# 4. INSTALL TOOLS (NON-INTERACTIVE): Use 'yes |' to auto-confirm any prompts.
echo "📦 Installing Gemini CLI..."
yes | npm install -g @google/gemini-cli

echo "📦 Installing Claude Code..."
# We use 'yes' here because the Claude installer often asks for permission.
yes | curl -fsSL https://claude.ai/install.sh | bash

echo "📦 Installing Copilot CLI..."
if command -v npm &> /dev/null; then
    yes | npm install -g @github/copilot
else
    echo "⚠️ npm not found, skipping Copilot CLI installation."
fi

# 5. MANUALLY LINK CONFIGS: Sometimes Codespaces skips the automatic linking.
# This forces your .bashrc and gemini.md to be active.
echo "🔗 Linking configuration files..."
ln -sf "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES_DIR/gemini.md" "$HOME/gemini.md"

# 6. REFRESH PATH: Ensure the new tools are available in the current session.
export PATH="$PATH:$(npm config get prefix)/bin"

echo "✅ All set! Installations and linking complete."
echo "💡 TIP: Run 'source ~/.bashrc' if your terminal hasn't updated yet."
