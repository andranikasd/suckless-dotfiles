#!/bin/bash
#===============================================================================
#
#          FILE:  setup.sh
#         USAGE:  source setup.sh
#   DESCRIPTION:  This script is designed to install and setup some essential
#                 tools that are used in my environment
#  REQUIREMENTS:  Bash shell, ~/.bashrc or equivalent shell configuration file.
#
#===============================================================================
set -e
set -x

declare -A COLORS
COLORS[info]='\033[0;37m'
COLORS[warning]='\033[0;33m'
COLORS[error]='\033[1;31m'
COLORS[time]='\033[0;34m'
COLORS[reset]='\033[0m'

info() {
  echo -e "${COLORS[time]}$(date +'%Y-%m-%dT%H:%M:%S%z')${COLORS[reset]} |${COLORS[info]} INFO ${COLORS[reset]}| $1"
}

warn() {
  echo -e "${COLORS[time]}$(date +'%Y-%m-%dT%H:%M:%S%z')${COLORS[reset]} |${COLORS[warning]} WARNING ${COLORS[reset]}| $1"
}

err() {
  echo -e "${COLORS[time]}$(date +'%Y-%m-%dT%H:%M:%S%z')${COLORS[reset]} |${COLORS[error]} ERROR ${COLORS[reset]}| $1" >&2
  exit 1
}

install_ubuntu_package() {
  local package_name="${1}"
  local package_version="${2}"
  local install_with_version=0

  if [[ $# -eq 0 ]]; then
    err "No arguments provided to function"
  fi
  if [[ -z "${package_name}" ]]; then
    err "Please provide package name. This option is required"
  fi

  if [[ -n "${package_version}" ]]; then
    install_with_version=1
  fi

  if [[ $install_with_version -eq 0 ]]; then
    sudo apt install "${package_name}"
  else
    sudo apt install "${package_name}"="${package_version}"
  fi
}

install_with_wget() {
  local install_url="${1}"
  local tool_name="${2}"

  if [[ -z "${install_url}" ]]; then
    err "No download url provided to function. This option is required"
  fi
  if [[ -z "${tool_name}" ]]; then
    err "No tool name provided to function. This option is required"
  fi

  mkdir -p /tmp/installed_tools
  wget "${install_url}" -o /tmp/installed_tools
  sudo dpkg -i "/tmp/installed_tools/${tool_name}.deb"
}
