#!/bin/bash

#===============================================================================
#
#          FILE:  logging.sh
# 
#         USAGE:  source /path/to/logging.sh
#
#   DESCRIPTION:  This script provides a logging framework for Bash scripts.
#                 It supports logging messages with different severity levels
#                 (INFO, WARN, ERROR) and can redirect the output of commands
#                 to the log with automatic detection of the appropriate log level.
#
#       OPTIONS:  N/A
#  REQUIREMENTS:  Bash shell
#          BUGS:  No known bugs at this time.
#         NOTES:  Ensure that this script is sourced properly in your scripts.
#        AUTHOR:  Andranik Grigoryan (andranik@grigoryan.work)
#       VERSION:  1.1
#       CREATED:  2024-09-03
#      REVISION:  2024-09-03 - Added color support
#
#===============================================================================

# --- Variables ---------------------------------------------------------------

LOG_FILE="${LOG_FILE:-/tmp/script.log}"  # Default log file if not set by the user
exec 3>&1 1>>"${LOG_FILE}" 2>&1            # Redirect stdout and stderr to log file

# Colors for log levels
COLOR_RESET='\033[0m'
COLOR_INFO='\033[0;36m'     # Cyan for INFO
COLOR_WARN='\033[0;33m'     # Yellow for WARN
COLOR_ERROR='\033[0;31m'    # Red for ERROR

# --- Functions ---------------------------------------------------------------

# Function: log
# Description: Logs a message with a given severity level, color-coded by level.
# Usage: log <level> <message>
log() {
    local level="$1"
    shift
    local msg="$*"
    local timestamp
    local color

    # Determine color based on log level
    case "$level" in
        INFO)
            color=$COLOR_INFO
            ;;
        WARN)
            color=$COLOR_WARN
            ;;
        ERROR)
            color=$COLOR_ERROR
            ;;
        *)
            color=$COLOR_RESET
            ;;
    esac

    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo -e "${color}${timestamp} [${level}] ${msg}${COLOR_RESET}" | tee /dev/fd/3
}

# Function: info
# Description: Logs an informational message.
# Usage: info <message>
info() {
    log "INFO" "$*"
}

# Function: warn
# Description: Logs a warning message.
# Usage: warn <message>
warn() {
    log "WARN" "$*"
}

# Function: error
# Description: Logs an error message.
# Usage: error <message>
error() {
    log "ERROR" "$*"
}

# Function: set_log_file
# Description: Sets a custom log file.
# Usage: set_log_file <file_path>
set_log_file() {
    LOG_FILE="$1"
    exec 3>&1 1>>"${LOG_FILE}" 2>&1
    info "Log file changed to ${LOG_FILE}"
}

# Function: run_and_log
# Description: Runs a command and logs its output, determining the log level
#              based on the command's exit status.
# Usage: run_and_log <command>
run_and_log() {
    local cmd="$*"
    local output
    info "Running command: $cmd"
    output=$($cmd 2>&1)
    local status=$?

    if [ $status -eq 0 ]; then
        log "INFO" "$output"
    elif [ $status -lt 126 ]; then
        log "WARN" "$output"
    else
        log "ERROR" "$output"
    fi

    return $status
}

# Function: redirect_and_log
# Description: Redirects the output of a command to the log file and also prints
#              it to the terminal. Determines the log level based on exit status.
# Usage: redirect_and_log <command>
redirect_and_log() {
    local cmd="$*"
    info "Running command: $cmd"
    $cmd >> "${LOG_FILE}" 2>&1
    local status=$?

    if [ $status -eq 0 ]; then
        info "Command completed successfully"
    elif [ $status -lt 126 ]; then
        warn "Command completed with warnings"
    else
        error "Command failed with errors"
    fi

    return $status
}

#===============================================================================
# End of logging.sh
#===============================================================================
