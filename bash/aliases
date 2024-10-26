#!/bin/bash
#===============================================================================
#
#          FILE:  aliases.sh
#
#         USAGE:  source /path/to/aliases.sh
#
#   DESCRIPTION:  This script defines a set of basic and commonly used aliases
#                 to improve command-line efficiency and productivity.
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

# --- Basic Navigation Aliases -------------------------------------------------

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"  # Go to home directory
alias c="clear" # Clear terminal screen

# --- Directory Listing Aliases ------------------------------------------------

alias ls="ls --color=auto" # Enable colorized output
alias ll="ls -la"          # Long listing format with hidden files
alias la="ls -A"           # List all files excluding . and ..
alias l="ls -CF"           # Classify entries by appending indicators

# --- File and Directory Management Aliases ------------------------------------

alias cp="cp -i"                               # Interactive copy (prompt before overwrite)
alias mv="mv -i"                               # Interactive move (prompt before overwrite)
alias rm="rm -i"                               # Interactive remove (prompt before delete)
alias mkdir="mkdir -p"                         # Create parent directories as needed
alias rmdir="rmdir --ignore-fail-on-non-empty" # Remove directory if empty

# --- System Information Aliases -----------------------------------------------

alias df="df -h"               # Human-readable disk usage
alias du="du -h --max-depth=1" # Human-readable disk usage by directory
alias free="free -m"           # Memory usage in MB
alias top="htop"               # Use htop instead of top if installed

# --- Network Management Aliases -----------------------------------------------

alias ping="ping -c 5"        # Send only 5 packets by default
alias myip="curl ifconfig.me" # Display public IP address

# --- Git Aliases --------------------------------------------------------------

alias gst="git status"                          # Show Git status
alias gco="git checkout"                        # Checkout a Git branch
alias gl="git log --oneline --graph --decorate" # Pretty Git log
alias gaa="git add --all"                       # Stage all changes
alias gcmsg="git commit -m"                     # Commit with message
alias gp="git push"                             # Push changes to remote
alias gpull="git pull"                          # Pull changes from remote

# --- Docker Aliases -----------------------------------------------------------

alias dps="docker ps"     # List running containers
alias dpsa="docker ps -a" # List all containers
alias di="docker images"  # List Docker images
alias dstop="docker stop" # Stop a container
alias drm="docker rm"     # Remove a container
alias drmimg="docker rmi" # Remove a Docker image

# --- Search and History Aliases -----------------------------------------------

alias h="history"              # Show command history
alias hgrep="history | grep"   # Search command history
alias grep="grep --color=auto" # Enable colorized grep output

# --- Miscellaneous Aliases ----------------------------------------------------

alias e="exit"               # Exit terminal session
alias vi="vim"               # Use Vim instead of Vi
alias vim="nvim"             # vim -> nvim
alias svi="sudo vim"         # Edit files as root with Vim
alias cls="clear && ls"      # Clear screen and list directory contents
alias src="source ~/.bashrc" # Reload bashrc configuration

# --- Custom Aliases -----------------------------------------------------------

alias clr="clear"                                                         # Clear terminal screen (alternative)
alias tf="terraform"                                                      # Short alias for Terraform
alias tfp="tf plan"                                                       # Terraform plan
alias tfa="tf apply"                                                      # Terraform apply
alias tfaa="tfa -auto-approve"                                            # Terraform apply with auto-approve
alias tfwl="tf workspace list"                                            # List Terraform workspaces
alias k="kubectl"                                                         # Short alias for kubectl
alias kc='export KUBE_EDITOR="code -w"; echo "Kube Editor set to VSCode"' # Set Kube editor to VSCode
alias kv='export KUBE_EDITOR="vim"; echo "Kube Editor set to Vim"'        # Set Kube editor to Vim

#===============================================================================
# End of aliases.sh
#===============================================================================
