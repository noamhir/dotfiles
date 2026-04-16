#!/bin/bash

# 1. Install Gemini CLI globally
echo "Installing Gemini CLI..."
npm install -g @google/gemini-cli

# 2. Install Claude Code
echo "Installing Claude Code..."
curl -fsSL https://claude.ai/install.sh | bash

# 3. Add aliases (Optional but helpful)
# This ensures your shell always knows where to find the binaries
echo 'export PATH="$PATH:$(npm config get prefix)/bin"' >> ~/.bashrc

echo "AI Tools setup complete!"
