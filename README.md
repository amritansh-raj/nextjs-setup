# Automated Next.js Project Setup

This script automates the setup of a Next.js project with essential tools like **Husky**, **Commitlint**, **Prettier**, and a **Devcontainer** for a streamlined development experience.

## 🎯 Purpose

The script simplifies the setup process for a Next.js project by configuring critical development tools, ensuring consistency in formatting, commit messages, and environment setup.

## 🛠️ Prerequisites

- **Node.js** and either **npm**, **yarn**, or **bun** installed.
- Basic understanding of Git and terminal commands.

## 🚀 Usage

1. Execute the scipt:
   1.1 Using curl

   ```bash
   curl -s https://raw.githubusercontent.com/amritansh-raj/nextjs-setup/main/setup.sh | bash -s -- <project_name> <container_name>
   ```

   1.2 Using wget

   ```bash
   wget -qO- https://raw.githubusercontent.com/amritansh-raj/nextjs-setup/main/setup.sh | bash -s -- <project_name> <container_name>
   ```

2. Clone the script:
   2.1 Save the script as a `.sh` file (e.g., `setup-nextjs-project.sh`).

   2.2. Make the script executable:

   ```bash
   chmod +x setup-nextjs-project.sh
   ```

   2.3. Run the script:

   ```bash
   ./setup-nextjs-project.sh
   ```

3. Follow the prompts to enter your project and container name.

## 🧰 Features

- **Next.js Project Creation**: Uses `bun create next-app` to create a new Next.js project.
- **Dependency Installation**: Installs essential packages like **Husky**, **Commitlint**, **Prettier**, and more.
- **Git Hooks**: Sets up Husky hooks for pre-commit and post-merge actions.
- **Commitlint**: Enforces conventional commit messages for better maintainability.
- **Prettier**: Automatically formats code for consistent style.
- **Devcontainer**: Provides a consistent development environment with a customizable Devcontainer setup.
- **Additional Packages**: Option to specify and install additional packages.

## ⚙️ Customization

- **Package Installation**: Modify the `additional_packages` variable to include other desired packages.
- **Git Hooks**: Customize the pre-commit and post-merge hooks in `.husky/` to add or remove specific actions.
- **Commitlint Rules**: Modify `commitlint.config.js` to adjust allowed commit types and messages.
- **Prettier Configuration**: Change formatting preferences in `.prettierrc`.
- **Devcontainer Setup**: Customize `devcontainer.json` to modify the base image, extensions, and other settings.

## 📋 Explanation of Script Steps

1. **Project Details**: Prompts you to enter the project and container names.
2. **Next.js App**: Creates a Next.js project using Bun's `bun create next-app`.
3. **Dependencies**: Installs Husky, Commitlint, Prettier, and other necessary packages.
4. **Husky and Git Hooks**: Sets up Husky and configures hooks for commit message linting, linting, formatting, and package updates.
5. **Package Scripts**: Adds `prepare` and `format` scripts to `package.json`.
6. **Commitlint Configuration**: Generates a `commitlint.config.js` file with conventional commit rules.
7. **Prettier Configuration**: Creates `.prettierrc` for formatting options and `.prettierignore` to exclude files from formatting.
8. **Lint-Staged**: Configures linting and formatting for staged files in `package.json`.
9. **Devcontainer Setup**: Creates `devcontainer.json` and `postCreateCommand.sh` for consistent development environments across different machines.

## 📦 Additional Notes

- Ensure you have the required permissions to create files and directories in your desired location.
- Refer to the official documentation of [Husky](https://typicode.github.io/husky/), [Commitlint](https://commitlint.js.org/), [Prettier](https://prettier.io/), and [Devcontainers](https://containers.dev/) for more information.

## 🎉 Enjoy Your Automated Next.js Project Setup!

Feel free to contribute, open issues, or suggest improvements.
