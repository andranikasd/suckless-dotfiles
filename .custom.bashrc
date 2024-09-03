#!/bin/bash
#===============================================================================
#
#          FILE:  .custom.bashrc
# 
#         USAGE:  source ~/.custom.bashrc
#
#   DESCRIPTION:  Custom bashrc file to set up the shell environment by sourcing
#                 environment variables, aliases, prompt, and helper scripts.
#
#       OPTIONS:  N/A
#  REQUIREMENTS:  Bash shell
#          BUGS:  No known bugs at this time.
#         NOTES:  Ensure that this script is sourced from your .bashrc.
#        AUTHOR:  Andranik Grigoryan (andranik@grigoryan.work)
#       VERSION:  1.0
#       CREATED:  2024-09-03
#      REVISION:  2024-09-03 - Initial version
#
#===============================================================================

# shellcheck source=/dev/null

# --- Source Environment Variables --------------------------------------------
if [ -f "$HOME/dotfiles/environment.sh" ]; then
    source "$HOME/dotfiles/environment.sh"
fi

# --- Source Aliases ----------------------------------------------------------
if [ -f "$HOME/dotfiles/aliases.sh" ]; then
    source "$HOME/dotfiles/aliases.sh"
fi

# --- Source Custom Prompt ----------------------------------------------------
if [ -f "$HOME/dotfiles/prompt.sh" ]; then
    source "$HOME/dotfiles/prompt.sh"
fi

# --- Source Helper Scripts ---------------------------------------------------
# FZF Enhancements
if [ -f "$HOME/helpers/fzf.sh" ]; then
    source "$HOME/helpers/fzf.sh"
fi

# Git Helpers
if [ -f "$HOME/helpers/git.sh" ]; then
    source "$HOME/helpers/git.sh"
fi

# Kubectl Helpers
if [ -f "$HOME/helpers/kubectl.sh" ]; then
    source "$HOME/helpers/kubectl.sh"
fi

# Watch Enhancements
if [ -f "$HOME/helpers/watch.sh" ]; then
    source "$HOME/helpers/watch.sh"
fi

# --- Final Customizations ----------------------------------------------------
# Add any final custom shell commands or environment setups here

# Add custom welcome message, e.g., using figlet and lolcat
if command -v figlet &> /dev/null && command -v lolcat &> /dev/null; then
    figlet -f slant "Welcome, $USER!" | lolcat
fi

#===============================================================================
# End of .custom.bashrc
#===============================================================================
