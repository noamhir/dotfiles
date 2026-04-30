#!/bin/bash

# 1. STOP ON ERROR
set -e

echo "🚀 Starting dotfiles installation..."

# 2. IDENTIFY DIRECTORY
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 3. ENSURE SYMLINK
ln -sfn "$DOTFILES_DIR" "$HOME/dotfiles"

# 4. INSTALL TOOLS (NON-INTERACTIVE)
echo "📦 Installing Gemini CLI..."
# Using --quiet to reduce log bloat
npm install -g @google/gemini-cli --quiet

# Fix syntax error: removed the leading '$'
echo "📦 Installing Copilot CLI..."
# npm install -g @github/copilot --quiet

# 5. OPENCODE & AI AGENT SETUP
if ! command -v opencode &> /dev/null; then
    echo "Installing OpenCode AI Agent..."
    curl -fsSL https://opencode.ai/install | bash
fi

# Create AGENTS.md
echo "Creating AGENTS.md..."
cat << 'EOF' > "$HOME/AGENTS.md"
# Project: Legal Automation Tools
# [Rest of your AGENTS.md content here...]
EOF

# 6. SYSTEM TOOLS (Tmux)
if ! command -v tmux &> /dev/null; then
    echo "tmux not found. Installing..."
    sudo apt-get update -qq && sudo apt-get install -y tmux
fi

# 7. SAFE LINKING (APPEND INSTEAD OF REPLACE)
echo "🔗 Configuring .bashrc..."
# Check if we've already added the source line to avoid duplicates
if ! grep -q "source ~/dotfiles/.bashrc" "$HOME/.bashrc"; then
    echo -e "\n# Load custom dotfiles\nsource ~/dotfiles/.bashrc" >> "$HOME/.bashrc"
fi

# Link specific configs that aren't the shell profile
ln -sf "$DOTFILES_DIR/gemini.md" "$HOME/gemini.md"

# 8. REFRESH PATH
export PATH="$PATH:$(npm config get prefix)/bin"

echo "✅ All set! Run 'source ~/.bashrc' if needed."
