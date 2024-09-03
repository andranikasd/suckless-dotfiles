#!/bin/bash
#===============================================================================
#
#          FILE:  functions.sh
# 
#         USAGE:  source ~/.bashrc or source /path/to/functions.sh
#
#   DESCRIPTION:  This script contains all custom bash functions used in my shell environment.
#
#       OPTIONS:  N/A (These functions are designed to be sourced into your shell environment)
#  REQUIREMENTS:  Bash shell, ~/.bashrc or equivalent shell configuration file.
#          BUGS:  No known bugs at this time.
#         NOTES:  Ensure that this script is sourced correctly to make the functions available.
#        AUTHOR:  Andranik Grigoryan (andranik@grigoryan.work)
#       VERSION:  1.0
#       CREATED:  2024-09-03
#      REVISION:  2024-09-03 - Initial version
#
#===============================================================================

# --- Global Variables --------------------------------------------------------
# Any global variables or paths you frequently use in these functions
export MY_VAR="some_value"

# --- Functions on top op kubectl ----------------------------------------------
# Function: kubectx_prompt
# Description: Displays the current Kubernetes context in the bash prompt.
# Usage: kubectx_prompt
# Parameters: None
# Returns: String (Kubernetes context name)
function kubectx_prompt() {
    local kubectx
    kubectx=$(kubectl config current-context 2>/dev/null)
    if [[ -n $kubectx ]]; then
        echo "[$kubectx]"
    fi
}

# Function: klogs
# Description: Tails logs for a specific pod in a given namespace.
# Usage: klogs pod_name [namespace]
# Parameters:
#   - pod_name: Name of the pod to tail logs from (required)
#   - namespace: Namespace of the pod (optional, default is "default")
# Returns: None
function klogs() {
    local pod_name=$1
    local namespace=${2:-default}
    kubectl logs -f "${pod_name}" -n "${namespace}"
}

# Function: kexec
# Description: Executes an interactive bash session in a specific container of a pod.
# Usage: kexec pod_name container_name [namespace]
# Parameters:
#   - pod_name: Name of the pod (required)
#   - container_name: Name of the container within the pod (required)
#   - namespace: Namespace of the pod (optional, default is "default")
# Returns: None
function kexec() {
    local pod_name
    local container_name
    local namespace
    pod_name=$1
    container_name=$2
    namespace=${3:-default}
    kubectl exec -it "${pod_name}" -c "${container_name}" -n "${namespace}" -- /bin/bash
}

# Function: kgp
# Description: Lists all pods in a specified namespace.
# Usage: kgp [namespace]
# Parameters:
#   - namespace: Namespace to list pods from (optional, default is "default")
# Returns: None
function kgp() {
    local namespace
    namespace="${1:-default}"
    kubectl get pods -n "${namespace}"
}

# Function: kns
# Description: Switches the current Kubernetes namespace in the kubectl context.
# Usage: kns namespace
# Parameters:
#   - namespace: The namespace to switch to (required)
# Returns: None
function kns() {
    local namespace=$1
    kubectl config set-context --current --namespace="${namespace}"
}

# Function: kdesc
# Description: Describes a Kubernetes resource in a specified namespace.
# Usage: kdesc resource_type resource_name [namespace]
# Parameters:
#   - resource_type: Type of the resource (e.g., pod, service) (required)
#   - resource_name: Name of the resource (required)
#   - namespace: Namespace of the resource (optional, default is "default")
# Returns: None
function kdesc() {
    local resource_type
    local resource_name
    local namespace
    resource_type=$1
    resource_name=$2
    namespace="${3:-default}"
    kubectl describe "${resource_type}" "${resource_name}" -n "${namespace}"
}

# Function: kdelp
# Description: Deletes a specified pod in a given namespace.
# Usage: kdelp pod_name [namespace]
# Parameters:
#   - pod_name: Name of the pod to delete (required)
#   - namespace: Namespace of the pod (optional, default is "default")
# Returns: None
function kdelp() {
    local pod_name
    local namespace
    pod_name=$2
    namespace="${2:-default}"
    kubectl delete pod "${pod_name}" -n "${namespace}"
}

# Function: kapply
# Description: Applies a Kubernetes manifest file to the cluster.
# Usage: kapply path/to/manifest.yaml
# Parameters:
#   - file_path: Path to the manifest file (required)
# Returns: None
function kapply() {
    local file_path
    file_path=$1
    kubectl apply -f "${file_path}"
}

# Function: krestart
# Description: Restarts a deployment by scaling it down to zero and back up.
# Usage: krestart deployment_name [namespace]
# Parameters:
#   - deployment_name: Name of the deployment to restart (required)
#   - namespace: Namespace of the deployment (optional, default is "default")
# Returns: None
function krestart() {
    local deployment_name
    local namespace
    deployment_name=$1
    namespace="${2:-default}"
    kubectl scale deployment "${deployment_name}" --replicas=0 -n "${namespace}"
    kubectl scale deployment "${deployment_name}" --replicas=1 -n "${namespace}"
}

# Function: kctx
# Description: Switches the current Kubernetes context.
# Usage: kctx context_name
# Parameters:
#   - context_name: Name of the Kubernetes context to switch to (required)
# Returns: None
function kctx() {
    local context_name
    context_name=$1
    kubectl config use-context "${context_name}"
}