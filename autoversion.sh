#!/bin/bash

# Function to generate the new version string based on the latest commit message
generate_new_version_string() {
    # Get the latest commit message
    local latest_commit_msg=$(git log -1 --pretty=%B)

    # Extract the date part (YYYY-MM-DD) from the latest commit message
    local latest_version_date=$(echo "$latest_commit_msg" | grep -oE "^[0-9]{4}-[0-9]{2}-[0-9]{2}")

    # Extract the alphabet character from the latest commit message
    local latest_version_alpha=$(echo "$latest_commit_msg" | grep -oE "[a-z]$")

    # Get the current date in UTC format (YYYY-MM-DD)
    local current_date=$(date -u "+%Y-%m-%d")

    if [ "$latest_version_date" = "$current_date" ]; then
        # If the latest commit date matches the current date, advance the alphabet by one
        if [ "$latest_version_alpha" = "z" ]; then
            latest_version_alpha="a"  # If it's 'z', roll over to 'a'
        else
            latest_version_alpha=$(echo "$latest_version_alpha" | tr "a-y" "b-z")  # Advance alphabet by one
        fi
    else
        # If the dates don't match, set the date to the current date and reset alphabet to "a"
        latest_version_date="$current_date"
        latest_version_alpha="a"
    fi

    # Combine the date and alphabet to form the new version string
    echo "${latest_version_date}${latest_version_alpha}"
}

# Get the name of the current working folder
working_folder_name=$(basename "$PWD")

echo ""
echo "Start updating ${working_folder_name}..."
echo ""

# Initialize status variables
pull_status="SKIPPED"
submodule_status="SKIPPED"
update_version_status="SKIPPED"
copy_version_status="SKIPPED"
update_time_status="SKIPPED"
stage_status="SKIPPED"
commit_status="SKIPPED"
push_status="SKIPPED"

# Pull the latest changes from the remote repository
if git pull; then
    pull_status="SUCCESS"
else
    pull_status="FAILED"
fi

# Update all submodules to their latest commit from the remote repository and merge them
if git submodule update --remote --recursive; then
    submodule_status="SUCCESS"
else
    submodule_status="FAILED"
fi

cp ./ModpackName.txt ./Mods/ModpackUtil/

# Check for changes in the "Mods" folder (excluding README.md files)
mods_changes=$(git status --porcelain Mods/ | grep -v "README.md")

# Check for changes in the entire repository
overall_changes=$(git status --porcelain | grep -v "README.md")

if [ -n "$mods_changes" ]; then
    # If "Mods" folder has changes, generate a new version string
    new_version_string=$(generate_new_version_string)
    echo "Mods folder changed. Bumping version to $new_version_string."
    
    # Update the CurrentVersion.txt file with the new version string
    if echo "$new_version_string" > ./CurrentVersion.txt; then
        echo "New version string written to CurrentVersion.txt"
        update_version_status="SUCCESS"
    else
        echo "Failed to write new version string to CurrentVersion.txt"
        update_version_status="FAILED"
    fi

    # Copy the updated CurrentVersion.txt file to the Mods/ModpackUtil/ directory
    if cp ./CurrentVersion.txt ./Mods/ModpackUtil/; then
        echo "CurrentVersion.txt copied to Mods/ModpackUtil/"
        copy_version_status="SUCCESS"
    else
        echo "Failed to copy CurrentVersion.txt to Mods/ModpackUtil/"
        copy_version_status="FAILED"
    fi

elif [ -n "$overall_changes" ]; then
    # If there are changes in other files, but not in the "Mods" folder, proceed without version bump
    echo "No changes in Mods folder, but other changes detected. Proceeding without version bump."
else
    # No changes detected anywhere, skip everything
    echo "No changes detected. Skipping update."
    exit 0
fi

# Check if CurrentVersion.txt exists before proceeding
if [ ! -f "./CurrentVersion.txt" ]; then
    echo "CurrentVersion.txt is missing. Failing update."
    exit 1
fi

# Write the current UTC date and time to VersionTime.txt in the Mods/ModpackUtil/ directory
if date -u "+%Y/%m/%d %H:%M:%S" > Mods/ModpackUtil/VersionTime.txt; then
    echo "VersionTime.txt updated successfully."
    update_time_status="SUCCESS"
else
    echo "Failed to update VersionTime.txt."
    update_time_status="FAILED"
fi

# Stage all changes in the current directory for commit
if git add .; then
    echo "Changes staged successfully."
    stage_status="SUCCESS"
else
    echo "Failed to stage changes."
    stage_status="FAILED"
fi

# Commit the staged changes
commit_message=$(cat ./CurrentVersion.txt)

if git commit -m "$commit_message"; then
    echo "Changes committed successfully."
    commit_status="SUCCESS"
else
    echo "Failed to commit changes."
    commit_status="FAILED"
fi

# Push the changes to the remote repository
if git push; then
    echo "Changes pushed to remote repository successfully."
    push_status="SUCCESS"
else
    echo "Failed to push changes to remote repository."
    push_status="FAILED"
fi

# Summary of the results
echo ""
echo "Update Summary for ${working_folder_name}:"
echo "------------------------------------------"
if [ "$update_version_status" = "SUCCESS" ] || [ "$update_version_status" = "SKIPPED" ]; then
    echo "${working_folder_name}: SUCCESSFULLY UPDATED"
else
    echo "${working_folder_name}: FAILED TO UPDATE"
    [ "$update_version_status" = "FAILED" ] && echo "  - Failed to update version"
    [ "$copy_version_status" = "FAILED" ] && echo "  - Failed to copy version file"
    [ "$update_time_status" = "FAILED" ] && echo "  - Failed to update version time"
    [ "$stage_status" = "FAILED" ] && echo "  - Failed to stage changes"
    [ "$commit_status" = "FAILED" ] && echo "  - Failed to commit changes"
    [ "$push_status" = "FAILED" ] && echo "  - Failed to push changes"
fi
echo "------------------------------------------"

# Exit with appropriate status
if [ "$pull_status" = "SUCCESS" ] && \
   [ "$submodule_status" = "SUCCESS" ] && \
   ([ "$update_version_status" = "SUCCESS" ] || [ "$update_version_status" = "SKIPPED" ]) && \
   ([ "$copy_version_status" = "SUCCESS" ] || [ "$copy_version_status" = "SKIPPED" ]) && \
   [ "$update_time_status" = "SUCCESS" ] && \
   [ "$stage_status" = "SUCCESS" ] && \
   [ "$commit_status" = "SUCCESS" ] && \
   [ "$push_status" = "SUCCESS" ]; then
    exit 0
else
    exit 1
fi