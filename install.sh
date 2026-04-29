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

# echo "📦 Installing Claude Code..."
# We use 'yes' here because the Claude installer often asks for permission.
# yes | curl -fsSL https://claude.ai/install.sh | bash

$ echo "📦 Installing Copilot CLI..."
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

# --- OpenCode & AI Agent Setup (April 2026) ---

# 1. Install OpenCode CLI if not already present
if ! command -v opencode &> /dev/null; then
    echo "Installing OpenCode AI Agent..."
    curl -fsSL https://opencode.ai/install | bash
else
    echo "OpenCode is already installed. Skipping..."
fi

# 2. Create the AGENTS.md file for project-specific context
echo "Creating AGENTS.md for legal automation workflow..."
cat << 'EOF' > AGENTS.md
# Project: Legal Automation Tools
**Role:** Senior Software Engineer / Prosecutorial Workflow Consultant
**Primary Objective:** Build high-stability, local-only automation tools (VBA, HTML, JS).

## 🛠 Tech Stack
- **VBA:** Excel Macros and Word Document Automation.
- **Web:** Local HTML/JavaScript/CSS (Offline-first).
- **Environment:** Windows / Microsoft Office / Local Browser.

## ⚖️ Core Development Rules (Strict)
- **Zero Unprompted Refactoring:** Never refactor working code unless explicitly asked. Fix ONLY the requested logic.
- **Zero Regressions:** Maintain existing functionality at all costs. 
- **Literal Execution:** Prioritize functionality and stability over aesthetics. If it works, leave it alone.
- **Local-Only:** Never suggest cloud-dependencies or CDNs. Scripts must run offline.

## 💻 Language Standards
### VBA (Excel/Word)
- Always include 'Option Explicit' at the top of every module.
- Use explicit error handling ('On Error GoTo ErrorHandler').
- **VBA Bug Prevention:** Use index-based loops ('For i = 1 to Count') instead of 'For Each' for Chart objects to avoid type mismatch errors.

### HTML / JavaScript
- Use Vanilla JavaScript (ES6+). No external frameworks unless requested.
- Prioritize simple, readable DOM manipulation for local tools.

## 📋 Common Commands
- **Switch Mode:** Press [Tab] to cycle between Plan (analysis) and Build (editing).
- **Add Focus:** Type '@' to search/add specific files to the AI's context.
- **Clean State:** Use '/clear' to reset chat context if tokens get bloated.

# Check if tmux is installed; if not, install it.
if ! command -v tmux &> /dev/null; then
    echo "tmux not found. Installing..."
    sudo apt-get update
    sudo apt-get install -y tmux
else
    echo "tmux is already installed."
fi

## 🎯 Project Context
You are assisting a prosecutor at the State Attorney's Office. Data privacy and precision are paramount. These tools are for professional legal use.
EOF

echo "Setup complete. Run 'opencode' to start."

# 6. REFRESH PATH: Ensure the new tools are available in the current session.
export PATH="$PATH:$(npm config get prefix)/bin"

echo "✅ All set! Installations and linking complete."
echo "💡 TIP: Run 'source ~/.bashrc' if your terminal hasn't updated yet."
