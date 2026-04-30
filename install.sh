#!/bin/bash

# STOP ON ERROR
set -e

echo "🚀 Starting dotfiles personalization..."

# 1. IDENTIFY DIRECTORY
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 2. ENSURE SYMLINK TO DOTFILES
# Using -n to prevent nested folders if run twice
ln -sfn "$DOTFILES_DIR" "$HOME/dotfiles"

# 3. SAFE CONFIG LINKING (The "No-Crash" Method)
echo "🔗 Linking configuration files..."

# Instead of overwriting .bashrc, we source your custom one from the existing one.
# This preserves the Codespaces default environment.
if ! grep -q "source ~/dotfiles/.bashrc" "$HOME/.bashrc"; then
    echo -e "\n# Added by dotfiles install.sh\nsource ~/dotfiles/.bashrc" >> "$HOME/.bashrc"
    echo "✅ Added source line to ~/.bashrc"
fi

# Link other specific config files
ln -sf "$DOTFILES_DIR/gemini.md" "$HOME/gemini.md"

# 4. CREATE PROJECT CONTEXT (AGENTS.md)
# We only do this if it doesn't exist, to avoid overwriting project-specific tweaks.
if [ ! -f "AGENTS.md" ]; then
    echo "📝 Creating AGENTS.md for legal automation..."
    cat << 'EOF' > AGENTS.md
# Project: Legal Automation Tools
**Role:** Senior Software Engineer / Prosecutorial Workflow Consultant
**Primary Objective:** Build high-stability, local-only automation tools (VBA, HTML, JS).

## 🛠 Tech Stack
- **VBA:** Excel Macros and Word Document Automation (David 12 font, Option Explicit).
- **Web:** Local HTML/JavaScript/CSS (Offline-first, Vanilla JS).
- **VBA Bug Prevention:** Use index-based loops for Chart objects.

## ⚖️ Core Rules
- **Zero Unprompted Refactoring.**
- **Zero Regressions.**
- **Local-Only:** No CDNs or Cloud dependencies.
EOF
    echo "✅ AGENTS.md created."
fi

# 5. REFRESH PATH
# Ensure npm-installed globals are immediately visible
export PATH="$PATH:$(npm config get prefix)/bin"

echo "✅ Personalization complete. Run 'opencode' to start."
