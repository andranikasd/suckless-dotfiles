#!/bin/bash
#===============================================================================
#
#          FILE:  environment.sh
# 
#         USAGE:  source /path/to/environment.sh
#
#   DESCRIPTION:  This script sets up environment variables that are commonly 
#                 used across multiple scripts and sessions.
#
#       OPTIONS:  N/A (This script is designed to be sourced into your shell environment)
#  REQUIREMENTS:  Bash shell, ~/.bashrc or equivalent shell configuration file.
#          BUGS:  No known bugs at this time.
#         NOTES:  Ensure that this script is sourced properly in your ~/.bashrc.
#        AUTHOR:  Andranik Grigoryan (andranik@grigoryan.work)
#       VERSION:  1.0
#       CREATED:  2024-09-03
#      REVISION:  2024-09-03 - Initial version
#
#===============================================================================

# --- Environment Variables ---------------------------------------------------

# Configure command history settings
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTCONTROL=ignoredups
export HISTIGNORE='clear:clr'

# Set PATH to include custom bin directories
export PATH="/home/$USER/.krew/bin:/home/$USER/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/$USER/.linkerd2/bin:$PATH"

# Export the default KUBE_EDITOR
export KUBE_EDITOR="vim"

# Set case-insensitive completion
bind "set completion-ignore-case on"

# --- End of environment variables setup --------------------------------------