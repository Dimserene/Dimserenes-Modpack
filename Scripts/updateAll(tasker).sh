#!/bin/bash

# Define an array of modpack directories
modpacks=("Dimserenes-Modpack" "Fine-tuned-Pack" "Vanilla-Plus-Pack" "Cruel-Pack" "Experimental-Pack" "Talisman-Pack")

# Base path
base_path="/sdcard/Modpacks"

# Log file path
log_file="$base_path/update_log.txt"

# Function to log messages
log_message() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" >> "$log_file"
}

# Function to colorize output
colorize_output() {
    local message=$1
    local status=$2
    case $status in
        "SUCCESS")
            echo -e "\033[0;32m$message\033[0m"  # Green for success
            ;;
        "FAILED")
            echo -e "\033[0;31m$message\033[0m"  # Red for failure
            ;;
        "SKIPPED")
            echo -e "\033[0;33m$message\033[0m"  # Yellow for skipped
            ;;
        *)
            echo "$message"  # Default color
            ;;
    esac
}

# Function to update a single modpack
update_modpack() {
    local modpack=$1
    local modpack_path="$base_path/$modpack"

    if [[ ! -d "$modpack_path" ]]; then
        log_message "Directory $modpack_path does not exist. Skipping $modpack."
        colorize_output "$modpack: FAILED (Directory does not exist)" "FAILED"
        execution_summaries+=("$modpack: FAILED (Directory does not exist)")
        return 1
    fi
    
    if [[ ! -f "$modpack_path/autoversion.sh" ]]; then
        log_message "autoversion.sh script not found in $modpack_path. Skipping $modpack."
        colorize_output "$modpack: FAILED (autoversion.sh not found)" "FAILED"
        execution_summaries+=("$modpack: FAILED (autoversion.sh not found)")
        return 1
    fi
    
    # Run the update script and capture the result
    cd "$modpack_path" || exit
    echo "Updating $modpack..."
    sh "$modpack_path/autoversion.sh" 2>&1 | while IFS= read -r line; do
        echo -e "\033[0;36m$line\033[0m"  # Display Git's real-time output in cyan
    done

    if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
        colorize_output "$modpack: SUCCESS" "SUCCESS"
        execution_summaries+=("$modpack: SUCCESS")
        log_message "$modpack update: SUCCESS"
    else
        colorize_output "$modpack: FAILED (Check autoversion.sh output for details)" "FAILED"
        execution_summaries+=("$modpack: FAILED (Check autoversion.sh output for details)")
        log_message "$modpack update: FAILED (Check autoversion.sh output for details)"
        return 1
    fi
}

# Main Execution
execution_summaries=()

# Update all modpacks
for modpack in "${modpacks[@]}"; do
    update_modpack "$modpack"
done

# Display summary of results
echo ""
echo "Update Summary:"
for summary in "${execution_summaries[@]}"; do
    if [[ $summary == *"SUCCESS"* ]]; then
        colorize_output "$summary" "SUCCESS"
    elif [[ $summary == *"FAILED"* ]]; then
        colorize_output "$summary" "FAILED"
    else
        echo "$summary"
    fi
done

# Log the summary
log_message "Update Summary:"
for summary in "${execution_summaries[@]}"; do
    log_message "$summary"
done

# Prompt user to press enter to exit
read -p "Press enter to exit..."
log_message "Script execution completed."