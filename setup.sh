#!/bin/bash

#===============================================================================
#
#          FILE:  setup.sh
# 
#         USAGE:  ./setup.sh
#
#   DESCRIPTION:  This script sets up a development environment on Ubuntu 22.04.
#                 It installs essential tools and software, configures Vim, and
#                 ensures that everything is ready for development work.
#
#       OPTIONS:  N/A
#  REQUIREMENTS:  Bash shell, Ubuntu 22.04
#          BUGS:  No known bugs at this time.
#         NOTES:  Ensure that this script is executed with sufficient permissions.
#        AUTHOR:  Andranik Grigoryan (andranik@grigoryan.work)
#       VERSION:  1.1
#       CREATED:  2024-09-03
#      REVISION:  2024-09-03 - Added soft link creation logic
#
#===============================================================================

# --- Include Logging ---------------------------------------------------------
source ./utils/logging.sh

# --- Script Initialization ---------------------------------------------------

info "Starting the setup script"

# Get the current username
USER=$(whoami)
info "Current username: $USER"

# Detect if the environment is WSL
if grep -q Microsoft /proc/version; then
    isWSL=1
    info "WSL environment detected"
    echo "Please enter your Windows username:"
    read -r winuser
    info "Windows username: $winuser"
else
    isWSL=0
    info "Non-WSL environment detected"
fi

# --- Vim Configuration -------------------------------------------------------

info "Copying Vim configuration file"
cp ./vim/vimrc "$HOME/.vimrc"
info "Vim configuration copied"

# --- Install Essential Tools -------------------------------------------------

info "Updating package list and installing essential tools"
if run_and_log sudo apt update && sudo apt install -y lolcat figlet vim curl wget fzf htop python3 python3-pip python3-venv golang; then
    info "Essential tools installed successfully"
else
    error "Failed to install essential tools"
fi

# --- Set Up Vim-Plug ----------------------------------------------------------

info "Setting up vim-plug"
if run_and_log curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim; then
    info "Vim-plug installed successfully"
else
    error "Failed to install vim-plug"
fi

# --- WSL-Specific Configuration -----------------------------------------------

if [ "$isWSL" -eq 1 ]; then
    info "Creating symlink to Windows home directory"
    ln -sf /mnt/c/Users/"$winuser" ~/win
    info "Symlink to Windows home directory created"
fi

# --- Install kubectl ----------------------------------------------------------

info "Checking for kubectl installation"
if ! kubectl version --client &>/dev/null; then
    info "kubectl not found, installing..."
    if run_and_log curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" &&
       run_and_log sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl &&
       run_and_log mkdir -p ~/.kube && touch ~/.kube/config && rm kubectl; then
        info "kubectl installed successfully"
    else
        error "Failed to install kubectl"
    fi
else
    info "kubectl is already installed"
fi

# --- Install Docker -----------------------------------------------------------

info "Checking for Docker installation"
if ! docker --version &>/dev/null; then
    info "Docker not found, installing..."
    if run_and_log sudo apt update &&
       run_and_log sudo apt install -y apt-transport-https ca-certificates curl software-properties-common &&
       run_and_log curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg &&
       echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null &&
       run_and_log sudo apt update &&
       run_and_log sudo apt install -y docker-ce docker-ce-cli containerd.io &&
       sudo usermod -aG docker "$USER" &&
       newgrp docker; then
        info "Docker installed successfully"
    else
        error "Failed to install Docker"
    fi
else
    info "Docker is already installed"
fi

# --- Install AWS CLI ----------------------------------------------------------

info "Checking for AWS CLI installation"
if ! aws --version &>/dev/null; then
    info "AWS CLI not found, installing..."
    if run_and_log curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" &&
       run_and_log unzip awscliv2.zip &&
       run_and_log sudo ./aws/install &&
       rm -rf aws awscliv2.zip; then
        info "AWS CLI installed successfully"
    else
        error "Failed to install AWS CLI"
    fi
else
    info "AWS CLI is already installed"
fi

# --- Install WSL-Hello-sudo ---------------------------------------------------

if [ "$isWSL" -eq 1 ]; then
    info "Checking for WSL-Hello-sudo installation"
    if [ ! -f /usr/share/pam-configs/wsl-hello ]; then
        info "WSL-Hello-sudo not found, installing..."
        if run_and_log wget http://github.com/nullpo-head/WSL-Hello-sudo/releases/latest/download/release.tar.gz &&
           run_and_log tar xvf release.tar.gz &&
           cd release || exit &&
           run_and_log . ./install.sh &&
           cd .. &&
           rm -rf release*; then
            info "WSL-Hello-sudo installed successfully"
        else
            error "Failed to install WSL-Hello-sudo"
        fi
    else
        info "WSL-Hello-sudo is already installed"
    fi
fi

# --- Install krew (kubectl plugin manager) -------------------------------------

info "Checking for krew installation"
if ! kubectl krew version &>/dev/null; then
    info "krew not found, installing..."
    temp_dir=$(mktemp -d) || { error "Failed to create temp directory"; exit 1; }
    cd "$temp_dir" || { error "Failed to change directory to temp directory"; exit 1; }

    OS="$(uname | tr '[:upper:]' '[:lower:]')"
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')"
    KREW="krew-${OS}_${ARCH}"

    if run_and_log curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz"; then
        if run_and_log tar zxvf "${KREW}.tar.gz"; then
            if run_and_log ./"${KREW}" install krew; then
                info "krew installed successfully"
            else
                error "Failed to install krew"
            fi
        else
            error "Failed to extract krew tar.gz"
        fi
    else
        error "Failed to download krew"
    fi

    # Clean up temporary directory
    cd - || exit 1
    rm -rf "$temp_dir"
else
    info "krew is already installed"
fi

# Continue with the rest of the script
info "Continuing with the rest of the setup..."

# --- Install kubens Plugin ----------------------------------------------------

info "Checking for kubens plugin"
if ! ~/.krew/bin/kubectl-krew list | grep -q ns; then
    info "kubens not found, installing..."
    if run_and_log ~/.krew/bin/kubectl-krew install ns; then
        info "kubens installed successfully"
    else
        error "Failed to install kubens"
    fi
else
    info "kubens is already installed"
fi

# --- Install kubectx Plugin ---------------------------------------------------

info "Checking for kubectx plugin"
if ! ~/.krew/bin/kubectl-krew list | grep -q ctx; then
    info "kubectx not found, installing..."
    if run_and_log ~/.krew/bin/kubectl-krew install ctx; then
        info "kubectx installed successfully"
    else
        error "Failed to install kubectx"
    fi
else
    info "kubectx is already installed"
fi

# --- Install neat Plugin ------------------------------------------------------

info "Checking for neat plugin"
if ! ~/.krew/bin/kubectl-krew list | grep -q neat; then
    info "neat not found, installing..."
    if run_and_log ~/.krew/bin/kubectl-krew install neat; then
        info "neat installed successfully"
    else
        error "Failed to install neat"
    fi
else
    info "neat is already installed"
fi

# --- Create Soft Links for Configuration Files --------------------------------

info "Creating soft links for configuration files"

# Soft links for dotfiles
mkdir -p "${HOME}/dotfiles/"
ln -sf "${PWD}/dotfiles/aliases.sh" "$HOME/dotfiles/aliases.sh"
ln -sf "${PWD}/dotfiles/environment.sh" "$HOME/dotfiles/environment.sh"
ln -sf "${PWD}/dotfiles/prompt.sh" "$HOME/dotfiles/prompt.sh"
info "Soft links for dotfiles created"

mkdir -p "${HOME}/helpers"
# Soft links for helper scripts
ln -sf "${PWD}/helpers/fzf.sh" "${HOME}/helpers/fzf.sh"
ln -sf "${PWD}/helpers/git.sh" "${HOME}/helpers/git.sh"
ln -sf "${PWD}/helpers/kubectl.sh" "${HOME}/helpers/kubectl.sh"
ln -sf "${PWD}/helpers/watch.sh" "${HOME}/helpers/watch.sh"
info "Soft links for helper scripts created"

# Soft link for .custom.bashrc in the home directory
ln -sf "$PWD/.custom.bashrc" "$HOME/.custom.bashrc"
info "Soft link for .custom.bashrc created"

# Copy and modify .bashrc with the current username
cp .custom.bashrc ~/.custom.bashrc
sed -i "s/USERNAME/${USER}/g" ~/.custom.bashrc

echo "source ${HOME}/.custom.bashrc" >> ${HOME}/.bashrc
info "Script execution completed successfully"

#===============================================================================
# End of setup.sh
#===============================================================================
