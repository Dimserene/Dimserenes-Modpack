#!/bin/bash

# Recloner Script - Reclones all modpacks after user confirmation

# Base path where modpacks are stored
base_path="/sdcard/Modpacks"
modpacks_list="$base_path/modpacks_list.txt"

# Load modpack names from the list file
modpacks=()
if [[ -f "$modpacks_list" ]]; then
    while IFS= read -r line; do
        # Trim leading/trailing whitespace and skip empty lines
        trimmed_line=$(echo "$line" | xargs)
        if [[ -n "$trimmed_line" ]]; then
            modpacks+=("$trimmed_line")
        fi
    done < "$modpacks_list"
else
    echo "Error: $modpacks_list not found."
    exit 1
fi

# Log file path
log_file="$base_path/reclone_log.txt"

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'  # No color

# Function to log status messages
log_status() {
    local modpack=$1
    local status=$2
    local color
    local display_status

    # Determine color based on status
    case "$status" in
        *"SUCCESS"*)
            color=$GREEN
            display_status="SUCCESS"
            ;;
        *"FAILED"*)
            color=$RED
            display_status="FAILED"
            ;;
        *)
            color=$NC
            display_status="$status"
            ;;
    esac

    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    local message="[$timestamp] ${modpack}: ${display_status}"

    # Print the message to the console with color
    echo -e "${color}${message}${NC}"

    # Log the message to the log file without color
    echo "$message" >> "$log_file"
}

# Function to get repository URL from local .git/config or set a default
get_repo_url() {
    local modpack_path="$base_path/$1"
    local repo_url=""

    # Check if the .git directory exists for the modpack
    if [[ -d "$modpack_path/.git" ]]; then
        # Retrieve the URL from the .git/config
        repo_url=$(git -C "$modpack_path" config --get remote.origin.url)
    fi

    # If no URL is found, you could specify a default or prompt the user
    if [[ -z "$repo_url" ]]; then
        echo "No remote URL found for $1."
        read -p "Enter the URL for $1: " repo_url
    fi

    echo "$repo_url"
}

# Function to reclone a modpack
reclone_modpack() {
    local modpack=$1
    local repo_url=$2
    local modpack_path="$base_path/$modpack"

    # Remove existing modpack directory
    if [[ -d "$modpack_path" ]]; then
        echo "Removing existing $modpack directory..."
        rm -rf "$modpack_path"
    fi

    # Clone the modpack repository
    if git clone --recurse-submodules "$repo_url" "$modpack_path"; then
        log_status "$modpack" "SUCCESS (Recloned)"
    else
        log_status "$modpack" "FAILED (Reclone failed)"
        return 1
    fi
}

# Confirmation prompt
echo "This will reclone all modpacks listed in $modpacks_list."
echo "Existing directories will be deleted and recloned from their repositories."
read -p "Are you sure you want to proceed? (y/n): " confirm
echo "================================="

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Operation cancelled. No changes were made."
    exit 0
fi

# Process reclone for all modpacks
for modpack in "${modpacks[@]}"; do
    modpack_path="$base_path/$modpack"
    
    # Get the repository URL for each modpack
    repo_url=$(get_repo_url "$modpack")

    if [[ -n "$repo_url" ]]; then
        echo "Recloning $modpack from $repo_url..."
        reclone_modpack "$modpack" "$repo_url"
    else
        echo "Skipping $modpack due to missing URL."
        log_status "$modpack" "FAILED (No repository URL provided)"
    fi
done

echo ""
echo "================================="
echo "Reclone Summary:"
for modpack in "${modpacks[@]}"; do
    echo "$modpack: Recloned"
done
echo "================================="
echo "All reclone operations completed."

# Prompt user to press enter to exit
echo ""
echo "Press enter to exit..."
read -r  # Changed to wait for enter key