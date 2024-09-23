#!/bin/bash

# Step 1: Ask for project details
# Step 1: Check for input arguments
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <project_name> <container_name> [additional_packages]"
  exit 1
fi

project_name=$1
container_name=$2
additional_packages=${3:-}

# Step 2: Create Next.js app with bun
echo "🚀 Creating Next.js app..."
if bun create next-app $project_name; then
  echo "✅ Successfully created Next.js app!"
else
  echo "❌ Error creating Next.js app."
  exit 1
fi

# Ensure project directory was created and navigate into it
if [ -d "$project_name" ]; then
  cd $project_name
else
  echo "❌ Error: Failed to create project directory $project_name"
  exit 1
fi

# Step 3: Ask for additional packages to install
# read -p "Enter any additional packages to install (space-separated, or press Enter to skip): " additional_packages

# Step 4: Add necessary dependencies with a progress indicator
echo "📦 Installing Husky, Commitlint, Prettier, and other packages..."
if bun add husky @commitlint/cli @commitlint/config-conventional lint-staged prettier prettier-plugin-tailwindcss $additional_packages; then
  echo "✅ Dependencies installed!"
else
  echo "❌ Error installing dependencies."
  exit 1
fi

# Step 5: Set up Husky and Git hooks
echo "🔧 Setting up Husky hooks..."
bun husky install

# Ensure the .husky directory exists
if [ ! -d ".husky" ]; then
  echo "❌ Error: Husky directory not created."
  exit 1
fi

# Create commit-msg hook for commitlint
echo 'bun commitlint --edit
bun run build' >.husky/commit-msg
chmod +x .husky/commit-msg

# Add pre-commit hook
echo 'bun lint
npx lint-staged
bun run format
sudo chown -R $(whoami) .' >.husky/pre-commit
chmod +x .husky/pre-commit

# Add post-merge hook to handle package updates
echo 'changed() {
    git diff --name-only HEAD@{1} HEAD | grep "^$1" >/dev/null 2>&1
}

if changed "package.json"; then
    echo "📦 package.json changed. Running bun install for updating packages."
    bun install
fi' >.husky/post-merge
chmod +x .husky/post-merge

# Step 6: Add prepare script to package.json (if not already present)
echo "📝 Updating package.json with prepare script..."
if jq '.scripts.prepare = "husky"' package.json >temp.json && mv temp.json package.json; then
  echo "✅ prepare script added to package.json!"
else
  echo "❌ Error updating package.json."
  exit 1
fi

echo "📝 Updating package.json with format script..."
if jq '.scripts.format = "prettier --write ."' package.json >temp.json && mv temp.json package.json; then
  echo "✅ format script added to package.json!"
else
  echo "❌ Error updating package.json."
  exit 1
fi

cat <<EOL >commitlint.config.js
// feat: Implement a new feature or enhance an existing one.
// init: Initialize a new project or start a new module.
// fix: Address a bug or issue in the codebase.
// build: Modify the build system or dependencies.
// docs: Update or add documentation.
// chore: Perform routine tasks or maintenance.
// style: Adjust code style or formatting without altering functionality.
// refactor: Restructure code without changing its external behavior.
// ci: Update or modify continuous integration configurations.
// test: Add or modify tests.
// revert: Undo a previous commit.
// perf: Improve performance of the code.
// vercel: Deploy changes or updates via Vercel.

module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat',
        'init',
        'fix',
        'build',
        'docs',
        'chore',
        'style',
        'refactor',
        'ci',
        'test',
        'revert',
        'perf',
        'vercel',
      ],
    ],
  },
};
EOL

# Step 12: Create .prettierrc file
cat <<EOL >.prettierrc
{
  "bracketSpacing": true,
  "endOfLine": "lf",
  "printWidth": 80,
  "semi": true,
  "singleQuote": true,
  "tabWidth": 2,
  "trailingComma": "all",
  "plugins": ["prettier-plugin-tailwindcss"]
}
EOL

# Step 13: Create .prettierignore file
cat <<EOL >.prettierignore
.devcontainer
.github
.husky
.next
.cache
package-lock.json
public
node_modules
next-env.d.ts
next.config.ts
yarn.lock
EOL

# Step 14: Add lint-staged configuration to package.json
jq '.["lint-staged"] = {
  "**/*.{js,jsx,ts,tsx}": [
    "eslint --max-warnings=0",
    "prettier --write"
  ],
  "**/*.{html,json,css,scss,md,mdx}": [
    "prettier --write"
  ]
}' package.json >temp.json && mv temp.json package.json

# Step 7: Create devcontainer.json
echo "📦 Creating devcontainer.json..."
mkdir -p .devcontainer
cat <<EOL >.devcontainer/devcontainer.json
{
  "name": "$container_name",
  "image": "mcr.microsoft.com/devcontainers/typescript-node:1-20",
  "runArgs": ["--name", "$container_name"],
  "customizations": {
    "vscode": {
      "settings": {
        "prettier.bracketSpacing": false,
        "editor.defaultFormatter": "esbenp.prettier-vscode",
        "editor.formatOnSave": true,
        "editor.codeActionsOnSave": {
          "source.fixAll": true,
          "source.organizeImports": true
        }
      },
      "extensions": [
        "PKief.material-icon-theme",
        "dbaeumer.vscode-eslint",
        "dsznajder.es7-react-js-snippets",
        "xabikos.JavaScriptSnippets",
        "skyran.js-jsx-snippets",
        "esbenp.prettier-vscode",
        "YoavBls.pretty-ts-errors",
        "bradlc.vscode-tailwindcss",
        "pmneo.tsimporter",
        "formulahendry.auto-rename-tag"
      ]
    }
  },
  "mounts": [
    "source=\${localEnv:HOME}/.ssh,target=/root/.ssh,type=bind,consistency=cached"
  ],
  "postCreateCommand": "sh .devcontainer/postCreateCommand.sh",
  "appPort": ["4000:4000"]
}
EOL
echo "✅ devcontainer.json created!"

# Step 8: Create postCreateCommand.sh
echo "📜 Creating postCreateCommand.sh..."
cat <<EOL >.devcontainer/postCreateCommand.sh
#!/bin/bash

npm i -g bun
bun install
chmod ug+x .husky/*
chmod ug+x .git/hooks/*
chown root:root /root/.ssh/id_ed25519 /root/.ssh/id_ed25519.pub
chmod 600 /root/.ssh/id_ed25519
sudo chown -R \$(whoami) /workspaces/$project_name
EOL
chmod +x .devcontainer/postCreateCommand.sh
echo "✅ postCreateCommand.sh created!"

# Continue with commitlint, prettier, and lint-staged setup
# Rest of the script follows as in your original...

echo "✅ Project setup complete!"
