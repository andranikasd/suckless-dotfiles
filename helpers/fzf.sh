#!/bin/bash
#===============================================================================
#
#          FILE:  fzf.sh
# 
#         USAGE:  source /path/to/fzf.sh
#
#   DESCRIPTION:  This script contains helper functions using fzf for enhanced
#                 command-line operations such as searching through history,
#                 files, directories, Git branches, and more.
#
#       OPTIONS:  N/A (This script is designed to be sourced into your shell environment)
#  REQUIREMENTS:  Bash shell, fzf, ~/.bashrc or equivalent shell configuration file.
#          BUGS:  No known bugs at this time.
#         NOTES:  Ensure that this script is sourced properly in your ~/.bashrc.
#        AUTHOR:  Andranik Grigoryan (andranik@grigoryan.work)
#       VERSION:  1.0
#       CREATED:  2024-09-03
#      REVISION:  2024-09-03 - Initial version
#
#===============================================================================

#-------------------------------------------------------------------------------
# Function: frevs
#
# Description:
#   Perform a reverse-i-search with enhanced fuzzy search capabilities using fzf.
#
# Usage:
#   frevs (or Ctrl+R in bash after binding)
#
# Parameters:
#   None
#
# Returns:
#   Executes the selected command from history.
#
#-------------------------------------------------------------------------------
frevs() {
    local selected_command
    selected_command=$(history | tac | fzf --tac --query="$READLINE_LINE" --reverse --preview="echo {}" --height=40%)
    READLINE_LINE="${selected_command##* }"
    READLINE_POINT=${#READLINE_LINE}
}
bind -x '"\C-r": "frevs"'

#-------------------------------------------------------------------------------
# Function: fco
#
# Description:
#   Fuzzy search and checkout a Git branch.
#
# Usage:
#   fco
#
# Parameters:
#   None
#
# Returns:
#   Switches to the selected Git branch.
#
#-------------------------------------------------------------------------------
fco() {
    local branches
    branches=$(git branch --all | sed 's/^[* ] //' | fzf --height=40% --reverse --preview "git log --oneline {}")
    git checkout $(echo "${branches}" | sed 's#remotes/origin/##')
}

#-------------------------------------------------------------------------------
# Function: frecent
#
# Description:
#   Fuzzy search and open a recently used file.
#
# Usage:
#   frecent
#
# Parameters:
#   None
#
# Returns:
#   Opens the selected file in the default editor.
#
#-------------------------------------------------------------------------------
frecent() {
    local file
    file=$(ls -t | fzf --height=40% --reverse --preview "bat --style=numbers --color=always --line-range :500 {}")
    [ -n "${file}" ] && ${EDITOR} "${file}"
}

#-------------------------------------------------------------------------------
# Function: fkill
#
# Description:
#   Fuzzy search and kill a process.
#
# Usage:
#   fkill
#
# Parameters:
#   None
#
# Returns:
#   Kills the selected process.
#
#-------------------------------------------------------------------------------
fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf --height=40% --reverse --preview="echo {}" | awk '{print $2}')
    if [ -n "${pid}" ]; then
        kill -9 "${pid}"
        echo "Killed process ${pid}"
    fi
}

#-------------------------------------------------------------------------------
# Function: fcd
#
# Description:
#   Fuzzy search and change to a directory.
#
# Usage:
#   fcd
#
# Parameters:
#   None
#
# Returns:
#   Changes to the selected directory.
#
#-------------------------------------------------------------------------------
fcd() {
    local dir
    dir=$(find "${1:-.}" -type d 2> /dev/null | fzf --height=40% --reverse)
    [ -n "${dir}" ] && cd "${dir}"
}

#-------------------------------------------------------------------------------
# Function: fssh
#
# Description:
#   Fuzzy search and SSH into a host from your known_hosts or a custom list.
#
# Usage:
#   fssh
#
# Parameters:
#   None
#
# Returns:
#   Initiates an SSH session to the selected host.
#
#-------------------------------------------------------------------------------
fssh() {
    local host
    host=$(< ~/.ssh/known_hosts cut -f 1 -d ' ' | sed 's/,.*//' | sort -u | fzf --height=40% --reverse)
    [ -n "${host}" ] && ssh "${host}"
}

#-------------------------------------------------------------------------------
# Function: falias
#
# Description:
#   Fuzzy search and execute a defined alias.
#
# Usage:
#   falias
#
# Parameters:
#   None
#
# Returns:
#   Executes the selected alias.
#
#-------------------------------------------------------------------------------
falias() {
    local alias
    alias=$(alias | fzf --height=40% --reverse --preview "echo {}" | cut -d '=' -f 1)
    eval "${alias}"
}

#-------------------------------------------------------------------------------
# Function: ffind
#
# Description:
#   Fuzzy search for files in the current directory and open in the default editor.
#
# Usage:
#   ffind
#
# Parameters:
#   None
#
# Returns:
#   Opens the selected file in the default editor.
#
#-------------------------------------------------------------------------------
ffind() {
    local file
    file=$(find . -type f 2> /dev/null | fzf --height=40% --reverse --preview="bat --style=numbers --color=always --line-range :500 {}")
    [ -n "${file}" ] && $EDITOR "${file}"
}

#-------------------------------------------------------------------------------
# Function: flog
#
# Description:
#   Fuzzy search through Git commit history and show details.
#
# Usage:
#   flog
#
# Parameters:
#   None
#
# Returns:
#   Displays the selected commit details.
#
#-------------------------------------------------------------------------------
flog() {
    local commit
    commit=$(git log --oneline --decorate | fzf --height=40% --reverse --preview "git show --color=always {}")
    [ -n "${commit}" ] && git show "${commit}"
}

#-------------------------------------------------------------------------------
# Function: fenv
#
# Description:
#   Fuzzy search through environment variables.
#
# Usage:
#   fenv
#
# Parameters:
#   None
#
# Returns:
#   Prints the selected environment variable's value.
#
#-------------------------------------------------------------------------------
fenv() {
    printenv | fzf --height=40% --reverse --preview="echo {}" | awk -F '=' '{print $2}'
}

#===============================================================================
# End of fzf.sh
#===============================================================================
