#!/bin/bash
#===============================================================================
#
#          FILE:  watch.sh
# 
#         USAGE:  source /path/to/watch.sh
#
#   DESCRIPTION:  This script contains helper functions to monitor various 
#                 system metrics, logs, and processes in real-time using the 
#                 `watch` command.
#
#       OPTIONS:  N/A (This script is designed to be sourced into your shell environment)
#  REQUIREMENTS:  Bash shell, watch command, ~/.bashrc or equivalent shell configuration file.
#          BUGS:  No known bugs at this time.
#         NOTES:  Ensure that this script is sourced properly in your ~/.bashrc.
#        AUTHOR:  Andranik Grigoryan (andranik@grigoryan.work)
#       VERSION:  1.0
#       CREATED:  2024-09-03
#      REVISION:  2024-09-03 - Initial version
#
#===============================================================================

#-------------------------------------------------------------------------------
# Function: watch_du
#
# Description:
#   Monitor the disk usage of a specific directory in real-time.
#
# Usage:
#   watch_du /path/to/directory
#
# Parameters:
#   - directory: The directory to monitor (default: current directory)
#
# Returns:
#   None
#
#-------------------------------------------------------------------------------
function watch_du() {
    local directory 
    directory="${1:-.}"
    watch -n 1 "du -sh ${directory}"
}

#-------------------------------------------------------------------------------
# Function: watch_df
#
# Description:
#   Monitor disk free space in real-time.
#
# Usage:
#   watch_df
#
# Parameters:
#   None
#
# Returns:
#   None
#
#-------------------------------------------------------------------------------
function watch_df() {
    watch -n 1 df -h
}

#-------------------------------------------------------------------------------
# Function: watch_ps
#
# Description:
#   Monitor processes matching a specific pattern in real-time.
#
# Usage:
#   watch_ps pattern
#
# Parameters:
#   - pattern: The pattern to match in the process list
#
# Returns:
#   None
#
#-------------------------------------------------------------------------------
function watch_ps() {
    local pattern
    pattern="$1"
    watch -n 1 "ps aux | grep -v grep | grep --color=auto ${pattern}"
}

#-------------------------------------------------------------------------------
# Function: watch_netstat
#
# Description:
#   Monitor network connections in real-time.
#
# Usage:
#   watch_netstat
#
# Parameters:
#   None
#
# Returns:
#   None
#
#-------------------------------------------------------------------------------
function watch_netstat() {
    watch -n 1 netstat -tuln
}

#-------------------------------------------------------------------------------
# Function: watch_logs
#
# Description:
#   Monitor the tail of a log file in real-time.
#
# Usage:
#   watch_logs /path/to/logfile
#
# Parameters:
#   - logfile: The log file to monitor
#
# Returns:
#   None
#
#-------------------------------------------------------------------------------
function watch_logs() {
    local logfile
    logfile="$1"
    watch -n 1 tail -n 20 "${logfile}"
}

#-------------------------------------------------------------------------------
# Function: watch_uptime
#
# Description:
#   Monitor system uptime and load average in real-time.
#
# Usage:
#   watch_uptime
#
# Parameters:
#   None
#
# Returns:
#   None
#
#-------------------------------------------------------------------------------
function watch_uptime() {
    watch -n 1 uptime
}

#-------------------------------------------------------------------------------
# Function: watch_free
#
# Description:
#   Monitor memory usage in real-time.
#
# Usage:
#   watch_free
#
# Parameters:
#   None
#
# Returns:
#   None
#
#-------------------------------------------------------------------------------
function watch_free() {
    watch -n 1 free -h
}

#-------------------------------------------------------------------------------
# Function: watch_top
#
# Description:
#   Monitor the top resource-consuming processes in real-time.
#
# Usage:
#   watch_top
#
# Parameters:
#   None
#
# Returns:
#   None
#
#-------------------------------------------------------------------------------
function watch_top() {
    watch -n 1 "ps aux --sort=-%mem | head -n 10"
}

#-------------------------------------------------------------------------------
# Function: watch_kubectl
#
# Description:
#   Monitor the status of Kubernetes pods in real-time.
#
# Usage:
#   watch_kubectl [namespace]
#
# Parameters:
#   - namespace: The Kubernetes namespace to monitor (optional)
#
# Returns:
#   None
#
#-------------------------------------------------------------------------------
function watch_kubectl() {
    local namespace
    namespace="${1:-default}"
    watch -n 1 "kubectl get pods -n ${namespace}"
}

#-------------------------------------------------------------------------------
# Function: watch_ping
#
# Description:
#   Monitor the connectivity to a host using ping in real-time.
#
# Usage:
#   watch_ping hostname
#
# Parameters:
#   - hostname: The hostname or IP address to ping
#
# Returns:
#   None
#
#-------------------------------------------------------------------------------
function watch_ping() {
    local hostname
    hostname="$1"
    watch -n 1 "ping -c 1 ${hostname}"
}

#===============================================================================
# End of watch.sh
#===============================================================================
