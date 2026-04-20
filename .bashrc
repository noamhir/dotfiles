# Ensure the global npm paths are refreshed for the current session
export PATH="$PATH:$(npm config get prefix)/bin"

# Automates the "Portable Single HTML" setup for any Vite React project
make-portable() {
  echo "📦 Installing portable build dependencies..."
  npm install vite-plugin-singlefile @types/node --save-dev --silent

  echo "🛠️ Fixing index.html (adding type='module')..."
  sed -i 's/<script src="\/src\/main.jsx"/<script type="module" src="\/src\/main.jsx"/' index.html
  sed -i 's/<script src="\/src\/main.js"/<script type="module" src="\/src\/main.js"/' index.html

  echo "📝 Copying the 'Golden' vite.config.ts..."
  # Safely copy the template from your dotfiles repository
  if [ -f "$HOME/dotfiles/templates/vite.config.ts" ]; then
      cp "$HOME/dotfiles/templates/vite.config.ts" ./vite.config.ts
      echo "✅ Golden config applied."
  else
      echo "❌ Error: Template not found at $HOME/dotfiles/templates/vite.config.ts"
  fi

  echo "🚀 Ready! Use 'npm run build' and grab the file from the /dist folder."
# Combine all 3 steps into one command: "save [message]"
save() {
  git add .
  git commit -m "$1"
  git push
}
}
