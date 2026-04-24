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
# yes | curl -fsSL https://claude.ai/install.sh | bash

echo "📦 Installing Copilot CLI..."
# if command -v npm &> /dev/null; then
#     yes | npm install -g @github/copilot
# else
#    echo "⚠️ npm not found, skipping Copilot CLI installation."
# fi

# 5. MANUALLY LINK CONFIGS: Sometimes Codespaces skips the automatic linking.
# This forces your .bashrc and gemini.md to be active.
echo "🔗 Linking configuration files..."
ln -sf "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES_DIR/gemini.md" "$HOME/gemini.md"
#!/bin/bash

#!/bin/bash

# 1. Install the Cline Extension
code --install-extension saoudrizwan.claude-dev

# 2. Generate the strict rules template
cat << 'EOF' > ~/.clinerules-template
# CORE PERSONA
Act as a senior, precise software engineer focused on stability.

# STRICT CODING RULES
- Zero Unprompted Refactoring: Fix only what is asked. Do not modernize surrounding code.
- Do Not Break Unrelated Logic: Leave unrelated functions alone.
- Literal Execution: If it works but looks ugly, leave it alone. Prioritize zero regressions.
- Local-First Architecture: Prefer offline solutions, local JSON data storage, and local libraries over cloud CDNs.
- File Paths: Default to absolute paths (especially for network drives) unless explicitly told otherwise.
- Idea Placement: Fulfill the exact request to the letter first. You may offer creative ideas, alternatives, or enhancements ONLY at the very end of your response.
EOF

# 3. Generate the ignore template to protect API quotas
cat << 'EOF' > ~/.clineignore-template
# Protect API Tokens by ignoring compiled output and heavy data
node_modules/
.git/
dist/
build/

# STRICTLY ignore local JSON databases
*.json.db
/data/*.json

# Ignore binary files and assets
*.jpg
*.png
*.pdf
EOF

# 4. Auto-deploy into the active workspace
# This checks if the files exist in the project root, and if not, copies the templates over.
echo 'if [ ! -f .clinerules ]; then cp ~/.clinerules-template .clinerules; fi' >> ~/.bashrc
echo 'if [ ! -f .clineignore ]; then cp ~/.clineignore-template .clineignore; fi' >> ~/.bashrc

# 6. REFRESH PATH: Ensure the new tools are available in the current session.
export PATH="$PATH:$(npm config get prefix)/bin"

echo "✅ All set! Installations and linking complete."
echo "💡 TIP: Run 'source ~/.bashrc' if your terminal hasn't updated yet."
