#!/bin/bash

# Install Gemini CLI (2026 Stable)
npm install -g @google/gemini-cli

# Install Claude Code (2026 Native Installer)
curl -fsSL https://claude.ai/install.sh | bash

# Ensure the paths are refreshed for the current session
export PATH="$PATH:$(npm config get prefix)/bin"
echo "🚀 Gemini CLI and Claude code installed successfuly."
# Automates the "Portable Single HTML" setup for any Vite React project
make-portable() {
  echo "📦 Installing portable build dependencies..."
  npm install vite-plugin-singlefile @types/node --save-dev --silent

  echo "🛠️ Fixing index.html (adding type='module')..."
  # This line uses 'sed' to add the type="module" attribute if it's missing
  sed -i 's/<script src="\/src\/main.jsx"/<script type="module" src="\/src\/main.jsx"/' index.html
  sed -i 's/<script src="\/src\/main.js"/<script type="module" src="\/src\/main.js"/' index.html

  echo "📝 Writing the 'Golden' vite.config.ts..."
  cat << 'EOF' > vite.config.ts
import tailwindcss from '@tailwindcss/vite';
import react from '@vitejs/plugin-react';
import path from 'path';
import { fileURLToPath } from 'url';
import { defineConfig } from 'vite';
import { viteSingleFile } from "vite-plugin-singlefile";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

export default defineConfig({
  plugins: [react(), tailwindcss(), viteSingleFile()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, '.'),
    },
  },
  build: {
    assetsInlineLimit: 100000000, 
    cssCodeSplit: false,
  }
});
EOF

  echo "🚀 Ready! Use 'npm run build' and grab the file from the /dist folder."
}
