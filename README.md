# suckless-dotfiles

**Author:** Andranik Grigoryan  
**Author Page:** [portfolio.andranik.me](https://portfolio.andranik.me)

## Overview

The `suckless-dotfiles` project is a collection of configuration files and helper scripts designed to create an efficient and productive development environment on Ubuntu 22.04. This project focuses on enhancing the command-line experience with custom aliases, environment variables, a tailored Bash prompt, and utility functions. Additionally, it provides support for various tools like `kubectl`, `fzf`, and `git`, and it includes a setup script to automate the installation and configuration of essential packages and Vim plugins.

## Project Structure

```bash
.
├── bash-template.sh
├── dotfiles
│   ├── aliases.sh
│   ├── environment.sh
│   └── prompt.sh
├── helpers
│   ├── fzf.sh
│   ├── git.sh
│   ├── kubectl.sh
│   └── watch.sh
├── LICENSE
├── README.md
├── setup.sh
├── utils
│   └── logging.sh
└── vim
    └── setup.sh

```


## Installation Guide

1. **Clone the Repository:**

   \```
   git clone https://github.com/andranikasd/suckless-dotfiles.git
   cd suckless-dotfiles
   \```

2. **Run the Setup Script:**

   \```
   ./setup.sh
   \```

   The setup script will:
   - Install essential packages like `vim`, `fzf`, `htop`, `kubectl`, and more.
   - Set up a custom Vim configuration with plugins managed via Vim-Plug.
   - Create soft links for dotfiles and helper scripts in your home directory.
   - Customize your shell environment with aliases, environment variables, and prompt settings.

3. **Source the Custom Bash Configuration:**

   After running the setup script, ensure that your `.bashrc` sources the custom `.custom.bashrc` file:

   \```
   echo "source ~/.custom.bashrc" >> ~/.bashrc
   source ~/.bashrc
   \```

## Usage Guide

### Aliases

The `aliases.sh` file defines a set of commonly used command-line aliases to improve efficiency:

- **Navigation Aliases:**
  - `..`: Move up one directory.
  - `...`: Move up two directories.
  - `~`: Go to the home directory.
  - `c`: Clear the terminal screen.

- **File Management Aliases:**
  - `cp`: Copy files with a prompt before overwriting.
  - `mv`: Move files with a prompt before overwriting.
  - `rm`: Remove files with a prompt before deletion.
  - `mkdir`: Create directories, including parent directories if needed.

- **System Information Aliases:**
  - `df`: Display disk usage in a human-readable format.
  - `du`: Display disk usage of directories in a human-readable format.
  - `free`: Display memory usage in MB.
  - `top`: Launch `htop` instead of the default `top`.

- **Git Aliases:**
  - `gst`: Show Git status.
  - `gco`: Checkout a Git branch.
  - `gl`: Display a pretty Git log with graph and decoration.
  - `gaa`: Stage all changes.
  - `gcmsg`: Commit with a message.
  - `gp`: Push changes to remote.

- **Docker Aliases:**
  - `dps`: List running containers.
  - `di`: List Docker images.
  - `dstop`: Stop a container.
  - `drm`: Remove a container.
  - `drmimg`: Remove a Docker image.

### Helpers

The `helpers` directory contains scripts that extend the functionality of common tools:

- **`fzf.sh`:** Enhances your terminal experience with `fzf`-powered searches:
  - `frevs`: Perform a reverse-i-search with fuzzy search capabilities.
  - `fco`: Fuzzy search and checkout a Git branch.
  - `frecent`: Fuzzy search and open a recently used file.
  - `fkill`: Fuzzy search and kill a process.
  - `fcd`: Fuzzy search and change to a directory.

- **`git.sh`:** Provides additional Git helper functions:
  - `git_current_branch`: Displays the current Git branch.
  - `git_add_all_and_commit`: Stages all changes and commits with a message.

- **`kubectl.sh`:** Adds convenience functions for `kubectl`:
  - `kubectx_prompt`: Displays the current Kubernetes context in the prompt.
  - `klogs`: Tail logs for a specific pod in a given namespace.
  - `kexec`: Executes an interactive bash session in a specific container of a pod.
  - `kgp`: Lists all pods in a specified namespace.
  - `kns`: Switches the current Kubernetes namespace in the `kubectl` context.

- **`watch.sh`:** Contains `watch` command enhancements for real-time monitoring:
  - `watch_du`: Monitor disk usage of a specific directory.
  - `watch_df`: Monitor disk free space.
  - `watch_ps`: Monitor processes matching a specific pattern.
  - `watch_netstat`: Monitor network connections.
  - `watch_logs`: Monitor the tail of a log file.

### Vim Configuration

The Vim configuration is defined in the `vimrc` file located in the `vim` directory. It includes:

- **Basic Settings:**
  - Relative and absolute line numbers.
  - Syntax highlighting.
  - Cursor line and column highlighting.
  - Tab settings with a width of 4 spaces.

- **Plugin Management:**
  - Managed via Vim-Plug with plugins like `NERDTree` and `vim-airline`.
  - Color scheme set to Dracula.

### Logging Utility

The `logging.sh` script in the `utils` directory provides a logging framework for Bash scripts:

- **Logging Levels:**
  - `info`: Logs informational messages.
  - `warn`: Logs warning messages.
  - `error`: Logs error messages.

- **Command Logging:**
  - `run_and_log`: Runs a command and logs its output, determining the log level based on the command's exit status.
  - `redirect_and_log`: Redirects the output of a command to the log file and also prints it to the terminal.

## Conclusion

The `suckless-dotfiles` project aims to streamline your development environment setup on Ubuntu 22.04, offering a robust set of tools and configurations to enhance productivity. Feel free to explore and customize the scripts and configurations to suit your specific needs.

For more details about the author and other projects, visit [portfolio.andranik.me](https://portfolio.andranik.me).
