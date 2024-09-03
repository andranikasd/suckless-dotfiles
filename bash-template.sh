#!/bin/bash
#===============================================================================
#
#          FILE:  functions.sh
# 
#         USAGE:  source ~/.bashrc or source /path/to/functions.sh
#
#   DESCRIPTION:  This script contains all custom bash functions that I use in my bashrc.
#
#       OPTIONS:  N/A (These functions are meant to be sourced in your shell environment)
#  REQUIREMENTS:  Bash shell, ~/.bashrc or equivalent shell configuration file.
#          BUGS:  N/A
#         NOTES:  Ensure that this script is sourced properly to make the functions available.
#        AUTHOR:  Andranik Grigoryan (andranik@grigoryan.work)
#       VERSION:  1.0
#       CREATED:  2024-09-03
#      REVISION:  2024-09-03
#===============================================================================

#-------------------------------------------------------------------------------
# Function: __python_env
#
# Description:
#   This function appends the Python virtual environment path to the bash 
#   prompt whenever a Python virtual environment is activated. It ensures that 
#   the prompt reflects the active environment, providing quick context for 
#   which environment is currently in use.
#
# Usage:
#   Call this function within your .bashrc or equivalent shell configuration 
#   file to automatically modify your prompt based on the active Python 
#   environment.
#
# Parameters:
#   None
#
# Returns:
#   None - The function modifies the PS1 prompt variable in place.
#
#-------------------------------------------------------------------------------


#-------------------------------------------------------------------------------
# Global Variable: MY_VAR
#
# Description:
#   This variable is used to store a commonly accessed value or setting that is 
#   referenced throughout multiple functions in the script. It can be used to 
#   set default paths, configuration options, or any other static information 
#   that needs to be accessed globally.
#
# Value:
#   "some_value" - This could be a path, a string identifier, or any other 
#   relevant data.
#
# Usage:
#   Refer to this variable in your functions or script logic wherever the 
#   associated value is needed.
#
#-------------------------------------------------------------------------------
