#!/bin/bash
set -e

echo "🚀 Starting dotfiles personalization..."
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. SYMLINKS (Safe/Idempotent)
ln -sfn "$DOTFILES_DIR" "$HOME/dotfiles"
ln -sf "$DOTFILES_DIR/gemini.md" "$HOME/gemini.md"

# 2. BASHRC (Safe/Checked)
if ! grep -q "source ~/dotfiles/.bashrc" "$HOME/.bashrc"; then
    echo -e "\n# Added by dotfiles install.sh\nsource ~/dotfiles/.bashrc" >> "$HOME/.bashrc"
    echo "✅ Added source line to ~/.bashrc"
fi

# 3. OPENCODE CONFIG (Prevent Overwrite if exists)
mkdir -p ~/.config/opencode
if [ ! -f ~/.config/opencode/opencode.json ]; then
    cat <<EOF > ~/.config/opencode/opencode.json
{
  "\$schema": "https://opencode.ai/config.json",
  "plugin": [
    "@morphllm/opencode-morph-plugin",
    "@tarquinen/opencode-dcp",
    "@pranjalmandavkar/opencode-notifier"
  ],
  "permission": { "bash": "allow" }
}
EOF
    echo "✅ opencode.json provisioned."
else
    echo "ℹ️ opencode.json already exists, skipping to preserve custom settings."
fi

# 4. BINARY INSTALLS (Checked)
if ! command -v osgrep &> /dev/null; then
    echo "Installing osgrep binary..."
    npm install -g osgrep
    osgrep setup
fi

# 5. SKILL INSTALLS (Checked)
# We check if the directory exists before running npx to save time
if [ ! -d "$HOME/.config/opencode/skills/grill-me" ]; then
    echo "Installing Grill Me skill..."
    npx skills@latest add mattpocock/skills --skill grill-me -g
else
    echo "✅ Grill Me skill already present."
fi

if [ ! -d "$HOME/.config/opencode/skills/osgrep" ]; then
    echo "Installing osgrep skill..."
    npx skills@latest add Ryandonofrio3/osgrep -g
else
    echo "✅ osgrep skill already present."
fi

echo "✅ Personalization complete. Your environment is ready."
