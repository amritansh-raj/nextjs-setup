README: Automated Next.js Project Setup
Purpose:
This script automates the setup of a Next.js project with essential tools like Husky, Commitlint, Prettier, and a Devcontainer for a streamlined development experience.

Prerequisites:
Node.js and npm or yarn installed.
Basic understanding of Git and terminal commands.
Usage:
Save the script as a .sh file (e.g., setup-nextjs-project.sh).
Make it executable: Run chmod +x setup-nextjs-project.sh.
Execute the script: Run ./setup-nextjs-project.sh.
Follow the prompts: Enter your project name and container name when asked.
Features:
Next.js Project Creation: Creates a new Next.js project using bun create next-app.
Dependency Installation: Installs essential packages like Husky, Commitlint, Prettier, and others.
Git Hooks: Sets up Husky hooks for pre-commit and post-merge actions.
Commitlint: Enforces conventional commit messages for better code maintainability.
Prettier: Automatically formats code to ensure consistent style.
Devcontainer: Creates a Devcontainer for a consistent development environment across different machines.
Additional Packages: Allows you to specify additional packages to install.
Customization:
Package Installation: Modify the additional_packages variable to include other desired packages.
Git Hooks: Customize the pre-commit and post-merge hooks to add or remove specific actions.
Commitlint Rules: Modify the commitlint.config.js file to adjust the allowed commit types and messages.
Prettier Configuration: Adjust the .prettierrc file to change formatting preferences.
Devcontainer: Customize the devcontainer.json file to modify the base image, extensions, and other settings.
Explanation of Steps:
Project Details: Asks for project and container names.
Next.js App: Creates a new Next.js project.
Dependencies: Installs necessary packages.
Husky and Git Hooks: Sets up Husky and creates hooks for commitlints, linting, formatting, and package updates.
Package.json: Adds prepare and format scripts to package.json.
Commitlint Configuration: Creates commitlint.config.js with conventional commit types.
Prettier Configuration: Creates .prettierrc with formatting options.
Prettier Ignore: Creates .prettierignore to exclude files from formatting.
Lint-Staged: Updates package.json for linting and formatting staged files.
Devcontainer: Creates devcontainer.json and postCreateCommand.sh for a consistent development environment.
Additional Notes:
Ensure you have the required permissions to create files and directories in your desired location.
For more information on using Husky, Commitlint, Prettier, and Devcontainers, refer to their respective documentation.
Enjoy your automated Next.js project setup!
