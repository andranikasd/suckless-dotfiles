#!/bin/bash
#===============================================================================
#
#          FILE:  setup.sh
# 
#         USAGE:  ./setup.sh
#
#   DESCRIPTION:  This script sets up Vim with a custom configuration by reading
#                 the .vimrc file located in the same directory as the script.
#                 It also installs Vim-Plug for plugin management.
#
#       OPTIONS:  N/A
#  REQUIREMENTS:  Bash shell, Vim, curl, and Git.
#          BUGS:  No known bugs at this time.
#         NOTES:  Ensure that this script is executed with sufficient permissions.
#        AUTHOR:  Andranik Grigoryan (andranik@grigoryan.work)
#       VERSION:  1.0
#       CREATED:  2024-09-03
#      REVISION:  2024-09-03 - Initial version
#
#===============================================================================

# --- Function Definitions ----------------------------------------------------

# Function: install_vim_plug
# Description: Installs Vim-Plug, a minimalist plugin manager for Vim.
install_vim_plug() {
    if [ ! -f ~/.vim/autoload/plug.vim ]; then
        echo "Installing Vim-Plug..."
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        echo "Vim-Plug installed."
    else
        echo "Vim-Plug is already installed."
    fi
}

# Function: setup_vimrc
# Description: Sets up the .vimrc file by copying it from the script directory.
setup_vimrc() {
    local script_dir
    script_dir=$(dirname "$(realpath "$0")")

    if [ -f "$script_dir/.vimrc" ]; then
        echo "Copying .vimrc from $script_dir to home directory..."
        cp "$script_dir/.vimrc" ~/.vimrc
        echo ".vimrc configuration applied."
    else
        echo "Error: .vimrc file not found in $script_dir"
        exit 1
    fi
}

# Function: install_plugins
# Description: Installs the plugins specified in the .vimrc file using Vim-Plug.
install_plugins() {
    echo "Installing Vim plugins..."
    vim +PlugInstall +qall
    echo "Vim plugins installed."
}

# --- Main Script -------------------------------------------------------------

# Install Vim-Plug if not already installed
install_vim_plug

# Set up .vimrc with the provided configuration from the script directory
setup_vimrc

# Install the Vim plugins
install_plugins

echo "Vim setup complete."

#===============================================================================
# End of setup.sh
#===============================================================================
