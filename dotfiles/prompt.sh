#!/bin/bash
#===============================================================================
#
#          FILE:  prompt_config.sh
# 
#         USAGE:  source /path/to/prompt_config.sh
#
#   DESCRIPTION:  This script sets up a custom bash prompt that includes information
#                 such as the last command status, current working directory,
#                 Python virtual environment, Kubernetes context, namespace, and Git branch.
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

#-------------------------------------------------------------------------------
# Function: __kube_ps1
#
# Description:
#   Displays the current Kubernetes context and namespace in the bash prompt. 
#   This function is useful for providing contextual information in the prompt 
#   when working with multiple Kubernetes clusters or namespaces.
#
# Usage:
#   This function is invoked by the set_prompt function and should not typically 
#   be called directly.
#
# Parameters:
#   None
#
# Returns:
#   String - A formatted string containing the Kubernetes context and namespace,
#            which is incorporated into the PS1 prompt.
#
#-------------------------------------------------------------------------------
function __kube_ps1() {
    local CYA
    local RED
    local LCYA
    local NC
    
    CYA='\[\033[0;36m\]'  # Cyan color
    RED='\[\033[0;31m\]'  # Red color
    LCYA='\[\033[1;36m\]' # Light cyan color
    NC='\[\033[0m\]'      # No color (reset)
    
    # Get current Kubernetes context from kubeconfig
    local CONTEXT
    CONTEXT=$(grep -oP '(?<=current-context: ).*' ~/.kube/config)
    
    if [ -n "$CONTEXT" ] && [ "$CONTEXT" != "\"\"" ]; then
        local NS
        NS=$(kubectl config view --minify -o jsonpath='{..namespace}')
        echo -e "${CYA}${CONTEXT}:${LCYA}${NS}${NC}"
    fi
}

#-------------------------------------------------------------------------------
# Function: __python_env
#
# Description:
#   Displays the Python virtual environment name in the bash prompt if a virtual 
#   environment is currently activated. This is helpful for developers working 
#   in multiple Python environments, providing clear visibility into the active 
#   environment.
#
# Usage:
#   This function is invoked by the set_prompt function and should not typically 
#   be called directly.
#
# Parameters:
#   None
#
# Returns:
#   String - A formatted string containing the name of the active Python virtual 
#            environment, which is incorporated into the PS1 prompt.
#
#-------------------------------------------------------------------------------
function __python_env() {
    if [ -n "$VIRTUAL_ENV" ]; then
        echo -e "\[\033[0;33m\]($(basename "${VIRTUAL_ENV}"))\[\033[0m\]"
    fi
}

#-------------------------------------------------------------------------------
# Function: set_prompt
#
# Description:
#   Sets up a custom bash prompt that includes:
#   - Last command status (Success or Failure)
#   - Current working directory
#   - Python virtual environment (if any)
#   - Kubernetes context and namespace (if any)
#   - Git branch (if in a Git repository)
#
# Usage:
#   This function is assigned to the PROMPT_COMMAND variable, which ensures it 
#   is executed before every command prompt is displayed. It constructs the PS1 
#   variable to customize the prompt.
#
# Parameters:
#   None
#
# Returns:
#   None - The function modifies the PS1 prompt variable in place.
#
#-------------------------------------------------------------------------------
function set_prompt() {
    local Last_Command # Capture the exit status of the last executed command
    local Red          # Red color for errors
    local Green        # Green color for success
    local Blue         # Blue color for username
    local Yellow       # Yellow color for working directory
    local DarkRed      # Dark red color for Git branch
    local Reset        # Reset color
    local FancyX       # Unicode character for a red X
    local Checkmark    # Unicode character for a green checkmark
    
    Last_Command=$?
    Red='\[\e[01;31m\]'
    Green='\[\e[01;32m\]'
    Blue='\[\033[38;5;87m\]'
    Yellow='\[\033[38;5;11m\]'
    DarkRed='\[\033[38;5;1m\]'
    Reset='\[\e[00m\]'
    FancyX='\342\234\227'
    Checkmark='\342\234\223'
    
    # Determine if the last command was successful or not
    local PS=""
    if [ "$Last_Command" -eq 0 ]; then
        PS+="$Green$Checkmark "   # Add green checkmark for success
    else
        PS+="$Red$FancyX "        # Add red X for failure
    fi
    
    local KUBE
    KUBE=$(__kube_ps1)            # Get Kubernetes context and namespace
    local PYTHON_ENV
    PYTHON_ENV=$(__python_env)    # Get Python virtual environment

    # Construct the custom prompt
    PS1="$PS $Blue\u$Reset [$Yellow\w$Reset] $PYTHON_ENV $KUBE $DarkRed\$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/') $Green\$$Reset> "
}

#-------------------------------------------------------------------------------
# PROMPT_COMMAND
#
# Description:
#   The PROMPT_COMMAND variable is a special bash variable that holds a command 
#   to execute before the command prompt is displayed. In this script, it is set 
#   to invoke the set_prompt function, ensuring the custom prompt is applied.
#
# Usage:
#   This variable is set automatically by sourcing this script.
#
# Value:
#   'set_prompt' - The function that constructs and sets the custom prompt.
#
#-------------------------------------------------------------------------------
PROMPT_COMMAND='set_prompt'
