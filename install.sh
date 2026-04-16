#!/bin/bash

# Install Gemini CLI (2026 Stable)
npm install -g @google/gemini-cli

# Install Claude Code (2026 Native Installer)
curl -fsSL https://claude.ai/install.sh | bash

# Ensure the paths are refreshed for the current session
export PATH="$PATH:$(npm config get prefix)/bin"
