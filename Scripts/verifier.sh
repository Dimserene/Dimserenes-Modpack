#!/bin/bash

# Base path to where modpacks are stored
modpacks_base_path="/sdcard/Modpacks"

# Check if the base modpacks folder exists
if [[ ! -d "$modpacks_base_path" ]]; then
    echo "Error: Modpacks folder not found at $modpacks_base_path."
    exit 1
fi

# Create temporary directory for storing results in Termux-compatible location
temp_dir="$modpacks_base_path/temp_results"
mkdir -p "$temp_dir"

# Function to check if a directory is populated
is_populated() {
    local dir="$1"
    local contents=$(ls -A "$dir" | grep -v '^\.git$' | head -n 1)
    [[ -z "$contents" ]] && return 1 || return 0
}

# Function to process each modpack in parallel
check_modpack() {
    local modpack_path="$1"
    local modpack_name=$(basename "$modpack_path")
    local mods_folder="$modpack_path/Mods"
    local result_file="$temp_dir/$modpack_name.txt"

    # Temporary arrays for each modpack’s populated/unpopulated folders
    local unpopulated_local=()
    local populated_local=0

    # Check if the Mods folder exists in the current modpack
    if [[ -d "$mods_folder" ]]; then
        echo "Checking Mods folder for modpack: $modpack_name"

        # Loop through each subfolder inside the Mods folder
        for mod_folder in "$mods_folder"/*/; do
            mod_name=$(basename "$mod_folder")

            if is_populated "$mod_folder"; then
                echo "[OK] $modpack_name/$mod_name is populated."
                populated_local=$((populated_local + 1))
            else
                echo "[WARNING] $modpack_name/$mod_name is not populated (empty or only .git file)."
                unpopulated_local+=("$modpack_name/$mod_name")
            fi
        done
    else
        echo "[WARNING] Mods folder not found for modpack: $modpack_name"
        unpopulated_local+=("$modpack_name/Mods (missing)")
    fi

    # Write results to the temporary file for this modpack
    echo "$populated_local" > "$result_file"
    for folder in "${unpopulated_local[@]}"; do
        echo "$folder" >> "$result_file"
    done
}

echo "Verifying mod folders within each modpack in $modpacks_base_path..."
echo "============================================================="

# Run checks in parallel for each modpack
for modpack_path in "$modpacks_base_path"/*/; do
    check_modpack "$modpack_path" &
done

# Wait for all background tasks to complete
wait

# Initialize counters and results array
populated_count=0
unpopulated_count=0
unpopulated_folders=()

# Collect results from temporary files
for result_file in "$temp_dir"/*.txt; do
    if [[ -f "$result_file" ]]; then
        # First line of each result file is the count of populated folders
        populated_count=$((populated_count + $(head -n 1 "$result_file")))

        # Remaining lines are unpopulated folders
        while read -r line; do
            # Ignore specific folders
            if [[ "$line" != "temp_results/Mods (missing)" && "$line" != "updateforks/Mods (missing)" ]]; then
                unpopulated_folders+=("$line")
                ((unpopulated_count++))
            fi
        done < <(tail -n +2 "$result_file")
    fi
done

# Cleanup temporary directory
rm -rf "$temp_dir"

echo "============================================================="
echo "Verification Summary:"
echo "Populated folders: $populated_count"
echo "Unpopulated folders: $unpopulated_count"

# Display the list of unpopulated folders, if any
if [[ $unpopulated_count -gt 0 ]]; then
    echo "List of unpopulated folders:"
    for folder in "${unpopulated_folders[@]}"; do
        echo "- $folder"
    done
else
    echo "All mod folders are well populated."
fi

# Prompt user to press enter to exit
echo ""
echo "Press enter to exit..."
read -r  # Changed to wait for enter key