#!/bin/bash
#===============================================================================
#
#          FILE:  git.sh
# 
#         USAGE:  source /path/to/git.sh
#
#   DESCRIPTION:  This script contains helper functions to streamline Git 
#                 operations, making it easier to perform common tasks like 
#                 initializing repositories, creating branches, and managing 
#                 remotes.
#
#       OPTIONS:  N/A (This script is designed to be sourced into your shell environment)
#  REQUIREMENTS:  Git, Bash shell, ~/.bashrc or equivalent shell configuration file.
#          BUGS:  No known bugs at this time.
#         NOTES:  Ensure that this script is sourced properly in your ~/.bashrc.
#        AUTHOR:  Andranik Grigoryan (andranik@grigoryan.work)
#       VERSION:  1.0
#       CREATED:  2024-09-03
#      REVISION:  2024-09-03 - Initial version
#
#===============================================================================

#-------------------------------------------------------------------------------
# Function: ginit
#
# Description:
#   Initializes a Git repository with custom configurations, such as setting the 
#   user's name and email, creating a branch, and adding a remote repository.
#
# Usage:
#   ginit [options]
#     --goya       Set user.name and user.email for Goya account
#     --personal   Set user.name and user.email for personal account
#     -b <branch>  Create and checkout a new branch
#     --remote <url> Add a remote repository URL
#     -i           Initialize a new Git repository (git init)
#
# Parameters:
#   --goya: Use Goya Git configuration (name and email).
#   --personal: Use personal Git configuration (name and email).
#   -b <branch>: Specify the branch name to create or checkout.
#   --remote <url>: Specify the remote repository URL.
#   -i: Initialize a new Git repository.
#
# Returns:
#   None
#
#-------------------------------------------------------------------------------
function ginit() {
    local name="Andranik Grigoryan"
    local email="andranik@grigoryan.work"
    local branch=""
    local remote=""
    local init_flag=false

    # Parse options
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            --goya)
                name="Andranik Grigoryan"
                email="andranik.grigoryan@goya.am"
                ;;
            --personal)
                name="Andranik Grigoryan"
                email="andranik@grigoryan.work"
                ;;
            -b)
                branch="$2"
                shift
                ;;
            --remote)
                remote="$2"
                shift
                ;;
            -i)
                init_flag=true
                ;;
            *)
                echo "Unknown option: $1"
                return 1
                ;;
        esac
        shift
    done

    # Initialize Git if requested
    if [ "$init_flag" = true ]; then
        git init
        if [ -n "$branch" ]; then
            git config --local init.defaultBranch "$branch"
        fi
    elif [ -n "$branch" ]; then
        git checkout -b "$branch" 2>/dev/null || git checkout "$branch"
    fi

    # Set Git user configuration
    git config user.name "$name"
    git config user.email "$email"

    # Add remote repository if provided
    if [ -n "$remote" ]; then
        git remote add origin "$remote"
    fi
}

#-------------------------------------------------------------------------------
# Function: gpush
#
# Description:
#   Pushes the current branch to the specified remote repository. If no remote 
#   is specified, 'origin' is used by default. Also includes the option to force 
#   push.
#
# Usage:
#   gpush [options]
#     -r <remote>  Specify the remote repository (default: origin)
#     -f           Force push to the remote repository
#
# Parameters:
#   -r <remote>: Specify the remote repository.
#   -f: Force push the branch.
#
# Returns:
#   None
#
#-------------------------------------------------------------------------------
function gpush() {
    local remote="origin"
    local force_flag=""

    # Parse options
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            -r)
                remote="$2"
                shift
                ;;
            -f)
                force_flag="--force"
                ;;
            *)
                echo "Unknown option: $1"
                return 1
                ;;
        esac
        shift
    done

    git push $force_flag "$remote" "$(git branch --show-current)"
}

#-------------------------------------------------------------------------------
# Function: gpull
#
# Description:
#   Pulls the latest changes from the specified remote repository. If no remote 
#   is specified, 'origin' is used by default. Also includes the option to rebase.
#
# Usage:
#   gpull [options]
#     -r <remote>  Specify the remote repository (default: origin)
#     --rebase     Rebase the current branch after pulling
#
# Parameters:
#   -r <remote>: Specify the remote repository.
#   --rebase: Rebase the current branch after pulling.
#
# Returns:
#   None
#
#-------------------------------------------------------------------------------
function gpull() {
    local remote="origin"
    local rebase_flag=""

    # Parse options
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            -r)
                remote="$2"
                shift
                ;;
            --rebase)
                rebase_flag="--rebase"
                ;;
            *)
                echo "Unknown option: $1"
                return 1
                ;;
        esac
        shift
    done

    git pull $rebase_flag "$remote" "$(git branch --show-current)"
}

#-------------------------------------------------------------------------------
# Function: gclean
#
# Description:
#   Cleans up the Git repository by removing untracked files and directories. 
#   This is useful for maintaining a clean working directory.
#
# Usage:
#   gclean [options]
#     -f  Force removal of untracked files and directories
#     -d  Remove untracked directories in addition to files
#
# Parameters:
#   -f: Force removal of untracked files.
#   -d: Remove untracked directories.
#
# Returns:
#   None
#
#-------------------------------------------------------------------------------
function gclean() {
    local force_flag=""
    local dir_flag=""

    # Parse options
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            -f)
                force_flag="-f"
                ;;
            -d)
                dir_flag="-d"
                ;;
            *)
                echo "Unknown option: $1"
                return 1
                ;;
        esac
        shift
    done

    git clean $force_flag $dir_flag
}

#-------------------------------------------------------------------------------
# Function: gstatus
#
# Description:
#   Displays the current status of the Git repository, including staged, 
#   unstaged, and untracked files.
#
# Usage:
#   gstatus
#
# Parameters:
#   None
#
# Returns:
#   None - The function displays the git status output.
#
#-------------------------------------------------------------------------------
function gstatus() {
    git status
}

#-------------------------------------------------------------------------------
# Function: gdiff
#
# Description:
#   Shows the differences between the working directory and the index (staged 
#   files). This is useful for reviewing changes before committing.
#
# Usage:
#   gdiff
#
# Parameters:
#   None
#
# Returns:
#   None - The function displays the git diff output.
#
#-------------------------------------------------------------------------------
function gdiff() {
    git diff
}

#-------------------------------------------------------------------------------
# Function: gbranch
#
# Description:
#   Lists all branches in the repository and highlights the current branch. 
#   Additionally, can create, delete, or switch branches based on provided options.
#
# Usage:
#   gbranch [options]
#     -c <branch>  Create and switch to a new branch
#     -d <branch>  Delete a branch
#
# Parameters:
#   -c <branch>: Create and switch to a new branch.
#   -d <branch>: Delete a specified branch.
#
# Returns:
#   None
#
#-------------------------------------------------------------------------------
function gbranch() {
    local create_branch=""
    local delete_branch=""

    # Parse options
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            -c)
                create_branch="$2"
                shift
                ;;
            -d)
                delete_branch="$2"
                shift
                ;;
            *)
                echo "Unknown option: $1"
                return 1
                ;;
        esac
        shift
    done

    if [ -n "$create_branch" ]; then
        git checkout -b "$create_branch"
    elif [ -n "$delete_branch" ]; then
        git branch -d "$delete_branch"
    else
        git branch
    fi
}

#-------------------------------------------------------------------------------
# Function: gmerge
#
# Description:
#   Merges the specified branch into the current branch. Provides options for 
#   a fast-forward or no-ff merge.
#
# Usage:
#   gmerge [options] <branch>
#     --no-ff  Perform a no-fast-forward merge
#
# Parameters:
#   --no-ff: Perform a no-fast-forward merge.
#   <branch>: The branch to merge into the current branch.
#
# Returns:
#   None
#
#-------------------------------------------------------------------------------
function gmerge() {
    local no_ff_flag=""
    local branch=""

    # Parse options
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            --no-ff)
                no_ff_flag="--no-ff"
                ;;
            *)
                if [ -z "$branch" ]; then
                    branch="$1"
                else
                    echo "Unknown option: $1"
                    return 1
                fi
                ;;
        esac
        shift
    done

    if [ -z "$branch" ]; then
        echo "Error: No branch specified to merge."
        return 1
    fi

    git merge $no_ff_flag "$branch"
}

#-------------------------------------------------------------------------------
# Function: greset
#
# Description:
#   Resets the current branch to a specific commit. Supports both soft and hard 
#   reset options.
#
# Usage:
#   greset [options] <commit>
#     --soft  Perform a soft reset (keep changes in working directory)
#     --hard  Perform a hard reset (discard all changes)
#
# Parameters:
#   --soft: Perform a soft reset.
#   --hard: Perform a hard reset.
#   <commit>: The commit to reset to.
#
# Returns:
#   None
#
#-------------------------------------------------------------------------------
function greset() {
    local reset_type=""
    local commit=""

    # Parse options
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            --soft)
                reset_type="--soft"
                ;;
            --hard)
                reset_type="--hard"
                ;;
            *)
                if [ -z "$commit" ]; then
                    commit="$1"
                else
                    echo "Unknown option: $1"
                    return 1
                fi
                ;;
        esac
        shift
    done

    if [ -z "$commit" ]; then
        echo "Error: No commit specified to reset to."
        return 1
    fi

    git reset $reset_type "$commit"
}

