#!/bin/bash

echo "🚀 Starting dotfiles installation..."

# Install Gemini CLI (2026 Stable)
npm install -g @google/gemini-cli

# Install Claude Code (2026 Native Installer)
curl -fsSL https://claude.ai/install.sh | bash

# Install GitHub Copilot CLI globally
if command -v npm &> /dev/null; then
    npm install -g @github/copilot
else
    echo "npm not found, skipping Copilot CLI installation."
fi

echo "✅ Installations complete."
